From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: notice "diff --git" patch again
Date: Wed, 21 Feb 2007 14:31:10 -0800
Message-ID: <7vy7mrm9ch.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702210014140.6485@iabervon.org>
	<Pine.LNX.4.64.0702210836210.4043@woody.linux-foundation.org>
	<7vr6sjnw15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 23:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJzzY-0004mQ-54
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 23:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423192AbXBUWbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423208AbXBUWbN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 17:31:13 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37313 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423192AbXBUWbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 17:31:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221223112.MALE2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 17:31:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SNX91W00W1kojtg0000000; Wed, 21 Feb 2007 17:31:10 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40328>

Earlier one that tried to be too consistent with GNU patch by
not stripping the leading path when we _know_ we are in a
subdirectory and the patch is relative to the toplevel was a
mistake.  This fixes it.

 - No change to behaviour when it is run from the toplevel of
   the repository.

 - When run from a subdirectory to apply a git-generated patch, 
   it uses the right -p<n> value automatically, with or without
   --index nor --cached option.

 - When run from a subdirectory to apply a randomly generated
   patch, it wants the right -p<n> value to be given by the
   user.

The second one is a pure improvement to correct inconsistency
between --index and non --index case, compared with 1.5.0.  The
third point could be further improved to guess what the right
value for -p<n> should be by looking at the patch, but should be
a topic of a separate patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c         |   23 ++++++++++++++++-------
 t/t4119-apply-config.sh |    4 ++--
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1beebe5..12f00e3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -144,6 +144,7 @@ struct patch {
 	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
+	unsigned int is_toplevel_relative:1;
 	unsigned int inaccurate_eof:1;
 	unsigned int is_binary:1;
 	unsigned int is_copy:1;
@@ -362,7 +363,7 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+		return find_name(line, NULL, 1, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -372,7 +373,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		len = strlen(name);
 		if (isnull)
 			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
-		another = find_name(line, NULL, p_value, TERM_TAB);
+		another = find_name(line, NULL, 1, TERM_TAB);
 		if (!another || memcmp(another, name, len))
 			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
@@ -427,28 +428,28 @@ static int gitdiff_newfile(const char *line, struct patch *patch)
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->old_name = find_name(line, NULL, p_value-1, 0);
+	patch->old_name = find_name(line, NULL, 0, 0);
 	return 0;
 }
 
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->new_name = find_name(line, NULL, p_value-1, 0);
+	patch->new_name = find_name(line, NULL, 0, 0);
 	return 0;
 }
 
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->old_name = find_name(line, NULL, p_value-1, 0);
+	patch->old_name = find_name(line, NULL, 0, 0);
 	return 0;
 }
 
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->new_name = find_name(line, NULL, p_value-1, 0);
+	patch->new_name = find_name(line, NULL, 0, 0);
 	return 0;
 }
 
@@ -787,6 +788,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 {
 	unsigned long offset, len;
 
+	patch->is_toplevel_relative = 0;
 	patch->is_rename = patch->is_copy = 0;
 	patch->is_new = patch->is_delete = -1;
 	patch->old_mode = patch->new_mode = 0;
@@ -831,6 +833,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 					die("git diff header lacks filename information (line %d)", linenr);
 				patch->old_name = patch->new_name = patch->def_name;
 			}
+			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
@@ -2499,6 +2502,12 @@ static int use_patch(struct patch *p)
 			return 0;
 		x = x->next;
 	}
+	if (0 < prefix_length) {
+		int pathlen = strlen(pathname);
+		if (pathlen <= prefix_length ||
+		    memcmp(prefix, pathname, prefix_length))
+			return 0;
+	}
 	return 1;
 }
 
@@ -2513,7 +2522,7 @@ static void prefix_one(char **name)
 
 static void prefix_patches(struct patch *p)
 {
-	if (!prefix)
+	if (!prefix || p->is_toplevel_relative)
 		return;
 	for ( ; p; p = p->next) {
 		if (p->new_name == p->old_name) {
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index f9b9425..32e0d71 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -78,7 +78,7 @@ test_expect_success 'apply --whitespace=strip in subdir' '
 	git update-index --refresh &&
 
 	cd sub &&
-	git apply --whitespace=strip -p2 ../patch.file &&
+	git apply --whitespace=strip ../patch.file &&
 	if grep " " file1
 	then
 		echo "Eh?"
@@ -101,7 +101,7 @@ test_expect_success 'apply --whitespace=strip from config in subdir' '
 	git update-index --refresh &&
 
 	cd sub &&
-	git apply -p2 ../patch.file &&
+	git apply ../patch.file &&
 	if grep " " file1
 	then
 		echo "Eh?"
