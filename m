Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259A520248
	for <e@80x24.org>; Tue, 26 Mar 2019 18:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfCZSXD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 14:23:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731531AbfCZSXC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 14:23:02 -0400
Received: (qmail 17904 invoked by uid 109); 26 Mar 2019 18:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 18:23:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22108 invoked by uid 111); 26 Mar 2019 18:23:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 14:23:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 14:23:00 -0400
Date:   Tue, 26 Mar 2019 14:23:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 2/2] fetch-pack: respect --no-update-shallow in v2
Message-ID: <20190326182300.GC24105@sigill.intra.peff.net>
References: <cover.1553546216.git.jonathantanmy@google.com>
 <cover.1553622678.git.jonathantanmy@google.com>
 <943b1cbc61dbcc498a9e34d7d39dc8617cb99195.1553622679.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <943b1cbc61dbcc498a9e34d7d39dc8617cb99195.1553622679.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 10:53:26AM -0700, Jonathan Tan wrote:

> @@ -1625,6 +1649,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  {
>  	struct ref *ref_cpy;
>  	struct shallow_info si;
> +	struct oid_array shallows_scratch = OID_ARRAY_INIT;
>  
>  	fetch_pack_setup();
>  	if (nr_sought)
> @@ -1649,10 +1674,11 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		die(_("no matching remote head"));
>  	}
>  	if (version == protocol_v2) {
> -		if (shallow && shallow->nr)
> +		if (shallow->nr)
>  			BUG("Protocol V2 does not provide shallows at this point in the fetch");
>  		memset(&si, 0, sizeof(si));
>  		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
> +					   &shallows_scratch, &si,
>  					   pack_lockfile);
>  	} else {
>  		prepare_shallow_info(&si, shallow);
> @@ -1680,6 +1706,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  	update_shallow(args, sought, nr_sought, &si);
>  cleanup:
>  	clear_shallow_info(&si);
> +	oid_array_clear(&shallows_scratch);
>  	return ref_cpy;
>  }

Yeah, this is much clearer than what I posted earlier. Thanks for
thinking it through.

The patches look good to me, modulo the timing of the NULL thing I
mentioned elsewhere.

-Peff
