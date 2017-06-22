Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDAAF1FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbdFVSpT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:45:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:49088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753777AbdFVSpS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:45:18 -0400
Received: (qmail 14552 invoked by uid 109); 22 Jun 2017 18:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 18:45:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4147 invoked by uid 111); 22 Jun 2017 18:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 14:45:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 14:45:16 -0400
Date:   Thu, 22 Jun 2017 14:45:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
References: <20170621213924.wh43i2h7v2zwihq3@genre.crustytoothpaste.net>
 <xmqqpodxm2t8.fsf@gitster.mtv.corp.google.com>
 <87efud7xjd.fsf@kyleam.com>
 <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
 <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 11:32:43AM -0700, Junio C Hamano wrote:

> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index ed99437ad..b7e489ad3 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -259,6 +259,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
> >  		/* a root commit, but there are still more entries to show */
> >  		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
> >  		logobj = parse_object(&reflog->noid);
> > +		if (!logobj)
> > +			logobj = parse_object(&reflog->ooid);
> >  	}
> >  
> >  	if (!logobj || logobj->type != OBJ_COMMIT) {
> 
> We already have a loop to find an entry that is a commit that
> discards any non-commit object before the pre-context of this hunk.
> This "oops, old side is NULL so let's cover it up by using the new
> side" kicks in after that.  I wonder if we can roll that cover-up
> logic into the loop, perhaps like

Yeah, I tried making the second conditional its own loop, but I agree it
probably ought to be part of a single loop looking for a sane parent
entry.

> 	do {
> 		reflog = &commit_reflog->...[recno];
> 		commit_reflog->recno--;
> -		logobj = parse_object(&reflog->ooid);
> +		logobj = parse_object(is_null_oid(&reflog->ooid) 
> +				? &reflog->noid : &reflog->ooid);
> -	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
> +	} while (commit_reflog->recno && (!logobj || logobj->type != OBJ_COMMIT));
> -
> -	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {
> -		/* a root commit ... */
> -		reflog = &commit_reflog->...[recno];
> -		logobj = parse_object(&reflog->noid);
> -	}

I don't think this is quite right, though. We've decremented "recno"
after assigning the old pointer to "reflog". So in the existing code,
"reflog" in that second conditional pointing to the _next_ entry (or
previous, really, since we are going in reverse order).

So I think you'd need to look at commit->reflog again (after checking
that we didn't go past the start of the array).

-Peff
