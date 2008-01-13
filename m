From: Steffen Prohaska <prohaska@zib.de>
Subject: [WIP v2] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sun, 13 Jan 2008 10:05:02 +0100
Message-ID: <12002151022583-git-send-email-prohaska@zib.de>
References: <20080112191429.GI2963@dpotapov.dyndns.org>
Cc: torvalds@linux-foundation.org, Steffen Prohaska <prohaska@zib.de>
To: dpotapov@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 10:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDynH-0002en-5v
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 10:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbYAMJFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 04:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbYAMJFR
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 04:05:17 -0500
Received: from mailer.zib.de ([130.73.108.11]:46639 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYAMJFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 04:05:11 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0D953Hg016774;
	Sun, 13 Jan 2008 10:05:03 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0D952nZ000048;
	Sun, 13 Jan 2008 10:05:03 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <20080112191429.GI2963@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70375>

This version gets the naked LF/autocrlf=true case right.
However, different from what Dimitry suggested, the safety check
is run for all cases that are irreversible.  Dimitry suggested to
run it only for the CRLF_GUESS case.  I believe this is not
sufficient: the explicit CFLF_TEXT case should also be checked.
The user explicitly marked the file as text but the conversion is
nonetheless irreversible in the current setting.  This might be
unexpected and we should warn about it.  Paranoid users can even
ask git to fail in this case.  Such users would need to manually
fix the file, e.g. running dos2unix.

I also added basic tests.

A documentation is yet missing.

    Steffen

---- snip snap ---

CRLF conversion bears a slight chance of corrupting data.
autocrlf=true will convert CRLF to LF during commit and LF to
CRLF during checkout.  A file that containes a mixture of LF and
CRLF before the commit cannot be recreated by git.  For text
files this does not really matter because we do not care about
the line endings anyway; but for binary files that are
accidentally classified as text the conversion can result in
corrupted data.

If you recognize such corruption during commit you can easily fix
it by setting the conversion type explicitly in .gitattributes.
Right after committing you still have the original file in your
work tree and this file is not yet corrupted.

However, in mixed Windows/Unix environments text files quite
easily can end up containing a mixture of CRLF and LF line
endings and git should handle such situations gracefully.  For
example a user could copy a CRLF file from Windows to Unix and
mix it with an existing LF file there.  The result would contain
both types of line endings.

Unfortunately, the desired effect of cleaning up text files
with mixed lineendings and undesired effect of corrupting binary
files can not be distinguished.  In both cases CRLF are removed
in an irreversible way.  For text files this is the right thing
to do, while for binary file its corrupting data.

In a sane environment committing and checking out the same file
should not modify the origin file in the work tree.  For
autocrlf=input the original file must not contain CRLF.  For
autocrlf=true the original file must not contain LF without
preceding CR.  Otherwise the conversion is irreversible.  Note,
git might be able to recreate the original file with different
autocrlf settings, but in the current environment checking out
will yield a file that differs from the file before the commit.

This patch adds a mechanism that can either warn the user about
an irreversible conversion or can even refuse to convert.  The
mechanism is controlled by the variable core.safecrlf, with the
following values
 - false: disable safecrlf mechanism
 - warn: warn about irreversible conversions
 - true: refuse irreversible conversions

The default is to warn.

The concept of a safety check was originally proposed in a similar
way by Linus Torvalds.  Thanks to Dimitry Potapov for insisting
on getting the naked LF/autocrlf=true case right.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h         |    8 ++++++++
 config.c        |    9 +++++++++
 convert.c       |   28 +++++++++++++++++++++++++---
 environment.c   |    1 +
 t/t0020-crlf.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..4e03e3d 100644
--- a/cache.h
+++ b/cache.h
@@ -330,6 +330,14 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 
+enum safe_crlf {
+	SAFE_CRLF_FALSE = 0,
+	SAFE_CRLF_FAIL = 1,
+	SAFE_CRLF_WARN = 2,
+};
+
+extern enum safe_crlf safe_crlf;
+
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
 extern int check_repository_format(void);
diff --git a/config.c b/config.c
index 857deb6..0a46046 100644
--- a/config.c
+++ b/config.c
@@ -407,6 +407,15 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.safecrlf")) {
+		if (value && !strcasecmp(value, "warn")) {
+			safe_crlf = SAFE_CRLF_WARN;
+			return 0;
+		}
+		safe_crlf = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/convert.c b/convert.c
index 4df7559..c9678ee 100644
--- a/convert.c
+++ b/convert.c
@@ -90,9 +90,6 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-	/* No CR? Nothing to convert, regardless. */
-	if (!stats.cr)
-		return 0;
 
 	if (action == CRLF_GUESS) {
 		/*
@@ -110,6 +107,20 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
+	if (safe_crlf && auto_crlf > 0 && action != CRLF_INPUT) {
+		/* CRLFs would be added by checkout: check if we have "naked" LFs */
+		if (stats.lf != stats.crlf) {
+			if (safe_crlf == SAFE_CRLF_WARN)
+				warning("Checkout will replace LFs with CRLF in %s", path);
+			else
+				die("Checkout would replace LFs with CRLF in %s", path);
+		}
+	}
+
+	/* Optimization: No CR? Nothing to convert, regardless. */
+	if (!stats.cr)
+		return 0;
+
 	/* only grow if not in place */
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
@@ -132,6 +143,17 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 				*dst++ = c;
 		} while (--len);
 	}
