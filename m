From: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] lookup_object(): Speed up 'git gc' by 12%, by reducing hash
 chain length
Date: Wed, 27 Apr 2011 23:35:02 +0200
Message-ID: <20110427213502.GA13647@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:35:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCOC-0001BN-EA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab1D0VfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:35:08 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:59727 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab1D0VfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:35:07 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFCO0-0007of-7W
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 27 Apr 2011 23:35:04 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 893FA3E250F; Wed, 27 Apr 2011 23:35:00 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172277>


I was looking at the 'git gc' stalled-cycles profile and noticed that 
lookup_object() was the top entry:

 aldebaran:~/git> perf record -e stalled-cycles -F 10000 ./git gc 
 Counting objects: 32459, done .
 Delta compression using up to 16 threads.
 Compressing objects: 100% (8161/8161), done.
 Writing objects: 100% (32459/32459), done.
 Total 32459 (delta 24077), reused 32459 (delta 24077)
 [ perf record: Woken up 5 times to write data ]
 [ perf record: Captured and wrote 1.199 MB perf.data (~52366 samples) ]

 aldebaran:~/git> perf report | head
 # Events: 30K stalled-cycles
 #
 # Overhead     Command          Shared Object                                     Symbol
 # ........  ..........  .....................  .........................................
 #
    36.36%         git  git                    [.] lookup_object
     6.55%         git  git                    [.] find_pack_entry_one
     6.53%         git  libz.so.1.2.5          [.] 0xc416          
     5.94%         git  libz.so.1.2.5          [.] inflate
     4.12%         git  [kernel.kallsyms]      [k] do_raw_spin_lock

