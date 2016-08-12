Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E0C2018E
	for <e@80x24.org>; Fri, 12 Aug 2016 07:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbcHLHZK (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 03:25:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:54039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbcHLHZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 03:25:08 -0400
Received: (qmail 6306 invoked by uid 109); 12 Aug 2016 07:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 07:24:19 +0000
Received: (qmail 17222 invoked by uid 111); 12 Aug 2016 07:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Aug 2016 03:24:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Aug 2016 03:24:17 -0400
Date:	Fri, 12 Aug 2016 03:24:17 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160812072417.huwa4e2tvtcew67k@sigill.intra.peff.net>
References: <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
 <20160809113337.GA1143@tb-raspi>
 <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160809125958.GA1501@tb-raspi>
 <20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net>
 <20160809212802.GA4132@tb-raspi>
 <alpine.DEB.2.20.1608101423160.4924@virtualbox>
 <20160811185812.GA18434@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160811185812.GA18434@tb-raspi>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 06:58:12PM +0000, Torsten Bögershausen wrote:

> commit 3754404d3d1ea4a0cbbed4986cc4ac1b5fe6b66e
> Author: Torsten Bögershausen <tboegi@web.de>
> Date:   Thu Aug 11 18:47:29 2016 +0200
> 
>     t0027: Correct raciness in NNO test
>     
>     When a non-reversible CRLF conversion is done in "git add",
>     a warning is printed on stderr.
>     
>     The commit_chk_wrnNNO() function  in t0027 was written to test this,
>     but did the wrong thing: Instead of looking at the warning
>     from "git add", it looked at the warning from "git commit".

Maybe add:

  This is racy because "git commit" may not have to do CRLF conversion
  at all if it can use the sha1 value from the index (which depends on
  whether "add" and "commit" run in a single second).

>     Thanks to Jeff King <peff@peff.net> for analizing t0027.
>     Reporyed-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>

s/analizing/analyzing/; s/Reporyed/Reported/

> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2860d2d..6e44382 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -119,8 +119,7 @@ commit_chk_wrnNNO () {
>  		fname=${pfx}_$f.txt &&
>  		cp $f $fname &&
>  		printf Z >>"$fname" &&
> -		git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
> -		git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
> +		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
>  	done

So this is the meat of the fix.

> @@ -394,11 +393,10 @@ test_expect_success 'commit files attr=crlf' '
>  
>  #                 attr                    LF        CRLF      CRLFmixLF   LF_mix_CR   CRLFNUL
>  commit_chk_wrnNNO ""      ""      false   ""        ""        ""          ""          ""
> -commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO ""      ""      true    ""        ""        ""          ""          ""
>  commit_chk_wrnNNO ""      ""      input   ""        ""        ""          ""          ""
> -
> -commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""          ""          ""
> -commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      false   ""        ""        ""          ""          ""
> +commit_chk_wrnNNO "auto"  ""      true    ""        ""        ""          ""          ""
>  commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""          ""          ""

I am not sure I understand why this reordering is necessary, but I guess
it's to group like things together in a single commit? Might be worth a
mention in the commit message.

-Peff
