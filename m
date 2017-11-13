Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C92201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdKMDzW (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:55:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:54474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751243AbdKMDzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:55:21 -0500
Received: (qmail 10567 invoked by uid 109); 13 Nov 2017 03:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Nov 2017 03:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19221 invoked by uid 111); 13 Nov 2017 03:55:34 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (5.148.117.68)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 22:55:34 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Nov 2017 03:55:17 +0000
Date:   Mon, 13 Nov 2017 03:55:17 +0000
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Soukaina NAIT HMID <nhsoukaina@gmail.com>, git@vger.kernel.org
Subject: Re: [add-default-config 2/5] adding default to color
Message-ID: <20171113035516.446uznhfl6xlfvmi@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
 <0102015fb0bf3002-3462777a-2363-40cf-af37-80e26c0db65b-000000@eu-west-1.amazonses.com>
 <20171112153659.lt77rn6h6faeqfpb@sigill.intra.peff.net>
 <xmqqvaiealsv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaiealsv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 12:40:16PM +0900, Junio C Hamano wrote:

> As an aside.  Over time we accumulated quite a many actions that are
> all mutually exclusive by nature.  I have a feeling that we might be
> better off to move away from this implementation.  The only thing
> that we are getting from the current one-bit-in-a-flag-word is that
> we can name the variable "actions" (instead of "action") to pretend
> as if we can be given more than one, and then having to check its
> value with HAS_MULTI_BITS(actions) to confuse ourselves.
> 
> Instead, perhaps we should introduce an "enum action" that includes
> ACTION_UNSPECIFIED that is the initial value for the "action"
> variable, which gets set to ACTION_GET, etc. with OPT_SET_INT().  If
> we really care about erroring out when given
> 
> 	$ git config --add --get foo.bar
> 
> instead of the "last one wins" semantics, we can use OPT_CMDMODE.
> 
> The above is of course outside the scope of this series, and I am
> not sure if it should be done as a preparatory or a follow-up
> clean-up.

Yes, I agree that it's a little confusing, and that an enum is a better
representation.  The TYPE constants have the same problem.

I _think_ we could use OPT_CMDMODE() for those, too. Despite the name,
there is nothing in the parse-options error message that would be
inappropriate for something that isn't a cmdmode. Though I care a lot
less about "--bool --int" reporting an error (instead of last-one-wins)
than I do about "--get --set".

-Peff
