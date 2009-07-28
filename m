From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3] git apply: option to ignore whitespace differences
Date: Tue, 28 Jul 2009 23:00:20 +0200
Message-ID: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 23:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVtmq-0001iU-0x
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbZG1VA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbZG1VA3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:00:29 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55189 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZG1VA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:00:27 -0400
Received: by fxm18 with SMTP id 18so17556fxm.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=+efNmzRQCH0ywNfDxwsRTUZbVBdnOfXk+Zh9MBsty5c=;
        b=nzfuSxPZbfyt96Hv/TTiQkK6O6X0VsiLJmcGVxZm1OG5U4IoHM0GTpsImDRX60Foe8
         WF3puT0NZ/B+dGh+3e/k3ZxUIhiIoj9IDB3+YXLGLFDcjQ6JVzlpPWEoLhG0wgxTGbVt
         VUqO+e9FFf7OccrkJPZkwCWKq1kUQ3k9dSL8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ii7bDWyxiG1UYCTQSM4PLroPIDca43fk7a1nlBO0hMPOdCU9aRaYdAFNPIc9m36cHj
         NBkLiF+j3tMQqyl7aJLgX6xxaEaRH4aqkddt5MF8TgeY9aUFI6p7rHHeIiutYrTx2oex
         7mMaJ8CSRLzqaiFX0lFzHQFaOh87ujBPCXkTU=
Received: by 10.103.167.14 with SMTP id u14mr4213410muo.81.1248814826583;
        Tue, 28 Jul 2009 14:00:26 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-27-183.clienti.tiscali.it [94.37.27.183])
        by mx.google.com with ESMTPS id n7sm1199985mue.28.2009.07.28.14.00.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 14:00:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.511.gcffae6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124274>

Introduce --ignore-whitespace option and corresponding config bool to
ignore whitespace differences while applying patches, akin to the
'patch' program.

'git am', 'git rebase' and the bash git completion are made aware of
this option.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Third iteration of the ignore-whitespace option for git-apply. Sorry for
the long delay from the previous one, but I've been busy with real-life
stuff.

Significant changes since the previous iterations:
* a boolean config option has been introduced
* the patch that synchronized the whitespace when it was being ignored
  has been squashed in
* the fuzzy buffer comparison needs the length of both buffers since, as
  pointed out in a private comunication, the hash check is not enough to
  guarantee that the candidates have the same non-whitespace characters

With regard to this, by the way, the expected failure for patch3 is
currently catched by a hashing, but it should be improved by generating
two lines with the same hash, one being a proper initial substring of
the other (modulo whitespace); a situation which I wasn't able to create
without resorting to situations that would make git (and diff) go
binary. Suggestions welcome.

Also, I've come across the need to implement a similar option for merges
(which basically reduces to adding the flag XDF_IGNORE_WHITESPACE_CHANGE
in appropriate places) but couldn't come up with a sensible way to
expose it via parameters to pass through to the merge engines, whose
interactions are a little over my head for now.


 Documentation/config.txt               |    5 +
 Documentation/git-am.txt               |    3 +-
 Documentation/git-apply.txt            |    7 ++
 Documentation/git-rebase.txt           |    3 +-
 builtin-apply.c                        |  135 ++++++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |    3 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |  143 ++++++++++++++++++++++++++++++++
 9 files changed, 295 insertions(+), 10 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 792dd42..c24fa5d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -461,6 +461,11 @@ it will be treated as a shell command.  For example, defining
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
 
+apply.ignore-whitespace::
+	Tells 'git-apply' to ignore whitespaces differences,
+	in the same way as the '--ignore-whitespace' option.
+	See linkgit:git-apply[1].
+
 apply.whitespace::
 	Tells 'git-apply' how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 32e689b..acd2a5d 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git am' [--signoff] [--keep] [--utf8 | --no-utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
-	 [--ignore-date]
+	 [--ignore-date] [--ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet]
 	 [<mbox> | <Maildir>...]
@@ -65,6 +65,7 @@ default.   You can use `--no-utf8` to override this.
 	it is supposed to apply to and we have those blobs
 	available locally.
 
