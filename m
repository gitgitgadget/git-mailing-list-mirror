From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-apply: require -p<n> when working in a subdirectory.
Date: Mon, 19 Feb 2007 17:57:29 -0800
Message-ID: <7vr6sl381i.fsf_-_@assigned-by-dhcp.cox.net>
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
	<7vps854qf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 20 02:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJKGG-0002WY-NC
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 02:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbXBTB5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 20:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbXBTB5c
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 20:57:32 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38598 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbXBTB5a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 20:57:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220015730.BCRJ1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 19 Feb 2007 20:57:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RdxV1W00D1kojtg0000000; Mon, 19 Feb 2007 20:57:30 -0500
In-Reply-To: <7vps854qf8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Feb 2007 16:35:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40196>

git-apply running inside a subdirectory, with or without --index,
used to always assume that the patch is formatted in such a way
to apply with -p1 from the toplevel, but it is more useful and
consistent with the use of "GNU patch -p1" if it defaulted to
assume that its input is meant to apply at the level it is
invoked in.

This changes the behaviour.  It used to be that the patch
generated this way would apply without any trick:

	edit Documentation/Makefile
	git diff >patch.file
	cd Documentation
	git apply ../patch.file

You need to give an explicit -p2 to git-apply now.  On the other
hand, if you got a patch from somebody else who did not follow
"patch is to apply from the top with -p1" convention, the input
patch would start with:

	diff -u Makefile.old Makefile
	--- Makefile.old
	+++ Makefile

and in such a case, you can apply it with:

	git apply -p0 patch.file

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This also makes "git apply" to honor -p<n> option even on git
   generated patches ("diff --git").

 builtin-apply.c         |   46 ++++++++++++++++++++++++++++++----------------
 t/t4119-apply-config.sh |   32 ++++++++++++++++++--------------
 2 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 6153791..53f286e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -238,7 +238,7 @@ static int name_terminate(const char *name, int namelen, int c, int terminate)
 	return 1;
 }
 
-static char * find_name(const char *line, char *def, int p_value, int terminate)
+static char *find_name(const char *line, char *def, int p_value, int terminate)
 {
 	int len;
 	const char *start = line;
@@ -362,7 +362,7 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, const char *oldnew)
 {
 	if (!orig_name && !isnull)
-		return find_name(line, NULL, 1, TERM_TAB);
+		return find_name(line, NULL, p_value, TERM_TAB);
 
 	if (orig_name) {
 		int len;
@@ -372,7 +372,7 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
 		len = strlen(name);
 		if (isnull)
 			die("git-apply: bad git-diff - expected /dev/null, got %s on line %d", name, linenr);
-		another = find_name(line, NULL, 1, TERM_TAB);
+		another = find_name(line, NULL, p_value, TERM_TAB);
 		if (!another || memcmp(another, name, len))
 			die("git-apply: bad git-diff - inconsistent %s filename on line %d", oldnew, linenr);
 		free(another);
@@ -427,28 +427,28 @@ static int gitdiff_newfile(const char *line, struct patch *patch)
 static int gitdiff_copysrc(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, p_value-1, 0);
 	return 0;
 }
 
 static int gitdiff_copydst(const char *line, struct patch *patch)
 {
 	patch->is_copy = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, p_value-1, 0);
 	return 0;
 }
 
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->old_name = find_name(line, NULL, 0, 0);
+	patch->old_name = find_name(line, NULL, p_value-1, 0);
 	return 0;
 }
 
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
 	patch->is_rename = 1;
-	patch->new_name = find_name(line, NULL, 0, 0);
+	patch->new_name = find_name(line, NULL, p_value-1, 0);
 	return 0;
 }
 
