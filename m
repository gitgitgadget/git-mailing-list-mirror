From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v14 16/16] test: run testcases with POSIX absolute paths on Windows
Date: Mon, 24 Jun 2013 23:21:40 +0800
Message-ID: <7b6237d76d53c240daf4641a00a09af5135fbba7.1372087065.git.worldhello.net@gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8bk-000724-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab3FXPXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:23:00 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51123 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3FXPW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:22:59 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so11001640pbc.23
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=iUoGBHPs/HXi7QVZsCnjxKIACRaSX/RpQ8WclgpJwzw=;
        b=LtU3hT6yufdtaO2hScLCIRlTGQQ55u35q/am6u071L+rDAxyz+Rd7kynp0Zep1QpMf
         2B3pNcwoTO0fzQu0EvqKOKBbg9BD0fDdkTBiMcYeaOsmnrxW5WSFgoP51LnBbmEKNVsb
         F4oFJr3Gh61PJ0bjpfvUVf148gyiRz2Pi+KaWyJJz4W+dqfy4HPZP8RnrKnh0AFOjhS/
         P2/ElUWeGg54ahPQYxN/SxZBaqMhA5n1PWMR9XdVrUSYyYa+EQYP+Mo0X83jxJzjHsq2
         EOaa8v7PjTroZlkrJ/p1ol4lAZjxSLI5VbeObz47gmg4+Bl4tdt87IllQRYZUjfDr/dd
         vudw==
X-Received: by 10.66.0.233 with SMTP id 9mr28602379pah.33.1372087378457;
        Mon, 24 Jun 2013 08:22:58 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id ix3sm18576807pbc.37.2013.06.24.08.22.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 08:22:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g41beab0
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372087065.git.worldhello.net@gmail.com>
References: <CANYiYbHQ307TroSd6Lk=5zg68jdKxGeA4N=hWGfaz1W29NhNVw@mail.gmail.com> <cover.1372087065.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228838>

Add new subcommand "mingw_path" in test-path-utils, so that we can get
the expected absolute paths on Windows. For example:

    COMMAND LINE                        Linux  Windows
    ==================================  =====  ===============
    test-path-utils mingw_path /        /      C:/msysgit
    test-path-utils mingw_path /a/b/    /a/b/  C:/msysgit/a/b/

With this utility, most skipped test cases in t0060 can be runcorrectly
on Windows.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 73 ++++++++++++++++++++++++++++++++++-----------------
 test-path-utils.c     |  5 ++++
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4deec..dac84 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,14 +7,39 @@ test_description='Test various path utilities'
 
 . ./test-lib.sh
 
+mingw_path() {
+	case $2 in
+	NO_MINGW)
+		echo "$1"
+		;;
+	*)
+		test-path-utils mingw_path "$1"
+		;;
+	esac
+}
+
+get_prereq_flag() {
+	case $1 in
+	POSIX)
+		echo $1
+		;;
+	*)
+		;;
+	esac
+}
+
 norm_path() {
-	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
+	expected=$(mingw_path "$2" "$3")
+	prereq=$(get_prereq_flag $3)
+	test_expect_success $prereq "normalize path: $1 => $2" \
+	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$expected'"
 }
 
 relative_path() {
-	test_expect_success $4 "relative path: $1 $2 => $3" \
-	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
+	expected=$(mingw_path "$3" "$4")
+	prereq=$(get_prereq_flag $4)
+	test_expect_success $prereq "relative path: $1 $2 => $3" \
+	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$expected'"
 }
 
 # On Windows, we are using MSYS's bash, which mangles the paths.
@@ -39,8 +64,8 @@ ancestor() {
 	 test \"\$actual\" = '$expected'"
 }
 
-# Absolute path tests must be skipped on Windows because due to path mangling
-# the test program never sees a POSIX-style absolute path
+# Some absolute path tests should be skipped on Windows due to path mangling
+# on POSIX-style absolute paths
 case $(uname -s) in
 *MINGW*)
 	;;
@@ -73,10 +98,10 @@ norm_path d1/s1//../s2/../../d2 d2
 norm_path d1/.../d2 d1/.../d2
 norm_path d1/..././../d2 d1/d2
 
-norm_path / / POSIX
-norm_path // / POSIX
-norm_path /// / POSIX
-norm_path /. / POSIX
+norm_path / /
+norm_path // / NO_MINGW
+norm_path /// / NO_MINGW
+norm_path /. /
 norm_path /./ / POSIX
 norm_path /./.. ++failed++ POSIX
 norm_path /../. ++failed++ POSIX
@@ -84,19 +109,19 @@ norm_path /./../.// ++failed++ POSIX
 norm_path /dir/.. / POSIX
 norm_path /dir/sub/../.. / POSIX
 norm_path /dir/sub/../../.. ++failed++ POSIX
-norm_path /dir /dir POSIX
-norm_path /dir// /dir/ POSIX
-norm_path /./dir /dir POSIX
-norm_path /dir/. /dir/ POSIX
-norm_path /dir///./ /dir/ POSIX
-norm_path /dir//sub/.. /dir/ POSIX
-norm_path /dir/sub/../ /dir/ POSIX
+norm_path /dir /dir
+norm_path /dir// /dir/
+norm_path /./dir /dir
+norm_path /dir/. /dir/
+norm_path /dir///./ /dir/
+norm_path /dir//sub/.. /dir/
+norm_path /dir/sub/../ /dir/
 norm_path //dir/sub/../. /dir/ POSIX
-norm_path /dir/s1/../s2/ /dir/s2/ POSIX
-norm_path /d1/s1///s2/..//../s3/ /d1/s3/ POSIX
-norm_path /d1/s1//../s2/../../d2 /d2 POSIX
-norm_path /d1/.../d2 /d1/.../d2 POSIX
-norm_path /d1/..././../d2 /d1/d2 POSIX
+norm_path /dir/s1/../s2/ /dir/s2/
+norm_path /d1/s1///s2/..//../s3/ /d1/s3/
+norm_path /d1/s1//../s2/../../d2 /d2
+norm_path /d1/.../d2 /d1/.../d2
+norm_path /d1/..././../d2 /d1/d2
 
 ancestor / / -1
 ancestor /foo / 0
@@ -197,8 +222,8 @@ relative_path /a	/a/b		../
 relative_path /		/a/b/		../../
 relative_path /a/c	/a/b/		../c
 relative_path /a/c	/a/b		../c
-relative_path /a/b	"<empty>"	/a/b	POSIX
-relative_path /a/b 	"<null>"	/a/b	POSIX
+relative_path /a/b	"<empty>"	/a/b
+relative_path /a/b 	"<null>"	/a/b
 relative_path "<empty>"	/a/b		./
 relative_path "<empty>"	"<empty>"	./
 relative_path "<empty>"	"<null>"	./
diff --git a/test-path-utils.c b/test-path-utils.c
index 95ef4..699ef 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -116,6 +116,11 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 3 && !strcmp(argv[1], "mingw_path")) {
+		puts(argv[2]);
+		return 0;
+	}
+
 	if (argc == 4 && !strcmp(argv[1], "relative_path")) {
 		struct strbuf sb = STRBUF_INIT;
 		const char *abs, *base, *rel;
-- 
1.8.3.1.756.g41beab0
