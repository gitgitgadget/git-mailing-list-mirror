Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2607203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbcGZUnD (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:43:03 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:54399 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756929AbcGZUnB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2016 16:43:01 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id D492C22FD9;
	Tue, 26 Jul 2016 21:42:59 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id C7E8636CB;
	Tue, 26 Jul 2016 21:42:59 +0100 (BST)
X-Quarantine-ID: <OaTZYU6mB8N9>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OaTZYU6mB8N9; Tue, 26 Jul 2016 21:42:58 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 38A9636C8;
	Tue, 26 Jul 2016 21:42:57 +0100 (BST)
Date:	Tue, 26 Jul 2016 21:42:53 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] push: add shorthand for --force-with-lease branch
 creation
Message-ID: <20160726204253.ciumvungwfwaw6el@john.keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
 <4e07ff23715b53fcd29564be1c74a9f66dd74e1e.1469483499.git.john@keeping.me.uk>
 <xmqqpoq12w93.fsf@gitster.mtv.corp.google.com>
 <20160726080309.pr46bbtzdvnr7fd3@john.keeping.me.uk>
 <xmqqwpk8yxvb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwpk8yxvb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 12:59:04PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> > @@ -2294,6 +2294,8 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
> >> >  	entry = add_cas_entry(cas, arg, colon - arg);
> >> >  	if (!*colon)
> >> >  		entry->use_tracking = 1;
> >> > +	else if (!colon[1])
> >> > +		memset(entry->expect, 0, sizeof(entry->expect));
> >> 
> >> hashclr()?
> >
> > Yes (and in the following patch as well).  I hadn't realised that
> > function exists.
> 
> Thanks; I've locally tweaked these two patches; the interdiff looks
> like this.

Thanks.  I'm about to send v3 anyway to pull a test forward to address
Jakub's comment.  I also used oidclr() for the last two changes below.

>  remote.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index e8b7bac..7eaf3c8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2304,7 +2304,7 @@ int parse_push_cas_option(struct push_cas_option *cas, const char *arg, int unse
>  	if (!*colon)
>  		entry->use_tracking = 1;
>  	else if (!colon[1])
> -		memset(entry->expect, 0, sizeof(entry->expect));
> +		hashclr(entry->expect);
>  	else if (get_sha1(colon + 1, entry->expect))
>  		return error("cannot parse expected object name '%s'", colon + 1);
>  	return 0;
> @@ -2354,7 +2354,7 @@ static void apply_cas(struct push_cas_option *cas,
>  		if (!entry->use_tracking)
>  			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
>  		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> -			memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
> +			hashclr(ref->old_oid_expect.hash);
>  		return;
>  	}
>  
> @@ -2364,7 +2364,7 @@ static void apply_cas(struct push_cas_option *cas,
>  
>  	ref->expect_old_sha1 = 1;
>  	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> -		memset(&ref->old_oid_expect, 0, sizeof(ref->old_oid_expect));
> +		hashclr(ref->old_oid_expect.hash);
>  }
>  
>  void apply_push_cas(struct push_cas_option *cas,
