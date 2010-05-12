From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 01:00:54 +0200
Message-ID: <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Cc: msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 01:01:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCKvZ-0004Tr-T2
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 01:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758414Ab0ELXBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 19:01:10 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:44545 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437Ab0ELXBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 19:01:06 -0400
Received: by ey-out-2122.google.com with SMTP id d26so172792eyd.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=knvd7SD/wlCFTV0jAKNQFmsNLqPCozhXAEQ6Dr4epZw=;
        b=miKes8x7lgkaoVSn3Zdt02vuYjCMDUGUsWYeEg0obf8DxoKL4j+gsWcBG5rGjsaVz1
         A8YZPZdlMvD0wUI3QUMSxXoYXHNUw5+YqpM/wZpTx+d6eFL2v1aG6REP/nOdmxdu6gK/
         PrN2GOvF8qmkDrI9zMh5FD/5U+addSqgkdYCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iE9uh5mrk8AEmbS+jvraEY2IKZsNdO2ciwkSQGHTtLbE5qnGJS+1wTRGjxByhFphpF
         pXlx466eh3M7LmZOvmyXlVyk1GsLiQqRqA5hjiSPb/7Y6Ka9U+HHKucvEXqJvZwFOSYa
         1x1A3HW7MtQBDYa0Z/hfrNqk3TgF44809V5J8=
Received: by 10.213.40.5 with SMTP id i5mr969317ebe.8.1273705265155;
        Wed, 12 May 2010 16:01:05 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm365675ewy.4.2010.05.12.16.01.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 16:01:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.5.gd739a
In-Reply-To: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146963>

As discussed at length on the list, "crlf" is a pretty bad name for an
attribute that enables end-of-line conversion, and the addition of "lf"
and "crlf" values for it doesn't help.

Rename the attribute "eolconv", but fall back to "crlf" for backwards
compatibility if "eolconv" is not set.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 Documentation/gitattributes.txt |   51 ++++++++++++++++++++------------------
 attr.c                          |    2 +-
 convert.c                       |   15 ++++++++---
 git-cvsserver.perl              |    8 ++++-
 t/t0025-crlf-auto.sh            |   31 ++++++++++++++++-------
 5 files changed, 67 insertions(+), 40 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index bb3b446..2887f85 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -92,30 +92,33 @@ such as 'git checkout' and 'git merge' run.  They also affect how
 git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
-`crlf`
-^^^^^^
+`eolconv`
+^^^^^^^^^
 
 This attribute enables and controls end-of-line normalization.  When a
 text file is normalized, its line endings are converted to LF in the
 repository.  Text files can have their line endings converted to
-CRLF in the working directory, using the `crlf` attribute for
+CRLF in the working directory, using the `eolconv` attribute for
 individual files or the `core.autocrlf` configuration variable for all
 files.
 
+For compatibility with older versions of git, `crlf` is an alias for
+this attribute.
+
 Set::
 
-	Setting the `crlf` attribute on a path enables end-of-line
+	Setting the `eolconv` attribute on a path enables end-of-line
 	normalization and marks the path as a text file.  End-of-line
 	conversion takes place without guessing the content type.
 
 Unset::
 
-	Unsetting the `crlf` attribute on a path tells git not to
+	Unsetting the `eolconv` attribute on a path tells git not to
 	attempt any end-of-line conversion upon checkin or checkout.
 
 Set to string value "auto"::
 
-	When `crlf` is set to "auto", the path is marked for automatic
+	When `eolconv` is set to "auto", the path is marked for automatic
 	end-of-line normalization.  If git decides that the content is
 	text, its line endings are normalized to LF on checkin.
 
@@ -134,13 +137,13 @@ Set to string value "lf"::
 
 Unspecified::
 
-	Leaving the `crlf` attribute unspecified tells git to apply
+	Leaving the `eolconv` attribute unspecified tells git to apply
 	end-of-line normalization only if the `core.autocrlf`
 	configuration variable is set, the content appears to be text,
 	and the file is either new or already normalized in the
 	repository.
 
-Any other value causes git to act as if `crlf` has been left
+Any other value causes git to act as if `eolconv` has been left
 unspecified.
 
 
@@ -157,10 +160,10 @@ the working directory, and prevent .jpg files from being normalized
 regardless of their content.
 
 ------------------------
-*.txt		crlf
-*.vcproj	crlf=crlf
-*.sh		crlf=lf
-*.jpg		-crlf
+*.txt		eolconv
+*.vcproj	eolconv=crlf
+*.sh		eolconv=lf
+*.jpg		-eolconv
 ------------------------
 
 Other source code management systems normalize all text files in their
