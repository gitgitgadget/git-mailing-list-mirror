From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 3/9] Teach checkout the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 20:50:02 +0100
Message-ID: <52EFF2EA.9060709@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:50:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPX1-0000Zo-Uy
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbaBCTuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:50:06 -0500
Received: from mout.web.de ([212.227.15.14]:57890 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbaBCTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:50:05 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LcPf8-1VQaqa3orW-00jnUD for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:50:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:UJWzvnXe6wwNimV1E30wOR1xYYB9dweOK3OHGf4p5pVsWeX7Xm7
 mx0ST1mT+OTzwuRrv0vpPZbXI4BFxl2mZIBZhsfguxcaFexAS/rISUXpsw4PVh+OkuyAsm8
 JI9X22x/r9Ot2+qiMemQhepcOqBeQ8xPB5T9m+GevbRlqXLVY+k50tXdM8W1g8gBc4oaxoR
 GojL4ldV/qfS3KsjfjU4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241458>

This new option will allow the user to not only update the work tree of
the superproject according to the checked out commit but to also update
the work tree of all initialized submodules (so they match the SHA-1
recorded in the superproject). But this commit only adds the option
without any functionality, that will be added to unpack_trees() in
subsequent commits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-checkout.txt |   2 +
 builtin/checkout.c             |  14 +++
 t/t2013-checkout-submodule.sh  | 215 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 228 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 91294f8..6c7d31f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,6 +225,8 @@ This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.

+include::recurse-submodules-update.txt[]
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..e4ef0ba 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -21,6 +21,9 @@
 #include "submodule.h"
 #include "argv-array.h"

+static const char *recurse_submodules_default = "off";
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
 static const char * const checkout_usage[] = {
 	N_("git checkout [options] <branch>"),
 	N_("git checkout [options] [<branch>] -- <file>..."),
@@ -1111,6 +1114,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_update_submodules },
+		{ OPTION_STRING, 0, "recurse-submodules-default",
+			   &recurse_submodules_default, NULL,
+			   "default mode for recursion", PARSE_OPT_HIDDEN },
 		OPT_END(),
 	};

@@ -1132,6 +1141,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}

+	set_config_update_recurse_submodules(
+		parse_update_recurse_submodules_arg("--recurse-submodules-default",
+						    recurse_submodules_default),
+		recurse_submodules);
+
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));

diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 06b18f8..bc3e1ca 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -4,17 +4,57 @@ test_description='checkout can handle submodules'

 . ./test-lib.sh

+submodule_creation_must_succeed() {
+	# checkout base ($1)
+	git checkout -f --recurse-submodules $1 &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $1 &&
+
+	# checkout target ($2)
+	if test -d submodule; then
+		echo change>>submodule/first.t &&
+		test_must_fail git checkout --recurse-submodules $2 &&
+		git checkout -f --recurse-submodules $2
+	else
+		git checkout --recurse-submodules $2
+	fi &&
+	test -e submodule/.git &&
+	test -f submodule/first.t &&
+	test -f submodule/second.t &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $2
+}
+
+submodule_removal_must_succeed() {
+	# checkout base ($1)
+	git checkout -f --recurse-submodules $1 &&
+	git submodule update -f &&
+	test -e submodule/.git &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $1 &&
+
+	# checkout target ($2)
+	echo change>>submodule/first.t &&
+	test_must_fail git checkout --recurse-submodules $2 &&
+	git checkout -f --recurse-submodules $2 &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $2 &&
+	! test -d submodule
+}
+
 test_expect_success 'setup' '
 	mkdir submodule &&
 	(cd submodule &&
 	 git init &&
 	 test_commit first) &&
-	git add submodule &&
+	echo first > file &&
+	git add file submodule &&
 	test_tick &&
 	git commit -m superproject &&
 	(cd submodule &&
 	 test_commit second) &&
-	git add submodule &&
+	echo second > file &&
+	git add file submodule &&
 	test_tick &&
 	git commit -m updated.superproject
 '
@@ -36,7 +76,8 @@ test_expect_success '"checkout <submodule>" updates the index only' '
 	git checkout HEAD^ submodule &&
 	test_must_fail git diff-files --quiet &&
 	git checkout HEAD submodule &&
-	git diff-files --quiet
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
 '

 test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
@@ -62,4 +103,172 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '

