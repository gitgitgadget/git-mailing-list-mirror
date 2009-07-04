From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 1/2] git apply: option to ignore whitespace differences
Date: Sat,  4 Jul 2009 13:53:48 +0200
Message-ID: <1246708429-21823-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 13:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN3ol-0004KU-5y
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZGDLx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 07:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbZGDLx6
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 07:53:58 -0400
Received: from mail-bw0-f207.google.com ([209.85.218.207]:53765 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbZGDLxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 07:53:55 -0400
Received: by bwz3 with SMTP id 3so827177bwz.37
        for <git@vger.kernel.org>; Sat, 04 Jul 2009 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vkmC6J0pujdbHreSqn5S0vefKHSzMjXVF8hs3Q5vwRA=;
        b=kkHtY/pkFLSu7gcTmZDg2P1Iw7QsFcdgsNnSxPkbicwFDJcLac/0ifh0vAYmtabMKK
         G0RyHoErNDIlEcYusp1eu43wDCG8+8Crsb9vSKaVn1tQl1LnNxE7l/nJyaDtSfKUg8Az
         8CmLQNjMKu8MhR/FwbNXrMGQKKI1GMcLU+5kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iPKAh6TlYTI1w1cmJIKjpq9N7Yr4z7KP6xo/NpWnwo4/9Xxz9HAbR0qrum4PMSmBnB
         k5rzGkrcUqeEQ6k6cNeBRS8ak5vMjGvsRDcHtTyVWVuC6imA/H9Nyedsv13R35ktrP56
         k5JW9ZUufxo4CDFNuEljtCb8vz6r259jY92bg=
Received: by 10.103.246.1 with SMTP id y1mr1374725mur.120.1246708437538;
        Sat, 04 Jul 2009 04:53:57 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-32-98.clienti.tiscali.it [94.37.32.98])
        by mx.google.com with ESMTPS id e10sm18453412muf.44.2009.07.04.04.53.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Jul 2009 04:53:57 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g4fff
In-Reply-To: <1246708429-21823-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122718>

Introduce --ignore-whitespace option to ignore whitespace differences
while applying the patch. The feature is based on Robert Fitzsimons'
work from
http://permalink.gmane.org/gmane.comp.version-control.git/7876

A test is included, and 'git am' and 'git rebase' are made aware of this
option and pass it through to 'git apply', and so is the bash git
completion.
---
 builtin-apply.c                        |   55 ++++++++++++++++-
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |  107 ++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..01230f1 100644
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
@@ -214,6 +215,52 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare s1 to s2 up to length n, ignoring whitespace differences.
+ * It is acceptable if s2 is a substring of s1.
+ */
+static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
+{
+	const char *stop = s2 + n;
+	int result;
+
+	if (!n)
+		return 0;
+
+	/* skip leading whitespace */
+	while (isspace(*s1))
+		s1++;
+	while (isspace(*s2))
+		s2++;
+	while (!result && s2 < stop) {
+		result = *s1++ - *s2++;
+		/*
+		 * skip whitespace inside if we have whitespace
+		 * on both buffers
+		 */
+		if (isspace(*s1) && isspace(*s2)) {
+			while (isspace(*s1))
+				s1++;
+			while (isspace(*s2))
+				s2++;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * Returns true if the lines in s2 match the buffer in s1 up to length n,
+ * according to the ignore_whitespace setting
+ */
+static int lines_match(const char *s1, const char *s2, size_t n)
+{
+	if (ignore_whitespace)
+		return !memcmp_ignore_whitespace(s1, s2, n);
+	else
+		return !memcmp(s1, s2, n);
+}
+
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -1690,7 +1737,7 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
+	    lines_match(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
 	if (ws_error_action != correct_ws_error)
@@ -1698,7 +1745,9 @@ static int match_fragment(struct image *img,
 
 	/*
 	 * The hunk does not apply byte-by-byte, but the hash says
-	 * it might with whitespace fuzz.
+	 * it might with whitespace fuzz. We haven't been asked to
+	 * ignore whitespace, we were asked to correct whitespace
+	 * errors, so let's try matching after whitespace correction.
 	 */
 	fixed_buf = xmalloc(preimage->len + 1);
 	buf = fixed_buf;
@@ -3304,6 +3353,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
 			"detect new or modified lines that have whitespace errors",
 			0, option_parse_whitespace },
+		OPT_BOOLEAN(0, "ignore-whitespace", &ignore_whitespace,
+			"ignore whitespace differences when finding context"),
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
 			"apply the patch in reverse"),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ddb71e2..d3415b5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -663,6 +663,7 @@ _git_am ()
 	--*)
 		__gitcomp "
 			--3way --committer-date-is-author-date --ignore-date
+			--ignore-whitespace
 			--interactive --keep --no-utf8 --signoff --utf8
 			--whitespace=
 			"
@@ -684,6 +685,7 @@ _git_apply ()
 			--stat --numstat --summary --check --index
 			--cached --index-info --reverse --reject --unidiff-zero
 			--apply --no-add --exclude=
+			--ignore-whitespace
 			--whitespace= --inaccurate-eof --verbose
 			"
 		return
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
index 0000000..b9e6f14
--- /dev/null
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -0,0 +1,107 @@
+#!/bin/sh
+#
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
+	}; 
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
+test_expect_success "S = patch1" \
+    'git-apply patch1.patch'
+
+test_expect_failure "F = patch2" \
+    'git-apply patch2.patch'
+
+test_expect_success "S = patch2 (--ignore-whitespace)" \
+    'git-apply --ignore-whitespace patch2.patch'
+
+test_expect_failure "S = patch3 (missing string at EOL)" \
+    'git-apply --ignore-whitespace patch3.patch'
+
+test_expect_failure "S = patch4 (missing EOL at EOF)" \
+    'git-apply --ignore-whitespace patch4.patch'
+
+test_expect_success "S = patch5 (leading whitespace)" \
+    'git-apply --ignore-whitespace patch5.patch'
+
+rm -f main.c
+test_expect_success "S = patch1 (--ignore-whitespace)" \
+    'git-apply --ignore-whitespace patch1.patch'
+
+test_done
+
+
-- 
1.6.3.3.512.g4fff