@@ -185,24 +188,24 @@ files without conversion to CRLF in the working directory.
 
 If you want to interoperate with a source code management system that
 enforces end-of-line normalization, or you simply want all text files
-in your repository to be normalized, you should instead set the `crlf`
+in your repository to be normalized, you should instead set the `eolconv`
 attribute to "auto" for _all_ files.
 
 ------------------------
-*	crlf=auto
+*	eolconv=auto
 ------------------------
 
 This ensures that all files that git considers to be text will have
 normalized (LF) line endings in the repository.
 
-NOTE: When `crlf=auto` normalization is enabled in an existing
+NOTE: When `eolconv=auto` normalization is enabled in an existing
 repository, any text files containing CRLFs should be normalized.  If
 they are not they will be normalized the next time someone tries to
 change them, causing unfortunate misattribution.  From a clean working
 directory:
 
 -------------------------------------------------
-$ echo "* crlf=auto" >>.gitattributes
+$ echo "* eolconv=auto" >>.gitattributes
                     # ...this should be the first line in .gitattributes
 $ rm .git/index     # Remove the index to force git to
 $ git reset         # re-scan the working directory
@@ -213,17 +216,17 @@ $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
 If any files that should not be normalized show up in 'git status',
-unset their `crlf` attribute before running 'git add -u'.
+unset their `eolconv` attribute before running 'git add -u'.
 
 ------------------------
-manual.pdf	-crlf
+manual.pdf	-eolconv
 ------------------------
 
 Conversely, text files that git does not detect can have normalization
 enabled manually.
 
 ------------------------
-weirdchars.txt	crlf
+weirdchars.txt	eolconv
 ------------------------
 
 If `core.safecrlf` is set to "true" or "warn", git verifies if
@@ -309,11 +312,11 @@ Interaction between checkin/checkout attributes
 In the check-in codepath, the worktree file is first converted
 with `filter` driver (if specified and corresponding driver
 defined), then the result is processed with `ident` (if
-specified), and then finally with `crlf` (again, if specified
+specified), and then finally with `eolconv` (again, if specified
 and applicable).
 
 In the check-out codepath, the blob content is first converted
-with `crlf`, and then `ident` and fed to `filter`.
+with `eolconv`, and then `ident` and fed to `filter`.
 
 
 Generating diff text
@@ -717,7 +720,7 @@ You do not want any end-of-line conversions applied to, nor textual diffs
 produced for, any binary file you track.  You would need to specify e.g.
 
 ------------
-*.jpg -crlf -diff
+*.jpg -eolconv -diff
 ------------
 
 but that may become cumbersome, when you have many attributes.  Using
@@ -730,7 +733,7 @@ the same time.  The system knows a built-in attribute macro, `binary`:
 
 which is equivalent to the above.  Note that the attribute macros can only
 be "Set" (see the above example that sets "binary" macro as if it were an
-ordinary attribute --- setting it in turn unsets "crlf" and "diff").
+ordinary attribute --- setting it in turn unsets "eolconv" and "diff").
 
 
 DEFINING ATTRIBUTE MACROS
@@ -741,7 +744,7 @@ at the toplevel (i.e. not in any subdirectory).  The built-in attribute
 macro "binary" is equivalent to:
 
 ------------
-[attr]binary -diff -crlf
+[attr]binary -diff -eolconv
 ------------
 
 
diff --git a/attr.c b/attr.c
index f5346ed..7f924bc 100644
--- a/attr.c
+++ b/attr.c
@@ -287,7 +287,7 @@ static void free_attr_elem(struct attr_stack *e)
 }
 
 static const char *builtin_attr[] = {
-	"[attr]binary -diff -crlf",
+	"[attr]binary -diff -eolconv",
 	NULL,
 };
 
diff --git a/convert.c b/convert.c
index 0eb3d4b..b46f85d 100644
--- a/convert.c
+++ b/convert.c
@@ -438,11 +438,13 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 
 static void setup_convert_check(struct git_attr_check *check)
 {
+	static struct git_attr *attr_eolconv;
 	static struct git_attr *attr_crlf;
 	static struct git_attr *attr_ident;
 	static struct git_attr *attr_filter;
 
 	if (!attr_crlf) {
+		attr_eolconv = git_attr("eolconv");
 		attr_crlf = git_attr("crlf");
 		attr_ident = git_attr("ident");
 		attr_filter = git_attr("filter");
@@ -452,6 +454,7 @@ static void setup_convert_check(struct git_attr_check *check)
 	check[0].attr = attr_crlf;
 	check[1].attr = attr_ident;
 	check[2].attr = attr_filter;
+	check[3].attr = attr_eolconv;
 }
 
 static int count_ident(const char *cp, unsigned long size)
@@ -639,7 +642,7 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 int convert_to_git(const char *path, const char *src, size_t len,
                    struct strbuf *dst, enum safe_crlf checksafe)
 {
-	struct git_attr_check check[3];
+	struct git_attr_check check[4];
 	int crlf = CRLF_GUESS;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
@@ -647,7 +650,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check + 0);
+		crlf = git_path_check_crlf(path, check + 3);
+		if (crlf == CRLF_GUESS)
+			crlf = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->clean)
@@ -669,7 +674,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	struct git_attr_check check[3];
+	struct git_attr_check check[4];
 	int crlf = CRLF_GUESS;
 	int ident = 0, ret = 0;
 	const char *filter = NULL;
