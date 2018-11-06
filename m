Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9911F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeKGFLd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:11:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:42646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725198AbeKGFLd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:11:33 -0500
Received: (qmail 12356 invoked by uid 109); 6 Nov 2018 19:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 19:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3208 invoked by uid 111); 6 Nov 2018 19:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 14:44:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 14:44:43 -0500
Date:   Tue, 6 Nov 2018 14:44:43 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] send-pack: set core.warnAmbiguousRefs=false
Message-ID: <20181106194442.GB8902@sigill.intra.peff.net>
References: <pull.68.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.68.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 11:13:47AM -0800, Derrick Stolee via GitGitGadget wrote:

> I've been looking into the performance of git push for very large repos. Our
> users are reporting that 60-80% of git push time is spent during the
> "Enumerating objects" phase of git pack-objects.
> 
> A git push process runs several processes during its run, but one includes 
> git send-pack which calls git pack-objects and passes the known have/wants
> into stdin using object ids. However, the default setting for 
> core.warnAmbiguousRefs requires git pack-objects to check for ref names
> matching the ref_rev_parse_rules array in refs.c. This means that every
> object is triggering at least six "file exists?" queries.
> 
> When there are a lot of refs, this can add up significantly! My PerfView
> trace for a simple push measured 3 seconds spent checking these paths.

Some of this might be useful in the commit message. :)

> The fix for this is simple: set core.warnAmbiguousRefs to false for this
> specific call of git pack-objects coming from git send-pack. We don't want
> to default it to false for all calls to git pack-objects, as it is valid to
> pass ref names instead of object ids. This helps regain these seconds during
> a push.

I don't think you actually care about the ambiguity check between refs
here; you just care about avoiding the ref check when we've seen (and
are mostly expecting) a 40-hex sha1. We have a more specific flag for
that: warn_on_object_refname_ambiguity.

And I think it would be OK to enable that all the time for pack-objects,
which is plumbing that does typically expect object names. See prior art
in 25fba78d36 (cat-file: disable object/refname ambiguity check for
batch mode, 2013-07-12) and 4c30d50402 (rev-list: disable object/refname
ambiguity check with --stdin, 2014-03-12).

> Derrick Stolee (1):
>   send-pack: set core.warnAmbiguousRefs=false
> 
>  send-pack.c | 2 ++
>  1 file changed, 2 insertions(+)

Whenever I see a change like this to the pack-objects invocation for
send-pack, it makes me wonder if upload-pack would want the same thing.

It's a moot point if we just set the flag directly in inside
pack-objects, though.

-Peff
