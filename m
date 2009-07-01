From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH/RFC] git apply: option to ignore whitespace differences
Date: Thu,  2 Jul 2009 01:25:22 +0200
Message-ID: <1246490722-1544-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 01:26:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM9Bp-0003oq-P2
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 01:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZGAXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbZGAXZc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 19:25:32 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49647 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbZGAXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 19:25:26 -0400
Received: by fxm18 with SMTP id 18so1143388fxm.37
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=uLt2ZWYtqh7lp9x3i7ZDVVdIrqM9v4IkUmnZteVM7oU=;
        b=doDJSvN+ebtn0+uR5ZUFQMrWVdvfxQ8m+3hJeC9LY9aa4M2UxIVdecBEGLVssvFgJY
         MNFJY/3/wbnKe1e6dkq+woaDcvEZsnhnayAMyfLixZVozNYDhcnYj7jJdec9sfZxG0jN
         zk3e0hZMl6Z9uaP3r2BbGQdu1DvGx1759mqws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oav4WpINlZLgh37dN2anVnK21V3EK/CH7RsGDj/ncjInMrV7q8Wj4JZkjexLNXD7o+
         hGo3l1I7ezdroPBSPVqE+QZi5KoR+dGySTpr0cDh8ZgI8pCTQdLeoXRs9mqdvj+7FN2X
         xL3SvvNu+DdlckJ9GoRa8vLZD1R3TZ06Oxu1U=
Received: by 10.103.182.3 with SMTP id j3mr3279126mup.88.1246490727948;
        Wed, 01 Jul 2009 16:25:27 -0700 (PDT)
Received: from localhost (host-78-15-5-16.cust-adsl.tiscali.it [78.15.5.16])
        by mx.google.com with ESMTPS id n10sm8608741mue.47.2009.07.01.16.25.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 16:25:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.3.487.gc7c49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122613>

Introduce --ignore-whitespace option to ignore whitespace differences
while applying the patch.

'git am' and 'git rebase' are made aware of this option and pass it
through to 'git apply', and so is the bash git completion.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin-apply.c                        |   49 ++++++++++++++++++++++++++++++--
 contrib/completion/git-completion.bash |    2 +
 git-am.sh                              |    3 +-
 git-rebase.sh                          |    3 ++
 4 files changed, 53 insertions(+), 4 deletions(-)

I must say that the only thing I don't like about this patch is the fact
that context lines matching with whitespace differences are taken from
the patch rather than being left untouched.

diff --git a/builtin-apply.c b/builtin-apply.c
index dc0ff5e..82efee7 100644
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
@@ -214,6 +215,41 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
+/*
+ * Compare two memory areas ignoring whitespace differences
+ */
+static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
+{
+	const char *stop = s1 + n;
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
+			if (s1 >= stop)
+				break;
+		}
+		result = *s1++ - *s2++;
+	} while (!result && (s1 < stop));
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
@@ -1690,10 +1726,10 @@ static int match_fragment(struct image *img,
 	if ((match_end
 	     ? (try + preimage->len == img->len)
 	     : (try + preimage->len <= img->len)) &&
-	    !memcmp(img->buf + try, preimage->buf, preimage->len))
+	    !memcmp_switch(preimage->buf, img->buf + try, preimage->len))
 		return 1;
 
-	if (ws_error_action != correct_ws_error)
+	if (!ignore_whitespace && (ws_error_action != correct_ws_error))
 		return 0;
 
 	/*
@@ -1731,8 +1767,13 @@ static int match_fragment(struct image *img,
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
@@ -3304,6 +3345,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
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
index 58d4eb6..8e8598c 100755
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
@@ -180,7 +181,7 @@ do
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
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
-- 
1.6.3.3.487.gc7c49