@@ -677,7 +682,9 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 	setup_convert_check(check);
 	if (!git_checkattr(path, ARRAY_SIZE(check), check)) {
 		struct convert_driver *drv;
-		crlf = git_path_check_crlf(path, check + 0);
+		crlf = git_path_check_crlf(path, check + 3);
+		if (crlf == CRLF_GUESS)
+			crlf = git_path_check_crlf(path, check + 0);
 		ident = git_path_check_ident(path, check + 1);
 		drv = git_path_check_convert(path, check + 2);
 		if (drv && drv->smudge)
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 13751db..ede47a6 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2369,8 +2369,12 @@ sub kopts_from_path
     if ( defined ( $cfg->{gitcvs}{usecrlfattr} ) and
          $cfg->{gitcvs}{usecrlfattr} =~ /\s*(1|true|yes)\s*$/i )
     {
-        my ($val) = check_attr( "crlf", $path );
-        if ( $val eq "set" )
+        my ($val) = check_attr( "eolconv", $path );
+        if ( $val eq "unspecified" )
+        {
+            $val = check_attr( "crlf", $path );
+        }
+        if ( $val =~ /^(set|crlf|lf)$/ )
         {
             return "";
         }
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index f11fee4..05e5725 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -41,9 +41,22 @@ test_expect_success 'default settings cause no changes' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_success 'crlf=true causes a CRLF file to be normalized' '
+test_expect_success 'eolconv=true causes a CRLF file to be normalized' '
 
 	rm -f .gitattributes tmp one two &&
+	echo "two eolconv" > .gitattributes &&
+	git read-tree --reset -u HEAD &&
+
+	# Note, "normalized" means that git will normalize it if added
+	has_cr two &&
+	twodiff=`git diff two` &&
+	test -n "$twodiff"
+'
+
+test_expect_success 'crlf=true also causes a CRLF file to be normalized' '
+
+	# Backwards compatilibity check
+	rm -f .gitattributes tmp one two &&
 	echo "two crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
@@ -53,11 +66,11 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 	test -n "$twodiff"
 '
 
-test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=false' '
+test_expect_success 'eolconv=crlf gives a normalized file CRLFs with autocrlf=false' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf false &&
-	echo "one crlf=crlf" > .gitattributes &&
+	echo "one eolconv=crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	has_cr one &&
@@ -65,11 +78,11 @@ test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=false
 	test -z "$onediff"
 '
 
-test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=input' '
+test_expect_success 'eolconv=crlf gives a normalized file CRLFs with autocrlf=input' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf input &&
-	echo "one crlf=crlf" > .gitattributes &&
+	echo "one eolconv=crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	has_cr one &&
@@ -77,11 +90,11 @@ test_expect_success 'crlf=crlf gives a normalized file CRLFs with autocrlf=input
 	test -z "$onediff"
 '
 
-test_expect_success 'crlf=lf gives a normalized file LFs with autocrlf=true' '
+test_expect_success 'eolconv=lf gives a normalized file LFs with autocrlf=true' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf true &&
-	echo "one crlf=lf" > .gitattributes &&
+	echo "one eolconv=lf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	! has_cr one &&
@@ -102,11 +115,11 @@ test_expect_success 'autocrlf=true does not normalize CRLF files' '
 	test -z "$onediff" -a -z "$twodiff"
 '
 
-test_expect_success 'crlf=auto, autocrlf=true _does_ normalize CRLF files' '
+test_expect_success 'eolconv=auto, autocrlf=true _does_ normalize CRLF files' '
 
 	rm -f .gitattributes tmp one two &&
 	git config core.autocrlf true &&
-	echo "* crlf=auto" > .gitattributes &&
+	echo "* eolconv=auto" > .gitattributes &&
 	git read-tree --reset -u HEAD &&
 
 	has_cr one &&
-- 
1.7.1.3.g448cb.dirty
