Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED4820323
	for <e@80x24.org>; Fri, 17 Mar 2017 00:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753443AbdCQATr (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 20:19:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:45574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbdCQATq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 20:19:46 -0400
Received: (qmail 13031 invoked by uid 109); 17 Mar 2017 00:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 00:19:46 +0000
Received: (qmail 12572 invoked by uid 111); 17 Mar 2017 00:19:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 20:19:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 20:19:42 -0400
Date:   Thu, 16 Mar 2017 20:19:42 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: sequencer "edit" command always issues a warning
Message-ID: <20170317001942.2lndsi47kdyzhane@sigill.intra.peff.net>
References: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net>
 <alpine.DEB.2.20.1703162358520.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703162358520.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 11:59:35PM +0100, Johannes Schindelin wrote:

> I do not recall why I chose warning(); probably just an oversight on my
> part. Your patch looks good.

Thanks. Here it is with a commit message.

I agree with Junio that if we had "info()" it would perhaps be the right
thing to use. We can go down that road later if we choose to.

-- >8 --
Subject: [PATCH] sequencer: drop "warning:" when stopping for edit

Since the conversion from shell to C in 56dc3ab04 (sequencer
(rebase -i): implement the 'edit' command, 2017-01-02),
stopping at an "edit" instruction went from:

  $ git rebase -i
  Stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
  You can amend the commit now, with
    [...more instructions...]

to:

  $ git rebase -i
  warning: stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
  You can amend the commit now, with
    [...more instructions...]

The "warning" implies that it's something unexpected, but
it's not. Let's switch back to the original message.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 1f729b053..8183a83c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1997,7 +1997,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (item->command == TODO_EDIT) {
 				struct commit *commit = item->commit;
 				if (!res)
-					warning(_("stopped at %s... %.*s"),
+					fprintf(stderr,
+						_("Stopped at %s...  %.*s"),
 						short_commit_name(commit),
 						item->arg_len, item->arg);
 				return error_with_patch(commit,
-- 
2.12.0.623.g86ec6c963

