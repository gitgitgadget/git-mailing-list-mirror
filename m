From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv1bis 1/2] git apply: option to ignore whitespace differences
Date: Thu,  2 Jul 2009 19:48:40 +0200
Message-ID: <1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 19:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQP2-0004Cb-MO
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbZGBRsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbZGBRss
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:48:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:51466 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbZGBRsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:48:46 -0400
Received: by fg-out-1718.google.com with SMTP id e21so540871fga.17
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 10:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ph3NIDyKKzIZMbcZdhZVvwKjdB0goiBkspkJtirYV7k=;
        b=k/lLE051MtLUcd+5WdFYZi9S07S7JwPCZGlJfyW/7jeOOJ/lm1vyDw8WteVkcqtLnN
         BqDL98Y7+PoBCUfnRbwwM5qTxW/tBJo6so7RVk22PMimR2ko0vLFQseV9kusj+wipI09
         0SgViHdseHxL3H4t9wqOcDCgXLnQsXZp2U0R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oejUjlcMh81pQIgrtHC22xIdh56S2citTyBkq/Rzccv2/Mic6t3TSh0vPzF7ddZoeZ
         bryCNafVEH1ii3nGgCjmso0OmvEjnuhFt/OkOUzIjw7O4Ays8HwolRxqxgWkHZ8M2C3W
         evPPbtUDFAkwHsod4bgT+YfTpNyvkvlwhxupk=
Received: by 10.86.97.18 with SMTP id u18mr458836fgb.66.1246556929099;
        Thu, 02 Jul 2009 10:48:49 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id l19sm6046608fgb.11.2009.07.02.10.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 10:48:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g509a
In-Reply-To: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122659>

Introduce --ignore-whitespace option to ignore whitespace differences
while applying the patch. The patch is based on Robert Fitzsimons' work
http://permalink.gmane.org/gmane.comp.version-control.git/7876
and includes his test case.

'git am' and 'git rebase' are made aware of this option and pass it
through to 'git apply', and so is the bash git completion.
---
 builtin-apply.c                        |   60 ++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |   74 ++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..70cc985 100644
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
@@ -214,6 +215,49 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare two memory areas ignoring whitespace differences
+ */
+static int memcmp_ignore_whitespace(const char *s1, size_t n1, const char *s2, size_t n2)
+{
+	const char *stop1 = s1 + n1;
+	const char *stop2 = s2 + n2;
+	int result;
+
+	if (!(n1 | n2))
+		return 0;
+
+	do {
+		if (isspace(*s1) && isspace(*s2)) {
+			while (isspace(*s1)) {
+				s1++;
+			}
+			while (isspace(*s2))
+				s2++;
+		}
+		/* Check here instead of in the while because
+		   the whitespace discarding might have moved us
+		   past the end */
+		if ((s1 >= stop1) || (s2 >= stop2))
+			break;
+		result = *s1++ - *s2++;
+	} while (!result);
+
+	return result;
+}
+
+/*
+ * Returns true if the given lines (buffer + len) match
+ * according to the ignore_whitespace setting
+ */
+static int lines_match(const char *s1, size_t n1, const char *s2, size_t n2)
+{
+	if (ignore_whitespace)
+		return !memcmp_ignore_whitespace(s1, n1, s2, n2);
+	else
+		return (n1 == n2) && !memcmp(s1, s2, n1);
+}
+
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -1665,6 +1709,7 @@ static int match_fragment(struct image *img,
 {
 	int i;
 	char *fixed_buf, *buf, *orig, *target;
+	size_t img_len = 0;
 
 	if (preimage->nr + try_lno > img->nr)
 		return 0;
@@ -1676,9 +1721,11 @@ static int match_fragment(struct image *img,
 		return 0;
 
 	/* Quick hash check */
-	for (i = 0; i < preimage->nr; i++)
+	for (i = 0; i < preimage->nr; i++) {
+		img_len += img->line[try_lno + i].len;
 		if (preimage->line[i].hash != img->line[try_lno + i].hash)
 			return 0;
+	}
 
 	/*
 	 * Do we have an exact match?  If we were told to match
@@ -1690,10 +1737,11 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
+	    lines_match(img->buf + try, img_len,
+	                preimage->buf, preimage->len))
 		return 1;
 
-	if (ws_error_action != correct_ws_error)
+	if (!ignore_whitespace && (ws_error_action != correct_ws_error))
 		return 0;
 
 	/*
@@ -1731,8 +1779,10 @@ static int match_fragment(struct image *img,
 		 * In either case, we are fixing the whitespace breakages
 		 * so we might as well take the fix together with their
 		 * real change.
+		 * If we are ignoring whitespace differences, don't check
+		 * for length equality.
 		 */
-		match = (tgtfixlen == fixlen && !memcmp(tgtfix, buf, fixlen));
+		match = lines_match(buf, fixlen, tgtfix, tgtfixlen);
 
 		if (tgtfix != tgtfixbuf)
 			free(tgtfix);
@@ -3304,6 +3354,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
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
index 0000000..d31e0f3
--- /dev/null
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -0,0 +1,74 @@
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
+@@ -0,0 +1,23 @@
++#include <stdio.h>
++
++void print_int(int num);
++int func(int num);
++
++int main() {
++       int i;
++
++       for (i = 0; i < 10; i++) {
++               print_int(func(i));
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
++
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -10,6 +10,8 @@
+ 		print_int(func(i));
+ 	}
+ 
++	printf("\n");
++
+ 	return 0;
+ }
+
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
+rm -f main.c
+test_expect_success "S = patch1 (--ignore-whitespace)" \
+    'git-apply --ignore-whitespace patch1.patch'
+
+test_done
+
+
-- 
1.6.3.3.511.g0ded0.dirty
