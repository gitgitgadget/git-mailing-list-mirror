From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Thu, 12 May 2016 11:02:07 +0530
Message-ID: <1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
 <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	Johannes.Schindelin@gmx.de, sunshine@sunshineco.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jFm-0005xa-CK
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbcELFdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:33:31 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34128 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcELFd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:33:29 -0400
Received: by mail-pa0-f65.google.com with SMTP id yl2so5171735pac.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 22:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0XxTCmVucMZDALR0iZ1fR4g5CnEYQqYfkY/lj+y89Yk=;
        b=guFdnfgb46F6+T2ukh6eYVyPYkzC9VVPvGS5T77YKC0hkks7k9mhK5wxanVwOjcNB9
         dgBmWq17CFm92QLycEo7FP7XUMeMubk4peBrzoEr7nMQlKpGQuTIIaXs1SNfHEsOIsXv
         ujQi4/nRcLMVLyd2kZdfpYN1VDWk8qYoItSLcfy8bGRVHPU/nG4YdhVYZFvhu2WpyX/c
         EY9DLHMQWNHTPbHlK/xLHb+WfKGasVYoPwGRmstKr/cUMNsP/8ydm0G1QOkwP0EvPrXa
         oCgrX+nZZKE80x44QUzbcECeqTZZd5mip88sNBqtKK/DivTLT2sePogiTe8Xb9vRisSc
         6x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0XxTCmVucMZDALR0iZ1fR4g5CnEYQqYfkY/lj+y89Yk=;
        b=Rdhv04BkccpF4tdUmXSOGALcilUNJJWXnUx/0JpXbrcw+vvAnImVfc1IwaiVA2wvx9
         q1/oCkCfXHVU4XnjhYFpZ352Pp0zaVmbpJX2a+MC8qD4BJDpA5Nut58DZFk41UYv1GRe
         j2bI835EwstUyPXUVPqUBzNZGYCxwUWW4J85iW7p5nUzU+LBg+cDRPdEak+xySQ3bJHK
         Jjvl2S3k4LPDEOGA4PHaMK/i0ZYfwETkkVxFDSe2E7j1F0eII/Vb2FpFeZx2jGETIdhh
         JLbY98G6ZP2etslbBnSRNDM9URZHyYYxsnxrMhAA6dbJrvPRVJyG9iD5LODnSEThclp+
         DQLQ==
X-Gm-Message-State: AOPr4FVxzwG2USpNlqvI8BsCKR1MNZu3ml9iTczpkU10JmwRl5fKVvMdAR4D41xt0R9YXw==
X-Received: by 10.66.177.16 with SMTP id cm16mr10869418pac.23.1463031203692;
        Wed, 11 May 2016 22:33:23 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id m86sm8585820pfj.77.2016.05.11.22.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 22:33:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294390>

Reimplement the `write_terms` shell function in C and add a `write-terms`
subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
remove the subcommand `--check-term-format` as it can now be called from
inside the function write_terms() C implementation.

Using `--write-terms` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other method.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 37 ++++++++++++++++++++++++++++++-------
 git-bisect.sh            | 22 +++++++---------------
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3c748d1..2b21c02 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -6,7 +6,7 @@
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
-	N_("git bisect--helper --check-term-format <term> <orig_term>"),
+	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	NULL
 };
 
@@ -56,18 +56,41 @@ static int check_term_format(const char *term, const char *orig_term)
 	return 0;
 }
 
+int write_terms(const char *bad, const char *good)
+{
+	struct strbuf content = STRBUF_INIT;
+	FILE *fp;
+	int res;
+
+	if (!strcmp(bad, good))
+		return error(_("please use two different terms"));
+
+	if (check_term_format(bad, "bad") || check_term_format(good, "good"))
+		return -1;
+
+	strbuf_addf(&content, "%s\n%s\n", bad, good);
+	fp = fopen(".git/BISECT_TERMS", "w");
+	if (!fp){
+		strbuf_release(&content);
+		die_errno(_("could not open the file to read terms"));
+	}
+	res = strbuf_write(&content, fp);
+	fclose(fp);
+	strbuf_release(&content);
+	return (res < 0) ? -1 : 0;
+}
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		CHECK_TERM_FMT
+		WRITE_TERMS
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
-		OPT_CMDMODE(0, "check-term-format", &cmdmode,
-			 N_("check format of the term"), CHECK_TERM_FMT),
+		OPT_CMDMODE(0, "write-terms", &cmdmode,
+			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -82,10 +105,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	switch (cmdmode) {
 	case NEXT_ALL:
 		return bisect_next_all(prefix, no_checkout);
-	case CHECK_TERM_FMT:
+	case WRITE_TERMS:
 		if (argc != 2)
-			die(_("--check-term-format requires two arguments"));
-		return check_term_format(argv[0], argv[1]);
+			die(_("--write-terms requires two arguments"));
+		return write_terms(argv[0], argv[1]);
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 7d7965d..2dd7ec5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -210,7 +210,7 @@ bisect_start() {
 	eval "$eval true" &&
 	if test $must_write_terms -eq 1
 	then
-		write_terms "$TERM_BAD" "$TERM_GOOD"
+		git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -557,18 +557,6 @@ get_terms () {
 	fi
 }
 
-write_terms () {
-	TERM_BAD=$1
-	TERM_GOOD=$2
-	if test "$TERM_BAD" = "$TERM_GOOD"
-	then
-		die "$(gettext "please use two different terms")"
-	fi
-	git bisect--helper --check-term-format "$TERM_BAD" bad || exit
-	git bisect--helper --check-term-format "$TERM_GOOD" good || exit
-	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
-}
-
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
@@ -582,13 +570,17 @@ check_and_set_terms () {
 		bad|good)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms bad good
+				TERM_BAD=bad
+				TERM_GOOD=good
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 			fi
 			;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				write_terms new old
+				TERM_BAD=new
+				TERM_GOOD=old
+				git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD"
 			fi
 			;;
 		esac ;;
-- 
2.8.2
