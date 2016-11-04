Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987802022D
	for <e@80x24.org>; Fri,  4 Nov 2016 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964877AbcKDQaQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:30:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:38689 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964819AbcKDQaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:30:16 -0400
Received: (qmail 29330 invoked by uid 109); 4 Nov 2016 16:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 16:30:15 +0000
Received: (qmail 24263 invoked by uid 111); 4 Nov 2016 16:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 12:30:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 12:30:12 -0400
Date:   Fri, 4 Nov 2016 12:30:12 -0400
From:   Jeff King <peff@peff.net>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] branch: remove unused parameter to create_branch()
Message-ID: <20161104163012.5r3uivnub3bdkqgr@sigill.intra.peff.net>
References: <20161104151949.13384-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161104151949.13384-1-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 04:19:49PM +0100, Tobias Klauser wrote:

> The name parameter to create_branch() has been unused since commit
> 55c4a673070f ("Prevent force-updating of the current branch"). Remove
> the parameter and adjust the callers accordingly. Also remove the
> parameter from the function's documentation comment.

This seemed eerily familiar, and it turns out I wrote this as a
preparatory step for a different topic a while back, but never finished
it.

So clearly a good change, though we might want to explain a bit more why
it's correct that the parameter is unused. Here's what I wrote:

  This function used to have the caller pass in the current value of
  HEAD, in order to make sure we didn't clobber HEAD.  In 55c4a6730,
  that logic moved to validate_new_branchname(), which just resolves
  HEAD itself. The parameter to create_branch is now unused.

I also ended up reformatting the documentation comment, but that's
purely optional. My patch is below for reference. Feel free to grab any
bits of it that you agree with.

-- >8 --
Subject: [PATCH] create_branch: drop unused "head" parameter

This function used to have the caller pass in the current
value of HEAD, in order to make sure we didn't clobber HEAD.
In 55c4a6730, that logic moved to validate_new_branchname(),
which just resolves HEAD itself. The parameter to
create_branch is now unused.

Since we have to update and re-wrap the docstring describing
the parameters anyway, let's take this opportunity to break
it out into a list, which makes it easier to find the
parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c           |  3 +--
 branch.h           | 22 ++++++++++++++--------
 builtin/branch.c   |  4 ++--
 builtin/checkout.c |  2 +-
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index a5a8dcbd0..0d459b3cf 100644
--- a/branch.c
+++ b/branch.c
@@ -228,8 +228,7 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(const char *head,
-		   const char *name, const char *start_name,
+void create_branch(const char *name, const char *start_name,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
diff --git a/branch.h b/branch.h
index b2f964933..3103eb9ad 100644
--- a/branch.h
+++ b/branch.h
@@ -4,15 +4,21 @@
 /* Functions for acting on the information about branches. */
 
 /*
- * Creates a new branch, where head is the branch currently checked
- * out, name is the new branch name, start_name is the name of the
- * existing branch that the new branch should start from, force
- * enables overwriting an existing (non-head) branch, reflog creates a
- * reflog for the branch, and track causes the new branch to be
- * configured to merge the remote branch that start_name is a tracking
- * branch for (if any).
+ * Creates a new branch, where:
+ *
+ *   - name is the new branch name
+ *
+ *   - start_name is the name of the existing branch that the new branch should
+ *     start from
+ *
+ *   - force enables overwriting an existing (non-head) branch
+ *
+ *   - reflog creates a reflog for the branch
+ *
+ *   - track causes the new branch to be configured to merge the remote branch
+ *     that start_name is a tracking branch for (if any).
  */
-void create_branch(const char *head, const char *name, const char *start_name,
+void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
 		   int clobber_head, int quiet, enum branch_track track);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index d5d93a8c0..60cc5c8e8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -807,7 +807,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -853,7 +853,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 
 		branch_existed = ref_exists(branch->refname);
-		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
 		/*
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b2a5b31d..512492aad 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -630,7 +630,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch, new->name,
+			create_branch(opts->new_branch, new->name,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
 				      opts->new_branch_force ? 1 : 0,
-- 
2.11.0.rc0.263.g6f44bc3

