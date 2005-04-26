From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 13:34:48 -0700
Message-ID: <7vacnlnuon.fsf@assigned-by-dhcp.cox.net>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org>
	<7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org>
	<7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261137350.18901@ppc970.osdl.org>
	<7vk6mpnz96.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504261207380.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWh7-0002Jx-63
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDZUfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVDZUfT
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:35:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49597 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261710AbVDZUez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 16:34:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426203450.SCQJ7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 26 Apr 2005 16:34:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261207380.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 26 Apr 2005 12:09:14 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 26 Apr 2005, Junio C Hamano wrote:
>> 
>> We should just fix "remove-merge-entries" and call that
>> unconditionally before the read-tree is called.  Once it is
>> fixed, we need to think about how to show this stage
>> information but that should be a separate discussion.

LT> I just thought that _if_ you wanted the unmerged parts to show up, then 
LT> the "1//filename.c" thing might be acceptable. Personally, I just think 
LT> diff-cache is pretty nonsensical with unmerged files,

I agree to what you said here.  We are not interested in the
unmerged files in the original GIT_INDEX_FILE at all.

However, remember that "unmerged" entries diff_cache() function
sees are from the tree you are comparing against, either your
GIT_INDEX_FILE (with --cached) or your working tree (without).

Currently I suspect the behaviour of diff-cache without --cached
flag may be broken.  Don't we need to check cached_only before
or inside of the first two if() statements in diff_cache()?  For
a path that appears in the tree you are comparing against (i.e.
stage 1 entries):

 - if GIT_INDEX_FILE does not have it but the working tree does,
   it would still say "deleted".

 - if GIT_INDEX_FILE does have it, the comparison goes against
   that entry, not against the working tree.

Similarly for entries that are not in the stage 1, the code ends
up comparing only the dircache entries and never goes to the
filesystem.

Here is a proposed fix.  When running without --cached,
diff_cache function really goes to the filesystem if the stage 0
entry in GIT_INDEX_FILE does not match what is in the working
tree for these cases.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |   40 ++++++++++++++++++++++++++++++++++++----
1 files changed, 36 insertions(+), 4 deletions(-)

./jit-snap -v 3:6
# - 04/26 12:25 Fix agreed with Linus.
# + 04/26 13:26 Proposed fix.
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -10,6 +10,19 @@ static void show_file(const char *prefix
 	       sha1_to_hex(ce->sha1), ce->name, line_termination);
 }
 
+/* A file *may* have been added to the working tree */
+static void show_possible_local_add(struct cache_entry *new)
+{
+	static unsigned char no_sha1[20];
+	struct stat st;
+	if (stat(new->name, &st) < 0)
+		return; /* no, working tree does not have one. */
+	if (cache_match_stat(new, &st))
+		return show_file("+", new);
+
+	printf("+%o\t%s\t%s\t%s%c", st.st_mode, "blob",
+	       sha1_to_hex(no_sha1), new->name, line_termination);
+}
 static int show_modified(struct cache_entry *old, struct cache_entry *new)
 {
 	unsigned int mode = ntohl(new->ce_mode), oldmode;
@@ -29,6 +42,8 @@ static int show_modified(struct cache_en
 			mode = st.st_mode;
 			sha1 = no_sha1;
 		}
+		else if (old == new)
+			return 0;
 	}
 
 	oldmode = ntohl(old->ce_mode);
@@ -48,16 +63,33 @@ static int diff_cache(struct cache_entry
 	while (entries) {
 		struct cache_entry *ce = *ac;
 
-		/* No matching 0-stage (current) entry? Show it as deleted */
+		/* No matching 0-stage (current) entry?
+		 * Show it as deleted.
+		 */
 		if (ce_stage(ce)) {
-			show_file("-", ce);
+			/* ... well, not so fast.  We may have it in the
+			 * working tree and operating without --cache.
+			 */
+			if (cached_only)
+				show_file("-", ce);
+			else
+				/* this is sneaky but it works.  trust me. */
+				show_modified(ce, ce);
 			ac++;
 			entries--;
 			continue;
 		}
-		/* No matching 1-stage (tree) entry? Show the current one as added */
+		/* No matching 1-stage (tree) entry?
+		 * Show the current one as added.
+		 */
 		if (entries == 1 || !same_name(ce, ac[1])) {
-			show_file("+", ce);
+			/* ... again, we may not have that in the
+			 * working tree and operating without --cache.
+			 */
+			if (cached_only)
+				show_file("+", ce);
+			else
+				show_possible_local_add(ce);
 			ac++;
 			entries--;
 			continue;


