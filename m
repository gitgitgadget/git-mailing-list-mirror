From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Tue, 26 Feb 2013 15:15:19 -0500
Message-ID: <20130226201518.GC13830@sigill.intra.peff.net>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
 <20130226200940.GF22756@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:15:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAQwG-0002OE-9x
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3BZUPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:15:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33229 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab3BZUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:15:22 -0500
Received: (qmail 10168 invoked by uid 107); 26 Feb 2013 20:16:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Feb 2013 15:16:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2013 15:15:19 -0500
Content-Disposition: inline
In-Reply-To: <20130226200940.GF22756@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217175>

On Tue, Feb 26, 2013 at 09:09:41PM +0100, Heiko Voigt wrote:

> > This function name is a bit weird. I would have thought the "from" here
> > was going to be a file, or a string, or whatever. But the filename setup
> > happens outside this function (and yet this function depends on it being
> > set up, as it calls git_parse_file). But maybe it will get less
> > confusing with the other patches on top...
> 
> The "do_config_from" means "parse from whatever is in 'top'". Later in
> the series its type changes from config_file to struct config.

Ah, I see. The "from" is the "struct config".

I wonder if it would be more obvious with the more usual OO-struct
functions, like:

  struct config_source {
          ...
  };
  void config_source_init_file(struct config_source *, const char *fn);
  void config_source_init_strbuf(struct config_source *,
                                 const struct strbuf *buf);
  void config_source_clear(struct config_source *);

  int config_source_parse(struct config_source *);

and then the use would be something like:

  struct config_source top;
  int ret;

  config_source_init_file(&top, "foo");
  ret = config_source_parse(&top);
  config_source_clear(&top);

  return ret;

I.e., "init" constructors, a "clear" destructor, and any methods like
"parse" that you need.  I haven't though too hard about it, though, so
maybe there is some reason it does not fit that model (it is a little
uncommon that the "init" would push itself onto a stack, but I think
that's OK).

-Peff
