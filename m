From: Jeff King <peff@peff.net>
Subject: Re: t5539 broken under Mac OS X
Date: Thu, 15 Jan 2015 17:27:19 -0500
Message-ID: <20150115222719.GA19021@peff.net>
References: <54B68D99.2040906@web.de>
 <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
 <54B6C897.5030405@web.de>
 <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBssx-0005Pu-4e
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 23:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbbAOW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 17:27:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:35177 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751879AbbAOW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 17:27:22 -0500
Received: (qmail 5416 invoked by uid 102); 15 Jan 2015 22:27:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 16:27:22 -0600
Received: (qmail 17006 invoked by uid 107); 15 Jan 2015 22:27:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 17:27:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 17:27:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262513>

On Thu, Jan 15, 2015 at 12:29:39PM -0800, Junio C Hamano wrote:

> This should not be the final patch (I think it should become a lazy
> prereq as it does a lot more), but just for testing, how does this
> look?
> 
>  t/test-lib.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index bb1402d..cdafab5 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1033,7 +1033,16 @@ test_lazy_prereq USR_BIN_TIME '
>  
>  # When the tests are run as root, permission tests will report that
>  # things are writable when they shouldn't be.
> -test -w / || test_set_prereq SANITY
> +if test_have_prereq POSIXPERM &&
> +	! test -w / &&
> +	>sanitytest &&
> +	chmod a= sanitytest &&
> +	! (>sanitytest) 2>/dev/null &&
> +	chmod +w sanitytest &&
> +	rm -f sanitytest
> +then
> +	test_set_prereq SANITY
> +fi

The current scheme does not require POSIXPERM. Would this mean that
some platforms no longer runs SANITY tests (e.g., Windows)?

Many of the SANITY-marked tests already require both, but not all. And
certainly lib-httpd actually cares whether you are _truly_ root, not
about weird filesystem permissions. Should lib-httpd literally be
checking the output of `id` (though I can imagine that is anything but
portable)?

-Peff
