From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sat, 19 Jan 2008 18:52:31 +0100
Message-ID: <12007651514111-git-send-email-prohaska@zib.de>
Cc: torvalds@linux-foundation.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes.Schindelin@gmx.de, dpotapov@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 18:54:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGHtO-0004Xa-Pj
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 18:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbYASRx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 12:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYASRx1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 12:53:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:48871 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbYASRx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 12:53:26 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0JHqW10027173;
	Sat, 19 Jan 2008 18:52:32 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0JHqVFE013871;
	Sat, 19 Jan 2008 18:52:31 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71124>

Here is an improved version of the mechanism that lazily checks
for irreversible conversions, as announced in

  http://mid.gmane.org/<7E3714CE-0073-4E42-A455-36D595946A6C@zib.de>

I have no plans to continue working on the second alternative
(is_worktree_safecrlf() check during startup).  I prefer to
have some feedback on this patch first.

I believe it would be a good idea to gather some real world
experience on pu or next before merging to master.  As explained
below quite a few commands may print warnings and this commit only
has tests for git add.

Therefore, I think this is post 1.5.4.

    Steffen

---- snip ---

CRLF conversion bears a slight chance of corrupting data.
autocrlf=true will convert CRLF to LF during commit and LF to
CRLF during checkout.  A file that containes a mixture of LF and
CRLF before the commit cannot be recreated by git.  For text
files this does not really matter because we do not care about
the line endings anyway; but for binary files that are
accidentally classified as text the conversion can result in
corrupted data.

If you recognize such corruption early you can easily fix it by
setting the conversion type explicitly in .gitattributes.  For
example, right after committing you still have the original file
in your work tree and this file is not yet corrupted.

However, in mixed Windows/Unix environments text files quite
easily can end up containing a mixture of CRLF and LF line
endings and git should handle such situations gracefully.  For
example, a user could copy a CRLF file from Windows to Unix and
mix it with an existing LF file there.  The result would contain
both types of line endings.

Unfortunately, the desired effect of cleaning up text files with
mixed line endings and the undesired effect of corrupting binary
files can not be distinguished.  In both cases CRLF endings are
removed in an irreversible way.  For text files this is the right
thing to do, while for binary file it means corrupting data.

In a sane environment, committing and checking out the same file
should not modify the original file in the work tree.  For
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

The safecrlf mechanism's details depend on the git command.  If
safecrlf is active (not false), files in the work tree must not
be modified in an irreversible way without giving the user a
chance to save them.  However, if the file in the work tree will
never be modified we should not print annoying warnings.

git apply will fail even if safecrlf=warn, because git apply will
write its changes back to the work tree immediately.  The user
would not have a chance to save the old version of the file after
a warning.  Hence, a warning isn't sufficient and we should fail
instead.

git diff, git add, and any other command that calls
index_fd(..., write_object=1) will behave exactly as requested
by safecrlf.  The user still has the chance to save her data
before checkout or applying the diff.

git blame will never warn nor fail because it never writes to the
work tree.

The concept of a safety check was originally proposed in a similar
way by Linus Torvalds.  Thanks to Dimitry Potapov for insisting
on getting the naked LF/autocrlf=true case right.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/config.txt        |   22 +++++++++++++++
 Documentation/gitattributes.txt |    5 +++
 builtin-apply.c                 |    2 +-
 builtin-blame.c                 |    2 +-
 cache.h                         |   10 ++++++-
 config.c                        |    9 ++++++
 convert.c                       |   34 +++++++++++++++++++----
 diff.c                          |    2 +-
 environment.c                   |    1 +
 sha1_file.c                     |    2 +-
 t/t0020-crlf.sh                 |   58 +++++++++++++++++++++++++++++++++++++++
 11 files changed, 136 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index df091d1..50903ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -139,6 +139,28 @@ core.autocrlf::
 	"text" (i.e. be subjected to the autocrlf mechanism) is
 	decided purely based on the contents.
 
+core.safecrlf::
+	If true, makes git check if converting `CRLF` as controlled by
+	`core.autocrlf` is reversible.  Git will check if a command
+	modifies a file in the work tree either directly or indirectly.
+	For example, committing a file followed by checking out the
+	same file should yield the original file in the work tree.  If
+	this is not the case for the current setting of
+	`core.autocrlf`, git will reject the file.  The variable can
+	be set to "warn", in which case git will only warn about an
+	irreversible conversion but accept the file.
++
+Note, this safety check does not mean that a checkout will generate a
+file identical to the original file for different settings of
+`core.autocrlf`, but only for the current one.  For example, a text
+file with `LF` would be accepted with `core.autocrlf=input` and could
+later be checked out with `core.autocrlf=true`, in which case the
+resulting file would contain `CRLF`, although the original file
+contained `LF`.  However, in both work trees the line endings would be
+consistent, that is either all `LF` or all `CRLF`, but never mixed.  A
+file with mixed line endings would be reported by the `core.safecrlf`
+mechanism.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. linkgit:git-update-index[1] and
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 35a29fd..2ffe1fb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -133,6 +133,11 @@ When `core.autocrlf` is set to "input", line endings are
 converted to LF upon checkin, but there is no conversion done
 upon checkout.
 
