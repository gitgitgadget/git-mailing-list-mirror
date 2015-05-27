From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 07/11] fetch-pack: use the configured transport
 protocol
Date: Wed, 27 May 2015 02:53:42 -0400
Message-ID: <20150527065342.GA1756@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVDp-00042H-LG
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbbE0Gxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:53:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:36491 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236AbbE0Gxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:53:44 -0400
Received: (qmail 32370 invoked by uid 102); 27 May 2015 06:53:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 01:53:44 -0500
Received: (qmail 4985 invoked by uid 107); 27 May 2015 06:53:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:53:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 02:53:42 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-8-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270027>

On Tue, May 26, 2015 at 03:01:11PM -0700, Stefan Beller wrote:

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 4a6b340..32dc8b0 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -127,6 +127,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  			args.update_shallow = 1;
>  			continue;
>  		}
> +		if (!strcmp("--transport-version", arg)) {
> +			args.version = strtol(arg + strlen("--transport-version"), NULL, 0);
> +			continue;
> +		}

You strcmp() the arg here, so there can't be anything at arg +
strlen(...), can there? Did you want:

  starts_with(arg, "--transports-version=")

here? Or better yet, skip_prefix().

> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +
> +	switch (args.version) {
> +	default:
> +	case 2:
> +		get_remote_capabilities(fd[0], NULL, 0);
> +		request_capabilities(fd[1]);
> +		break;

Should the "default" case be to complain about an unknown version,
rather than fall-through to 2?

-Peff