@@ -2394,7 +2394,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 {
 	if (patch->is_delete > 0) {
 		if (phase == 0)
-			remove_file(patch);
+			remove_file(patch, 1);
 		return;
 	}
 	if (patch->is_new > 0 || patch->is_copy) {
@@ -2407,7 +2407,7 @@ static void write_out_one_result(struct patch *patch, int phase)
 	 * thing: remove the old, write the new
 	 */
 	if (phase == 0)
-		remove_file(patch);
+		remove_file(patch, 0);
 	if (phase == 1)
 		create_file(patch);
 }
@@ -2520,15 +2520,26 @@ static int use_patch(struct patch *p)
 			return 0;
 		x = x->next;
 	}
-	if (0 < prefix_length) {
-		int pathlen = strlen(pathname);
-		if (pathlen <= prefix_length ||
-		    memcmp(prefix, pathname, prefix_length))
-			return 0;
-	}
 	return 1;
 }
 
+static char *prefix_one(char *name)
+{
+	if (!name)
+		return name;
+	return xstrdup(prefix_filename(prefix, prefix_length, name));
+}
+
+static void prefix_patches(struct patch *p)
+{
+	if (!prefix)
+		return;
+	for ( ; p; p = p->next) {
+		p->new_name = prefix_one(p->new_name);
+		p->old_name = prefix_one(p->old_name);
+	}
+}
+
 static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 {
 	unsigned long offset, size;
@@ -2551,11 +2562,14 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 			break;
 		if (apply_in_reverse)
 			reverse_patches(patch);
+		if (prefix)
+			prefix_patches(patch);
 		if (use_patch(patch)) {
 			patch_stats(patch);
 			*listp = patch;
 			listp = &patch->next;
-		} else {
+		}
+		else {
 			/* perhaps free it a bit better? */
 			free(patch);
 			skipped_patch++;
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 0e8ea7e..816b5b8 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -10,20 +10,22 @@ test_description='git-apply --whitespace=strip and configuration file.
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo A >file1 &&
-	cp file1 saved &&
-	git add file1 &&
-	echo "B " >file1 &&
+	mkdir sub &&
+	echo A >sub/file1 &&
+	cp sub/file1 saved &&
+	git add sub/file1 &&
+	echo "B " >sub/file1 &&
 	git diff >patch.file
 '
 
 test_expect_success 'apply --whitespace=strip' '
 
-	cp saved file1 &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
 	git update-index --refresh &&
 
 	git apply --whitespace=strip patch.file &&
-	if grep " " file1
+	if grep " " sub/file1
 	then
 		echo "Eh?"
 		false
@@ -34,12 +36,13 @@ test_expect_success 'apply --whitespace=strip' '
 
 test_expect_success 'apply --whitespace=strip from config' '
 
-	cp saved file1 &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
 	git update-index --refresh &&
 
 	git config apply.whitespace strip &&
 	git apply patch.file &&
-	if grep " " file1
+	if grep " " sub/file1
 	then
 		echo "Eh?"
 		false
@@ -48,19 +51,19 @@ test_expect_success 'apply --whitespace=strip from config' '
 	fi
 '
 
-mkdir sub
 D=`pwd`
 
 test_expect_success 'apply --whitespace=strip in subdir' '
 
 	cd "$D" &&
 	git config --unset-all apply.whitespace
-	cp saved file1 &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
 	git update-index --refresh &&
 
 	cd sub &&
-	git apply --whitespace=strip ../patch.file &&
-	if grep " " ../file1
+	git apply --whitespace=strip -p2 ../patch.file &&
+	if grep " " file1
 	then
 		echo "Eh?"
 		false
@@ -73,11 +76,12 @@ test_expect_success 'apply --whitespace=strip from config in subdir' '
 
 	cd "$D" &&
 	git config apply.whitespace strip &&
-	cp saved file1 &&
+	rm -f sub/file1 &&
+	cp saved sub/file1 &&
 	git update-index --refresh &&
 
 	cd sub &&
-	git apply ../patch.file &&
+	git apply -p2 ../patch.file &&
 	if grep " " file1
 	then
 		echo "Eh?"
-- 
1.5.0.1.555.g13b30
