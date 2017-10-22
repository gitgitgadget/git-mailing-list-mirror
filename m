Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F74202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbdJVM1Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 08:27:25 -0400
Received: from mail.pdinc.us ([67.90.184.27]:55422 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbdJVM1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 08:27:24 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id v9MCRJtU009289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 22 Oct 2017 08:27:19 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Jeff King'" <peff@peff.net>,
        "'Joris Valette'" <joris.valette@gmail.com>
Cc:     "'Andreas Schwab'" <schwab@linux-m68k.org>, <git@vger.kernel.org>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com> <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat> <87zi8sxvkg.fsf@linux-m68k.org> <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com> <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net> <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com> <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
In-Reply-To: <20171016221324.stn56gqnliunvcdv@sigill.intra.peff.net>
Subject: RE: Consider escaping special characters like 'less' does
Date:   Sun, 22 Oct 2017 08:27:20 -0400
Organization: PD Inc
Message-ID: <37013BB09DFE493BB7E11E66A34657CE@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdNGy//u8MeAJQZWQbyg533+8QmnmwEZPcJQ
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Jeff King
> Sent: Monday, October 16, 2017 6:13 PM
> To: Joris Valette
> Cc: Andreas Schwab; Jason Pyeron; git@vger.kernel.org
> Subject: Re: Consider escaping special characters like 'less' does
> 
<snip/>
> 
> I.e., something like this would probably help your case 
> without hurting
> anybody:
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 28b325d754..d44e5ea459 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -714,6 +714,16 @@ sub parse_diff {
>  		push @{$hunk[-1]{DISPLAY}},
>  			(@colored ? $colored[$i] : $diff[$i]);
>  	}
> +
> +	foreach my $hunk (@hunk) {
> +		foreach my $line (@{$hunk->{DISPLAY}}) {
> +			# all control chars minus newline and 
> ESC (for color)
> +			if ($line =~ s/[\000-\011\013-\032\034-\037]/?/g) {

What about CR [0x0D] ?

> +				$hunk->{CONTROLCHARS} = 1;
> +			}
> +		}
> +	}
> +
>  	return @hunk;
>  }
>  
> @@ -1407,6 +1417,9 @@ sub patch_update_file {
>  		if ($hunk[$ix]{TYPE} eq 'hunk') {
>  			$other .= ',e';
>  		}
> +		if ($hunk[$ix]->{CONTROLCHARS}) {
> +			print "warning: control characters in 
> hunk have been replaced by '?'\n";
> +		}
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> 
> I can't help but feel this is the tip of a larger iceberg, 
> though. E.g.,
> what about characters outside of the terminal's correct encoding? Or
> broken UTF-8 characters?
> 
> -Peff
> 

