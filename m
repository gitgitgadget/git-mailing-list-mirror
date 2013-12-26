From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] Teach checkout to recursively checkout submodules
Date: Thu, 26 Dec 2013 08:22:38 -0800
Message-ID: <20131226162238.GQ20443@google.com>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 17:23:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwDiF-0005jP-GH
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 17:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3LZQWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 11:22:44 -0500
Received: from mail-gg0-f177.google.com ([209.85.161.177]:39869 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464Ab3LZQWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 11:22:43 -0500
Received: by mail-gg0-f177.google.com with SMTP id 4so1726623ggm.8
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C+gnUzWi/5dp0DWgIslzdJfWnc5lQhyAVbMnPElKOXU=;
        b=lJ5IJapepW/4teFm+ORtquy4jx22gJj+voxRwNZNwXxg/kuYIC4X7dBiX1afGeYHpC
         KAP3FjnH5HJuxYp7Fch2ML7bvNQcX5Nq1jdxnB1v1hbjAy5U1sHdq2DPWOZxtiouDNku
         LEaeVD7XlBkDRqpHEew/yp84joQ8xMQs5ulalt1K/2jzJ1i7rzM9BlcO8xp39BfJCXgv
         9LWRyh7KQ9QjuwGGLczJ0Jl3bAWNEqhrUvmLz2f05dcr8Ha4ZOiJwHKjFR+ahmeaYPZf
         nxsuMxrXppKmtYYJH6sZa9oGM/qdJZqcf23XBgeK3a3mzRQ6QtrrTIAwqJoI5ZIHitaZ
         CxPg==
X-Received: by 10.236.23.129 with SMTP id v1mr2034376yhv.135.1388074961907;
        Thu, 26 Dec 2013 08:22:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm42300052yhq.15.2013.12.26.08.22.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 08:22:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131226155857.GL20443@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239700>

From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Wed, 13 Jun 2012 18:50:10 +0200

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is the patch that actually introduces the --recurse-submodules
option, which makes the rest work.

The tests indicate some future directions for improving this, but
it works reasonably well already.  I think I'd be most comfortable
applying these if they were rearranged a little to the following
order:

 1. First, introducing the --recurse-submodules option, perhaps
    with no actual effect, with tests that it is parsed correctly,
    the default works, etc.

 2. Then, adding the desired behaviors one by one with corresponding
    tests (handling submodule modifications, removals, additions).

 3. Finally, any needed tweaks on top.

That way, it is easy to play around with early patches without
worrying about the later ones at first, and the patches are easy
to review to confirm that they at least don't break anything in
the --no-recurse-submodules case.

That said, Debian experimental has these applied as is already,
and there haven't been any complaints yet.

Thoughts?
Jonathan

 Documentation/git-checkout.txt |   8 ++
 builtin/checkout.c             |  14 +++
 submodule.c                    |  14 +++
 submodule.h                    |   3 +
 t/t2013-checkout-submodule.sh  | 215 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 251 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 91294f8..aabcc65 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,6 +225,14 @@ This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject.If
+	local modifications in a submodule would be overwritten the checkout
+	will fail until `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated, only the
+	hash recorded in the superproject will be changed.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..ac2f8d8 100644
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
+		parse_fetch_recurse_submodules_arg("--recurse-submodules-default",
+						   recurse_submodules_default),
+		recurse_submodules);
+
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
diff --git a/submodule.c b/submodule.c
index 3365987..bdce1b2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -398,6 +398,20 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
 	}
 }
 
+int option_parse_update_submodules(const struct option *opt,
+				   const char *arg, int unset)
+{
+	if (unset) {
+		*(int *)opt->value = RECURSE_SUBMODULES_OFF;
+	} else {
+		if (arg)
+			*(int *)opt->value = parse_update_recurse_submodules_arg(opt->long_name, arg);
+		else
+			*(int *)opt->value = RECURSE_SUBMODULES_ON;
+	}
+	return 0;
+}
+
 int submodule_needs_update(const char *path)
 {
 	struct string_list_item *path_option;
diff --git a/submodule.h b/submodule.h
index b42ae91..9841da3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,7 @@
 
 struct diff_options;
 struct argv_array;
+struct option;
 
 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
@@ -23,6 +24,8 @@ int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+int option_parse_update_submodules(const struct option *opt,
+		const char *arg, int unset);
 int submodule_needs_update(const char *path);
 int populate_submodule(const char *path, unsigned char sha1[20], int force);
 int depopulate_submodule(const char *path);
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
1.8.5.1
