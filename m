From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue,  3 May 2016 17:33:12 -0700
Message-ID: <1462321992-15153-1-git-send-email-sbeller@google.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 04 02:33:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axkko-0007pO-2o
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 02:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880AbcEDAdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 20:33:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34004 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849AbcEDAdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 20:33:21 -0400
Received: by mail-pa0-f54.google.com with SMTP id r5so17390877pag.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnV+npLtYEQeo/rRV2uxiTQ2JbEHUDAyZGvpkTBJMLo=;
        b=iEZ4T/UGrwtl3BrM7kR3dubQCKz8zngvYUP83+9mbIUfVEW/zzY0tDQZ8q0gtTIOww
         +5wZVEmGicAec+HjOyuyAIPdzIM4LOxT+A3LElVQR7XhFG/mDCTFVxnge9GTR+Ys363B
         7aA98ofA1NCaDql5eCgWaQNED4NFX8BHy4gjsWjYdtF/+diRChEPd+n1wju+SZdB2C48
         nOZV8alDwGZYTfJbQM5tIkLyXpFByHSwExgaUZB2GlLihhoFgz5nJOr9ySFlsfK3YWxT
         Y6knDCkQfu09uhUnOdU9jinG/FWiYykLjcf45Tolgw0aPbUilLpqHVnR46T6+y8z0Uej
         Ep3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnV+npLtYEQeo/rRV2uxiTQ2JbEHUDAyZGvpkTBJMLo=;
        b=eSgrQZFPoCL/bTNjvwoszdPwkCfufF5Bwkfw+dsQwppGX0oAJBz+8smQ3HnhLUDYko
         RZygpW3CxQSSHuQJ139kOXLxSwqahJob1GtGMcsXht5eXtX1iBOOu0yV8AjQ2JXpOeEQ
         yvVd5oJqN5vbCh0KZNStCLhInpFQGUgRGSJR1z6RCz04YBxma43X/zSZ/OQ0iQe5TgKe
         7kZ2+ztLpl7zgG4KDMMwaTPUPD06XnnK0HIyDhyO1eAOjdomRoGMbpe8/gmGOsucSC9I
         Ju6cLp6umO79iWhxL9JtZMfu74LR/F61Ig7zVsaZMliYGeee0DCjGdKCJAD7Cicd1GYO
         sV0A==
X-Gm-Message-State: AOPr4FVzhhDkn37dhm0wCt8po6sLrTaRZ9HX4ftA0DYlZoXgnoBM7qaAAsaU/Kq/DMnanXk/
X-Received: by 10.66.26.43 with SMTP id i11mr8001037pag.58.1462321999978;
        Tue, 03 May 2016 17:33:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:81d8:5415:7a03:cda9])
        by smtp.gmail.com with ESMTPSA id bk8sm927022pac.3.2016.05.03.17.33.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 17:33:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.9.g9db9a47
In-Reply-To: <1462313499-6760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293482>

The discussion in [1] realized that '.' is a faulty suggestion as
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

So instead of a path spec add a parameter '--all' to deinit all submodules
and add a test to check for the corner case of an empty repository.

The code only needs to learn about the '--all' parameter and doesn't
require further changes as `git submodule--helper list "$@"` will list
all submodules in case of "$@" being empty.

[1] http://news.gmane.org/gmane.comp.version-control.git/289535

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio writes:
> I do not particularly view it as a new feature.  The way the old
> message suggested did not work in a pathological corner case, but we
> wanted to keep the "force user to be explicit when doing mass
> destruction", and a fix we happened to chose requires addition of a
> new option--that would still look like a fix to me.

It is a fix for a corner case, but it is renaming the switch, so I would
expect that we'd wait for a new version at least.

> It is not like we are forbidding the use of "submodule deinit ."
> that used to work in a tree with at least one tracked path.  With
> the change, a script that has such a command will continue to work,
> no?

But we are also not garantueeing it either? Before this patch
"submodule deinit ." was the blessed way to deinit all submodules.
Sure, `deinit "*"` may have worked as well, but that was never asserted
via tests internally nor via documentation to the user.

So if someone was yelling at us because of a bug, we'd fix it if it was
related to "deinit .", but not if it was "deinit '*'".

This change both gives guidance in the documentation on how to deinit
all submodules as well as removing the tests for the '.' case (by 
replacing them with the 'all' case).

So I'd prefer if we'd spin this as a feature rather than a bug fix.

This was developed on 2a4c8c36a7f6ad, 2016-03-24
Merge branch 'sb/submodule-module-list-pathspec-fix'

Thanks,
Stefan

 Documentation/git-submodule.txt | 12 +++++++++++-
 git-submodule.sh                | 12 ++++++++++--
 t/t7400-submodule-basic.sh      | 14 +++++++++-----
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..4dbf8d0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
+'git submodule' [--quiet] deinit [-f|--force] [-a|--all] [--] <path>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--] [<path>...]
@@ -144,6 +144,11 @@ deinit::
 	you really want to remove a submodule from the repository and commit
 	that use linkgit:git-rm[1] instead.
 +
+	To unregister all submodules use `--all` with no path spec. In
+	version 2.8 and prior, you were advised to give '.' to unregister
+	all submodules. This may continue to work in the future, but as the
+	path spec '.' may include regular files, this could stop working.
++
 If `--force` is specified, the submodule's work tree will be removed even if
 it contains local modifications.
 
@@ -247,6 +252,11 @@ OPTIONS
 --quiet::
 	Only print error messages.
 
+-a::
+--all::
+	This option is only valid for the deinit command. Unregister all
+	submodules in the work tree.
+
 -b::
 --branch::
 	Branch of repository to add as submodule.
diff --git a/git-submodule.sh b/git-submodule.sh
index 43c68de..301cd0d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
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
+		die "$(eval_gettext "'--all' is incompatible with pathspec arguments")"
+	fi
+	if test $# = 0 && test -z "$deinit_all"
 	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
+		die "$(eval_gettext "Use '--all' if you really want to deinitialize all submodules")"
 	fi
 
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e1abd19..6e28ea5 100755
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
@@ -858,7 +862,7 @@ test_expect_success 'submodule deinit works on repository without submodules' '
 		>file &&
 		git add file &&
 		git commit -m "repo should not be empty"
-		git submodule deinit .
+		git submodule deinit --all
 	)
 '
 
@@ -887,12 +891,12 @@ test_expect_success 'submodule deinit from subdirectory' '
 	rmdir init
 '
 
-test_expect_success 'submodule deinit . deinits all initialized submodules' '
+test_expect_success 'submodule deinit --all deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
 	test_must_fail git submodule deinit &&
-	git submodule deinit . >actual &&
+	git submodule deinit --all >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
 	test_i18ngrep "Cleared directory .init" actual &&
@@ -958,11 +962,11 @@ test_expect_success 'submodule deinit is silent when used on an uninitialized su
 	git submodule deinit init >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-	git submodule deinit . >actual &&
+	git submodule deinit --all >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-	git submodule deinit . >actual &&
+	git submodule deinit --all >actual &&
 	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" actual &&
 	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .example2" actual &&
 	test_i18ngrep "Cleared directory .init" actual &&
-- 
2.8.0.rc4.10.geb92688.dirty
