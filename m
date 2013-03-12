From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] config: make parsing stack struct independent
 from actual data source
Date: Tue, 12 Mar 2013 07:03:55 -0400
Message-ID: <20130312110355.GE11340@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310165940.GD1136@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 12 12:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFN0d-0000Nh-01
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 12:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab3CLLEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 07:04:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49559 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512Ab3CLLD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 07:03:58 -0400
Received: (qmail 25960 invoked by uid 107); 12 Mar 2013 11:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 07:05:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 07:03:55 -0400
Content-Disposition: inline
In-Reply-To: <20130310165940.GD1136@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217946>

On Sun, Mar 10, 2013 at 05:59:40PM +0100, Heiko Voigt wrote:

> diff --git a/config.c b/config.c
> index f55c43d..fe1c0e5 100644
> --- a/config.c
> +++ b/config.c
> @@ -10,20 +10,42 @@
>  #include "strbuf.h"
>  #include "quote.h"
>  
> -typedef struct config_file {
> -	struct config_file *prev;
> -	FILE *f;
> +struct config_source {
> +	struct config_source *prev;
> +	void *data;

Would a union be more appropriate here? We do not ever have to pass it
directly as a parameter, since we pass the "struct config_source" to the
method functions.

It's still possible to screw up using a union, but it's slightly harder
than screwing up using a void pointer. And I do not think we need the
run-time flexibility offered by the void pointer in this case.

> +static int config_file_fgetc(struct config_source *conf)
> +{
> +	FILE *f = conf->data;
> +	return fgetc(f);
> +}

This could become just:

  return fgetc(conf->u.f);

and so forth (might it make sense to give "f" a more descriptive name,
as we are adding other sources?).

-Peff
