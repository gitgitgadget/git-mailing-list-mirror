Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9CF21F454
	for <e@80x24.org>; Wed,  6 Nov 2019 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfKFREH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 12:04:07 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:42467 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732100AbfKFREH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 12:04:07 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 12:04:06 EST
Received: (qmail 13473 invoked by uid 484); 6 Nov 2019 16:56:43 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.40 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.40):. 
 Processed in 0.321203 secs); 06 Nov 2019 16:56:43 -0000
Received: from unknown (HELO ingpc3.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.40])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 6 Nov 2019 16:56:42 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     git@vger.kernel.org
Cc:     Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH] branch: Forbid to create local branches with confusing names
Date:   Wed,  6 Nov 2019 17:56:28 +0100
Message-Id: <20191106165628.28563-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.24.0.1.g6c2c19214d.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type:   text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this patch, git allows to do something like this:
  git branch remotes/origin/master
  git branch refs/remotes/origin/master
  git branch heads/master
  git branch tags/v3.4
All of these local branch names lead to severe confusion,
not only for a user but also for git itself.

This patch forbids to create local branches, with names which start
with any of

  refs/
  heads/
  remotes/
  tags/

With this patch, you might still create these kind of local branches,
but now you have to additionally specify the '-f' option.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 branch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

 This patch refers way back to the discussion from 2014:
   From: Josef Wolf
   To: git@vger.kernel.org
   Subject: error: src refspec refs/heads/master matches more than one.
   Date: Fri, 14 Feb 2014 12:31:36 +0100
 See for example here:
   https://public-inbox.org/git/20140214113136.GA17817@raven.inka.de/

 The origin of the problem is, that git has (almost) no constraints
 what kind of names are allowed for local branches.
 There nowadays is a constraint that you are NOT allowed to create
 a branch which is called HEAD. See commit 16169285f1e6 ("Merge
 branch 'jc/branch-name-sanity'", 2017-11-28).

 In the old mail thread a lot of potential constraints for local
 branch names were discussed; in particular a lot of strategies
 were discussed what kind of local branch names might be a problem
 (the gist is: avoid ambiguities, by finding out which names
 lead to ambiguities NOW).

 I personally think it makes more sense to forbid a much
 bigger class of confusing branch names.
 In particular I think all local branch names starting with
   refs/
   heads/
   remotes/
   tags/
 should be forbidden (per default, can still be forced).
 This also avoids trouble for an unforseeable future.
 Example:
   git branch remotes/blub/master
 This might not be a problem now, because you have no 
 remote called "blub" right now.
 But if you later use
   git remote add blub <URL>
   git fetch blub
 you very likely run into trouble.

 The above approach still allows you to create local branches
 with a name of the form
    <remote name>/<something ...>
 but I cannot see how this might be avoided; remotes might
 be added later so what would you do in the case that a local
 branch already existed named like the remote or a remote
 tracking branch.

 With the proposed constraints you are at least are able to use
    heads/<remote name>/<something ...>
    remotes/<remote name>/<something ...>
 to differentiate between the two.

 This really is an issue; people seem to stumble over it
 and I guess this is particularly true if you control git
 via scripts. See for example (two years later):
   From: Duy Nguyen
   To: Junio C Hamano
   Cc: Git Mailing List <git@vger.kernel.org>,
   Subject: Re: error: src refspec refs/heads/master matches more than one.
   Date: Wed, 23 Mar 2016 18:17:05 +0700

 So with this patch I want to pick up this old discussion yet again.

 This code can probably be done a lot better I guess, but I wanted to
 send in something, to start the discussion.

diff --git a/branch.c b/branch.c
index 579494738a..e74872dac5 100644
--- a/branch.c
+++ b/branch.c
@@ -256,6 +256,16 @@ void create_branch(struct repository *r,
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
 
+	if (!force && (
+		starts_with(name, "refs/") ||
+		starts_with(name, "heads/") ||
+		starts_with(name, "remotes/") ||
+		starts_with(name, "tags/")
+	)) {
+		die(_("A local branch name should not start with "
+		      "\"refs/\", \"heads/\", \"remotes/\" or \"tags/\""));
+	}
+
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-- 
2.24.0.1.g6c2c19214d.dirty

