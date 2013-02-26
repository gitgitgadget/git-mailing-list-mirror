From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Tue, 26 Feb 2013 21:09:41 +0100
Message-ID: <20130226200940.GF22756@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:10:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQqs-0008Gy-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547Ab3BZUJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:09:50 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:37212 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab3BZUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:09:49 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAQqL-0000FW-Kx; Tue, 26 Feb 2013 21:09:41 +0100
Content-Disposition: inline
In-Reply-To: <20130226195449.GA13830@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217173>

On Tue, Feb 26, 2013 at 02:54:49PM -0500, Jeff King wrote:
> On Tue, Feb 26, 2013 at 08:38:50PM +0100, Heiko Voigt wrote:
> > +static int do_config_from(struct config_file *top, config_fn_t fn, void *data)
> > +{
> > +	int ret;
> > +
> > +	/* push config-file parsing state stack */
> > +	top->prev = cf;
> > +	top->linenr = 1;
> > +	top->eof = 0;
> > +	strbuf_init(&top->value, 1024);
> > +	strbuf_init(&top->var, 1024);
> > +	cf = top;
> > +
> > +	ret = git_parse_file(fn, data);
> > +
> > +	/* pop config-file parsing state stack */
> > +	strbuf_release(&top->value);
> > +	strbuf_release(&top->var);
> > +	cf = top->prev;
> > +
> > +	return ret;
> > +}
> 
> This function name is a bit weird. I would have thought the "from" here
> was going to be a file, or a string, or whatever. But the filename setup
> happens outside this function (and yet this function depends on it being
> set up, as it calls git_parse_file). But maybe it will get less
> confusing with the other patches on top...

The "do_config_from" means "parse from whatever is in 'top'". Later in
the series its type changes from config_file to struct config.

The name 'git_parse_file' becomes definitely wrong after this series.
Maybe I should rename it?

Cheers Heiko
