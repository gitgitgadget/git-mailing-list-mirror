From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Racy git: avoid having to be always too careful
Date: Sat, 05 Aug 2006 04:20:26 -0700
Message-ID: <7virl7e8ed.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 13:20:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KCl-0003Ek-SR
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWHELU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161312AbWHELU2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:20:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37260 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161311AbWHELU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 07:20:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805112027.LFBZ6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 07:20:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 31 Jul 2006 09:55:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24906>

Immediately after a bulk checkout, most of the paths in the
working tree would have the same timestamp as the index file,
and this would force ce_match_stat() to take slow path for all
of them.  When writing an index file out, if many of the paths
have very new (read: the same timestamp as the index file being
written out) timestamp, we are better off delaying the return
from the command, to make sure that later command to touch the
working tree files will leave newer timestamps than recorded in
the index, thereby avoiding to take the slow path.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Linus Torvalds <torvalds@osdl.org> writes:

> Doing an "strace" on "git diff" shows that we close() a file descriptor 
> twice (getting EBADFD on the second one) when we end up in ce_compare_data 
> if the index does not match the checked-out stat information.
>
> The "index_fd()" function will already have closed the fd for us, so we 
> should not close it again.
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> The way I found this also showed a potential performance problem: if you 
> do a "git reset --hard" (or similar) after you have changes in your tree, 
> it will write the index file with the same timestamp as the checked out 
> files that it re-wrote.
>
> That will also then forever afterwards (well, until the next "git 
> update-index --refresh") cause the "uncommon" timestamp case in 
> ce_match_stat(), where we check the index-file timestamp against the 
> timestamp of the stat data, to trigger.
>
> Not very good. The "ce_modified_check_fs()" tests can be quite expensive 
> if you have lots of those files because we end up then calling the 
> "ce_compare_data()" function a lot. And suddenly "git diff" doesn't take a 
> tenth of a second any more.
>
> We should really try to have some way to re-generate the index 
> automatically when this case triggers, so that we only need to do it 
> _once_ rather than keep doing it forever while the index is "potentially 
> stale".
>
> Any ideas?

Here is what I came up with.  I am not very happy with its
magic, but should be better than nothing.

 read-cache.c |   44 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f92cdaa..ce76c20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "cache-tree.h"
+#include <time.h>
 
 /* Index extensions.
  *
@@ -923,7 +924,7 @@ static void ce_smudge_racily_clean_entry
 		 * $ echo filfre >nitfol
 		 * $ git-update-index --add nitfol
 		 *
-		 * but it does not.  Whe the second update-index runs,
+		 * but it does not.  When the second update-index runs,
 		 * it notices that the entry "frotz" has the same timestamp
 		 * as index, and if we were to smudge it by resetting its
 		 * size to zero here, then the object name recorded
@@ -945,7 +946,9 @@ int write_cache(int newfd, struct cache_
 {
 	SHA_CTX c;
 	struct cache_header hdr;
-	int i, removed;
+	int i, removed, recent;
+	struct stat st;
+	time_t now;
 
 	for (i = removed = 0; i < entries; i++)
 		if (!cache[i]->ce_mode)
@@ -959,15 +962,19 @@ int write_cache(int newfd, struct cache_
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
+	now = fstat(newfd, &st) ? 0 : st.st_mtime;
+	recent = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
+		time_t entry_time = (time_t) ntohl(ce->ce_mtime.sec);
 		if (!ce->ce_mode)
 			continue;
-		if (index_file_timestamp &&
-		    index_file_timestamp <= ntohl(ce->ce_mtime.sec))
+		if (index_file_timestamp && index_file_timestamp <= entry_time)
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
+		if (now && now <= entry_time)
+			recent++;
 	}
 
 	/* Write extension data here */
@@ -983,5 +990,34 @@ int write_cache(int newfd, struct cache_
 			return -1;
 		}
 	}
+
+	/*
+	 * To prevent later ce_match_stat() from always falling into
+	 * check_fs(), if we have too many entries that can trigger
+	 * racily clean check, we are better off delaying the return.
+	 * We arbitrarily say if more than 20 paths or 25% of total
+	 * paths are very new, we delay the return until the index
+	 * file gets a new timestamp.
+	 *
+	 * NOTE! NOTE! NOTE!
+	 *
+	 * This assumes that nobody is touching the working tree while
+	 * we are updating the index.
+	 */
+	if (20 < recent || entries <= recent * 4) {
+		now = fstat(newfd, &st) ? 0 : st.st_mtime;
+		while (now && !fstat(newfd, &st) && st.st_mtime <= now) {
+			struct timespec rq, rm;
+			off_t where = lseek(newfd, 0, SEEK_CUR);
+			rq.tv_sec = 0;
+			rq.tv_nsec = 250000000;
+			nanosleep(&rq, &rm);
+			if ((where == (off_t) -1) ||
+			    (write(newfd, "", 1) != 1) ||
+			    (lseek(newfd, -1, SEEK_CUR) != where) ||
+			    ftruncate(newfd, where))
+				break;
+		}
+	}
 	return ce_flush(&c, newfd);
 }
-- 
1.4.2.rc3.g19a8a
