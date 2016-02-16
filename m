From: Jeff King <peff@peff.net>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Mon, 15 Feb 2016 22:28:19 -0500
Message-ID: <20160216032818.GB19954@sigill.intra.peff.net>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
 <20160215140422.GA1747@mitoraj.siccegge.de>
 <xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
 <20160216012210.GB11961@sigill.intra.peff.net>
 <xmqqziv1mjf8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christoph Egger <christoph@christoph-egger.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 04:28:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWJP-0003jL-RV
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 04:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbcBPD2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 22:28:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:42738 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752759AbcBPD2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 22:28:22 -0500
Received: (qmail 19014 invoked by uid 102); 16 Feb 2016 03:28:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:28:21 -0500
Received: (qmail 15713 invoked by uid 107); 16 Feb 2016 03:28:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 22:28:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 22:28:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqziv1mjf8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286311>

On Mon, Feb 15, 2016 at 07:19:07PM -0800, Junio C Hamano wrote:

> I suspect that "#else" is too agressive to bail out or something
> silly like that.
> 
> Oh, I think I found it.
> 
> @@ -216,6 +219,13 @@ static int http_options(const char *var, const char *value, void *cb)
>  	if (!strcmp("http.sslcapath", var))
>  		return git_config_pathname(&ssl_capath, var, value);
>  #endif
> +	if (!strcmp("http.pinnedpubkey", var))
> +#if LIBCURL_VERSION_NUM >= 0x072c00
> +		return git_config_pathname(&ssl_pinnedkey, var, value);
> +#else
> +		warning(_("Public key pinning not supported with cURL < 7.44.0"));
> +		return 0;
> +#endif
> 
> We are not writing in Python.  Indenting the second line the same
> way does not make it part of the block.  Of course by inserting the
> new config in the earlier part of the function, it broke everything
> that comes after.

Oof. Good eyes. I suspected something funny with the #if, but after
starting at it for minutes, couldn't see it.

That makes sense, and the fix is obvious.

-Peff
