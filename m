From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5] submodule deinit: require '--all' instead of '.' for all submodules
Date: Thu,  5 May 2016 12:52:32 -0700
Message-ID: <1462477952-6669-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu May 05 21:52:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayPKM-0000HL-JU
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 21:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757763AbcEETwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 15:52:43 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33724 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738AbcEETwl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 15:52:41 -0400
Received: by mail-pf0-f182.google.com with SMTP id 206so41260483pfu.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=PEvPWxkyaJ1UN4wvmFexnw/kfsnblNpOsURjbZd7qmk=;
        b=EEEOCLEMnFH+qdHuSRaSU1fRsPPZyqiXaufJCwhqUMi5AH/OcbguGx0DkY64p82oPH
         DS7pzpsLn3+7fDR+hFnTaBA1uTj87Wa38Y1LVvVRhdh/LQkdDDXX42CXKbASAo7+X0Tg
         gw8RC2kAiU/b5ti63b5FCLhAlZe8yrGFWjd+g3FUm8bUm98olzWFrc71ZFF8aHZY8r0t
         5yb4rlh/YPFhQJAns7f+xqtGrmgrQ0dE8kxSAVEoKkGfi0fEUw5K/dIbtyUcGV1n+DPd
         6c4tOF+9gaXj7ISSVNOyP8NlPap50JaHWZQn5gUAzehj7TwW8jlWemnv/VGHfIAk97Jh
         F9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PEvPWxkyaJ1UN4wvmFexnw/kfsnblNpOsURjbZd7qmk=;
        b=ajmAQ7l9AKibiwmxJ5AjqA5HGCO19G0kqsjAYaECpbWllws6Kfjzj+kyZLrGNbj4pV
         kvz3vTMEAsRyxdDXN2c/HgavCCkhSc6Pp05YM/JpAGm6zR9v5WGdzuM4RxO5QB4EYCL5
         ufRP9DXe7IWs8A1R1Ekrwgvbt8FpHIrEiFD9nNLw6APO6w+ze2AD51GCdQSF6cIK1iyf
         UuJdS1OX3sG3JAapp0K3RS5CYO6MGbIiIFWuOzk5wo7fUS8tVIN/mGDofhuBmpcM5RGg
         Wt1TIgcUb6PFxNUTTFK1gjKG8zp4y0YW08eTZVTD6iRk5xAGSHHJ9+yMKa4BKSDA5jgS
         a8xw==
X-Gm-Message-State: AOPr4FXWLXxtMZ8Ifzv0/KgvIoj5xOAppMkFTQM2FbGE3mOn3Qyyn+KBo8/qHCAUv/1MrS8I
X-Received: by 10.98.70.144 with SMTP id o16mr23341003pfi.26.1462477960327;
        Thu, 05 May 2016 12:52:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:35ed:c390:3d1b:b3bd])
        by smtp.gmail.com with ESMTPSA id i6sm15552780pfc.65.2016.05.05.12.52.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 May 2016 12:52:39 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.1.g3af9c03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293671>

The discussion in [1] pointed out that '.' is a faulty suggestion as
there is a corner case where it fails:

> "submodule deinit ." may have "worked" in the sense that you would
> have at least one path in your tree and avoided this "nothing
> matches" most of the time.  It would have still failed with the
> exactly same error if run in an empty repository, i.e.
>
>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>        $ git init
>        $ rungit v2.6.6 submodule deinit .
>        error: pathspec '.' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>        $ >file && git add file
>        $ rungit v2.6.6 submodule deinit .
>        $ echo $?
>        0

So instead of a pathspec add the '--all' option to deinit all submodules
and add a test to check for the corner case of an empty repository.

The code only needs to learn about the '--all' option and doesn't
require further changes as `git submodule--helper list "$@"` will list
all submodules when "$@" is empty.

