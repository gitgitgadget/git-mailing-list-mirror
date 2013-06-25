From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v15 16/16] test: run testcases with POSIX absolute paths on Windows
Date: Tue, 25 Jun 2013 23:53:57 +0800
Message-ID: <efaab326bda8d9da8e16625a3889262fa1175b93.1372175283.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 17:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrVaw-0004nk-To
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 17:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3FYPzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 11:55:18 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36866 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3FYPzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 11:55:16 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1004454pdi.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=4V5XXIAH88fkHPtCW86VQkX+T9TaUhWNQS5glBMflb0=;
        b=b3ELpx88b9IwL2dboJ1I4XoMUIiVfcjAm45JSSMPNZ+h8+t//jNFoTRfWrcvg8jzTO
         S256KXgXwHNN3yeDBcSgQx8gCJO+OqRlh+Wa8j6f+6roFF1XzlvNVdkKv42nGMSGnu7q
         zIbGbNBWPfpAOExoFilBTS2kzjpcMG7nvvqpfB3ryhENMKZkmFgirUHHPR8L68HC7XXj
         0n1i0IRSYHEW5lQaLr5Cx53NMB7eCWn/psYHxpNCc9cIL7W68hvwft5QO9ejztiuKnmO
         fBAv05/u2Q9+eavpjaR9BhkYqHp/HmsjNt7QZdnSzMwuRMi+luch6aX4sPJdivbThUf8
         B8AQ==
X-Received: by 10.66.224.73 with SMTP id ra9mr386476pac.163.1372175714324;
        Tue, 25 Jun 2013 08:55:14 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.39])
        by mx.google.com with ESMTPSA id pb5sm23760930pbc.29.2013.06.25.08.55.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 25 Jun 2013 08:55:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.756.g2e9b71f
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1372175282.git.worldhello.net@gmail.com>
References: <cover.1372175282.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228976>

Some test cases are skipped on Windows by marking with POSIX prereq.
This is because arguments look like absolute paths (such as /a/b)
for regular Windows programs (*.exe executables, no bash scripts)
are changed to Windows paths (like C:/msysgit/a/b).

There is no cygpath nor equivalent on msysGit, but it is easy to
write one. New subcommand "mingw_path" is added in test-path-utils,
so that we can get the expected absolute paths on Windows. E.g.

    COMMAND LINE                        Linux output  Windows output
    ==================================  ============  ===============
    test-path-utils mingw_path /        /             C:/msysgit
    test-path-utils mingw_path /a/b/    /a/b/         C:/msysgit/a/b/

With this utility, most skipped test cases in t0060 can be turned on
to be tested correctly on Windows.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t0060-path-utils.sh | 44 +++++++++++++++++++++++---------------------
 test-path-utils.c     |  5 +++++
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 76c779..3a48d 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -8,13 +8,15 @@ test_description='Test various path utilities'
 . ./test-lib.sh
 
 norm_path() {
+	expected=$(test-path-utils mingw_path "$2")
 	test_expect_success $3 "normalize path: $1 => $2" \
-	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
+	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$expected'"
 }
 
 relative_path() {
+	expected=$(test-path-utils mingw_path "$3")
 	test_expect_success $4 "relative path: $1 $2 => $3" \
-	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$3'"
+	"test \"\$(test-path-utils relative_path '$1' '$2')\" = '$expected'"
 }
 
 # On Windows, we are using MSYS's bash, which mangles the paths.
@@ -39,8 +41,8 @@ ancestor() {
 	 test \"\$actual\" = '$expected'"
 }
 
-# Absolute path tests must be skipped on Windows because due to path mangling
-# the test program never sees a POSIX-style absolute path
+# Some absolute path tests should be skipped on Windows due to path mangling
+# on POSIX-style absolute paths
 case $(uname -s) in
 *MINGW*)
 	;;
@@ -73,30 +75,30 @@ norm_path d1/s1//../s2/../../d2 d2
 norm_path d1/.../d2 d1/.../d2
 norm_path d1/..././../d2 d1/d2
 
-norm_path / / POSIX
+norm_path / /
 norm_path // / POSIX
 norm_path /// / POSIX
-norm_path /. / POSIX
+norm_path /. /
 norm_path /./ / POSIX
 norm_path /./.. ++failed++ POSIX
-norm_path /../. ++failed++ POSIX
+norm_path /../. ++failed++
 norm_path /./../.// ++failed++ POSIX
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
@@ -198,8 +200,8 @@ relative_path /		/a/b/		../../
 relative_path /a/c	/a/b/		../c
 relative_path /a/c	/a/b		../c
 relative_path /x/y	/a/b/		../../x/y
-relative_path /a/b	"<empty>"	/a/b	POSIX
-relative_path /a/b 	"<null>"	/a/b	POSIX
+relative_path /a/b	"<empty>"	/a/b
+relative_path /a/b 	"<null>"	/a/b
 relative_path a/b/c/	a/b/		c/
 relative_path a/b/c/	a/b		c/
 relative_path a/b//c	a//b		c
diff --git a/test-path-utils.c b/test-path-utils.c
index 1bf473..bb975 100644
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
 		const char *in, *prefix, *rel;
-- 
1.8.3.1.756.g2e9b71f
