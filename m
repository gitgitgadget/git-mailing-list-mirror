From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] apply: do not get confused by symlinks in the middle
Date: Thu, 10 May 2007 21:36:53 -0700
Message-ID: <7vmz0cf02i.fsf_-_@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com>
	<81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
	<4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
	<46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 06:37:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmMsK-000134-8g
	for gcvg-git@gmane.org; Fri, 11 May 2007 06:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbXEKEg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 00:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbXEKEg4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 00:36:56 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50630 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXEKEgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 00:36:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511043655.QZQB24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 00:36:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xgcu1W0011kojtg0000000; Fri, 11 May 2007 00:36:55 -0400
In-Reply-To: <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 May 2007 23:44:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46935>

HPA noticed that git-rebase fails when changes involve symlinks
in the middle of the hierarchy.  Consider:

 * The tree state before the patch is applied has arch/x86_64/boot
   as a symlink pointing at ../i386/boot/

 * The patch tries to remove arch/x86_64/boot symlink, and
   create bunch of files there: .gitignore, Makefile, etc.

git-apply tries to be careful while applying patches; it never
touches the working tree until it is convinced that the patch
would apply cleanly.  One of the check it does is that when it
knows a path is going to be created by the patch, it runs
lstat() on the path to make sure it does not exist.

This leads to a false alarm.  Because we do not touch the
working tree before all the check passes, when we try to make
sure that arch/x86_64/boot/.gitignore does not exist yet, we
haven't removed the arch/x86_64/boot symlink.  The lstat() check
ends up seeing arch/i386/boot/.gitignore through the
yet-to-be-removed symlink, and says "Hey, you already have a
file there, but what you fed me is a patch to create a new
file. I am not going to clobber what you have in the working
tree."

We have similar checks to see a file we are going to modify does
exist and match the preimage of the diff, which is done by
directly opening and reading the file.

For a file we are going to delete, we make sure that it does
exist and matches what is going to be removed (a removal patch
records the full preimage, so we check what you have in your
working tree matches it in full -- otherwise we would risk
losing your local changes), which again is done by directly
opening and reading the file.

These checks need to be adjusted so that they are not fooled by
symlinks in the middle.

 - To make sure something does not exist, first lstat().  If it
   does not exist, it does not, so be happy.  If it _does_, we
   might be getting fooled by a symlink in the middle, so break
   leading paths and see if there are symlinks involved.  When
   we are checking for a path a/b/c/d, if any of a, a/b, a/b/c
   is a symlink, then a/b/c/d does _NOT_ exist, for the purpose
   of our test.

   This would fix this particular case you saw, and would not
   add extra overhead in the usual case.

 - To make sure something already exists, first lstat().  If it
   does not exist, barf (up to this, we already do).  Even if it
   does seem to exist, we might be getting fooled by a symlink
   in the middle, so make sure leading paths are not symlinks.

   This would make the normal codepath much more expensive for
   deep trees, which is a bit worrisome.

This patch implements the first side of the check "making sure
it does not exist".  The latter "making sure it exists" check is
not done yet, so applying the patch in reverse would still
fail, but we have to start from somewhere.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This should help the particular rebase go beyond the 0058
   patch.  While developing the new t4122 test I noticed that
   read-tree -m -u (aka git-checkout) seems to have a very
   similar problem, but I haven't dug into that yet.

 builtin-apply.c                 |   69 +++++++++++++++++++++++++++++++++-----
 t/t4122-apply-symlink-inside.sh |   57 ++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 9 deletions(-)
 create mode 100755 t/t4122-apply-symlink-inside.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index f94d0db..38d20ef 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2009,6 +2009,63 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 	return 0;
 }
 
+static int has_symlink_component(const char *new_name)
+{
+	char path[PATH_MAX];
+	const char *sp, *ep;
+	char *dp;
+
+	sp = new_name;
+	dp = path;
+
+	while (1) {
+		size_t len;
+		struct stat st;
+
+		ep = strchr(sp, '/');
+		if (!ep)
+			break;
+		len = ep - sp;
+		if (PATH_MAX <= dp + len - path + 2)
+			return 0; /* new name is longer than that??? */
+		memcpy(dp, sp, len);
+		dp[len] = 0;
+
+		if (lstat(path, &st))
+			return 0; /* why? we already lstat() new_name successfully. */
+		if (S_ISLNK(st.st_mode))
+			return 1;
+
+		dp[len++] = '/';
+		dp = dp + len;
+		sp = ep + 1;
+	}
+	return 0;
+}
+
+static int check_to_create_blob(const char *new_name, int ok_if_exists)
+{
+	struct stat nst;
+	if (!lstat(new_name, &nst)) {
+		if (S_ISDIR(nst.st_mode) || ok_if_exists)
+			return 0;
+		/*
+		 * A leading component of new_name might be a symlink
+		 * that is going to be removed with this patch, but
+		 * still pointing at somewhere that has the path.
+		 * In such a case, path "new_name" does not exist as
+		 * far as git is concerned.
+		 */
+		if (has_symlink_component(new_name))
+			return 0;
+
+		return error("%s: already exists in working directory", new_name);
+	}
+	else if ((errno != ENOENT) && (errno != ENOTDIR))
+		return error("%s: %s", new_name, strerror(errno));
+	return 0;
+}
+
 static int check_patch(struct patch *patch, struct patch *prev_patch)
 {
 	struct stat st;
@@ -2095,15 +2152,9 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 		    !ok_if_exists)
 			return error("%s: already exists in index", new_name);
 		if (!cached) {
-			struct stat nst;
-			if (!lstat(new_name, &nst)) {
-				if (S_ISDIR(nst.st_mode) || ok_if_exists)
-					; /* ok */
-				else
-					return error("%s: already exists in working directory", new_name);
-			}
-			else if ((errno != ENOENT) && (errno != ENOTDIR))
-				return error("%s: %s", new_name, strerror(errno));
+			int err = check_to_create_blob(new_name, ok_if_exists);
+			if (err)
+				return err;
 		}
 		if (!patch->new_mode) {
 			if (0 < patch->is_new)
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
new file mode 100755
index 0000000..37c9a9f
--- /dev/null
+++ b/t/t4122-apply-symlink-inside.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='apply to deeper directory without getting fooled with symlink'
+. ./test-lib.sh
+
+lecho () {
+	for l_
+	do
+		echo "$l_"
+	done
+}
+
+test_expect_success setup '
+
+	mkdir -p arch/i386/boot arch/x86_64 &&
+	lecho 1 2 3 4 5 >arch/i386/boot/Makefile &&
+	ln -s ../i386/boot arch/x86_64/boot &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	git branch test &&
+
+	rm arch/x86_64/boot &&
+	mkdir arch/x86_64/boot &&
+	lecho 2 3 4 5 6 >arch/x86_64/boot/Makefile &&
+	git add . &&
+	test_tick &&
+	git commit -a -m second &&
+
+	git format-patch --binary -1 --stdout >test.patch
+
+'
+
+test_expect_success apply '
+
+	git checkout test &&
+	git reset --hard && #### checkout seems to be buggy
+	git diff --exit-code test &&
+	git diff --exit-code --cached test &&
+	git apply --index test.patch
+
+'
+
+test_expect_success 'check result' '
+
+	git diff --exit-code master &&
+	git diff --exit-code --cached master &&
+	test_tick &&
+	git commit -m replay &&
+	T1=$(git rev-parse "master^{tree}") &&
+	T2=$(git rev-parse "HEAD^{tree}") &&
+	test "z$T1" = "z$T2"
+
+'
+
+test_done
+
-- 
1.5.2.rc3.706.g498a
