Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042EA1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 09:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeKGSvB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 13:51:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:43306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726161AbeKGSvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 13:51:01 -0500
Received: (qmail 13427 invoked by uid 109); 7 Nov 2018 09:21:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Nov 2018 09:21:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11433 invoked by uid 111); 7 Nov 2018 09:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Nov 2018 04:20:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Nov 2018 04:21:29 -0500
Date:   Wed, 7 Nov 2018 04:21:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] pack-objects: ignore ambiguous object warnings
Message-ID: <20181107092129.GA8671@sigill.intra.peff.net>
References: <pull.68.git.gitgitgadget@gmail.com>
 <pull.68.v2.git.gitgitgadget@gmail.com>
 <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
 <20181106211234.GA8383@sigill.intra.peff.net>
 <xmqqftwdd54p.fsf@gitster-ct.c.googlers.com>
 <xmqq7ehpclsa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ehpclsa.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 07, 2018 at 05:52:05PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The fix here is similar to 4c30d50 "rev-list: disable object/refname
> > ambiguity check with --stdin".  While the get_object_list() method
> > reads the objects from stdin, turn warn_on_object_refname_ambiguity
> > flag (which is usually true) to false.  Just for code hygiene, save
> > away the original at the beginning and restore it once we are done.
> 
> I actually think this is a bit too broad.  The calling process of
> this program does know that it is feeding list of raw object names
> (prefixed with ^ for negative ones), but the codepath this patch
> touches does not know who is calling it with what.  It would be
> safer to introduce a mechanism for the caller to tell this codepath
> not to bother checking refnames, as it knows it is feeding the raw
> object names and not refnames.
> 
> After all, you can feed things like "refs/heads/master" from the
> standard input of "git pack-objects --revs", no?

Keep in mind that this is not disallowing "refs/heads/master", nor even
disabling the ambiguity checking if we feed a "foo" that exists as both
a tag and a branch.

It is only disabling the check that when the caller feeds a 40-hex sha1,
we do not double-check to make sure that there is not a ref of the same
name (which is not even really an ambiguity, but just an informational
message for the user; the object id has always and must always take
precedence).

So yes, the caller does know better "I am only going to feed object
ids". But you can likewise look from the callee's perspective: "I am
going to take a lot of inputs, and spending time for an informational
message for each one is not worth doing".

So I think it's justifiable from that point of view. And from a
practical point of view, it's much simpler: we do not have teach every
caller to specify its input, or risk being slowed down by a low-value
informational check.

-Peff
