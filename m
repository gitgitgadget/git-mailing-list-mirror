From: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 00:51:14 +0200
Message-ID: <20110427225114.GA16765@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:52:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDaS-0006jp-5V
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab1D0Wvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 18:51:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34278 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab1D0Wvy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 18:51:54 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFDZk-0003Mo-QC
	from <mingo@elte.hu>; Thu, 28 Apr 2011 00:51:18 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 931503E250F; Thu, 28 Apr 2011 00:51:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172286>


Looking at the stalled-cycled profile of a cached 'git gc' i noticed the 
find_pack_entry_one() entry:

 $ perf record -e stalled-cycles -F 10000 ./git gc
 $ perf report

# Events: 26K stalled-cycles
#
# Overhead     Command          Shared Object                                     Symbol
# ........  ..........  .....................  .........................................
#
    26.07%         git  git                    [.] lookup_object
    10.22%         git  libz.so.1.2.5          [.] 0xc43a          
     7.08%         git  libz.so.1.2.5          [.] inflate
     6.63%         git  git                    [.] find_pack_entry_one
     5.37%         git  [kernel.kallsyms]      [k] do_raw_spin_lock
     4.03%         git  git                    [.] lookup_blob
     3.09%         git  libc-2.13.90.so        [.] __strlen_sse42
     2.81%         git  libc-2.13.90.so        [.] __memcpy_ssse3_back

Annotation shows:

 $ perf annotate find_pack_entry_one

 Percent |      Source code & Disassembly of git
------------------------------------------------
         :
     ...
         :                      int cmp = hashcmp(index + mi * stride, sha1);
    0.90 :        4b9264:       89 ee                   mov    %ebp,%esi
    0.45 :        4b9266:       41 0f af f2             imul   %r10d,%esi
    2.86 :        4b926a:       4c 01 de                add    %r11,%rsi
   53.34 :        4b926d:       f3 a6                   repz cmpsb %es:(%rdi),%ds:(%rsi)
   14.37 :        4b926f:       0f 92 c0                setb   %al
    5.78 :        4b9272:       41 0f 97 c4             seta   %r12b
    1.52 :        4b9276:       41 28 c4                sub    %al,%r12b

Most overhead is in hashcmp(), which uses memcmp(), which falls back to 
assembly string operations.

But we know that hashcmp() compares hashes, which if they do not match, the first byte
will differ in 99% of the cases.

So i tried the patch below: instead of relying on GCC putting in the string 
ops, i used an open-coded loop for this relatively short comparison, which does 
not go beyond the first byte in 99% of the cases.

While it at i also open-coded the is_null_sha1() comparison: instead of 
comparing it to null_sha1[] byte by byte, we can use the sha1 value directly 
and use much more optimal 64-bit and 32-bit comparisons.

The results were rather surprising:

 #
 # Before:
 #

 $ perf stat --sync --repeat 10 ./git gc

 Performance counter stats for './git gc' (10 runs):

       2771.119892 task-clock               #    0.863 CPUs utilized            ( +-  0.16% )
             1,813 context-switches         #    0.001 M/sec                    ( +-  3.06% )
               167 CPU-migrations           #    0.000 M/sec                    ( +-  2.92% )
            39,210 page-faults              #    0.014 M/sec                    ( +-  0.26% )
     8,828,405,654 cycles                   #    3.186 GHz                      ( +-  0.13% )
     2,102,083,909 stalled-cycles           #   23.81% of all cycles are idle   ( +-  0.52% )
     8,821,931,740 instructions             #    1.00  insns per cycle        
                                            #    0.24  stalled cycles per insn  ( +-  0.04% )
     1,750,408,175 branches                 #  631.661 M/sec                    ( +-  0.04% )
        74,612,120 branch-misses            #    4.26% of all branches          ( +-  0.07% )

        3.211098537  seconds time elapsed  ( +-  1.52% )

[ Note: the --sync option to perf stat emits a sync() before each 'git gc' 
  test-run, this reduces the noise of 'elapsed time' numbers enormously. ]

 #
 # After:
 #

 $ perf stat --sync --repeat 10 ./git gc

 Performance counter stats for './git gc' (10 runs):

       2349.498022 task-clock               #    0.807 CPUs utilized            ( +-  0.15% )
             1,842 context-switches         #    0.001 M/sec                    ( +-  2.50% )
               164 CPU-migrations           #    0.000 M/sec                    ( +-  3.67% )
            39,350 page-faults              #    0.017 M/sec                    ( +-  0.06% )
     7,484,317,230 cycles                   #    3.185 GHz                      ( +-  0.15% )
     1,577,673,341 stalled-cycles           #   21.08% of all cycles are idle   ( +-  0.67% )
    11,067,826,786 instructions             #    1.48  insns per cycle        
                                            #    0.14  stalled cycles per insn  ( +-  0.02% )
     2,489,157,909 branches                 # 1059.442 M/sec                    ( +-  0.02% )
        59,384,019 branch-misses            #    2.39% of all branches          ( +-  0.22% )

        2.910829134  seconds time elapsed  ( +-  1.39% )

'git gc' got faster by 18%! Interestingly, 33% of all prior stalled cycles 
disappeared: most of them turned into actual cycle count savings and speedups.

So it's rather clear that the string assembly instructions based memcmp is 
suboptimal for short comparisons like this: there's quite a bit of setup 
latency in repz cmpsb and the CPU is idling around during that time.

(I ran this on a Nehalem system, so it's a rather fast and modern Intel CPU.)

Also note another very interesting detail, the number of branch misses went way 
down, well beyond the measurement noise:

 before:   74,612,120 branch-misses            #    4.26% of all branches          ( +-  0.07% )
  after:   59,384,019 branch-misses            #    2.39% of all branches          ( +-  0.22% )

One theory would be that the open-coded loop is easier for the CPU to speculate 
along, so it produces less branch misses.

The number of instructions and branches increased - this is mostly because the 
PMU counts a complex 'repz cmpsb' as a single instruction issuing many uops, 
while the open-coded loop consists of separate instructions - but roughly the 
same amount of uops.

I suspect 'git fsck' got faster as well, but i have not measured that.

There's more string op use in the Git sha1 code, but this was the lowest 
hanging fruit.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/cache.h b/cache.h
index 2674f4c..c5a54fb 100644
--- a/cache.h
+++ b/cache.h
@@ -675,14 +675,33 @@ extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
-static inline int is_null_sha1(const unsigned char *sha1)
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return !memcmp(sha1, null_sha1, 20);
+	int i;
+
+	for (i = 0; i < 20; i++, sha1++, sha2++) {
+		if (*sha1 != *sha2) {
+			if (*sha1 < *sha2)
+				return -1;
+			return +1;
+		}
+	}
+
+	return 0;
 }
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+
+static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return memcmp(sha1, sha2, 20);
+	const unsigned long long *sha1_64 = (void *)sha1;
+	const unsigned int *sha1_32 = (void *)sha1;
+
+	if (sha1_64[0] || sha1_64[1] || sha1_32[4])
+		return 0;
+
+	return 1;
 }
+
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 {
 	memcpy(sha_dst, sha_src, 20);
