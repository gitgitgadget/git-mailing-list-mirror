From: Jeff King <peff@peff.net>
Subject: Re: [RFH] Spurious failures of t0025.[34]
Date: Fri, 30 Jul 2010 14:25:33 -0400
Message-ID: <20100730182532.GB18544@coredump.intra.peff.net>
References: <201007292340.01836.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuHN-0008RN-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317Ab0G3SZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:25:41 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36655 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759955Ab0G3SZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:25:39 -0400
Received: (qmail 3464 invoked by uid 111); 30 Jul 2010 18:25:37 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Fri, 30 Jul 2010 18:25:37 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jul 2010 14:25:33 -0400
Content-Disposition: inline
In-Reply-To: <201007292340.01836.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152254>

On Thu, Jul 29, 2010 at 11:40:01PM +0200, Thomas Rast wrote:

> Doing the following on current next (v1.7.2.1-230-g75e8ac1) stops
> after a number of iterations, usually within 5 minutes:
> 
>   while GIT_SKIP_TESTS="t0025.[5-9] t0025.??" \
>       ./t0025-crlf-auto.sh --valgrind --root=/dev/shm --tee -i
>   do
>     :
>   done

I was able to reproduce after many iterations on my debian unstable box,
too.

What's odd to me is that valgrind reports no error. Which implies to me
that it is actually a race condition that is being triggered by how slow
valgrind makes us run, but not an actual memory error.

> I tried patching them in this way:
> 
> ---- 8< ----
> diff --git i/t/t0025-crlf-auto.sh w/t/t0025-crlf-auto.sh
> index f5f67a6..d7424c9 100755
> --- i/t/t0025-crlf-auto.sh
> +++ w/t/t0025-crlf-auto.sh
> @@ -48,8 +48,7 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
>  
>  	# Note, "normalized" means that git will normalize it if added
>  	has_cr two &&
> -	twodiff=`git diff two` &&
> -	test -n "$twodiff"
> +	test_must_fail git diff --exit-code two

I also tried doing instead:

  test -n "$twodiff" || bash -i

which dumped me with a shell in the "broken" state. The interesting
thing is that I can then repeatably run "git diff two" and get an empty
diff.  So I don't think the error or race condition is in the run of
"git diff" itself, but rather what happened above (presumably the in
the read-tree step).

> So... does anyone have any ideas what to test next?  Or what might
> cause this?

Sorry, I am also at a loss, but maybe those hints can help point you in
the right direction. The next step for me would be to try running just
the read-tree bit in a loop to see if you can get anomalous results.

-Peff
