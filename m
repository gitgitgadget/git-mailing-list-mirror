From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] config: factor out config file stack management
Date: Tue, 12 Mar 2013 06:52:00 -0400
Message-ID: <20130312105200.GC11340@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165752.GB1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 11:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFMoq-0006Lr-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 11:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab3CLKwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 06:52:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49539 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab3CLKwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 06:52:04 -0400
Received: (qmail 25890 invoked by uid 107); 12 Mar 2013 10:53:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 06:53:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 06:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20130310165752.GB1136@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217944>

On Sun, Mar 10, 2013 at 05:57:53PM +0100, Heiko Voigt wrote:

> Because a config callback may start parsing a new file, the
> global context regarding the current config file is stored
> as a stack. Currently we only need to manage that stack from
> git_config_from_file. Let's factor it out to allow new
> sources of config data.
>
> [...]
>
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

Can we throw in a comment at the top here with the expected usage? In
particular, do_config_from is expecting the caller to have filled in
certain fields (at this point, top->f and top->name), but there is
nothing to make that clear.

-Peff
