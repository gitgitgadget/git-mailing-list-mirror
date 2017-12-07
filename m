Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2014F20954
	for <e@80x24.org>; Thu,  7 Dec 2017 13:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755673AbdLGNWK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 08:22:10 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58998 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755670AbdLGNWI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2017 08:22:08 -0500
X-IronPort-AV: E=Sophos;i="5.45,373,1508796000"; 
   d="scan'208";a="304417188"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 07 Dec 2017 14:22:06 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v4] send-email: extract email-parsing code into a subroutine
References: <20171206230225.18873-1-nathan.payre@etu.univ-lyon1.fr>
        <ff9066a7209b4e21867d933542f8eece@BPMBX2013-01.univ-lyon1.fr>
Date:   Thu, 07 Dec 2017 14:22:05 +0100
In-Reply-To: <ff9066a7209b4e21867d933542f8eece@BPMBX2013-01.univ-lyon1.fr>
        (PAYRE NATHAN's message of "Thu, 7 Dec 2017 10:28:57 +0000")
Message-ID: <q7h94lp2oepu.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not terribly important, but your patch has trailing newlines. "git diff
--staged --check" to see them. More below.

PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr> writes:

> the part of code which parses the header a last time to prepare the
> email and send it.

The important point is not that it's the last time the code parses
headers, so I'd drop the "a last time".

> +	my %parsed_email;
> +	$parsed_email{'body'} = '';
> +	while (my $line = <$c>) {
> +		next if $line =~ m/^GIT:/;
> +		parse_header_line($line, \%parsed_email);
> +		if ($line =~ /^\n$/i) {

You don't need the /i (case-Insensitive) here, there are no letters to
match.

> +	if ($parsed_email{'mime-version'}) {
> +		$need_8bit_cte = 0;

This $need_8bit_cte is a leftover of the old code, which processed the
headers in the order it found them in the message and had to remember
the content of MIME-Version while parsing Content-Type.

I believe you can apply this on top of your patch:

--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -709,7 +709,6 @@ EOT3
        open $c, "<", $compose_filename
                or die sprintf(__("Failed to open %s: %s"), $compose_filename, $!);
 
-       my $need_8bit_cte = file_has_nonascii($compose_filename);
        my $in_body = 0;
        my $summary_empty = 1;
        if (!defined $compose_encoding) {
@@ -740,12 +739,10 @@ EOT3
                        "\n";
        }
        if ($parsed_email{'mime-version'}) {
-               $need_8bit_cte = 0;
                print $c2 "MIME-Version: $parsed_email{'mime-version'}\n",
                                "Content-Type: $parsed_email{'content-type'};\n",
                                "Content-Transfer-Encoding: $parsed_email{'content-transfer-encoding'}\n";
-       }
-       if ($need_8bit_cte) {
+       } else if (file_has_nonascii($compose_filename)) {
                if ($parsed_email{'content-type'}) {
                                print $c2 "MIME-Version: 1.0\n",
                                         "Content-Type: $parsed_email{'content-type'};",

It reads much better: "If the original message already had a
MIME-Version header, then use that, else see if the file has non-ascii
characters and if so, use MIME-Version: 1.0".

Actually, you can even simplify further by factoring the if/else below:

> +		if ($parsed_email{'content-type'}) {
> +				print $c2 "MIME-Version: 1.0\n",
> +					 "Content-Type: $parsed_email{'content-type'};",

(Suspicious ";", and suspicious absence of "\n" here, I don't think it's
intentional and I'm fixing it below, but correct me if I'm wrong)

> +					 "Content-Transfer-Encoding: 8bit\n";
> +			} else {

(Broken indentation, this is not aligned with the "if" above)

>  				print $c2 "MIME-Version: 1.0\n",
>  					 "Content-Type: text/plain; ",
> -					   "charset=$compose_encoding\n",
> +					 "charset=$compose_encoding\n",
>  					 "Content-Transfer-Encoding: 8bit\n";
>  			}

This could become stg like (untested):

	} else if (file_has_nonascii($compose_filename)) {
        	my $content_type = ($parsed_email{'content-type'} or
                	"text/plain; charset=$compose_encoding");
		print $c2 "MIME-Version: 1.0\n",
			  "Content-Type: $content_type\n",
			  "Content-Transfer-Encoding: 8bit\n";
	}

> +	open $c2, "<", $compose_filename . ".final"
> +		or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
> +	close $c2;

What is this? Cut-and-paste mistake?

> +sub parse_header_line {
> +	my $lines = shift;
> +	my $parsed_line = shift;
> +	my $pattern1 = join "|", qw(To Cc Bcc);
> +	my $pattern2 = join "|",
> +		qw(From Subject Date In-Reply-To Message-ID MIME-Version 
> +			Content-Type Content-Transfer-Encoding References);
> +	
> +	foreach (split(/\n/, $lines)) {
> +		if (/^($pattern1):\s*(.+)$/i) {
> +		        $parsed_line->{lc $1} = [ parse_address_line($2) ];
> +		} elsif (/^($pattern2):\s*(.+)\s*$/i) {
> +		        $parsed_line->{lc $1} = $2;
> +		}

I don't think you need to list the possibilities in the "else" branch.
Just matching /^([^:]*):\s*(.+)\s*$/i should do the trick.

> +			$body = $body . $body_line;

Or just: $body .= $body_line;

-- 
Matthieu Moy
https://matthieu-moy.fr/
