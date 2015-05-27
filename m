From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 08/11] transport: connect_setup appends protocol
 version number
Date: Wed, 27 May 2015 03:02:02 -0400
Message-ID: <20150527070202.GG885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-9-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:02:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVLv-0007t5-NL
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbbE0HCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:02:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:36506 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbbE0HCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:02:04 -0400
Received: (qmail 335 invoked by uid 102); 27 May 2015 07:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:02:04 -0500
Received: (qmail 5057 invoked by uid 107); 27 May 2015 07:02:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:02:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:02:02 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-9-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270029>

On Tue, May 26, 2015 at 03:01:12PM -0700, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  transport.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/transport.c b/transport.c
> index 3ef15f6..33644a6 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -496,15 +496,29 @@ static int set_git_option(struct git_transport_options *opts,
>  static int connect_setup(struct transport *transport, int for_push, int verbose)
>  {
>  	struct git_transport_data *data = transport->data;
> +	const char *remote_program;
> +	char *buf = 0;

Use NULL when you mean a NULL pointer (they're equivalent to the
compiler, but the word is easier to read).

I agree on Eric's naming this "to_free" (and I consider it idiomatic to
assign them in a chain, like "foo = to_free = xmalloc(...)", but we
don't always do that).

> +	if (transport->smart_options
> +	    && transport->smart_options->transport_version) {
> +		buf = xmalloc(strlen(remote_program) + 12);
> +		sprintf(buf, "%s-%d", remote_program,
> +			transport->smart_options->transport_version);
> +		remote_program = buf;
> +	}

Using xstrfmt can help you avoid magic numbers and repetition,
like:

  to_free = xstrfmt("%s-%d",
                    remote_program,
		    transport->smart_options->transport_version);

-Peff
