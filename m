From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 07:32:31 -0400
Message-ID: <20150917113231.GB22085@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154950.GG29753@sigill.intra.peff.net>
 <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
 <20150916204226.GE3915@sigill.intra.peff.net>
 <20150917112856.GA22085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 13:32:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcXQc-0003Es-AI
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 13:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbbIQLce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 07:32:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:60740 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751723AbbIQLce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 07:32:34 -0400
Received: (qmail 22498 invoked by uid 102); 17 Sep 2015 11:32:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 06:32:33 -0500
Received: (qmail 29481 invoked by uid 107); 17 Sep 2015 11:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 07:32:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 07:32:31 -0400
Content-Disposition: inline
In-Reply-To: <20150917112856.GA22085@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278109>

On Thu, Sep 17, 2015 at 07:28:56AM -0400, Jeff King wrote:

>  	/*
>  	 * The branches file would have URL and optionally
>  	 * #branch specified.  The "master" (or specified) branch is
> -	 * fetched and stored in the local branch of the same name.
> +	 * fetched and stored in the local branch matching the
> +	 * remote name.
>  	 */
> -	frag = strchr(p, '#');
> -	if (frag) {
> +	frag = strchr(buf.buf, '#');
> +	if (frag)
>  		*(frag++) = '\0';
> -		strbuf_addf(&branch, "refs/heads/%s", frag);
> -	} else
> -		strbuf_addstr(&branch, "refs/heads/master");
> +	else
> +		frag = "master";
> +
> +	add_url_alias(remote, strbuf_detach(&buf, NULL));
> +	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
> +					  frag, remote->name));

There is a little bit of subtlety here. "frag" points into the strbuf.
We then detach the strbuf, and assume that "frag" is still valid. This
works fine, as we retain the same buffer when detaching. But I wonder if
it is violating the strbuf abstraction too much.

We can xstrdup() the frag section, but it just adds a little more
tedious book-keeping to the function.

-Peff
