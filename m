From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 17:38:50 -0500
Message-ID: <20150113223849.GA3144@peff.net>
References: <54B5579B.4080607@kdbg.org>
 <20150113214733.GA16582@peff.net>
 <54B59D24.7030508@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBA6z-0004bU-DP
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbbAMWix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:38:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:34108 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751066AbbAMWiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 17:38:52 -0500
Received: (qmail 20191 invoked by uid 102); 13 Jan 2015 22:38:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 16:38:52 -0600
Received: (qmail 30935 invoked by uid 107); 13 Jan 2015 22:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 17:39:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 17:38:50 -0500
Content-Disposition: inline
In-Reply-To: <54B59D24.7030508@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262358>

On Tue, Jan 13, 2015 at 11:33:08PM +0100, Johannes Sixt wrote:

> BTW, is it the incompressibility where the time is lost or lack of
> sparseness of the files? How does the timing change with this patch on
> top?

Oh, good call. It's the incompressibility. Which makes perfect sense.
Once we copy the file into the object database, that copy is not sparse.
But in the genrandom version, it _is_ a million times bigger. :)

With the patch below, my timings go back to ~0.7s (actually, they seem
slightly _better_ on average than what is in "master" now, but there is
quite a bit of run-to-run noise, so it may not be meaningful).

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index f653121..9cf4e0e 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -9,10 +9,10 @@ test_expect_success setup '
>  	# clone does not allow us to pass core.bigfilethreshold to
>  	# new repos, so set core.bigfilethreshold globally
>  	git config --global core.bigfilethreshold 200k &&
> -	test-genrandom seed1 2000000 >large1 &&
> +	printf "\0%2000000s" X >large1 &&
>  	cp large1 large2 &&
>  	cp large1 large3 &&
> -	test-genrandom seed2 2500000 >huge &&
> +	printf "\0%2500000s" Y >huge &&
>  	GIT_ALLOC_LIMIT=1500k &&
>  	export GIT_ALLOC_LIMIT
>  '

I think with this squashed in, I have no complaints at all about your
patch.

-Peff