+--ignore-date::
 --whitespace=<option>::
 -C<n>::
 -p<n>::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 735374d..ef92c03 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	  [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
+	  [--ignore-whitespace]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
 	  [--exclude=PATH] [--include=PATH] [--directory=<root>]
 	  [--verbose] [<patch>...]
@@ -149,6 +150,9 @@ patch to each path is used.  A patch to a path that does not match any
 include/exclude pattern is used by default if there is no include pattern
 on the command line, and ignored if there is any include pattern.
 
+--ignore-whitespace::
+	When applying a patch, ignore whitespace differences if necessary.
+
 --whitespace=<action>::
 	When applying a patch, detect a new or modified line that has
 	whitespace errors.  What are considered whitespace errors is
@@ -205,6 +209,9 @@ running `git apply --directory=modules/git-gui`.
 Configuration
 -------------
 
+apply.ignore-whitespace::
+	Set this boolean configuration flag if you want to ignore whitespace
+	differences to be ignored by default.
 apply.whitespace::
 	When no `--whitespace` flag is given from the command
 	line, this configuration item is used as the default.
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index db1b71d..0aefc34 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -268,8 +268,9 @@ OPTIONS
 	exit with the message "Current branch is up to date" in such a
 	situation.
 
+--ignore-whitespace::
 --whitespace=<option>::
-	This flag is passed to the 'git-apply' program
+	These flag are passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Incompatible with the --interactive option.
 
diff --git a/builtin-apply.c b/builtin-apply.c
index 39dc96a..792c7ac 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -39,6 +39,7 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int check;
+static int ignore_whitespace;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -214,6 +215,62 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare lines s1 of length n1 and s2 of length n2, ignoring
+ * whitespace difference. Returns 1 if they match, 0 otherwise
+ */
+static int fuzzy_matchlines(const char *s1, size_t n1,
+			    const char *s2, size_t n2)
+{
+	const char *last1 = s1 + n1 - 1;
+	const char *last2 = s2 + n2 - 1;
+	int result = 0;
+
+	if (n1 < 0 || n2 < 0)
+		return 0;
+
+	/* ignore line endings */
+	while ((*last1 == '\r') || (*last1 == '\n'))
+		last1--;
+	while ((*last2 == '\r') || (*last2 == '\n'))
+		last2--;
+
+	/* skip leading whitespace */
+	while (isspace(*s1) && (s1 <= last1))
+		s1++;
+	while (isspace(*s2) && (s2 <= last2))
+		s2++;
+	/* early return if both lines are empty */
+	if ((s1 > last1) && (s2 > last2))
+		return 1;
+	while (!result) {
+		result = *s1++ - *s2++;
+		/*
+		 * Skip whitespace inside. We check for whitespace on
+		 * both buffers because we don't want "a b" to match
+		 * "ab"
+		 */
+		if (isspace(*s1) && isspace(*s2)) {
+			while (isspace(*s1) && s1 <= last1)
+				s1++;
+			while (isspace(*s2) && s2 <= last2)
+				s2++;
+		}
+		/*
+		 * If we reached the end on one side only,
+		 * lines don't match
+		 */
+		if (
+		    ((s2 > last2) && (s1 <= last1)) ||
+		    ((s1 > last1) && (s2 <= last2)))
+			return 0;
+		if ((s1 > last1) && (s2 > last2))
+			break;
+	}
+
+	return !result;
+}
+
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -1672,10 +1729,17 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 	}
 }
 
