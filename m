Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B78EE1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 21:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdLKVM3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 16:12:29 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20825 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752318AbdLKVM2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2017 16:12:28 -0500
X-IronPort-AV: E=Sophos;i="5.45,392,1508796000"; 
   d="scan'208";a="304995775"
Received: from zmbs3.inria.fr ([128.93.142.16])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2017 22:12:27 +0100
Date:   Mon, 11 Dec 2017 22:12:26 +0100 (CET)
From:   Matthieu Moy <matthieu.moy@univ-lyon1.fr>
To:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <1718292310.23922425.1513026746802.JavaMail.zimbra@inria.fr>
In-Reply-To: <34c53164f4054ee88354f19fc38ae0c4@BPMBX2013-01.univ-lyon1.fr>
References: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com> <34c53164f4054ee88354f19fc38ae0c4@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH] send-email: extract email-parsing code into a
 subroutine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.136.42.158]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF57 (Linux)/8.0.9_GA_6191)
Thread-Topic: [PATCH] send-email: extract email-parsing code into a subroutine
Thread-Index: AQHTcQOqbyjx8qlrA0aAQZcsk3LEMwkEcjPq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr> wrote:

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -685,7 +685,7 @@ Lines beginning in "GIT:" will be removed.
>  Consider including an overall diffstat or table of contents
>  for the patch you are writing.
>  
> -Clear the body content if you don't wish to send a summary.
> +Clear the body content if you dont wish to send a summary.

This is not part of your patch. Use "git add -p" to specify
exactly which hunks should go into the patch and don't let this
kind of change end up in the version you send.

> +	my %parsed_email;
> +	$parsed_email{'body'} = '';
> +	while (my $line = <$c>) {
> +		next if $line =~ m/^GIT:/;
> +		parse_header_line($line, \%parsed_email);
> +		if ($line =~ /^$/) {
> +			$parsed_email{'body'} = filter_body($c);
>  		}
> -		print $c2 $_;

I didn't notice this at first, but you're modifying the behavior here:
the old code used to print to $c2 anything that didn't match any of
the if/else if branches.

To keep this behavior, you need to keep all these extra headers in
$parsed_email (you do, in this version) and print them after taking
care of all the known headers (AFAICT, you don't).

>  	}
> -	close $c;
> -	close $c2;

You'll still need $c2, but you don't need $c anymore, so I'd keep the
"close $c" here. OTOH, $c2 is not needed before this point (actually a
bit later), so it would make sense to move the "open" down a little.
This would materialize the "read input, then write output" scheme (as
opposed to "write output while reading input" in the previous code).
It's not a new issue in your patch, but giving variables meaningful
names (i.e. not $c and $c2) would help, too.

> +	if ($parsed_email{'mime-version'}) {
> +		print $c2 "MIME-Version: $parsed_email{'mime-version'}\n",
> +				"Content-Type: $parsed_email{'content-type'};\n",
> +				"Content-Transfer-Encoding: $parsed_email{'content-transfer-encoding'}\n";
> +	}
> +
> +	if ($parsed_email{'content-type'}) {
> +		print $c2 "MIME-Version: 1.0\n",
> +			 "Content-Type: $parsed_email{'content-type'};\n",
> +			 "Content-Transfer-Encoding: 8bit\n";

This "if ($parsed_email{'content-type'})" does not correspond to
anything in the old code, and ...

> +	} elsif (file_has_nonascii($compose_filename)) {
> +                my $content_type = ($parsed_email{'content-type'} or
> +                        "text/plain; charset=$compose_encoding");

Here, your're dealing explicitly with $parsed_email{'content-type'} !=
false (you're in the 'else' branch where it can only be false).

I think you just meant to drop the "if
($parsed_email{'content-type'})" part, and plug the "elseif" directly
after the "if ($parsed_email{'mime-version'})". That's what I
suggested in my earlier email.

> +                my $content_type =3D ($parsed_email{'content-type'} or
> +                        "text/plain; charset=3D$compose_encoding");
> +                print $c2 "MIME-Version: 1.0\n",
> +                          "Content-Type: $content_type\n",
> +                          "Content-Transfer-Encoding: 8bit\n";
> +        }

This part is indented with spaces, please use tabs.

-- 
Matthieu Moy
https://matthieu-moy.fr/
