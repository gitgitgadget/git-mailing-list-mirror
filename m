From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] commit: allow editing the commit message even in
 shared repos
Date: Thu, 7 Jan 2016 07:41:18 -0500
Message-ID: <20160107124117.GA14421@sigill.intra.peff.net>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
 <cover.1452085713.git.johannes.schindelin@gmx.de>
 <38701d9358765af334ce405eb4a29f0063dae670.1452085713.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 07 13:41:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH9sk-000692-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 13:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbcAGMl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 07:41:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:49865 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753202AbcAGMlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 07:41:23 -0500
Received: (qmail 3200 invoked by uid 102); 7 Jan 2016 12:41:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 07:41:22 -0500
Received: (qmail 3707 invoked by uid 107); 7 Jan 2016 12:41:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Jan 2016 07:41:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jan 2016 07:41:18 -0500
Content-Disposition: inline
In-Reply-To: <38701d9358765af334ce405eb4a29f0063dae670.1452085713.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283477>

On Wed, Jan 06, 2016 at 02:09:43PM +0100, Johannes Schindelin wrote:

> It was pointed out by Yaroslav Halchenko that the file containing the
> commit message is writable only by the owner, which means that we have
> to rewrite it from scratch in a shared repository.
> [...]
> diff --git a/wrapper.c b/wrapper.c
> index b43d437..29a45d2 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -391,6 +391,19 @@ FILE *xfdopen(int fd, const char *mode)
>  	return stream;
>  }
>  
> +FILE *fopen_for_writing(const char *path)
> +{
> +	FILE *ret = fopen(path, "w");
> +
> +	if (!ret && errno == EPERM) {
> +		if (!unlink(path))
> +			ret = fopen(path, "w");
> +		else
> +			errno = EPERM;
> +	}
> +	return ret;
> +}

Thanks, this looks good to me. Having seen the implementation, it really
is just "try harder to fopen()".  I guess calling it "fopen_me_harder()"
would be too obscure. :)

-Peff