+/*
+ * Update the preimage, and the common lines in postimage,
+ * from buffer buf of length len. If postlen is 0 the postimage
+ * is updated in place, otherwise it's updated on a new buffer
+ * of length postlen
+ */
+
 static void update_pre_post_images(struct image *preimage,
 				   struct image *postimage,
 				   char *buf,
-				   size_t len)
+				   size_t len, size_t postlen)
 {
 	int i, ctx;
 	char *new, *old, *fixed;
@@ -1694,11 +1758,19 @@ static void update_pre_post_images(struct image *preimage,
 	*preimage = fixed_preimage;
 
 	/*
-	 * Adjust the common context lines in postimage, in place.
-	 * This is possible because whitespace fixing does not make
-	 * the string grow.
+	 * Adjust the common context lines in postimage. This can be
+	 * done in-place when we are just doing whitespace fixing,
+	 * which does not make the string grow, but needs a new buffer
+	 * when ignore_whitespace causes the update, since in this case
+	 * we could have e.g. tabs converted to multiple spaces.
+	 * We trust the caller to tell us if the update can be done
+	 * in place (postlen==0) or not.
 	 */
-	new = old = postimage->buf;
+	old = postimage->buf;
+	if (postlen)
+		new = postimage->buf = xmalloc(postlen);
+	else
+		new = old;
 	fixed = preimage->buf;
 	for (i = ctx = 0; i < postimage->nr; i++) {
 		size_t len = postimage->line[i].len;
@@ -1773,12 +1845,57 @@ static int match_fragment(struct image *img,
 	    !memcmp(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
+	/*
+	 * No exact match. If we are ignoring whitespace, run a line-by-line
+	 * fuzzy matching. We collect all the line length information because
+	 * we need it to adjust whitespace if we match.
+	 */
+	if (ignore_whitespace) {
+		size_t imgoff = 0;
+		size_t preoff = 0;
+		size_t postlen = postimage->len;
+		size_t imglen[preimage->nr];
+		for (i = 0; i < preimage->nr; i++) {
+			imglen[i] = img->line[try_lno+i].len;
+			size_t prelen = preimage->line[i].len;
+			if (!fuzzy_matchlines(
+				img->buf + try + imgoff, imglen[i],
+				preimage->buf + preoff, prelen))
+				return 0;
+			if (preimage->line[i].flag & LINE_COMMON)
+				postlen += imglen[i] - prelen;
+			imgoff += imglen[i];
+			preoff += prelen;
+		}
+
+		/*
+		 * Ok, the preimage matches with whitespace fuzz. Update it and
+		 * the common postimage lines to use the same whitespace as the
+		 * target. imgoff now holds the true length of the target that
+		 * matches the preimage, and we need to update the line lengths
+		 * of the preimage to match the target ones.
+		 */
+		fixed_buf = xmalloc(imgoff);
+		memcpy(fixed_buf, img->buf + try, imgoff);
+		for (i = 0; i < preimage->nr; i++)
+			preimage->line[i].len = imglen[i];
+
+		/*
+		 * Update the preimage buffer and the postimage context lines.
+		 */
+		update_pre_post_images(preimage, postimage,
+				fixed_buf, imgoff, postlen);
+		return 1;
+	}
+
 	if (ws_error_action != correct_ws_error)
 		return 0;
 
 	/*
 	 * The hunk does not apply byte-by-byte, but the hash says
-	 * it might with whitespace fuzz.
+	 * it might with whitespace fuzz. We haven't been asked to
+	 * ignore whitespace, we were asked to correct whitespace
+	 * errors, so let's try matching after whitespace correction.
 	 */
 	fixed_buf = xmalloc(preimage->len + 1);
 	buf = fixed_buf;
@@ -1830,7 +1947,7 @@ static int match_fragment(struct image *img,
 	 * hunk match.  Update the context lines in the postimage.
 	 */
 	update_pre_post_images(preimage, postimage,
-			       fixed_buf, buf - fixed_buf);
+			       fixed_buf, buf - fixed_buf, 0);
 	return 1;
 
  unmatch_exit:
@@ -3272,6 +3389,8 @@ static int git_apply_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "apply.whitespace"))
 		return git_config_string(&apply_default_whitespace, var, value);
+	else if (!strcmp(var, "apply.ignore-whitespace"))
+		ignore_whitespace = git_config_bool(var, value);
 	return git_default_config(var, value, cb);
 }
 
@@ -3384,6 +3503,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
 			"detect new or modified lines that have whitespace errors",
 			0, option_parse_whitespace },
+		OPT_BOOLEAN(0, "ignore-whitespace", &ignore_whitespace,
+			"ignore whitespace differences when finding context"),
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
 			"apply the patch in reverse"),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5543dc4..7978d1d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -674,6 +674,7 @@ _git_am ()
 	--*)
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
+			--ignore-whitespace
 			--interactive --keep --no-utf8 --signoff --utf8
 			--whitespace=
 			"
