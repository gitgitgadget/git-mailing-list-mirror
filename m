Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2CB1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbcFPShB (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 14:37:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751620AbcFPShA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 14:37:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B78D925760;
	Thu, 16 Jun 2016 14:36:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ynlAMoj01xiuspYprzDx0S6zqtE=; b=NID2HN
	/7+bj6PbPbbDwTUwrRAiJizWpKSUw+bf8ACzTebbCiUJL1K+DC1FlWpH7jL3M9NM
	m7C2UgR0ij68yQq8VZO62FcKgoNz0/Ujj+XhnoSr+vd49x/QdWmR9b4WVTWNGVPF
	6Msj6tKmxjVs6ZzKnwQizvIX1vRYC/CbC/f4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JpcdVsPCnnNEJmLH6ePcpfw15h1io0l4
	Mtxe5CGeq4wYxiGeIgWv0fzqfTfC5MBMFMXKDrCTDVunkzwYtuOfeezwgRMdECvd
	Kp8ihPdzyFUhVPtm+vjxNV3f8avK7EJD5jAxowfthOzUynQr6d0opPYq5qxGbC/h
	5srC6QRhRIo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A3C522575F;
	Thu, 16 Jun 2016 14:36:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 237CC2575E;
	Thu, 16 Jun 2016 14:36:59 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
Subject: Re: final git bisect step leads to: "fatal: you want to use way too much memory"
References: <20160616125326.GA314@x4> <20160616132952.GC314@x4>
	<20160616134742.GA25920@sigill.intra.peff.net>
Date:	Thu, 16 Jun 2016 11:36:57 -0700
In-Reply-To: <20160616134742.GA25920@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jun 2016 09:47:42 -0400")
Message-ID: <xmqqporh3rqu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F47302C-33F1-11E6-8E62-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Interesting. But `git show` on the commit in question (f216419e5) does
> not have any problems. It looks like bisect's internal "show the commit"
> code does not properly call setup_revisions() to finalize the "struct
> rev_info". That leaves the expand_tabs_in_log flag as "-1", which then
> ends up cast to an unsigned of 2^64 when we use it in a size
> computation.

Yuck

> And who knows what other bugs have been lurking there over the years;
> there are other flags that should be finalized by setup_revision(), too.
>
> This patch should fix it.

Looks sensible.

> diff --git a/bisect.c b/bisect.c
> index 6d93edb..dc13319 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -890,6 +890,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>  	if (!opt.diffopt.output_format)
>  		opt.diffopt.output_format = DIFF_FORMAT_RAW;
>  
> +	setup_revisions(0, NULL, &opt, NULL);
>  	log_tree_commit(&opt, commit);
>  }
>  
