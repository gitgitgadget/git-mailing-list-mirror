From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 19:01:39 -0400
Message-ID: <20140317230139.GB19578@sigill.intra.peff.net>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
 <1395093144-6786-2-git-send-email-quintus.public@gmail.com>
 <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:01:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPgXS-00062U-EV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbaCQXBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 19:01:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:41451 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751854AbaCQXBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:01:41 -0400
Received: (qmail 3300 invoked by uid 102); 17 Mar 2014 23:01:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Mar 2014 18:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Mar 2014 19:01:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob14a14s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244307>

On Mon, Mar 17, 2014 at 03:52:51PM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index 3e1d5c3..4135980 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -193,7 +193,7 @@ static int verify_format(const char *format)
> >  		at = parse_atom(sp + 2, ep);
> >  		cp = ep + 1;
> >  
> > -		if (!memcmp(used_atom[at], "color:", 6))
> > +		if (starts_with(used_atom[at], "color:"))
> >  			need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);
> >  	}
> >  	return 0;
> 
> Good.

Actually, I found this one confusing. We are looking for "color:", but
if we find it, we _don't_ skip past and look at what comes after.
Instead, we compare the whole string. Which works because color_reset
actually contains "color:reset", and we end up just re-comparing the
first bit of the string. So the memcmp here is redundant, and this can
simply become:

  need_color_reset_at_eol = !!strcmp(used_atom[at], color_reset);

Or am I missing something?

-Peff
