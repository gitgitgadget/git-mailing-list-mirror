Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D481207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 20:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036393AbdDUU1L (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 16:27:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:37954 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1036003AbdDUU1J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 16:27:09 -0400
Received: (qmail 20078 invoked by uid 109); 21 Apr 2017 20:27:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 20:27:08 +0000
Received: (qmail 20044 invoked by uid 111); 21 Apr 2017 20:27:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 16:27:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 16:27:06 -0400
Date:   Fri, 21 Apr 2017 16:27:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] completion: optionally disable checkout DWIM
Message-ID: <20170421202705.4uhbk3okccszxvgl@sigill.intra.peff.net>
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


When we complete branch names for "git checkout", we also
complete remote branch names that could trigger the DWIM
behavior. Depending on your workflow and project, this can
be either convenient or annoying.

For instance, my clone of gitster.git contains 74 local
"jk/*" branches, but origin contains another 147. When I
want to checkout a local branch but can't quite remember the
name, tab completion shows me 251 entries. And worse, for a
topic that has been picked up for pu, the upstream branch
name is likely to be similar to mine, leading to a high
probability that I pick the wrong one and accidentally
create a new branch.

This patch adds a way for the user to tell the completion
code not to include DWIM suggestions for checkout. This can
already be done by typing:

  git checkout --no-guess jk/<TAB>

but that's rather cumbersome. The downside, of course, is
that you no longer get completion support when you _do_ want
to invoke the DWIM behavior. But depending on your workflow,
that may not be a big loss (for instance, in git.git I am
much more likely to want to detach, so I'd type "git
checkout origin/jk/<TAB>" anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
Compared to v1, this version requires the new variable be set to "1" (to
leave more room for later extension), and uses short-circuiting || for
the logic.

 contrib/completion/git-completion.bash | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5..f977b54d8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -28,6 +28,14 @@
 # completion style.  For example '!f() { : git commit ; ... }; f' will
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
+#
+# You can set the following environment variables to influence the behavior of
+# the completion routines:
+#
+#   GIT_COMPLETION_CHECKOUT_NO_GUESS
+#
+#     When set to "1", do not include "DWIM" suggestions in git-checkout
+#     completion (e.g., completing "foo" when "origin/foo" exists).
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -1248,7 +1256,8 @@ _git_checkout ()
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
 		local flags="--track --no-track --no-guess" track_opt="--track"
-		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
+		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
+		   [ -n "$(__git_find_on_cmdline "$flags")" ]; then
 			track_opt=''
 		fi
 		__git_complete_refs $track_opt
-- 
2.13.0.rc0.364.g36b4d8031
