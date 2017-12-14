Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F12601F404
	for <e@80x24.org>; Thu, 14 Dec 2017 14:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbdLNOFg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 09:05:36 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:26781 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753135AbdLNOFf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2017 09:05:35 -0500
X-IronPort-AV: E=Sophos;i="5.45,400,1508796000"; 
   d="scan'208";a="305482570"
Received: from zmbs3.inria.fr ([128.93.142.16])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Dec 2017 15:05:33 +0100
Date:   Thu, 14 Dec 2017 15:05:33 +0100 (CET)
From:   Matthieu Moy <matthieu.moy@univ-lyon1.fr>
To:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <285414621.1144481.1513260333115.JavaMail.zimbra@inria.fr>
In-Reply-To: <ce70816f94c24754bea9bc8175de4bc4@BPMBX2013-01.univ-lyon1.fr>
References: <CAGb4CBVcUv111dUy9waScAL2WATkk0LVqJQ55g3-XbH1H228YQ@mail.gmail.com> <ce70816f94c24754bea9bc8175de4bc4@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH] send-email: extract email-parsing code into a
 subroutine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.136.87.204]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF57 (Linux)/8.0.9_GA_6191)
Thread-Topic: [PATCH] send-email: extract email-parsing code into a subroutine
Thread-Index: AQHTdMMrYRuOAdSWLEGWkE5ZVx9GcaNCnqKAfNFOGeo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr> wrote:

> -		print $c2 $_;
>  	}
> +
>  	close $c;


Nit: this added newline does not seem necessary to me. Nothing
serious, but this kind of thing tend to distract the reader when
reviewing the patch.

> +	foreach my $key (keys %parsed_email) {
> +		next if $key == 'body';
> +		print $c2 "$key: $parsed_email{$key}";
> +	}

I'd add a comment like

	# Preserve unknown headers

at the top of the loop to make it clear what we're doing.

On a side note: there's no comment in the code you're adding. This is
not necessarily a bad thing (beautifully written code does not need
comments to be readable), but you may re-read your code with the
question "did I explain everything well-enough?" in mind. The loop
above is a case where IMHO a short and sweet comment helps the reader.

Two potential issues not mentionned in your message but that we
discussed offlist is that 1) this doesn't preserve the order, and 2)
this strips duplicate headers. I believe this is not a problem here,
and trying to solve these points would make the code overkill, but
this would really deserve being mentionned in the commit message.
First, so that people reviewing your patch now can confirm (or not)
that you are taking the right decision by doing this, and also for
people in the future examining your patch (e.g. after a bisect).

> +sub parse_header_line {
> +	my $lines = shift;
> +	my $parsed_line = shift;
> +	my $pattern = join "|", qw(To Cc Bcc);

Nit: you may want to rename it to something more explicit, like
$addr_headers_pat.

None of my nit should block the patch inclusion, but I think the
commit message should be expanded to include a mention of the
"duplicate headers"/"header order" potential issue.

-- 
Matthieu Moy
https://matthieu-moy.fr/