Annotated output showed the culprit:

         :              if (!obj_hash)
         :                      return NULL;
         :
         :              i = hashtable_index(sha1);
         :              while ((obj = obj_hash[i]) != NULL) {
    4.13 :        498316:       eb 1f                   jmp    498337 <lookup_object+0x47>
    0.00 :        498318:       0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
    0.00 :        49831f:       00 
         :                      if (!hashcmp(sha1, obj->sha1))
    1.48 :        498320:       48 8d 78 04             lea    0x4(%rax),%rdi
    0.02 :        498324:       4c 89 d6                mov    %r10,%rsi
    0.00 :        498327:       4c 89 d9                mov    %r11,%rcx
   26.12 :        49832a:       f3 a6                   repz cmpsb %es:(%rdi),%ds:(%rsi)
   17.12 :        49832c:       74 14                   je     498342 <lookup_object+0x52>
         :                              break;
         :                      i++;
    6.88 :        49832e:       83 c2 01                add    $0x1,%edx
         :                      if (i == obj_hash_size)
         :                              i = 0;
    2.28 :        498331:       44 39 ca                cmp    %r9d,%edx
    0.24 :        498334:       0f 44 d3                cmove  %ebx,%edx

"perf stat --detailed" shows us the following picture:

 Performance counter stats for './git gc':

       3145.596314 task-clock               #    0.877 CPUs utilized          
             1,760 context-switches         #    0.001 M/sec                  
               174 CPU-migrations           #    0.000 M/sec                  
            41,509 page-faults              #    0.013 M/sec                  
     9,753,859,587 cycles                   #    3.101 GHz                      (22.91%)
     2,555,944,921 stalled-cycles           #   26.20% of all cycles are idle   (33.89%)
     8,976,468,086 instructions             #    0.92  insns per cycle        
                                            #    0.28  stalled cycles per insn  (44.83%)
     1,782,743,476 branches                 #  566.743 M/sec                    (55.70%)
        85,045,367 branch-misses            #    4.77% of all branches          (66.54%)
     1,982,452,996 L1-dcache-loads          #  630.231 M/sec                    (66.18%)
       152,320,833 L1-dcache-load-misses    #    7.68% of all L1-dcache hits    (55.50%)
        43,358,073 LLC-loads                #   13.784 M/sec                    (45.33%)
         2,636,774 LLC-load-misses          #    0.838 M/sec                    (11.50%)

        3.586922714  seconds time elapsed

... so git gc is still fitting into the L1 cache mostly, and it rarely falls 
out of the L2 cache. So CPU execution is stalling processing longish hash 
chains and comparing sha1's.

So i tried the quick patch below, which just increases the object hash size 
more aggressively, to 16x of the object count, not the previous 2x sizing.

The results are (run against the Git repo itself, on ec014ea ("Git 1.7.5")):

 #
 # Before:
 #

 Performance counter stats for './git gc' (10 runs):

       3147.437358 task-clock               #    0.793 CPUs utilized            ( +-  0.18% )
             1,753 context-switches         #    0.001 M/sec                    ( +-  3.09% )
               165 CPU-migrations           #    0.000 M/sec                    ( +-  2.86% )
            42,587 page-faults              #    0.014 M/sec                    ( +-  0.04% )
    10,041,078,653 cycles                   #    3.190 GHz                      ( +-  0.18% )
     2,613,923,719 stalled-cycles           #   26.03% of all cycles are idle   ( +-  0.45% )
     9,110,524,009 instructions             #    0.91  insns per cycle        
                                            #    0.29  stalled cycles per insn  ( +-  0.03% )
     1,796,732,369 branches                 #  570.856 M/sec                    ( +-  0.04% )
        84,828,313 branch-misses            #    4.72% of all branches          ( +-  0.06% )

        3.971525714  seconds time elapsed  ( +-  8.56% )

 #
 # After:
 #

 Performance counter stats for './git gc' (10 runs):

       2805.034899 task-clock               #    0.757 CPUs utilized            ( +-  0.16% )
             1,709 context-switches         #    0.001 M/sec                    ( +-  2.51% )
               169 CPU-migrations           #    0.000 M/sec                    ( +-  1.73% )
            42,963 page-faults              #    0.015 M/sec                    ( +-  0.23% )
     8,944,314,899 cycles                   #    3.189 GHz                      ( +-  0.17% )
     2,118,720,399 stalled-cycles           #   23.69% of all cycles are idle   ( +-  0.52% )
     9,017,027,059 instructions             #    1.01  insns per cycle        
                                            #    0.23  stalled cycles per insn  ( +-  0.03% )
     1,780,388,097 branches                 #  634.712 M/sec                    ( +-  0.04% )
        76,104,907 branch-misses            #    4.27% of all branches          ( +-  0.07% )

        3.707549437  seconds time elapsed  ( +-  7.13% )

The takeaway is that stalled cycles dropped by 23%:

     2,613,923,719 stalled-cycles           #   26.03% of all cycles are idle   ( +-  0.45% )
     2,118,720,399 stalled-cycles           #   23.69% of all cycles are idle   ( +-  0.52% )

And total runtime (measured in cycles) decreased by 12.2%:

    10,041,078,653 cycles                   #    3.190 GHz                      ( +-  0.18% )
     8,944,314,899 cycles                   #    3.189 GHz                      ( +-  0.17% )

Elapsed time dropped as well as expected, but measurement noise [last column] 
is high there, due to IO effects.

Cache misses are down as well:

 # Before:

     1,982,452,996 L1-dcache-loads          #  630.231 M/sec                    (66.18%)
       152,320,833 L1-dcache-load-misses    #    7.68% of all L1-dcache hits    (55.50%)
        43,358,073 LLC-loads                #   13.784 M/sec                    (45.33%)
         2,636,774 LLC-load-misses          #    0.838 M/sec                    (11.50%)

 # After:

     1,946,597,133 L1-dcache-loads          #  687.078 M/sec                    (67.61%)
       125,634,149 L1-dcache-load-misses    #    6.45% of all L1-dcache hits    (56.38%)
        30,778,323 LLC-loads                #   10.864 M/sec                    (44.40%)
         2,697,827 LLC-load-misses          #    0.952 M/sec                    (10.94%)

This is somewhat surprising, the hash table got larger after all. Cachemisses 
went down probably due to less chain-walking reducing the effective working set 
size of git gc.

So oversizing the hash seems to works well for git gc. I tried a 4x and 8x 
oversizing as well, it was an improvement but 16x clearly beats it. Larger
than 16x seems like overkill.

I guess the hash function itself is as good as it gets:

 static unsigned int hashtable_index(const unsigned char *sha1)
 {
         unsigned int i;
         memcpy(&i, sha1, sizeof(unsigned int));
         return i % obj_hash_size;
 }

as sha1's ought to be fairly well distributed. The problem i suspect is that 
even with perfectly random distribution of the hash, there will always be 
second, third and higher order chains, which get more and more expensive to 
walk. So a 2x sized hash table becomes overcrowded.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/object.c b/object.c
index 7e1f2bb..b3fe485 100644
--- a/object.c
+++ b/object.c
@@ -91,7 +91,7 @@ struct object *lookup_object(const unsigned char *sha1)
 static void grow_object_hash(void)
 {
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = obj_hash_size < 32 ? 32 : 16 * obj_hash_size;
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
@@ -116,7 +116,7 @@ void *create_object(const unsigned char *sha1, int type, void *o)
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
-	if (obj_hash_size - 1 <= nr_objs * 2)
+	if (obj_hash_size - 1 <= nr_objs * 16)
 		grow_object_hash();
 
 	insert_obj_hash(obj, obj_hash, obj_hash_size);
