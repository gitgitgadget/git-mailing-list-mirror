From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Tue, 26 Feb 2013 14:54:49 -0500
Message-ID: <20130226195449.GA13830@sigill.intra.peff.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQcR-0001KV-GH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622Ab3BZTyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:54:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33164 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab3BZTyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:54:53 -0500
Received: (qmail 9760 invoked by uid 107); 26 Feb 2013 19:56:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Feb 2013 14:56:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2013 14:54:49 -0500
Content-Disposition: inline
In-Reply-To: <20130226193850.GB22756@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217170>

On Tue, Feb 26, 2013 at 08:38:50PM +0100, Heiko Voigt wrote:

> Because a config callback may start parsing a new file, the
> global context regarding the current config file is stored
> as a stack. Currently we only need to manage that stack from
> git_config_from_file. Let's factor it out to allow new
> sources of config data.
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> 
> Peff, I hope you do not mind that I totally copied your commit message
> here.

I don't mind at all.

> The patch takes a different approach though. If you like we can add a
> 
> 	Commit-Message-by: Jeff King <peff@peff.net>
> 
> here :-)

I think my name is plastered all over "git log" enough as it is.

> +static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> +{
> +	int ret;
> +
> +	/* push config-file parsing state stack */
> +	top->prev = cf;
> +	top->linenr = 1;
> +	top->eof = 0;
> +	strbuf_init(&top->value, 1024);
> +	strbuf_init(&top->var, 1024);
> +	cf = top;
> +
> +	ret = git_parse_file(fn, data);
> +
> +	/* pop config-file parsing state stack */
> +	strbuf_release(&top->value);
> +	strbuf_release(&top->var);
> +	cf = top->prev;
> +
> +	return ret;
> +}

This function name is a bit weird. I would have thought the "from" here
was going to be a file, or a string, or whatever. But the filename setup
happens outside this function (and yet this function depends on it being
set up, as it calls git_parse_file). But maybe it will get less
confusing with the other patches on top...

-Peff
