Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39BC1F424
	for <e@80x24.org>; Thu, 10 May 2018 05:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeEJFME (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 01:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:34334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755004AbeEJFME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 01:12:04 -0400
Received: (qmail 17994 invoked by uid 109); 10 May 2018 05:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 05:12:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20697 invoked by uid 111); 10 May 2018 05:12:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 01:12:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 01:12:02 -0400
Date:   Thu, 10 May 2018 01:12:02 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] packfile: close and free packs upon releasing an
 object store
Message-ID: <20180510051201.GB27259@sigill.intra.peff.net>
References: <20180510001211.163692-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510001211.163692-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 05:12:10PM -0700, Stefan Beller wrote:

> In d0b59866223 (object-store: close all packs upon clearing the object
> store, 2018-03-23), we made sure to close all packfiles on releasing
> an object store, but we also have to free the memory of the closed packs.

I know we've assumed in a few places that a "struct packed_git" will
never go away. The one that comes to mind is the mru list.

It looks like we'll be OK here:

> diff --git a/object.c b/object.c
> index 66cffaf6e51..3e64a4a26dd 100644
> --- a/object.c
> +++ b/object.c
> @@ -485,6 +485,6 @@ void raw_object_store_clear(struct raw_object_store *o)
>  	o->alt_odb_tail = NULL;
>  
>  	INIT_LIST_HEAD(&o->packed_git_mru);
> -	close_all_packs(o);
> +	close_and_free_packs(o);
>  	o->packed_git = NULL;
>  }

because we clear the list above. But it would be dangerous for anybody
else to call close_and_free_packs(). Should that INIT_LIST_HEAD get
moved down into that function?

Probably the same applies to setting NULL here; you're left with a
dangling pointer if you just call close_and_free_packs(). Should
that helper maybe just be a static function in object.c?


Just brainstorming other places where the immutability of "struct
packed_git" might be important:

  - pack-objects keeps a pointer from each object_entry to its
    containing packed_git. That's probably OK, as you wouldn't expect to
    be able to close the object store in the middle of that operation.

  - the reachability bitmap code holds a pointer to the pack that has a
    bitmap. Probably that whole "struct bitmap_index" needs to be part
    of the object_store (arguably it should all just be _inside_ the
    packed_git, but the current implementation avoids complexity by just
    having a single bitmap-per-repo).

-Peff
