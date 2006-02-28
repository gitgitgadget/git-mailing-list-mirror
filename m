From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Tue, 28 Feb 2006 00:10:13 -0800
Message-ID: <7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
	<7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 09:10:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDzw7-0001B5-G0
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 09:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWB1IKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 03:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWB1IKS
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 03:10:18 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4341 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750730AbWB1IKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 03:10:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228080732.EHTZ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 03:07:32 -0500
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16921>

Junio C Hamano <junkio@cox.net> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f ->
>> blob dfc9cd58dc065d17030d875d3fea6e7862ede143
>> size (491102 -> 496045)
>> delta size (16 byte blocks): 248899 in less than 0.1 sec
>> delta size (3 byte blocks): 136000 in 11.8 secs
>> delta size (3 byte blocks + this patch): 171688 in 0.79 sec
>
> These numbers are misleading.
>
> The 36K objects pack I used in my previous tests gives 9971223
> (from "next" branch) vs 9664546 (this patch) final pack size.
> The wallclock time on my machine is 1m35 vs 3m30.  I doubt many
> people are willing to pay 100% more waiting time for 3% tighter
> pack.

I tried an experimental patch to cull collided hash buckets
very aggressively.  I haven't applied your last "reuse index"
patch, though -- I think that is orthogonal and I'd like to
leave that to the next round.

With the same dataset: resulting pack is 9651096 vs 9664546
(your patch) final pack size, with wallclock 2m45s (user 2m31).
Still not good enough, and at the same time I wonder why it gets
_smaller_ results than yours.  But the generated pack unpacked
cleanly in a cloned linux-2.6 repository (having objects and
refs up to v2.6.14) and the result was fsck-objects clean.

I'd appreciate it if you can test it on the 20MB blobs and see
what happens if you have time.

BTW, the benchmark I've been doing is with this dataset:

	git rev-list --objects-edge v2.6.14..v2.6.15-rc1 >RL-N
        time git pack-objects <RL-N --stdout | wc -c

---
diff --git a/diff-delta.c b/diff-delta.c
index 0730b24..52df372 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -88,22 +88,35 @@ static struct index ** delta_index(const
 
 	/*
 	 * Now make sure none of the hash buckets has more entries than
-	 * we're willing to test.  Otherwise we short-circuit the entry
-	 * list uniformly to still preserve a good repartition across
-	 * the reference buffer.
+	 * we're willing to test.  Otherwise we cull the entry list to
+	 * limit identical three byte prefixes to still preserve a good
+	 * repartition across the reference buffer.
 	 */
 	for (i = 0; i < hsize; i++) {
+		struct index **list, *bucket, *remaining;
+		int cnt;
 		if (hash_count[i] < hlimit)
 			continue;
-		entry = hash[i];
-		do {
-			struct index *keep = entry;
-			int skip = hash_count[i] / hlimit / 2;
-			do {
-				entry = entry->next;
-			} while(--skip && entry);
-			keep->next = entry;
-		} while(entry);
+		
+		bucket = NULL;
+		list = &bucket;
+		remaining = hash[i];
+		cnt = 0;
+		while (cnt < hlimit && remaining) {
+			struct index *this = remaining, *that;
+			remaining = remaining->next;
+			for (that = bucket; that; that = that->next) {
+				if (!memcmp(that->ptr, this->ptr, 3))
+					break;
+			}
+			if (that)
+				continue; /* discard */
+			cnt++;
+			*list = this;
+			list = &(this->next);
+			this->next = NULL;
+		}
+		hash[i] = bucket;
 	}
 	free(hash_count);
 
