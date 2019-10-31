Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C415B1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 06:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJaGSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 02:18:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:34658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726370AbfJaGSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 02:18:33 -0400
Received: (qmail 11900 invoked by uid 109); 31 Oct 2019 06:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 06:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27443 invoked by uid 111); 31 Oct 2019 06:21:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 02:21:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 02:18:32 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031061832.GA20830@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030224328.GB44961@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 03:43:28PM -0700, Denton Liu wrote:

> On Wed, Oct 30, 2019 at 04:28:35PM -0400, Jeff King wrote:
> Dscho brought up in the GGG thread[1] that perhaps we want to treat
> branch descriptions like notes and have them all under something like
> `refs/notes/branches`. This would certainly solve my problem of
> having versioned descriptions and it would probably do it in a much more
> general way than having a versioned included config.
> 
> Anyone see any potential problems with this approach?

I don't think it would be `refs/notes/`, as that is assumed to contain
mappings of object ids (and if I understand correctly, this would be a
mapping of branch names to data.

You could just have "refs/meta/descriptions/foo" pointing to a blob
which contains the description of "refs/heads/foo". That makes it easy
to edit descriptions, even if you don't like using "git branch
--edit-description".

You could also have "refs/meta/descriptions" to point to a _single_ blob
with all of the descriptions. It could even be in the existing config
format. And then you could include it with "[include] blob = ...". That
doesn't exist yet, but it would be easy to add (it was something I had
always considered when writing the config-include code, but there was
never really a good use; and you do have to be careful about pointing to
untrusted blobs). That's a convoluted way to get where you want, but I
wonder if integrating to the existing config system would have any
benefits. I haven't really thought it through.

(Of course that's also only one step away from having a versioned config
file in your .git directory, but it might possibly be a bit easier to
manage, since it would always be committed).

That's mostly off-the-top-of-my-head rambling, so please disregard
anything that seems totally off-base. :)

-Peff
