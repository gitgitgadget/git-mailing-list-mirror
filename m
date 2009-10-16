From: Jean Privat <jean@pryen.org>
Subject: [PATCH RFC] git describe without refs distinguishes dirty working 
	tree
Date: Fri, 16 Oct 2009 11:12:08 -0400
Message-ID: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyoUf-0002On-1m
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 17:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbZJPPNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbZJPPNG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 11:13:06 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:34413 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbZJPPNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 11:13:04 -0400
Received: by pxi1 with SMTP id 1so273938pxi.33
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=rpfJlZdYHM+tGVXPaVhn1RDQmP91JY1ScAINd1S6fPE=;
        b=WtGQxINffyKGCdoAkjNMA9bk0XAJVRrtZ+A+lRqMRLDnodT/uXmumx3P0Cpvfdmfrm
         pgo28sbBsS8umVzG1fXRKE/NgbscXnBvQXnrBjuUUy3qVYqRE/iMV9gMKNViwx+dZFAF
         V1ikhuhn3xeH1/rEkF/drKNUZQIXG0La7/jSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=Wq4aXPetyVBrKoZ8r65KqQNZUDBmaGyrHDLNdhcG5kmH4z/mjFNoXG9+uk0o/j0ho0
         91jFTvrrBYzmHV/nkd8OE4lmcCOvy+FSr5j31KsmuFkKCOha8E20zXLPNO47cN9A72Z6
         gPp+EoOCtcNbFzcxMde5mMPwKfulvFGv3O/ms=
Received: by 10.140.225.10 with SMTP id x10mr74023rvg.154.1255705948205; Fri, 
	16 Oct 2009 08:12:28 -0700 (PDT)
X-Google-Sender-Auth: d4205a3dee3d9d8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130502>

git describe without refs still works on HEAD but append "-dirty" if the
working three is dirty. If the working tree is clean, nothing is appended.

Previous behavior can be achieved by specifying "HEAD".

Many build scripts use `git describe` to produce a version number.
However, additional git commands are required to distinguish builds done
with a clean tree from builds done with a dirty tree.
This patch helps the writing of these scripts since `git describe` do
the intended thing.

This new behavior could affect existing scripts by producing version
number like v1.0.4-14-g2414721-dirty-dirty.
These scripts could be easily fixed by explicitly using HEAD when calling
`git describe` and works with any version of git.

Signed-off-by: Jean Privat <jean@pryen.org>
---

Initially, I wanted to add an option `--worktree` that works on HEAD and
appends "-dirty" when the working tree is dirty. After rethink I
realized that users (me included) should prefer to describe the working
tree by default, and only describe HEAD if HEAD was explicitly specified.

Note that documentation of `git describe` did not mentioned the behavior
of the command when no committish is specified.
However, since it is still a behavior change. If the patch is accepted,
it could target version 1.7.
---
 Documentation/git-describe.txt |    5 ++++-
 builtin-describe.c             |   18 +++++++++++++++++-
 t/t6120-describe.sh            |    8 ++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index b231dbb..c49ecc8 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -8,7 +8,7 @@ git-describe - Show the most recent tag that is
reachable from a commit

 SYNOPSIS
 --------
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] <committish>...
+'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<committish>...]

 DESCRIPTION
 -----------
@@ -18,6 +18,9 @@ shown.  Otherwise, it suffixes the tag name with the number of
 additional commits on top of the tagged object and the
 abbreviated object name of the most recent commit.

+Without any committish, `git describe` opperates on HEAD and
+appends "-dirty" if the working tree is dirty.
+
 By default (without --all or --tags) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
 see the -a and -s options to linkgit:git-tag[1].
diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..4105d9c 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -5,6 +5,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "diff.h"

 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -23,6 +24,13 @@ static int max_candidates = 10;
 static int found_names;
 static const char *pattern;
 static int always;
+static int dirty; /* Is working tree dirty? */
+
+/* diff-index command arguments to check if working tree is dirty. */
+static const char *diff_index_args[] = {
+	"diff-index", "--quiet", "HEAD", "--", NULL
+};
+

 struct commit_name {
 	struct tag *tag;
@@ -208,6 +216,8 @@ static void describe(const char *arg, int last_one)
 		display_name(n);
 		if (longformat)
 			show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
+		if (dirty)
+			printf("-dirty");
 		printf("\n");
 		return;
 	}
@@ -265,7 +275,10 @@ static void describe(const char *arg, int last_one)
 	if (!match_cnt) {
 		const unsigned char *sha1 = cmit->object.sha1;
 		if (always) {
-			printf("%s\n", find_unique_abbrev(sha1, abbrev));
+			printf("%s", find_unique_abbrev(sha1, abbrev));
+			if (dirty)
+				printf("-dirty");
+			printf("\n");
 			return;
 		}
 		die("cannot describe '%s'", sha1_to_hex(sha1));
@@ -300,6 +313,8 @@ static void describe(const char *arg, int last_one)
 	display_name(all_matches[0].name);
 	if (abbrev)
 		show_suffix(all_matches[0].depth, cmit->object.sha1);
+	if (dirty)
+		printf("-dirty");
 	printf("\n");

 	if (!last_one)
@@ -360,6 +375,7 @@ int cmd_describe(int argc, const char **argv,
const char *prefix)
 	}

 	if (argc == 0) {
+		dirty = cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
diff_index_args, prefix);
 		describe("HEAD", 1);
 	} else {
 		while (argc-- > 0) {
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8c7e081..8938fc6 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -123,6 +123,14 @@ test_expect_success 'rename tag Q back to A' '
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD

+test_expect_success 'set-up dirty working tree' '
+	echo >>file
+'
+
+check_describe "A-*[0-9a-f]-dirty"
+
+check_describe "A-*[0-9a-f]" HEAD
+
 test_expect_success 'set-up matching pattern tests' '
 	git tag -a -m test-annotated test-annotated &&
 	echo >>file &&
-- 
1.6.5
