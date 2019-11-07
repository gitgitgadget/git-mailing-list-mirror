Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F351F454
	for <e@80x24.org>; Thu,  7 Nov 2019 19:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfKGTII (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 14:08:08 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:41615 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfKGTIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 14:08:07 -0500
Received: (qmail 2093 invoked by uid 484); 7 Nov 2019 19:08:06 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.085844 secs); 07 Nov 2019 19:08:06 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 7 Nov 2019 19:08:05 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     git@vger.kernel.org
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH v2 2/4] branch: Prevent creation of local branches named "refs" or "refs/*"
Date:   Thu,  7 Nov 2019 20:07:48 +0100
Message-Id: <20191107190750.26674-3-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
References: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
 <20191107190750.26674-1-ingo.rohloff@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To explain the intention, here is an example:

A user executes
   git branch refs/remotes/origin/master
or
   git checkout -b refs/remotes/origin/master
after this operation
   git log refs/remotes/origin/master
will very likely complain that this reference is ambiguous.

The reason is, that you now very likely have the following two
references which both match:

   refs/remotes/origin/master
   refs/heads/refs/remotes/origin/master

git cannot decide which of the two references is meant.

By preventing the creation of local branches which are named
  refs  or  refs/*
this issue is circumvented:
  git log refs/*
will never refer to local branches located under
  refs/heads/refs/*
because such local branches should not exist.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 builtin/branch.c   | 6 ++++++
 builtin/checkout.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ef214632f..c2e45ff52c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -497,6 +497,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	const char *interpreted_newname = NULL;
 	int recovery = 0;
 
+	if (newname_has_bad_prefix(newname))
+		die(_("Invalid new branch name: '%s'"), newname);
+
 	if (!oldname) {
 		if (copy)
 			die(_("cannot copy the current branch while not on any."));
@@ -844,6 +847,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
+		if (newname_has_bad_prefix(argv[0]))
+			die(_("Invalid new branch name: '%s'"), argv[0]);
+
 		create_branch(the_repository,
 			      argv[0], (argc == 2) ? argv[1] : head,
 			      force, 0, reflog, quiet, track);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3634a3dac1..51ac2cae43 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1566,6 +1566,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->new_orphan_branch)
 		opts->new_branch = opts->new_orphan_branch;
 
+	if (opts->new_branch && newname_has_bad_prefix(opts->new_branch))
+		die(_("Invalid new branch name: '%s'"), opts->new_branch);
+
 	/* --track without -b/-B/--orphan should DWIM */
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
 		const char *argv0 = argv[0];
-- 
2.24.0