+
+	if (safe_crlf && (action == CRLF_INPUT || auto_crlf <= 0)) {
+		/* CRLFs would not be restored by checkout: check if we removed CRLFs */
+		if (buf->len != dst - buf->buf) {
+			if (safe_crlf == SAFE_CRLF_WARN)
+				warning("Stripped CRLF from %s.", path);
+			else
+				die("Refusing to strip CRLF from %s.", path);
+		}
+	}
+
 	strbuf_setlen(buf, dst - buf->buf);
 	return 1;
 }
diff --git a/environment.c b/environment.c
index 18a1c4e..e351e99 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,7 @@ int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 89baebd..e2e0f7b 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -8,6 +8,10 @@ q_to_nul () {
 	tr Q '\000'
 }
 
+q_to_cr () {
+	tr Q '\015'
+}
+
 append_cr () {
 	sed -e 's/$/Q/' | tr Q '\015'
 }
@@ -42,6 +46,47 @@ test_expect_success setup '
 	echo happy.
 '
 
+test_expect_failure 'safecrlf: autocrlf=input, all CRLF' '
+
+	git repo-config core.autocrlf input &&
+	git repo-config core.safecrlf true &&
+
+	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	git add allcrlf
+'
+
+test_expect_failure 'safecrlf: autocrlf=input, mixed LF/CRLF' '
+
+	git repo-config core.autocrlf input &&
+	git repo-config core.safecrlf true &&
+
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	git add mixed
+'
+
+test_expect_failure 'safecrlf: autocrlf=true, all LF' '
+
+	git repo-config core.autocrlf true &&
+	git repo-config core.safecrlf true &&
+
+	for w in I am all LF; do echo $w; done >alllf &&
+	git add alllf
+'
+
+test_expect_failure 'safecrlf: autocrlf=true mixed LF/CRLF' '
+
+	git repo-config core.autocrlf true &&
+	git repo-config core.safecrlf true &&
+
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >mixed &&
+	git add mixed
+'
+
+test_expect_success 'switch off autocrlf, safecrlf' '
+	git repo-config core.autocrlf false &&
+	git repo-config core.safecrlf false
+'
+
 test_expect_success 'update with autocrlf=input' '
 
 	rm -f tmp one dir/two three &&
-- 
1.5.4.rc2.60.g46ee
