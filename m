Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BE11F516
	for <e@80x24.org>; Thu, 28 Jun 2018 11:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeF1LtQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 07:49:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58002 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934223AbeF1LtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 07:49:14 -0400
Received: (qmail 7137 invoked by uid 109); 28 Jun 2018 11:49:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 11:49:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19067 invoked by uid 111); 28 Jun 2018 11:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 07:49:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 07:49:12 -0400
Date:   Thu, 28 Jun 2018 07:49:12 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180628114912.GA12901@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 07:39:53PM +0100, Ramsay Jones wrote:

> Since commit ed8b10f631 ("fsck: check .gitmodules content", 2018-05-02),
> fsck will issue an error message for '.gitmodules' content that cannot
> be parsed correctly. This is the case, even when the corresponding blob
> object has been included on the skiplist. For example, using the cgit
> repository, we see the following:
> 
>   $ git fsck
>   Checking object directories: 100% (256/256), done.
>   error: bad config line 5 in blob .gitmodules
>   error in blob 51dd1eff1edc663674df9ab85d2786a40f7ae3a5: gitmodulesParse: could not parse gitmodules blob
>   Checking objects: 100% (6626/6626), done.
>   $
> 
>   $ git config fsck.skiplist '.git/skip'
>   $ echo 51dd1eff1edc663674df9ab85d2786a40f7ae3a5 >.git/skip
>   $
> 
>   $ git fsck
>   Checking object directories: 100% (256/256), done.
>   error: bad config line 5 in blob .gitmodules
>   Checking objects: 100% (6626/6626), done.
>   $
> 
> Note that the error message issued by the config parser is still
> present, despite adding the object-id of the blob to the skiplist.
> 
> One solution would be to provide a means of suppressing the messages
> issued by the config parser. However, given that (logically) we are
> asking fsck to ignore this object, a simpler approach is to just not
> call the config parser if the object is to be skipped. Add a check to
> the 'fsck_blob()' processing function, to determine if the object is
> on the skiplist and, if so, exit the function early.

Yeah, this solution seems sensible. Given that we would never report any
error for that blob, there is no point in even looking at it. I wonder
if we ought to do the same for other types, too. Is there any point in
opening a tree that is in the skiplist?

> I noticed recently that the 'cgit.git' repo was complaining when
> doing an 'git fsck' ...
> 
> Note that 'cgit' had a '.gitmodules' file and a 'submodule.sh'
> script back in 2007, which had nothing to do with the current
> git submodule facilities, ... ;-)

Yikes. I worried about that sort of regression when adding the
.gitmodules checks. But this _is_ a pretty unique case: somebody was
implementing their own version of submodules (pre-git-submodule) and
decided to use the same name. So I'm not sure if this is a sign that we
need to think through the regression, or a sign that it really is rare.

One thing we could do is turn the parse failure into a noop. The main
point of the check is to protect people against the malicious
.gitmodules bug. If the file can't be parsed, then it also can't be an
attack vector (assuming the parser used for the fsck check and the
parser used by the victim behave identically).

That wouldn't help with your stray message, of course, but it would
eliminate the need to deal with the skiplist here (and skiplists aren't
always easy to do -- for instance, pushing up a non-fork of cgit to
GitHub would now be rejected because of this old file, and you'd have to
contact support to resolve it).

> I just remembered that I had intended to review the name of the
> function that this patch introduces before sending, but totally
> forgot! :(
> 
> [Hmm, 'to_be_skipped' -> object_to_be_skipped, object_on_skiplist,
> etc., ... suggestions welcome!]

The current name is OK to be, but object_on_skiplist() also seems quite
obvious.

-Peff
