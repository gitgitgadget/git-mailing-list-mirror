From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git submodule add: Require the new --force option to add
 ignored paths
Date: Sat, 17 Jul 2010 17:11:43 +0200
Message-ID: <4C41C82F.8030200@web.de>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com> <1278351183-18734-1-git-send-email-avarab@gmail.com> <7vmxu572w5.fsf@alter.siamese.dyndns.org> <4C33A552.5060008@web.de> <AANLkTinn_Vz6I619Do4AOCVMUgfpyy84L1wh3lkuCP7R@mail.gmail.com> <4C37A03E.7030801@web.de> <7viq4k8i0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 17:12:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa944-0003Q0-8z
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab0GQPMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 11:12:25 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35869 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab0GQPMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 11:12:24 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7383B1647058C;
	Sat, 17 Jul 2010 17:11:47 +0200 (CEST)
Received: from [80.128.59.5] (helo=[192.168.178.29])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1Oa93L-00036U-00; Sat, 17 Jul 2010 17:11:47 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7viq4k8i0e.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19XtMuFPL9FWqUbDrq0uN/FjusXhzmoKQzktgz4
	D2y8dgOcGy5JDg+94R3jVc6QAp0ckpdszjsvmMlVxgrBptKwIF
	ubWZ21pLjEuZy9TUK4gQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151184>

To make the behavior of "git submodule add" more consistent with "git add"
ignored submodule paths should not be silently added when they match an
entry in a .gitignore file. To be able to override that default behavior
in the same way as we can do that for "git add", the new option "--force"
is introduced.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 13.07.2010 00:14, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> With this patch it should be easy to have "git submodule add" return
>> an error /before/ adding a submodule path and its contents when it
>> is found in .gitignore.
>>
>> Opinions?
> 
> Sounds like a right thing to do.

So here we go. This patch applies to pu as it needs the
'git add: Add the "--ignore-missing" option for the dry run'
patch to work.


 Documentation/git-submodule.txt |    7 ++++++-
 git-submodule.sh                |   16 ++++++++++++++--
 t/t7400-submodule-basic.sh      |   27 +++++++++++++++------------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 76a832a..617069f 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] add [-b branch]
+'git submodule' [--quiet] add [-b branch] [-f|--force]
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
@@ -187,6 +187,11 @@ OPTIONS
 --branch::
 	Branch of repository to add as submodule.

+-f::
+--force::
+	This option is only valid for the add command.
+	Allow adding an otherwise ignored submodule path.
+
 --cached::
 	This option is only valid for status and summary commands.  These
 	commands typically use the commit found in the submodule HEAD, but
diff --git a/git-submodule.sh b/git-submodule.sh
index ad2417d..170186f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2007 Lars Hjemli

 dashless=$(basename "$0" | sed -e 's/-/ /')
-USAGE="[--quiet] add [-b branch] [--reference <repository>] [--] <repository> [<path>]
+USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] update [--init] [-N|--no-fetch] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
@@ -19,6 +19,7 @@ require_work_tree

 command=
 branch=
+force=
 reference=
 cached=
 recursive=
@@ -133,6 +134,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-f | --force)
+			force=$1
+			;;
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
@@ -201,6 +205,14 @@ cmd_add()
 	git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
 	die "'$path' already exists in the index"

+	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
+	then
+		echo >&2 "The following path is ignored by one of your .gitignore files:" &&
+		echo >&2 $path &&
+		echo >&2 "Use -f if you really want to add it."
+		exit 1
+	fi
+
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$path"
 	then
@@ -234,7 +246,7 @@ cmd_add()
 		) || die "Unable to checkout submodule '$path'"
 	fi

-	git add --force "$path" ||
+	git add $force "$path" ||
 	die "Failed to add submodule '$path'"

 	git config -f .gitmodules submodule."$path".path "$path" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d9f2785..9bda970 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -86,25 +86,28 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '

-test_expect_success 'submodule add to .gitignored path' '
-	echo "refs/heads/master" >expect &&
-	>empty &&
-
+test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
+		cat <<-\EOF >expect &&
+		The following path is ignored by one of your .gitignore files:
+		submod
+		Use -f if you really want to add it.
+		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
 		git add --force .gitignore &&
 		git commit -m"Ignore everything" &&
-		git submodule add "$submodurl" submod &&
-		git submodule init
-	) &&
+		! git submodule add "$submodurl" submod >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'

-	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
-	test_cmp expect heads &&
-	test_cmp expect head &&
-	test_cmp empty untracked
+test_expect_success 'submodule add to .gitignored path with --force' '
+	(
+		cd addtest-ignore &&
+		git submodule add --force "$submodurl" submod
+	)
 '

 test_expect_success 'submodule add --branch' '
-- 
1.7.2.rc3.262.gcf61
