From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Sun, 12 Mar 2006 16:42:17 -0800
Message-ID: <7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
	<7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 01:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIb98-0005bl-Ki
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 01:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWCMAmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 19:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCMAmV
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 19:42:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:27841 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932292AbWCMAmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Mar 2006 19:42:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313003905.LFUU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Mar 2006 19:39:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17530>

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Sun, 12 Mar 2006, Junio C Hamano wrote:
>>> 
>>> master  : 130m virtual, 40m resident, (0major+12510minor)
>>>           66.06user 0.07system 1:10.95elapsed
>>> "next"  : 150m virtual, 65m resident, (0major+49858minor)
>>>           51.41user 0.45system 0.57.55elapsed
>>
>> Any way to fix that "4 times as many page misses, and 70% bigger rss?" 
>> thing? It looks like you're not very careful about your memory use.

"this"  : 145m virtual, 57m resident, (0major+18855minor)
          39.81user 0.28system 0:42.16elapsed

50% more page misses, 45% bigger rss, 65% less usertime.
Slowly getting there...

-- >8 --
[PATCH] diffcore-delta: make the hash a bit denser.

To reduce wasted memory, wait until the hash fills up more
densely before we rehash.  This reduces the working set size a
bit further.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diffcore-delta.c  |   13 +++++++++----
 diffcore-rename.c |    4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

af0b459589edaa77c51a892dd7dc44329634d253
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 471b98f..f8a7518 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -25,8 +25,12 @@
  */
 
 /* Wild guess at the initial hash size */
-#define INITIAL_HASH_SIZE 10
+#define INITIAL_HASH_SIZE 9
 #define HASHBASE 65537 /* next_prime(2^16) */
+/* We leave more room in smaller hash but do not let it
+ * grow to have unused hole too much.
+ */
+#define INITIAL_FREE(sz_log2) ((1<<(sz_log2))*(sz_log2-3)/(sz_log2))
 
 struct spanhash {
 	unsigned long hashval;
@@ -38,7 +42,8 @@ struct spanhash_top {
 	struct spanhash data[FLEX_ARRAY];
 };
 
-static struct spanhash *spanhash_find(struct spanhash_top *top, unsigned long hashval)
+static struct spanhash *spanhash_find(struct spanhash_top *top,
+				      unsigned long hashval)
 {
 	int sz = 1 << top->alloc_log2;
 	int bucket = hashval & (sz - 1);
@@ -62,7 +67,7 @@ static struct spanhash_top *spanhash_reh
 
 	new = xmalloc(sizeof(*orig) + sizeof(struct spanhash) * sz);
 	new->alloc_log2 = orig->alloc_log2 + 1;
-	new->free = osz;
+	new->free = INITIAL_FREE(new->alloc_log2);
 	memset(new->data, 0, sizeof(struct spanhash) * sz);
 	for (i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
@@ -122,7 +127,7 @@ static struct spanhash_top *hash_chars(u
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
 	hash->alloc_log2 = i;
-	hash->free = (1<<i)/2;
+	hash->free = INITIAL_FREE(i);
 	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
 
 	/* an 8-byte shift register made of accum1 and accum2.  New
diff --git a/diffcore-rename.c b/diffcore-rename.c
index b80b432..8380049 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -307,8 +307,10 @@ void diffcore_rename(struct diff_options
 			m->score = estimate_similarity(one, two,
 						       minimum_score);
 		}
+		/* We do not need the text anymore */
 		free(two->cnt_data);
-		two->cnt_data = NULL;
+		free(two->data);
+		two->data = two->cnt_data = NULL;
 		dst_cnt++;
 	}
 	/* cost matrix sorted by most to least similar pair */
-- 
1.2.4.g3dcf