[1] http://news.gmane.org/gmane.comp.version-control.git/289535

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

  * dropped the short -a option
  * dropped the "In version 2.8 and before.." part of the documentation
  * be concise and give the usage. This doesn't use the new "die_with_usage"
    or "error_with_usage" though.
  * fixed the test

 Documentation/git-submodule.txt | 19 +++++++++++++------
 git-submodule.sh                | 15 ++++++++++++---
 t/t7400-submodule-basic.sh      | 24 +++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..ad85183 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
+'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--] [<path>...]
@@ -140,12 +140,15 @@ deinit::
 	tree. Further calls to `git submodule update`, `git submodule foreach`
 	and `git submodule sync` will skip any unregistered submodules until
 	they are initialized again, so use this command if you don't want to
-	have a local checkout of the submodule in your work tree anymore. If
+	have a local checkout of the submodule in your working tree anymore. If
 	you really want to remove a submodule from the repository and commit
 	that use linkgit:git-rm[1] instead.
 +
-If `--force` is specified, the submodule's work tree will be removed even if
-it contains local modifications.
+When the command is run without pathspec, it errors out,
+instead of deinit-ing everything, to prevent mistakes.
++
+If `--force` is specified, the submodule's working tree will
+be removed even if it contains local modifications.
 
 update::
 +
@@ -247,6 +250,10 @@ OPTIONS
 --quiet::
 	Only print error messages.
 
+--all::
+	This option is only valid for the deinit command. Unregister all
+	submodules in the working tree.
+
 -b::
 --branch::
 	Branch of repository to add as submodule.
@@ -257,8 +264,8 @@ OPTIONS
 --force::
 	This option is only valid for add, deinit and update commands.
 	When running add, allow adding an otherwise ignored submodule path.
-	When running deinit the submodule work trees will be removed even if
-	they contain local changes.
+	When running deinit the submodule working trees will be removed even
+	if they contain local changes.
 	When running update (only effective with the checkout procedure),
 	throw away local changes in submodules when switching to a
 	different commit; and always run a checkout operation in the
diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..5e9b5c0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
+   or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
@@ -521,6 +521,7 @@ cmd_init()
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
+	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -530,6 +531,9 @@ cmd_deinit()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--all)
+			deinit_all=t
+			;;
 		--)
 			shift
 			break
@@ -544,9 +548,14 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
+	if test -n "$deinit_all" && test "$#" -ne 0
+	then
+		echo >&2 "$(eval_gettext "pathspec and --all are incompatible")"
+		usage
+	fi
+	if test $# = 0 && test -z "$deinit_all"
 	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e1abd19..cc3cca0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -11,6 +11,10 @@ subcommands of git submodule.
 
 . ./test-lib.sh
 
+test_expect_success 'submodule deinit works on empty repository' '
+	git submodule deinit --all
+'
+
 test_expect_success 'setup - initial commit' '
 	>t &&
 	git add t &&
@@ -858,7 +862,8 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		>file &&
 		git add file &&
 		git commit -m "repo should not be empty"
-		git submodule deinit .
+		git submodule deinit . &&
+		git submodule deinit --all
 	)
 '
 
@@ -900,6 +905,19 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	rmdir init example2
 '
 
+test_expect_success 'submodule deinit --all deinits all initialized submodules' '
+	git submodule update --init &&
+	git config submodule.example.foo bar &&
+	git config submodule.example2.frotz nitfol &&
+	test_must_fail git submodule deinit &&
+	git submodule deinit --all >actual &&
+	test -z "$(git config --get-regexp "submodule\.example\.")" &&
+	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
+	test_i18ngrep "Cleared directory .init" actual &&
+	test_i18ngrep "Cleared directory .example2" actual &&
+	rmdir init example2
+'
+
 test_expect_success 'submodule deinit deinits a submodule when its work tree is missing or empty' '
 	git submodule update --init &&
 	rm -rf init example2/* example2/.git &&
@@ -966,6 +984,10 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
+	git submodule deinit --all >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init example2
 '
 
-- 
2.8.0.1.g3af9c03
