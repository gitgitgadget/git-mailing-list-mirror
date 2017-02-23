Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3662D201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdBWIMB (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:12:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:60515 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdBWIMB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:12:01 -0500
Received: (qmail 31724 invoked by uid 109); 23 Feb 2017 08:12:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 08:12:00 +0000
Received: (qmail 22989 invoked by uid 111); 23 Feb 2017 08:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 03:12:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 03:11:58 -0500
Date:   Thu, 23 Feb 2017 03:11:58 -0500
From:   Jeff King <peff@peff.net>
To:     bs.x.ttp@recursor.net
Cc:     git@vger.kernel.org
Subject: Re: possible bug:  inconsistent CLI behaviour for empty user.name
Message-ID: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
References: <20170203051309.a737846dd26a6ed8df1e4112@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170203051309.a737846dd26a6ed8df1e4112@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 05:13:09AM +0100, bs.x.ttp@recursor.net wrote:

> The problem is that GIT accepts a user.name of " " for some operations
> (for example when doing a simple "git commit"), but does require a
> "non-empty" user.name for others (like git commit --amend and git
> rebase). In case of the latter commands GIT fails with the message
> "fatal: empty ident name (for <email@address>) not allowed".

I think it's a bug. We try to always reject empty usernames, but the
"empty" check is done before we cut off leading and trailing cruft (like
whitespace).

The "--amend" command notices because it actually parses the name out of
the existing commit. That version has already had its whitespace eaten
up (when it was written into the original commit), and so it ends up as
blank.

Here's a series which fixes that along with a few other oddities I
noticed.

  [1/4]: ident: mark error messages for translation
  [2/4]: ident: handle NULL email when complaining of empty name
  [3/4]: ident: reject all-crud ident name
  [4/4]: ident: do not ignore empty config name/email

 ident.c                       | 49 ++++++++++++++++++++++++++-----------------
 t/t7518-ident-corner-cases.sh | 36 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 19 deletions(-)
 create mode 100755 t/t7518-ident-corner-cases.sh


-Peff
