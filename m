Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F9C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCIWKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCIWKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:10:32 -0500
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 14:10:30 PST
Received: from marcos.anarc.at (marcos.anarc.at [64.18.183.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFF8F4D9D
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1678399457;
        bh=jL36PwQVbzVEcBk8QVCtE08++V45EqYMEnRHW2zkTn4=;
        h=From:To:Cc:Subject:Date:From;
        b=ke8iWeaIghKr6K7MGhlaALXLlauviwjNXJ8yHggTQrblnP2T2PcfOiJvhUST/G6Z9
         AjjxdJGJ8ojbmmcjqi89PCo6ywZmPHWPJx1DtiAOoBYSToE2sjWR2yuof2aQqL0mB2
         2PqTLul3I8//pIWipWWOVTcOU4575W0XszvVZxDrFV0Egmm3iCJqru5iLE7VqPDmtz
         D7l88h9nydNMyltrRnqCl5PZJr5pn7Xf+x+TXTdOTOJWkEzMqKBfSOsGwHRRB3MK9y
         3FIprkSRqZGK/rhL1zud2BF2FWXoxPOL8KvvINO4q97pSh5R8gpPiGE33qzBwDA4Mi
         o1HRLyQJ7DDEQ==
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id 0EAF310E5DA; Thu,  9 Mar 2023 17:04:17 -0500 (EST)
Received: by angela.localdomain (Postfix, from userid 1000)
        id 5F816E00EE; Thu,  9 Mar 2023 17:04:16 -0500 (EST)
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [RFC PATCH] hooks--pre-push.sample: identify branch point
Date:   Thu,  9 Mar 2023 17:04:05 -0500
Message-Id: <20230309220405.219212-1-anarcat@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pre-push hook introduced in 87c86dd14a (Add sample pre-push hook
script, 2013-01-13) has a pretty naive implementation that inspects
the entirety of that branch history, regardless of previous merges.

In other words, if you create a topic branch from a current history,
the entire history will be inspected by the pre-push hook. In my case,
there was an old "WIP" commit log that broke the hook, even though
that commit wasn't specific to the branch in question, nor was it
introduced by the push.

This patch aims at fixing that problem by restricting the revisions inspected when a new branch is pushed to something that is more specific to that branch.

This implementation will first attempt to find an ancestor that the
current branch is related to (`--merged=`). This is where this
implementation is the most questionable; normally you would put
`master` or `main` as a base branch, but who knows what people
actually use for this nowadays. And besides, it's fair to assume you
could be pushing something based on a branch that already exists
upstream that is *not* master or main... But still, that's a tricky
bit I'm not sure of.

Then we find the "branch point" which is the latest commit on the
ancestor branch that's shared with the inspected ref. This,
interestingly, seems to be a really tricky problem as well. I base my
implementation off this answer on Stack Overflow (I know! at least
it's not ChatGPT!):

https://stackoverflow.com/a/71193866/1174784

There are currently a whopping twenty-five answers to that question in
that thread, and I'm hoping the community here will have a more
definitive answer to this question. I have picked the answer that uses
the least possible external commands, but it still uses a `tail -1`
which I'm somewhat unhappy about. I have thought of using
`--max-count` for this instead, but I understand that probably does
the equivalent of a `head -n` *and* it's applied before `--reverse`,
so there's not other way to do this.

The final question to answer here is whether this is a good idea in
the first place, and whether this is the right place to answer this
kind of question. I happen to really like using pre-push (instead of
pre-commit) for inspecting my work before submitting it upstream, so
it was a natural fit for me, but this might be everyone's taste.

As the subject indicates, I would very much welcome comments on
this. I would be happy to submit a more elaborate version of
this (e.g. with unit tests) if it's interesting for the community, or
receive guidance on where best this could be implemented or improved.

Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 templates/hooks--pre-push.sample | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
index 4ce688d32b..f871b65195 100755
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -33,8 +33,24 @@ do
 	else
 		if test "$remote_oid" = "$zero"
 		then
-			# New branch, examine all commits
-			range="$local_oid"
+			# new branch
+			#
+			# search for a base branch that's part of this branch, latest modified
+			#
+			# it's a better heuristic than hardcoding "master" or "main"
+			base_branch=$(git for-each-ref \
+					  --merged="$local_ref" \
+					  --no-contains="$local_ref" \
+					  --format="%(refname:strip=-1)" \
+					  --sort='-*authordate' \
+					  refs/heads )
+			# find the place where we branched off the base branch
+			branch_point=$(git rev-parse \
+					   $(git rev-list --exclude-first-parent-only \
+						 ^"$base_branch" "$local_ref"| tail -1)^ \
+                                    )
+			# examine all commits up to the branch point
+		        range="$branch_point..$local_oid"
 		else
 			# Update to existing branch, examine new commits
 			range="$remote_oid..$local_oid"
-- 
2.39.2

