From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] wrapper.c: convert trivial snprintf calls to
 xsnprintf
Date: Fri, 3 Jun 2016 05:13:47 -0400
Message-ID: <20160603091347.GG28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603074724.12173-10-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:14:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8lAy-0005jW-9y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcFCJNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:13:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48332 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751735AbcFCJNv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 05:13:51 -0400
Received: (qmail 2217 invoked by uid 102); 3 Jun 2016 09:13:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:13:50 -0400
Received: (qmail 19292 invoked by uid 107); 3 Jun 2016 09:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:13:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 05:13:47 -0400
Content-Disposition: inline
In-Reply-To: <20160603074724.12173-10-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296292>

On Fri, Jun 03, 2016 at 07:47:24AM +0000, Elia Pinto wrote:

> diff --git a/wrapper.c b/wrapper.c
> index 5dc4e15..0d44835 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -433,16 +433,11 @@ int xmkstemp(char *template)
>  int git_mkstemp(char *path, size_t len, const char *template)
>  {
>  	const char *tmp;
> -	size_t n;
>  
>  	tmp = getenv("TMPDIR");
>  	if (!tmp)
>  		tmp = "/tmp";
> -	n = snprintf(path, len, "%s/%s", tmp, template);
> -	if (len <= n) {
> -		errno = ENAMETOOLONG;
> -		return -1;
> -	}
> +	(void)xsnprintf(path, len, "%s/%s", tmp, template);
>  	return mkstemp(path);
>  }

I don't think this one is a good change. git_mkstemp is a library
function, and there are places that indirectly call it (via the gpg
code) that do not die when it fails (and even if all the callers _did_
die, isn't "could not create temporary file ..." a better error message
than "BUG: attempt to snprintf into too-small buffer"?).

-Peff
