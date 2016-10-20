Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D218320986
	for <e@80x24.org>; Thu, 20 Oct 2016 02:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757205AbcJTCN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 22:13:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:59826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756790AbcJTCN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 22:13:26 -0400
Received: (qmail 5313 invoked by uid 109); 20 Oct 2016 02:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:13:25 +0000
Received: (qmail 19673 invoked by uid 111); 20 Oct 2016 02:13:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 22:13:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 22:13:23 -0400
Date:   Wed, 19 Oct 2016 22:13:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
Message-ID: <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
 <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 04:36:36PM -0700, Jacob Keller wrote:

> >   # undo selectively
> >   git reset -p HEAD^
> >   git commit --amend
> 
> AHA! I knew about git reset -p but I didn't know about git reset -p
> allowed passing a treeish. Does this reset modify my local files at
> all? I think it doesn't, right?

Correct. If you wanted to modify the working tree, too, use "git
checkout -p HEAD^".

> I still think it's worth while to add a check for git-commit which
> does something like check when we say "git commit <files>" and if the
> index already has those files marked as being changed, compare them
> with the current contents of the file as in the checkout and quick
> saying "please don't do that" so as to avoid the problem in the first
> place.
> 
> A naive approach would just be "if index already has staged
> differences dont allow path selection" but that doesn't let me do
> something like "git add -p <files>" "git commit <other files>"

I suspect both of those would complain about legitimate workflows.

I dunno.  I do not ever use "git commit <file>" myself. I almost
invariably use one of "git add -p" (to review changes as I add them) or
"git add -u" (when I know everything is in good shape, such as after
merge resolution; I'll sometimes just "git commit -a", too).

But it sounds like you want a third mode besides "--include" and
"--only". Basically "commit what has been staged already, but restrict
the commit to the paths I mentioned". Something like "--only-staged" or
something. I do not think we would want to change the default from
--only, but I could see a config option or something to select that
behavior.

I suspect nobody has really asked for such a thing before because
separate staging and "git commit <file>" are really two distinct
workflows. Your pain comes from mix-and-matching them.

-Peff
