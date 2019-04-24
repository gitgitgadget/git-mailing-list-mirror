Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6013F1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 01:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfDXBUT (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 21:20:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57612 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfDXBUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 21:20:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 416FF60D27;
        Tue, 23 Apr 2019 21:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ozDqrM+YtN2ZoBrAn8trU9zf9Y=; b=rgCSv+
        ZUI3ch98UHmqyjJ9IZv6/HxzrxwSUXSr4HWCVzZTzEzGfVUu6dR0PwyHNbEj/Ebf
        Xju0SEOkic9CiEIPcU2GliZd6T/+yCYI0czR8Voo8NSLSS+ntiJGBlq2vxYrJ+8P
        t7yC4hDNMjI9R/sYzfQdpbnII8f+ULx0OgdJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfbYaBql//URbAKlNnaJ8nFodbmo8R+x
        ns+3SzCJ5G0hPS9Wp0RKosDawQiyVQmCxWRL9JXP5rFwvAXbyXRdCQ5g2C5XPqjS
        TYN+ARLZ90ZRpNqlNC//anO1R30fJOHZwEoAdfQB8zmGnWZrAD4WQaYNMWKYWnHM
        8VY99dsdV0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A4BE60D26;
        Tue, 23 Apr 2019 21:20:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C03F60D24;
        Tue, 23 Apr 2019 21:20:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] t/perf: depend on perl JSON only when using --codespeed
References: <20190423043419.GA11689@sigill.intra.peff.net>
Date:   Wed, 24 Apr 2019 10:20:12 +0900
In-Reply-To: <20190423043419.GA11689@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 23 Apr 2019 00:34:20 -0400")
Message-ID: <xmqqd0lc42sz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CD2672E-662F-11E9-A65B-EE24A11ADF13-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 05eb1c37ed (perf/aggregate: implement codespeed JSON output,
> 2018-01-05) added a dependency on the perl JSON module to show output
> from aggregate.perl, but we only need it when the user asks for
> --codespeed output. While the module is pretty common, it's not part of
> the base system, and this dependency can get in the way of producing the
> default human-readable output.
>
> Let's bump the "use" down to a "require" in the code path that needs it,
> which will be interpreted at run-time instead of compile-time. People
> not using "--codespeed" won't even load the module, and anybody using it
> should see the same results (including the same perl error if they don't
> have it).

Nice.

> This bites me occasionally when running perf tests on many-core work
> machines where I can't just "apt-get install libjson-perl". So I finally
> decided look into it. :)

Thanks.

>  t/perf/aggregate.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
> index 494907a892..76dd48f890 100755
> --- a/t/perf/aggregate.perl
> +++ b/t/perf/aggregate.perl
> @@ -3,7 +3,6 @@
>  use lib '../../perl/build/lib';
>  use strict;
>  use warnings;
> -use JSON;
>  use Getopt::Long;
>  use Git;
>  
> @@ -342,7 +341,8 @@ sub print_codespeed_results {
>  		}
>  	}
>  
> -	print to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
> +	require JSON;
> +	print JSON::to_json(\@data, {utf8 => 1, pretty => 1, canonical => 1}), "\n";
>  }
>  
>  binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
