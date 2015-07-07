From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Tue, 7 Jul 2015 17:13:04 -0400
Message-ID: <20150707211304.GA16683@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165501.GB23503@peff.net>
 <xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
 <20150707204837.GA15483@peff.net>
 <xmqq4mlf3cgf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:13:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCaAz-0004Hc-W2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962AbbGGVNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:13:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:57134 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757931AbbGGVNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 17:13:08 -0400
Received: (qmail 12070 invoked by uid 102); 7 Jul 2015 21:13:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 16:13:07 -0500
Received: (qmail 13620 invoked by uid 107); 7 Jul 2015 21:13:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jul 2015 17:13:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jul 2015 17:13:04 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mlf3cgf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273602>

On Tue, Jul 07, 2015 at 02:05:52PM -0700, Junio C Hamano wrote:

> And that is because DATE_NORMAL is defined to be 0; we can claim
> that the compiler is being stupid to take one of the enum
> date_mode_type values that happens to be 0 and misinterpret it as
> the program wanted to pass a NULL pointer to a structure, but that
> is not what happened.

Ah, I didn't think the compiler would coerce an enum into a pointer
constant. That seems kind of insane. But it is indeed what gcc does.

In that case, we can indeed do the NULL-pointer thing I mentioned. Which
is not even _that_ ugly; it follows the standard.

The "cast DATE_RELATIVE to a pointer and uncast it on the other side"
thing _does_ violate the standard. It is not needed for this, but it
would make the DATE_MODE() macro reentrant.

> > +	static const struct fallback_mode = { DATE_NORMAL };
> 
> Yes, that is nasty.  Renumbering the enum to begin with 1 may be a
> much saner solution, unless somebody does

I am worried more about somebody who does memset(0) on a struct, and
expects that to default to DATE_NORMAL.

> In any case, I did another evil merge to fix it.

OK. Do you want to leave it be, then, or would you prefer me to do the
NULL fallback? Or we could bump the enum to start with 1, and then
explicitly treat "0" as a synonym for DATE_NORMAL (in case it comes in
through a memset or similar).

-Peff
