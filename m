Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE3CC4332F
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5714E619E8
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 00:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352529AbhKPAcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:32:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:59294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345537AbhKOT2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:28:41 -0500
Received: (qmail 13860 invoked by uid 109); 15 Nov 2021 19:25:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 19:25:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16989 invoked by uid 111); 15 Nov 2021 19:25:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 14:25:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 14:25:36 -0500
From:   Jeff King <peff@peff.net>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Message-ID: <YZK0MKCYAJmG+pSU@coredump.intra.peff.net>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
 <20211115115153.48307-2-dyroneteng@gmail.com>
 <YZKyC7c8b9PnyXG8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZKyC7c8b9PnyXG8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 02:16:27PM -0500, Jeff King wrote:

> On Mon, Nov 15, 2021 at 07:51:51PM +0800, Teng Long wrote:
> 
> > diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> > index 3a442631c7..1f82229649 100644
> > --- a/builtin/ls-tree.c
> > +++ b/builtin/ls-tree.c
> > @@ -20,6 +20,7 @@ static int line_termination = '\n';
> >  #define LS_SHOW_TREES 4
> >  #define LS_NAME_ONLY 8
> >  #define LS_SHOW_SIZE 16
> > +#define LS_OID_ONLY 32
> >  static int abbrev;
> >  static int ls_options;
> >  static struct pathspec pathspec;
> > @@ -90,6 +91,14 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
> >  	else if (ls_options & LS_TREE_ONLY)
> >  		return 0;
> >  
> > +	if ((ls_options & LS_NAME_ONLY) && (ls_options & LS_OID_ONLY))
> > +		die(_("cannot specify --oid-only and --name-only at the same time"));
> 
> This seems reasonable to me. Letting them overwrite each other (i.e.,
> "last one wins") would also be fine, but we can always loosen to that
> behavior later if we choose.

Oh, and whichever direction we go, it would probably make sense for
--long to be handled in the same way. I.e.:

  git ls-tree --long --oid-only

does not really make sense. Though we currently just ignore --long for:

  git ls-tree --long --name-only

which is arguably a bug.

-Peff
