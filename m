Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7311F462
	for <e@80x24.org>; Fri, 24 May 2019 17:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfEXRIC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 13:08:02 -0400
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:42550 "EHLO
        resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbfEXRIC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 May 2019 13:08:02 -0400
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-01v.sys.comcast.net with ESMTP
        id UD8phzF1cHkmzUDflhxl1S; Fri, 24 May 2019 17:08:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1558717681;
        bh=BvZJOjD2GiM243wGHA0BoOusDj7wH60RRzlhvmPfWhs=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=HLs5K0qTMYEiIBRV8JmaQweBj5lPBdACGMOkrxgDgakppH8mB8Ozst/230JI1Y/0x
         jKfVxTr4WF7ZLX18/h1QgwucPWG1SK4/FXRWtdk5qAxXD/9cdTwlv8zucj+qbLxQDb
         vzRFQiiU5Owbw+YnZ2tMZKKXIjftuBIPilMfmVD4ehUFLhbYvMvAXeypaY/sWzPMIX
         /7e7NaRtAkdvH4i8zQs9e3jDLT6xJJjJh1KnqfDsfZn954NTR3FlULaWCmfrVbEwnV
         QxiaqOfkX3YuLBuRGypQWYo/2SeQT8wVlPxHPxPjugfic/2C3OVI2X9Py3Z8eOCaEi
         Cxa2sdAQB+SSQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f5ca:db6a:b0f5:2073])
        by resomta-po-14v.sys.comcast.net with ESMTPSA
        id UDfihMCE5aUYaUDfjhRWw4; Fri, 24 May 2019 17:08:00 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Fri, 24 May 2019 10:07:58 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] list-objects-filter: disable 'sparse:path' filters
Message-ID: <20190524170758.GB7160@comcast.net>
References: <20190524120318.4851-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524120318.4851-1-chriscool@tuxfamily.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 02:03:18PM +0200, Christian Couder wrote:
> For now though, let's just disable 'sparse:path' filters.

This is probably the right thing to do. I did jump through a lot of hoops to
support escaping sub-filters in my pending filter combination patchset, since
sparse spec path names can have arbitrary characters. After this patch we only
support a handful of characters in filterspecs, so a lot of that escaping logic
can be dropped, at least for now. Anyway, this is not a complaint, just an
observation.

The alternative is to hide sparse:path= support behind a flag which is disabled
by default, but I don't recommend doing that just to have an excuse to include
the URL-encoding logic.

Thank you for cleaning up.

>  	} else if (skip_prefix(arg, "sparse:path=", &v0)) {
> -		filter_options->choice = LOFC_SPARSE_PATH;
> -		filter_options->sparse_path_value = strdup(v0);
> -		return 0;
> +		if (errbuf) {
> +			strbuf_addstr(
> +				errbuf,
> +				_("sparse:path filters are now disabled"));

This wording may leave room for misunderstanding, since it sounds a little like
the filter can be re-enabled somehow. Maybe you can say "sparse:path filters
support has been dropped [optional: 'for security reasons' etc.]"

> +		}
> +		return 1;
>  	}
>  	/*
>  	 * Please update _git_fetch() in git-completion.bash when you

As the comment states, don't forget to update git-completion.bash :)
