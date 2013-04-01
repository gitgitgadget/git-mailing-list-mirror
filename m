From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 19:33:13 -0400
Message-ID: <20130401233313.GB30935@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 01:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMoEU-0000Bn-V9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 01:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066Ab3DAXdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 19:33:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757623Ab3DAXdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 19:33:16 -0400
Received: (qmail 3714 invoked by uid 107); 1 Apr 2013 23:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 19:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 19:33:13 -0400
Content-Disposition: inline
In-Reply-To: <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219725>

On Mon, Apr 01, 2013 at 03:46:42PM -0600, Felipe Contreras wrote:

> Otherwise transport-helper will continue checking for refs and other
> things what will confuse the user more.
> [...]
> diff --git a/transport-helper.c b/transport-helper.c
> index cb3ef7d..dfdfa7a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -460,6 +460,10 @@ static int fetch_with_import(struct transport *transport,
>  
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> +
> +	if (!check_command(data->helper))
> +		die("Error while running helper");
> +
>  	argv_array_free_detached(fastimport.argv);

Can you be more specific about what happens when we miss the death here,
what happens next, etc?

Checking asynchronously for death like this is subject to a race
condition; the helper may be about to die but not have died yet. In
practice we may catch some cases, but this seems like an indication that
the protocol is not well thought-out. Usually we would wait for a
confirmation over the read pipe from a child, and know that the child
failed when either:

  1. It tells us so on the pipe.

  2. The pipe closes (at which point we know it is time to reap the
     child).

Why doesn't that scheme work here? I am not doubting you that it does
not; the import helper protocol is a bit of a mess, and I can easily
believe it has such a problem. But I'm wondering if it's possible to
improve it in a more robust way.

-Peff
