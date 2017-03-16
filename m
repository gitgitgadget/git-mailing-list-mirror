Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E358520953
	for <e@80x24.org>; Thu, 16 Mar 2017 13:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbdCPNQG (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 09:16:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:45089 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbdCPNQD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 09:16:03 -0400
Received: (qmail 32503 invoked by uid 109); 16 Mar 2017 13:15:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 13:15:37 +0000
Received: (qmail 14667 invoked by uid 111); 16 Mar 2017 13:15:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 09:15:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 09:15:34 -0400
Date:   Thu, 16 Mar 2017 09:15:34 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: sequencer "edit" command always issues a warning
Message-ID: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was rebasing with the new built-in sequencer code today, and I was
surprised to see the use of warning() here:

  $ git rebase -i
  [set one commit to 'edit']
  warning: stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
  You can amend the commit now, with
    [...more instructions...]

It alarmed me for a minute until I realized that no, this is nothing to
be alarmed about, but just git doing exactly what I told it to do.

The original just wrote:

  Stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name

It would be easy to switch back:

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

and that would match most of the other messages that the command issues,
which use a bare fprintf() and start with a capital letter. But I'm not
sure if there was some reason to treat this one differently.

-Peff
