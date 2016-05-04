From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue,  3 May 2016 18:19:45 -0700
Message-ID: <1462324785-26389-1-git-send-email-sbeller@google.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 04 03:20:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axlTw-0000ry-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 03:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbcEDBTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 21:19:54 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35401 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbcEDBTy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 21:19:54 -0400
Received: by mail-pa0-f45.google.com with SMTP id iv1so17287699pac.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 18:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYU4hXQY6jsB3UwMGqAId+rNaoIx9vABU3T3ghlDTh4=;
        b=h6TC18AOmuOXuiqAe0YbwZpWyB2MUwYfapidrsi6Ep9ooW8yIQfPGlaQ5sjF/CFksU
         qXcrEiLvkXJTlfCW44o8FBDX+m7Ks+PIYP+++yIi7yfSIp3FxKLbnPXM0dzjEXnuvjXf
         nt3CeAkUTlUrZdvgA0tc+i6xvZmcnzNcOLgEKrcZY4lWf1QaPLPCifKVTo2NNTgDdgQW
         ZA2QKIR2228/+JvFXLhImnaPD7KXvaHf8/Ix5OP9BxeOEEMQjG0ptKhB+tRpCEqjtYHy
         bgoZ7PXNtZvsc09CuSFq+UFemft8NHeVJ6447CaiIp4sP+DCgOiKrR61iv+Qh0caTQ7p
         HWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYU4hXQY6jsB3UwMGqAId+rNaoIx9vABU3T3ghlDTh4=;
        b=KBX09g637lt2VSt0EYJm2vsXdRRqGu6LVqNIRQszHzYDSbWZv2ZRRWnLM5Xa55WuSW
         JQgS2PG1ISCTzxqh07NEIkegHgvt6zF5vVqY1xM2Mjzd1OvI1x0VfsYi9jwcFA1L1PsR
         imFjmeEmi4tEQ3tPVqndFghDtk9bESRIeoNE/Gp7qBtlpszR2m7dgrt//d3Ml1rhBPg3
         5fbDOM2Ml4jbf9YP8G5bPEKXclTMXjzD3BCJPGA3ukC9YKI9eNpZyK1Z1W6mC6bxlXf8
         H2N+oYHr4xGte+x8S59RXr3O7TgIO5LXMHgvZJBoigP2raeBqrB4bsS8Z5BFL/xHEcdP
         sRFQ==
X-Gm-Message-State: AOPr4FVjsbBdUecFodrSaetXQG85R1InJZs0PKs1S96RprTay81+Ygsjf4ITMOOYsg4w+kY5
X-Received: by 10.66.139.9 with SMTP id qu9mr8165388pab.101.1462324793061;
        Tue, 03 May 2016 18:19:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:81d8:5415:7a03:cda9])
        by smtp.gmail.com with ESMTPSA id x89sm1028433pfa.87.2016.05.03.18.19.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 18:19:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.9.g9db9a47
In-Reply-To: <1462321992-15153-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293485>

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

Changes since v2:
* dedented section in documentation for --all, as it broke asciidoc.
* Using a consistent usage string in git-modules.sh (both at top as well as in
  the die message) as well as in the documentation.

Jonathan writes:
>> It is a fix for a corner case, but it is renaming the switch, so I would
>> expect that we'd wait for a new version at least.
> The bug was that the documentation and error message gave advice that
> didn't work.

By having the old way untested, we do not give guarantees any more about the '.'
case, which may be used in scripts and break, no?

Thanks,
Stefan

 Documentation/git-submodule.txt | 12 +++++++++++-
 git-submodule.sh                | 14 +++++++++++---
 t/t7400-submodule-basic.sh      | 14 +++++++++-----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1572f05..24d7197 100644
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
@@ -144,6 +144,11 @@ deinit::
 	you really want to remove a submodule from the repository and commit
 	that use linkgit:git-rm[1] instead.
 +
+To unregister all submodules use `--all` with no path spec. In
+version 2.8 and prior, you were advised to give '.' to unregister
+all submodules. This may continue to work in the future, but as the
+path spec '.' may include regular files, this could stop working.
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
index 43c68de..6dabb56 100755
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
+		die "$(eval_gettext "usage: $dashless [--quiet] deinit [-f|--force] (--all | [--] <path>...)")"
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
2.8.0.rc4.9.g9db9a47
