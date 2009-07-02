From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] git apply: option to ignore whitespace differences
Date: Thu,  2 Jul 2009 14:52:16 +0200
Message-ID: <1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Fitzsimons <robfitz@273k.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 14:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMLmF-00056H-AP
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 14:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbZGBMw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 08:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbZGBMw0
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 08:52:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12671 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbZGBMwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 08:52:24 -0400
Received: by fg-out-1718.google.com with SMTP id e21so478510fga.17
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=st2urDPkLrxHJPzkCdGC+KoMu+f1LCcLw46FdfL741g=;
        b=b3OURhGDRVkpZzMWpvRDErjmSjM5U9DxP3tMxuHObbpjpgpr780CKd5b/Vd7PDIN93
         yqVooDAJgqr7Uw7pFNdeXsX9AGScoGX7lx/F3/ZTYTLtKQ4/0ZPeRk+uXXd9+0msS+wS
         vJoBgTybe8HAIfYIAe+ZTICN8TBHYm85dmwQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E24yEnVyV2jemQwQxZ5sMC25Mr0VO7tUAw3qyzmbRzJOllS+RAPSxbYBuu7m8tJ9+G
         o2D/g1EuomBZIqRkkjx7fsaVvDDm/ho8vYjzbYHWG6bKuf6qnI7dhuOjtJZPfJdthcuX
         pRaRz9xuCw76jVdTTA8jPEEnRapxT6IIeb5RE=
Received: by 10.86.27.17 with SMTP id a17mr163011fga.17.1246539145504;
        Thu, 02 Jul 2009 05:52:25 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id l12sm5212814fgb.14.2009.07.02.05.52.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 05:52:24 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.512.g1f6a.dirty
In-Reply-To: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122642>

Introduce --ignore-whitespace option to ignore whitespace differences
while applying the patch. The patch is an adaptatin of Robert
Fitzsimons' previous work, available at
http://permalink.gmane.org/gmane.comp.version-control.git/7876
including his test case.

'git am' and 'git rebase' are made aware of this option and pass it
through to 'git apply', and so is the bash git completion.
---
 builtin-apply.c                        |   53 +++++++++++++++++++++-
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 +
 t/t4107-apply-ignore-whitespace.sh     |   74 ++++++++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100755 t/t4107-apply-ignore-whitespace.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..86860d6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -39,6 +39,7 @@ static int diffstat;
 static int numstat;
 static int summary;
 static int check;
+static int ignore_whitespace = 0;
 static int apply = 1;
 static int apply_in_reverse;
 static int apply_with_reject;
@@ -214,6 +215,45 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare two memory areas ignoring whitespace differences
+ */
+static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
+{
+	const char *stop1 = s1 + n;
+	const char *stop2 = s2 + n;
+	int result;
+
+	if (!n)
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
+static int memcmp_switch(const char *s1, const char *s2, size_t n)
+{
+	if (ignore_whitespace)
+		return memcmp_ignore_whitespace(s1, s2, n);
+	else
+		return memcmp(s1, s2, n);
+}
+
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -1690,10 +1730,10 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
+	    !memcmp_switch(img->buf + try, preimage->buf, preimage->len))
 		return 1;
 
-	if (ws_error_action != correct_ws_error)
+	if (!ignore_whitespace && (ws_error_action != correct_ws_error))
 		return 0;
 
 	/*
@@ -1731,8 +1771,13 @@ static int match_fragment(struct image *img,
 		 * In either case, we are fixing the whitespace breakages
 		 * so we might as well take the fix together with their
 		 * real change.
+		 * If we are ignoring whitespace differences, don't check
+		 * for length equality.
 		 */
-		match = (tgtfixlen == fixlen && !memcmp(tgtfix, buf, fixlen));
+		if (ignore_whitespace)
+			match = !memcmp_ignore_whitespace(buf, tgtfix, fixlen);
+		else
+			match = (tgtfixlen == fixlen && !memcmp(tgtfix, buf, fixlen));
 
 		if (tgtfix != tgtfixbuf)
 			free(tgtfix);
@@ -3304,6 +3349,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
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
1.6.3.3.512.g1f6a.dirty
