From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 18:43:34 -0400
Message-ID: <20150501224334.GB1179@peff.net>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
 <1430519737-6224-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:43:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJet-00047j-CO
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbbEAWnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:43:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:53085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbbEAWng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:43:36 -0400
Received: (qmail 23013 invoked by uid 102); 1 May 2015 22:43:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:43:36 -0500
Received: (qmail 20890 invoked by uid 107); 1 May 2015 22:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:44:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:43:34 -0400
Content-Disposition: inline
In-Reply-To: <1430519737-6224-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268184>

On Fri, May 01, 2015 at 03:35:37PM -0700, Stefan Beller wrote:

> Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory

Looks like the patch has expanded beyond checkout-index.c. Maybe:

  unconditionally free result of prefix_path

would be more descriptive? I usually like the "area:" prefix, but I
think here the common thread is not an area, but that they are return
values from prefix_path.

> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index 9ca2da1..5325f92 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -249,8 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
>  			die("git checkout-index: don't mix '--stdin' and explicit filenames");
>  		p = prefix_path(prefix, prefix_length, arg);
>  		checkout_file(p, prefix);
> -		if (p < arg || p > arg + strlen(arg))
> -			free((char *)p);
> +		free((char *)p);

Can we just drop the "const" from the declaration of "p"? Then we don't
have to do this funny cast here. It looks like the same applies to the
other callsites, and even the other uses of prefix_path in
update-index.c.

-Peff
