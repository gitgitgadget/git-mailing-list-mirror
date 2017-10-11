Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C286C1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 20:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdJKUTE (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:19:04 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:60122 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752525AbdJKUTD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 16:19:03 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Oct 2017 16:19:03 EDT
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id 2NL7eL6i8AbhQ2NLDeABvs; Wed, 11 Oct 2017 20:10:55 +0000
Received: from mail.tremily.us ([67.168.186.5])
        by resomta-po-15v.sys.comcast.net with SMTP
        id 2NJGeFE3fW4bC2NJHeNQA3; Wed, 11 Oct 2017 20:08:55 +0000
Received: from ullr.tremily.us (ullr.tremily.us [192.168.10.7])
        by mail.tremily.us (Postfix) with SMTP id ECD32FEC547;
        Wed, 11 Oct 2017 13:09:21 -0700 (PDT)
Received: (nullmailer pid 10208 invoked by uid 1000);
        Wed, 11 Oct 2017 20:10:55 -0000
From:   "W. Trevor King" <wking@tremily.us>
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C5=81ukasz=20Gryglicki?= <lukaszgryglicki@o2.pl>,
        "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] pull: pass --signoff/--no-signoff to "git merge"
Date:   Wed, 11 Oct 2017 13:10:47 -0700
Message-Id: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
X-Mailer: git-send-email 2.13.6
X-CMAE-Envelope: MS4wfEXp4Nd0niGeobCEYLhajPZmSkZnogdaWgehZ0GgBgTb1WqrX+LKBnievkvFz+60zBVmGlvvxP5j753EgyYjWvbjhZ5iR4bH+vhgLb+yq/2KmUTmZZfG
 BEvl8cgdQprpUJY6eEdKBuUTB8YJPczjoR0Lpxle5SFV9law9WOiIn92lWJFxMqQ/1Xv4pgZyA3Lb1ofmdoF9kypRd7aEkiK/ui1a7+dUl+HNXLwpjen4LLp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following 09c2cb87 (pull: pass --allow-unrelated-histories to "git
merge", 2016-03-18) with the tests also drawing on 14d01b4f (merge:
add a --signoff flag, 2017-07-04).

The order of options in merge-options.txt isn't clear to me, but I've
put --signoff between --log and --stat as somewhat alphabetized and
having an "add to the commit message" function like --log.

The tests aren't as extensive as t7614-merge-signoff.sh, but they
exercises both the --signoff and --no-signoff options.  There may be a
more efficient way to set them up (like t7614-merge-signoff.sh's
test_setup), but with all the pull options packed into a single test
script it seemed easiest to just copy/paste the duplicate setup code.

09c2cb87 didn't motivate the addition of --allow-unrelated-histories
to pull; only citing the reason from e379fdf3 (merge: refuse to create
too cool a merge by default, 2016-03-18) gave for *not* including it.
I like having both exposed in pull because while the fetch-and-merge
approach might be a more popular way to judge "how well they fit
together", you can also do that after an optimistic pull.  And in
cases where an optimistic pull is likely to succeed, suggesting it is
easier to explain to Git newbies than a FETCH_HEAD merge.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-merge.txt     |  8 --------
 Documentation/merge-options.txt | 10 ++++++++++
 builtin/pull.c                  |  8 ++++++++
 t/t5521-pull-options.sh         | 43 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4df6431c34..0ada8c856b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,14 +64,6 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
-
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign the resulting merge commit. The `keyid` argument is
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 4e32304301..f394622d65 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -51,6 +51,16 @@ set to `no` at the beginning of them.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
+--signoff::
+--no-signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
++
+With --no-signoff do not add a Signed-off-by line.
 
 --stat::
 -n::
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a22..4469342f51 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -97,6 +97,7 @@ static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
 static char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
+static int opt_signoff;
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -175,6 +176,9 @@ static struct option pull_options[] = {
 	OPT_SET_INT(0, "allow-unrelated-histories",
 		    &opt_allow_unrelated_histories,
 		    N_("allow merging unrelated histories"), 1),
+	OPT_BOOL(0, "signoff",
+		    &opt_signoff,
+		    N_("add Signed-off-by:")),
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
@@ -610,6 +614,10 @@ static int run_merge(void)
 		argv_array_push(&args, opt_gpg_sign);
 	if (opt_allow_unrelated_histories > 0)
 		argv_array_push(&args, "--allow-unrelated-histories");
+	if (opt_signoff > 0)
+		argv_array_push(&args, "--signoff");
+	else
+		argv_array_push(&args, "--no-signoff");
 
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ded8f98dbe..d95789ab8c 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -165,4 +165,47 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	)
 '
 
+test_expect_success 'git pull --signoff add a sign-off line' '
+	test_when_finished "rm -fr src dst actual expected" &&
+	cat >expected <<-EOF &&
+		Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
+	EOF
+	git init src &&
+	(
+		cd src &&
+		test_commit one
+	) &&
+	git clone src dst &&
+	(
+		cd src &&
+		test_commit two
+	) &&
+	(
+		cd dst &&
+		git pull --signoff --no-ff &&
+		git cat-file commit HEAD | tail -n1 >../actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	(
+		cd src &&
+		test_commit one
+	) &&
+	git clone src dst &&
+	(
+		cd src &&
+		test_commit two
+	) &&
+	(
+		cd dst &&
+		git pull --signoff --no-signoff --no-ff &&
+		git cat-file commit HEAD | sed -n /Signed-off-by/p >../actual
+	) &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.13.6

