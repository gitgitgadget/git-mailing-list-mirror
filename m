From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2 3/4] config: make parsing stack struct independent
 from actual data source
Date: Tue, 12 Mar 2013 17:27:35 +0100
Message-ID: <20130312162734.GB4704@sandbox-ub.fritz.box>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165940.GD1136@sandbox-ub.fritz.box>
 <20130312110355.GE11340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:28:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFS3Z-0005Bx-E6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898Ab3CLQ1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 12:27:39 -0400
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:53245 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab3CLQ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 12:27:38 -0400
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UFS35-0007Bc-IZ; Tue, 12 Mar 2013 17:27:35 +0100
Content-Disposition: inline
In-Reply-To: <20130312110355.GE11340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217974>

On Tue, Mar 12, 2013 at 07:03:55AM -0400, Jeff King wrote:
> On Sun, Mar 10, 2013 at 05:59:40PM +0100, Heiko Voigt wrote:
> 
> > diff --git a/config.c b/config.c
> > index f55c43d..fe1c0e5 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -10,20 +10,42 @@
> >  #include "strbuf.h"
> >  #include "quote.h"
> >  
> > -typedef struct config_file {
> > -	struct config_file *prev;
> > -	FILE *f;
> > +struct config_source {
> > +	struct config_source *prev;
> > +	void *data;
> 
> Would a union be more appropriate here? We do not ever have to pass it
> directly as a parameter, since we pass the "struct config_source" to the
> method functions.
> 
> It's still possible to screw up using a union, but it's slightly harder
> than screwing up using a void pointer. And I do not think we need the
> run-time flexibility offered by the void pointer in this case.

No we do not need the void pointer flexibility. But that means every new
source would need to add to this union. Junio complained about that fact
when I first added the extra members directly to the struct. A union
does not waste that much space and we get some seperation using the
union members. Since this struct is local only I think that should be
ok.

> > +static int config_file_fgetc(struct config_source *conf)
> > +{
> > +	FILE *f = conf->data;
> > +	return fgetc(f);
> > +}
> 
> This could become just:
> 
>   return fgetc(conf->u.f);
> 
> and so forth (might it make sense to give "f" a more descriptive name,
> as we are adding other sources?).

Will change that.

Cheers Heiko