+If `core.safecrlf` is set to "true" or "warn", git verifies if
+the conversion is reversible for the current setting of
+`core.autocrlf`.  For "true", git rejects irreversible
+conversions; for "warn", git only prints a warning but accepts
+an irreversible conversion.
 
 `ident`
 ^^^^^^^
diff --git a/builtin-apply.c b/builtin-apply.c
index d57bb6e..847f70e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1430,7 +1430,7 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error("unable to open or read %s", path);
-		convert_to_git(path, buf->buf, buf->len, buf);
+		convert_to_git(path, buf->buf, buf->len, buf, safe_crlf ? SAFE_CRLF_FAIL : 0);
 		return 0;
 	default:
 		return -1;
diff --git a/builtin-blame.c b/builtin-blame.c
index 9b4c02e..c361ee1 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2073,7 +2073,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die("read error %s from stdin", strerror(errno));
 	}
-	convert_to_git(path, buf.buf, buf.len, &buf);
+	convert_to_git(path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
diff --git a/cache.h b/cache.h
index 39331c2..943185b 100644
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
@@ -632,7 +640,7 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 /* convert.c */
 /* returns 1 if *dst was used */
-extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst);
+extern int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst, enum safe_crlf checksafe);
 extern int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst);
 
 /* add */
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
index 4df7559..2700cde 100644
--- a/convert.c
+++ b/convert.c
@@ -81,7 +81,7 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 }
 
 static int crlf_to_git(const char *path, const char *src, size_t len,
-                       struct strbuf *buf, int action)
+                       struct strbuf *buf, int action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
@@ -90,9 +90,6 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		return 0;
 
 	gather_stats(src, len, &stats);
-	/* No CR? Nothing to convert, regardless. */
-	if (!stats.cr)
-		return 0;
 
 	if (action == CRLF_GUESS) {
 		/*
@@ -110,6 +107,30 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 			return 0;
 	}
 
+	if (checksafe) {
+		if (action == CRLF_INPUT || auto_crlf <= 0) {
+			/* CRLFs would not be restored by checkout: check if we'd remove CRLFs */
+			if (stats.crlf) {
+				if (checksafe == SAFE_CRLF_WARN)
+					warning("CRLF will be replaced by LF in %s.", path);
+				else
+					die("CRLF would be replaced by LF in %s.", path);
+			}
+		} else if (auto_crlf > 0) {
+			/* CRLFs would be added by checkout: check if we have "naked" LFs */
+			if (stats.lf != stats.crlf) {
+				if (checksafe == SAFE_CRLF_WARN)
+					warning("LFs will be replaced by CRLF in %s", path);
+				else
+					die("LF would be replaced by CRLF in %s", path);
+			}
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
@@ -531,7 +552,8 @@ static int git_path_check_ident(const char *path, struct git_attr_check *check)
 	return !!ATTR_TRUE(value);
 }
 
-int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst)
+int convert_to_git(const char *path, const char *src, size_t len,
+			struct strbuf *dst, enum safe_crlf checksafe)
 {
 	struct git_attr_check check[3];
 	int crlf = CRLF_GUESS;
@@ -553,7 +575,7 @@ int convert_to_git(const char *path, const char *src, size_t len, struct strbuf
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(path, src, len, dst, crlf);
+	ret |= crlf_to_git(path, src, len, dst, crlf, checksafe);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/diff.c b/diff.c
index b18c140..ad4e91e 100644
--- a/diff.c
+++ b/diff.c
@@ -1624,7 +1624,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		 * Convert from working tree format to canonical git format
 		 */
 		strbuf_init(&buf, 0);
-		if (convert_to_git(s->path, s->data, s->size, &buf)) {
+		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
 			s->should_munmap = 0;
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
diff --git a/sha1_file.c b/sha1_file.c
index 6583797..09e5c8f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2342,7 +2342,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	if ((type == OBJ_BLOB) && S_ISREG(st->st_mode)) {
 		struct strbuf nbuf;
 		strbuf_init(&nbuf, 0);
-		if (convert_to_git(path, buf, size, &nbuf)) {
+		if (convert_to_git(path, buf, size, &nbuf, write_object ? safe_crlf : 0)) {
 			munmap(buf, size);
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 89baebd..8e188b0 100755
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
@@ -42,6 +46,60 @@ test_expect_success setup '
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
+test_expect_success 'safecrlf: print warning only once' '
+
+	git repo-config core.autocrlf input &&
+	git repo-config core.safecrlf warn &&
+
+	for w in I am all LF; do echo $w; done >doublewarn &&
+	git add doublewarn &&
+	git commit -m "nowarn" &&
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn &&
+	test $(git add doublewarn 2>&1 | grep "CRLF will be replaced by LF" | wc -l) = 1
+'
+
+test_expect_success 'switch off autocrlf, safecrlf, reset HEAD' '
+	git repo-config core.autocrlf false &&
+	git repo-config core.safecrlf false &&
+	git reset --hard HEAD^
+'
+
 test_expect_success 'update with autocrlf=input' '
 
 	rm -f tmp one dir/two three &&
-- 
1.5.4.rc3.15.g8a53c
