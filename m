From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4] submodule deinit: require '--all' instead of '.' for all submodules
Date: Wed,  4 May 2016 15:40:03 -0700
Message-ID: <1462401603-2067-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 05 00:40:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay5Sr-0001ix-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbcEDWkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 18:40:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32843 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbcEDWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 18:40:08 -0400
Received: by mail-pa0-f41.google.com with SMTP id xk12so28947180pac.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1hMJnszB4xyN7bnncEG2NnFrsFty4pKctvoZwbXeY+4=;
        b=i9aecYXTt/nUxmarN+qwv98yBwHN1SSABgh/4GQmRyRosamiwjegAwzH6KtQkyV5yk
         38QV5b4lIfALh1LiHIDckO9v+JMligfRbKkha2ckzwkPo3z0WfZUQkbV7oVrWokOMWXh
         9mjN1RxPWOpkrZDO1NWOkD3WCld5ikDvV2IAbDIejWPtoS0/fiRtfVceXUUgddBcHPmv
         epRRNxvztyjmnmCc40Xev0WQb4mkgDR5DvgnGvd/i2EzG1zb8+yBmjFw8PV3rIOLyy5y
         Khb9fq/DFF9BaEPLFGNRfnkbDdF62WYg/4pTvYj5fP1FUkAm1t1oddrNgV9BgodOLvlC
         aX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1hMJnszB4xyN7bnncEG2NnFrsFty4pKctvoZwbXeY+4=;
        b=ePXa1p4jHkbmDOiQ4+bI7MlMOZqrbsOi9Xz9PtP7z1+9MkGkExGRDdPxuc1ct6O5yn
         eCdUx0U046FQLryChMpI+Vvv+A2KbDcSvqw3XTy+uQSqv2PKhQd7p30RamcOb5/x8pyu
         /aOdQOfj6U6D8UBexvFuQmRbfxoumTlZw5VkZTYbrqhZgdBLl2X40UNia8etm390ZAQM
         Nb0gqg4/qfW7F8VfwgfxBYtfM8d6KnSylCg4j+LvDJq88qEdSoO0fHsjPC1rPmryAVZf
         IZSvq8C2O8oGzdPA03NN2aK+lJh7IU8bTp7XtMwuUVa+hYJM+9DL/uSuhmTee9HcZZyF
         l3zA==
X-Gm-Message-State: AOPr4FUTFoJR8WxWzy3KUtrvME1df+8Lp/0J62n55JjSgNHH9dWElLlrnUMmkiH/zEHQX1fx
X-Received: by 10.66.90.196 with SMTP id by4mr15788214pab.117.1462401607298;
        Wed, 04 May 2016 15:40:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:5dde:2d2:8425:8aa0])
        by smtp.gmail.com with ESMTPSA id c190sm8435016pfb.33.2016.05.04.15.40.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 May 2016 15:40:06 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.9.g082ee08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293612>

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
* reworded commit message slightly (realize, pathspec)
* reworded the documentation 
* no "usage:" to go thru l10n.

 Documentation/git-submodule.txt | 25 +++++++++++++++++++------
 git-submodule.sh                | 14 +++++++++++---
 t/t7400-submodule-basic.sh      | 28 +++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..aeeb2ed 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
+'git submodule' [--quiet] deinit [-f|--force] (-a|--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--] [<path>...]
@@ -140,12 +140,20 @@ deinit::
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
+instead of deinit-ing everything, to prevent mistakes. In
+version 2.8 and before the command gave a suggestion to use
+'.' to unregister all submodules when it was invoked without
+any argument, but this suggestion did not work and gave a
+wrong message if you followed it in pathological cases and is
+no longer recommended.
++
+If `--force` is specified, the submodule's working tree will
+be removed even if it contains local modifications.
 
 update::
 +
@@ -247,6 +255,11 @@ OPTIONS
 --quiet::
 	Only print error messages.
 
+-a::
+--all::
+	This option is only valid for the deinit command. Unregister all
+	submodules in the working tree.
+
 -b::
 --branch::
 	Branch of repository to add as submodule.
@@ -257,8 +270,8 @@ OPTIONS
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
index 43c68de..caa80fe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
+   or: $dashless [--quiet] deinit [-f|--force] (-a|--all| [--] <path>...)
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
+		-a|--all)
+			deinit_all=t
+			;;
 		--)
 			shift
 			break
@@ -544,9 +548,13 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
+	if test -n "$deinit_all" && test "$#" -ne 0
+	then
+		die "$(eval_gettext "--all and pathspec are incompatible")"
+	fi
+	if test $# = 0 && test -z "$deinit_all"
 	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e1abd19..bd0d229 100755
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
@@ -966,6 +984,14 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
+	git submodule deinit --all >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
+	git submodule deinit -a >actual &&
+	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
+	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
+	test_i18ngrep "Cleared directory .init" actual &&
 	rmdir init example2
 '
 
-- 
2.8.0.rc4.9.g082ee08.dirty
