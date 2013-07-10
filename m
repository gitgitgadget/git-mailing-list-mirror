From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for
 status_printf
Date: Wed, 10 Jul 2013 02:11:15 -0400
Message-ID: <20130710061115.GA11741@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
 <20130710002328.GC19423@sigill.intra.peff.net>
 <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
 <20130710052859.GA5339@sigill.intra.peff.net>
 <7vip0jt1sy.fsf@alter.siamese.dyndns.org>
 <20130710054050.GA7206@sigill.intra.peff.net>
 <7vehb7t0zs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 08:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwncd-0000ya-1o
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 08:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab3GJGLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 02:11:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:45576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab3GJGLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 02:11:19 -0400
Received: (qmail 9969 invoked by uid 102); 10 Jul 2013 06:12:35 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 01:12:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 02:11:15 -0400
Content-Disposition: inline
In-Reply-To: <7vehb7t0zs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230028>

On Tue, Jul 09, 2013 at 10:52:55PM -0700, Junio C Hamano wrote:

> > The patch to do it is below, but I actually think an explicit blank-line
> > function like:
> >
> >   status_print_empty_line(s, color);
> >
> > would be more obvious to a reader.
> 
> I noticed that all but one can be dealt with with
> 
>     perl -p -i -e 's/status_printf_ln\((.*), ""\);/status_printf($1, "\\n");/'
> 
> That is,
> 
> -	status_printf_ln(s, GIT_COLOR_NORMAL, "");
> +	status_printf(s, GIT_COLOR_NORMAL, "\n");
> 
> which does not look _too_ bad.

Is that correct, though? The reason we have *_printf_ln in the
first place is that we want to do:

  ${color}content${reset}\n

to make sure that the newline does not happen inside the colorization.
At least that is why I added color_printf_ln long ago.

It would probably improve the code quite a bit if we could simply feed
multi-line strings to status_printf, and have it stick the colorization
in the correct spot of each line. And hmm...it kind of looks like
status_vprintf already does that. Now I'm puzzled why many of these do
not simply include the newline along with the string being printed.

> There is one instance that needs this, though.
> 
> -		status_printf(s, color(WT_STATUS_HEADER, s), "");
> +		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");

Hmm, yeah. It cannot be combined with the lines following it, either,
because they are using different colorization.

If you want to keep refactoring this, I don't mind, but I kind of feel
like we are going down a rabbit hole for very little gain.

-Peff
