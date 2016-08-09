Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43741F859
	for <e@80x24.org>; Tue,  9 Aug 2016 13:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbcHIN1s (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 09:27:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932389AbcHIN1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 09:27:48 -0400
Received: (qmail 28843 invoked by uid 109); 9 Aug 2016 13:27:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 13:27:47 +0000
Received: (qmail 20628 invoked by uid 111); 9 Aug 2016 13:27:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 09:27:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 09:27:45 -0400
Date:	Tue, 9 Aug 2016 09:27:45 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
 <20160809113337.GA1143@tb-raspi>
 <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160809125958.GA1501@tb-raspi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160809125958.GA1501@tb-raspi>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 12:59:58PM +0000, Torsten Bögershausen wrote:

> Thanks for the explanation, so there are 2 chances for a race.
> 
> I assume that the suggested "touch" will fix race#2 in most cases.
> In my understanding, the change of the file size will be more reliable:
>  
> 
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 2860d2d..9933a9b 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -120,6 +120,7 @@ commit_chk_wrnNNO () {
>                 cp $f $fname &&
>                 printf Z >>"$fname" &&
>                 git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
> +               printf Z >>"$fname" &&
>                 git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
>         done
> -------------------
> Does anybody agree ?

I think the mtime change is reliable. We know that the mtime on the file
will be greater than or equal to the index mtime (because it happened
afterwards), so git will always look at the on-disk contents.

With your change, "git commit" will also always re-read the file from
disk, because it actually has new content (and you provide the filename
on the command line, so it is stage-and-commit, not just
"commit-the-index").

So either is fine.

> And, by the way, the convert warning may be issued twice, once in
> "git add" and once in "git commit".

Yes, but you only save it from "git commit", so we can ignore what
happens from "add" here. But that's why I wondered if:

  git -c core.autocrlf=$crlf add $fname >"${pfx}_$f.err" 2>&1

would make more sense. We _know_ that we have to do convert_to_git() in
that step because the content is changed. And then you can ignore the
warnings from "git commit" (which are racy), or you can simply commit as
a whole later, as some other loops do.

But like Dscho, I do not actually understand what this test is checking.
The function is called commit_chk_wrnNNO(), so perhaps you really are
interested in what "commit" has to say. But IMHO that is not an
interesting test. We know that if it has to read the content from disk,
it will call convert_to_git(), which is the exact same code path used by
"git add". So I do not understand what it is accomplishing to make a
commit at all here.

-Peff
