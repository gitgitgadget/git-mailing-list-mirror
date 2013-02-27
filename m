From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Wed, 27 Feb 2013 08:51:02 +0100
Message-ID: <20130227075100.GA3268@sandbox-ub>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org>
 <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
 <20130226200940.GF22756@sandbox-ub>
 <20130226201518.GC13830@sigill.intra.peff.net>
 <7vobf6loas.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 08:51:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAbnd-0004Vx-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 08:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab3B0HvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 02:51:12 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:47265 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab3B0HvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 02:51:12 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UAbn4-0008Ve-MN; Wed, 27 Feb 2013 08:51:02 +0100
Content-Disposition: inline
In-Reply-To: <7vobf6loas.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217197>

On Tue, Feb 26, 2013 at 02:10:03PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I wonder if it would be more obvious with the more usual OO-struct
> > functions, like:
> >
> >   struct config_source {
> >           ...
> >   };
> >   void config_source_init_file(struct config_source *, const char *fn);
> >   void config_source_init_strbuf(struct config_source *,
> >                                  const struct strbuf *buf);
> >   void config_source_clear(struct config_source *);
> >
> >   int config_source_parse(struct config_source *);
> >
> > and then the use would be something like:
> >
> >   struct config_source top;
> >   int ret;
> >
> >   config_source_init_file(&top, "foo");
> >   ret = config_source_parse(&top);
> >   config_source_clear(&top);
> >
> >   return ret;
> >
> > I.e., "init" constructors, a "clear" destructor, and any methods like
> > "parse" that you need.
> 
> Yup, that cocincides with my first impression I sent out for the
> previous RFC/PATCH round.

I agree that your suggestions would make the design more OO and provide
us with more flexibility. However at the following costs:

Currently the push and pop are combined into one function. This design
makes it impossible to forget the cleanup if someone else uses this
function. The same applies to the private data handling around
do_config_from().

All memory is currently handled on the stack. If we have an init/clear
design at least the private data for strbuf needs to be put on the heap.
We could pass in the config_strbuf but IMO that would violate the
encapsulation.

Thus we also require a specialized clear which frees that private data
(we need that to close the file anyway). Because of that I would probably
call it destroy or free.

That means there will be six additional functions instead of one: We
need init and clear for both, a common init and a common clear for the
push/pop part. IMO that will make the code harder to read for the first
time.

Then we would have a hybrid stack/heap solution still involving side
effects (setting the global cf).

Do not get me wrong. I am not against changing it but I would like to
spell out the consequences first before doing so.

Do you still think that is nicer approach?

Cheers Heiko
