From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 16/16] test: run testcases with POSIX absolute paths
 on Windows
Date: Tue, 25 Jun 2013 08:40:36 +0800
Message-ID: <CANYiYbE52EtdnoPUW5HYio1SQsKoVjEf5BdxbcTqjsNXCmq92g@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<7b6237d76d53c240daf4641a00a09af5135fbba7.1372087065.git.worldhello.net@gmail.com>
	<51C89655.4070208@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 02:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrHJK-0006Am-3u
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 02:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab3FYAki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 20:40:38 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:38895 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3FYAkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 20:40:37 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so8848149wes.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gg97fpLHn4QrKPvVBa7mRRrFlOjyIfbDotIn0CMETZM=;
        b=iW4iB0ZFv4ZBLsBFDWdR2yKDrCYpoUtBr9zyA1Z7bQyJrL9K9fhl6TN2Q/OwLCn44C
         OI9c37RBFppjDdn17Cr0ua5W62lTNUzrpS7VR5eWqdQrZnU0H6oJbFsI065V6RM0B1Fo
         cCX3SdpyRT0OOk76Yyvg5H0B7muMJmAgX+dhFZutBBG2nDcQyGCSOUaytsk574F4+vh7
         kHwKSakUWwWqV0iIxWRrTcfACRtqcvxGl3yTYJzQXoDCqmsd+MwkaD0nm10Sa/9ePJlr
         5hQXuYBmACJlcmpomHBgt/iyC2dAVoFBzNILp4hWjnNkAO0PBW7kCpZHgkNNX1JZAw55
         HQtA==
X-Received: by 10.194.133.106 with SMTP id pb10mr10660598wjb.62.1372120836133;
 Mon, 24 Jun 2013 17:40:36 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Mon, 24 Jun 2013 17:40:36 -0700 (PDT)
In-Reply-To: <51C89655.4070208@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228936>

2013/6/25 Johannes Sixt <j6t@kdbg.org>:
> Thanks for working on this. Did you have an opportunity to test on Windows?

Yes, I write this commit on Windows, and have tested it in msysGit.

>> +mingw_path() {
>> +     case $2 in
>> +     NO_MINGW)
>> +             echo "$1"
>> +             ;;
>> +     *)
>> +             test-path-utils mingw_path "$1"
>> +             ;;
>> +     esac
>> +}
>> +
>> +get_prereq_flag() {
>> +     case $1 in
>> +     POSIX)
>> +             echo $1
>> +             ;;
>> +     *)
>> +             ;;
>> +     esac
>> +}
>
> It took me a while to notice that the token POSIX serves a different
> purpose than NO_MINGW: POSIX is only needed to skip a test, NO_MINGW is
> only used to avoid a test-path-utils call. The reason for the complexity
> is that you put both tokens in the same parameter position in the
> invocations of the test cases.
>
> You use NO_MINGW only twice. I would just skip these two tests, then the
> parameter position is reserved for the prerequisite, and things stay simple.
>

I agree. I rewrite the commit log and remove NO_MINGW like below:

-- 8-< --

>From 4875562a849422a3f31d6ccf3c0eb8a6693adf0e Mon Sep 17 00:00:00 2001
Message-Id: <4875562a849422a3f31d6ccf3c0eb8a6693adf0e.1372120737.git.worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 24 Jun 2013 21:35:23 +0800
Subject: [PATCH] test: run testcases with POSIX absolute paths on Windows

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
 t/t0060-path-utils.sh | 42 ++++++++++++++++++++++--------------------
 test-path-utils.c     |  5 +++++
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4deec..d5f35 100755
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
@@ -73,10 +75,10 @@ norm_path d1/s1//../s2/../../d2 d2
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
 norm_path /../. ++failed++ POSIX
@@ -84,19 +86,19 @@ norm_path /./../.// ++failed++ POSIX
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
@@ -197,8 +199,8 @@ relative_path /a	/a/b		../
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