+test_expect_success '"checkout --recurse-submodules" removes deleted submodule' '
+	git config -f .gitmodules submodule.submodule.path submodule &&
+	git config -f .gitmodules submodule.submodule.url submodule.bare &&
+	(cd submodule && git clone --bare . ../submodule.bare) &&
+	echo submodule.bare >>.gitignore &&
+	git config submodule.submodule.ignore none &&
+	git add .gitignore .gitmodules submodule &&
+	git submodule update --init &&
+	git commit -m "submodule registered" &&
+	git checkout -b base &&
+	git checkout -b delete_submodule &&
+	rm -rf submodule &&
+	git rm submodule &&
+	git commit -m "submodule deleted" &&
+	submodule_removal_must_succeed base delete_submodule
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule' '
+	submodule_creation_must_succeed delete_submodule base
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule in existing directory' '
+	git checkout --recurse-submodules delete_submodule &&
+	mkdir submodule &&
+	submodule_creation_must_succeed delete_submodule base
+'
+
+test_expect_success '"checkout --recurse-submodules" replaces submodule with files' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_dir &&
+	git update-index --force-remove submodule &&
+	rm -rf submodule/.git .gitmodules &&
+	git add .gitmodules submodule/* &&
+	git commit -m "submodule replaced" &&
+	git checkout -f base &&
+	git submodule update -f &&
+	git checkout --recurse-submodules replace_submodule_with_dir &&
+	test -d submodule &&
+	! test -e submodule/.git &&
+	test -f submodule/first.t &&
+	test -f submodule/second.t
+'
+
+test_expect_success '"checkout --recurse-submodules" removes files and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_dir base
+'
+
+test_expect_failure '"checkout --recurse-submodules" replaces submodule with a file' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_file &&
+	git update-index --force-remove submodule &&
+	rm -rf submodule .gitmodules &&
+	echo content >submodule &&
+	git add .gitmodules submodule &&
+	git commit -m "submodule replaced with file" &&
+	git checkout -f base &&
+	git submodule update -f &&
+	git checkout --recurse-submodules replace_submodule_with_file &&
+	test -d submodule &&
+	! test -e submodule/.git &&
+	test -f submodule/first.t &&
+	test -f submodule/second.t
+'
+
+test_expect_success '"checkout --recurse-submodules" removes the file and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_file base
+'
+
+test_expect_failure '"checkout --recurse-submodules" replaces submodule with a link' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_link &&
+	git update-index --force-remove submodule &&
+	rm -rf submodule .gitmodules &&
+	ln -s submodule &&
+	git add .gitmodules submodule &&
+	git commit -m "submodule replaced with link" &&
+	git checkout -f base &&
+	git submodule update -f &&
+	git checkout --recurse-submodules replace_submodule_with_link &&
+	test -d submodule &&
+	! test -e submodule/.git &&
+	test -f submodule/first.t &&
+	test -f submodule/second.t
+'
+
+test_expect_success '"checkout --recurse-submodules" removes the link and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_link base
+'
+
+test_expect_success '"checkout --recurse-submodules" updates recursively' '
+	git checkout --recurse-submodules base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout -b updated_submodule &&
+	(cd submodule &&
+	 echo x >>first.t &&
+	 git add first.t &&
+	 test_commit third) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m updated.superproject &&
+	git checkout --recurse-submodules base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f to update a modifed submodule commit' '
+	(
+		cd submodule &&
+		git checkout --recurse-submodules HEAD^
+	) &&
+	test_must_fail git checkout --recurse-submodules master &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f to update modifed submodule content' '
+	echo modified >submodule/second.t &&
+	test_must_fail git checkout --recurse-submodules HEAD^ &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git checkout --recurse-submodules -f HEAD^ &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" ignores modified submodule content that would not be changed' '
+	echo modified >expected &&
+	cp expected submodule/first.t &&
+	git checkout --recurse-submodules HEAD^ &&
+	test_cmp expected submodule/first.t &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" does not care about untracked submodule content' '
+	echo untracked >submodule/untracked &&
+	git checkout --recurse-submodules master &&
+	git diff-files --quiet --ignore-submodules=untracked &&
+	git diff-index --quiet --cached HEAD &&
+	rm submodule/untracked
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f when submodule commit is not present (but does fail anyway)' '
+	git checkout --recurse-submodules -b bogus_commit master &&
+	git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submodule
+	BOGUS_TREE=$(git write-tree) &&
+	BOGUS_COMMIT=$(echo "bogus submodule commit" | git commit-tree $BOGUS_TREE) &&
+	git commit -m "bogus submodule commit" &&
+	git checkout --recurse-submodules -f master &&
+	test_must_fail git checkout --recurse-submodules bogus_commit &&
+	git diff-files --quiet &&
+	test_must_fail git checkout --recurse-submodules -f bogus_commit &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master
+'
+
 test_done
-- 
1.9.rc0.28.ge3363ff
