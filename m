From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] remote: use parse_config_key
Date: Mon, 15 Feb 2016 18:04:43 -0500
Message-ID: <20160215230443.GB30631@sigill.intra.peff.net>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455575984-24348-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:04:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSCM-00045g-Qo
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbcBOXEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 18:04:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:42617 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753355AbcBOXEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 18:04:46 -0500
Received: (qmail 5753 invoked by uid 102); 15 Feb 2016 23:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 18:04:46 -0500
Received: (qmail 14153 invoked by uid 107); 15 Feb 2016 23:04:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 18:04:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 18:04:43 -0500
Content-Disposition: inline
In-Reply-To: <1455575984-24348-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286286>

On Mon, Feb 15, 2016 at 11:39:41PM +0100, Thomas Gummerer wrote:

> -	if (!starts_with(key,  "remote."))
> +	if (parse_config_key(key, "remote", &name, &namelen, &subkey) < 0)
>  		return 0;
> -	name = key + 7;
>  
>  	/* Handle remote.* variables */
> -	if (!strcmp(name, "pushdefault"))
> +	if (!strcmp(subkey, "pushdefault"))
>  		return git_config_string(&pushremote_name, key, value);

I think this needs to become:

  if (!name && !strcmp(subkey, "pushdefault"))

so that we do not match "remote.foo.pushdefault", which is nonsense. The
original avoided it by conflating "name" and "subkey" at various points,
and not parsing out the subkey until later. Making that more explicit is
one of the things that I think is improved by your patch. :)

>  	/* Handle remote.<name>.* variables */
> -	if (*name == '/') {
> +	if (*(name ? name : subkey) == '/') {
>  		warning("Config remote shorthand cannot begin with '/': %s",
> -			name);
> +			name ? name : subkey);
>  		return 0;
>  	}
> -	subkey = strrchr(name, '.');
> -	if (!subkey)
> +	if (!name)
>  		return 0;

I think you can bump the "if (!name)" check earlier. If it is empty, we
know that it does not start with "/". And then you can avoid the extra
NULL-checks.

The rest of the patch looks good to me. I hadn't realized initially that
all of the subkey compares would become "foo" and not ".foo". That makes
the diff noisier, but IMHO the result is much better.

-Peff
