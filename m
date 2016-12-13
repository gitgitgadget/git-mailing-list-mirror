Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596AB203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932959AbcLMTuE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:50:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:55966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbcLMTtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:49:03 -0500
Received: (qmail 27770 invoked by uid 109); 13 Dec 2016 19:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 19:49:02 +0000
Received: (qmail 17979 invoked by uid 111); 13 Dec 2016 19:49:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 14:49:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 14:49:00 -0500
Date:   Tue, 13 Dec 2016 14:49:00 -0500
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Ariel <asgit@dsgml.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p with unmerged files (was: git add -p with new file)
Message-ID: <20161213194859.eoztbojnp4veaozc@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <98817141-fa57-7687-09c4-dc96419d8a35@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98817141-fa57-7687-09c4-dc96419d8a35@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 08:21:59PM +0100, Stephan Beyer wrote:

> While we're on the topic that "git add -p" should behave like the
> "normal" "git add" (not "git add -u"): what about unmerged changes?

I agree that's a related part of the workflow, though the implementation
is a bit harder.

> When I have merge conflicts, I almost always use my aliases
> "edit-unmerged" and "add-unmerged":
> 
> $ git config --global --list | grep unmerged
> alias.list-unmerged=diff --name-only --diff-filter=U
> alias.edit-unmerged=!vim `git list-unmerged`

You might like contrib/git-jump for that, which makes it easier to go to
the specific spots within files.

When "git jump merge" produces no hits, I know I've dealt with all of
the conflicts (textual ones, anyway). I do often want to run "git add
-p" then to review the changes before staging.

I think what is most helpful there is probably "git diff HEAD" to see
what the merge is bringing in (or the cherry-pick, or "am", or
whatever). If I wanted "add -p" to do anything, I think it would be to
act as if stage 2 ("ours", which should be the same as what is in HEAD)
was already in the index. I.e., show the diff against that, apply any
hunks we select, and store the whole thing as stage 0, losing the
unmerged bit.

When you select all hunks, this is equivalent to "git add unmerge-file".
If you choose only a subset of hunks, it leaves the unselected ones for
you to examine later via "git diff". And if you choose none, it should
probably leave unmerged.

That's just a scheme I thought up, though. I've never actually tried it
in practice.

-Peff