@@ -695,6 +696,7 @@ _git_apply ()
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
+			--ignore-whitespace
 			--whitespace= --inaccurate-eof --verbose
 			"
 		return
@@ -1537,6 +1539,7 @@ _git_config ()
 	__gitcomp "
 		add.ignore-errors
 		alias.
+		apply.ignore-whitespace
 		apply.whitespace
 		branch.autosetupmerge
 		branch.autosetuprebase
diff --git a/git-am.sh b/git-am.sh
index d64d997..fe024b1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
+ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
@@ -303,7 +304,7 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--patch-format)
 		shift ; patch_format="$1" ;;
-	--reject)
+	--reject|--ignore-whitespace)
 		git_apply_opt="$git_apply_opt $1" ;;
 	--committer-date-is-author-date)
 		committer_date_is_author_date=t ;;
diff --git a/git-rebase.sh b/git-rebase.sh
index 18bc694..d741752 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -333,6 +333,9 @@ do
 			;;
 		esac
 		;;
+	--ignore-whitespace)
+		git_am_opt="$git_am_opt $1"
+		;;
 	--committer-date-is-author-date|--ignore-date)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
new file mode 100755
index 0000000..5a09001
--- /dev/null
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Giuseppe Bilotta
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --ignore-whitespace.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > patch1.patch <<\EOF
+diff --git a/main.c b/main.c
+new file mode 100644
+--- /dev/null
++++ b/main.c
+@@ -0,0 +1,22 @@
++#include <stdio.h>
++
++void print_int(int num);
++int func(int num);
++
++int main() {
++       int i;
++
++       for (i = 0; i < 10; i++) {
++               print_int(func(i)); /* stuff */
++       }
++
++       return 0;
++}
++
++int func(int num) {
++       return num * num;
++}
++
++void print_int(int num) {
++       printf("%d", num);
++}
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -10,6 +10,8 @@
+ 		print_int(func(i)); /* stuff */
+ 	}
+ 
++	printf("\n");
++
+ 	return 0;
+ }
+ 
+EOF
+
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -10,1 +10,1 @@
+ 		print_int(func(i)); 
+EOF
+
+cat > patch4.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -21,1 +21,1 @@
+ 	}; 
+\ No newline at end of file
+EOF
+
+cat > patch5.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -2,1 +2,1 @@
+ 	void print_int(int num);
+EOF
+
+cat > main.c.final <<\EOF
+#include <stdio.h>
+
+void print_int(int num);
+int func(int num);
+
+int main() {
+       int i;
+
+       for (i = 0; i < 10; i++) {
+               print_int(func(i)); /* stuff */
+       }
+
+	printf("\n");
+
+       return 0;
+}
+
+int func(int num) {
+       return num * num;
+}
+
+void print_int(int num) {
+       printf("%d", num);
+}
+EOF
+
+test_expect_success "S = patch1" \
+    'git-apply patch1.patch'
+
+test_expect_failure "F = patch2" \
+    'git-apply patch2.patch'
+
+git config apply.ignore-whitespace true
+
+test_expect_success "S = patch2 (--ignore-whitespace)" \
+    'git-apply patch2.patch'
+
+test_expect_failure "F = patch3 (missing string at EOL)" \
+    'git-apply patch3.patch'
+
+test_expect_failure "F = patch4 (missing EOL at EOF)" \
+    'git-apply patch4.patch'
+
+test_expect_success "S = patch5 (leading whitespace)" \
+    'git-apply patch5.patch'
+
+test_expect_success "S = main.c.final" \
+    'diff -q main.c main.c.final'
+
+rm -f main.c
+test_expect_success "S = patch1 (--ignore-whitespace)" \
+    'git-apply patch1.patch'
+
+test_expect_failure "F = patch5 (leading whitespace)" \
+    'git-apply --no-ignore-whitespace patch5.patch'
+
+test_done
+
+
-- 
1.6.3.3.511.gcffae6.dirty
