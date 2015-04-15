From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Wed, 15 Apr 2015 18:18:24 -0400
Message-ID: <20150415221824.GB27566@peff.net>
References: <552E9816.6040502@gmail.com>
 <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 00:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiVdg-0008HI-W8
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 00:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777AbbDOWS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 18:18:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:45959 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756776AbbDOWS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 18:18:26 -0400
Received: (qmail 27693 invoked by uid 102); 15 Apr 2015 22:18:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Apr 2015 17:18:26 -0500
Received: (qmail 19586 invoked by uid 107); 15 Apr 2015 22:18:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Apr 2015 18:18:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2015 18:18:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267243>

On Wed, Apr 15, 2015 at 01:21:15PM -0700, Junio C Hamano wrote:

> > -		type[i++] = c;
> > -		if (i >= sizeof(type))
> > -			return -1;
> > +		strbuf_addch(&typename, c);
> >  	}
> > -	type[i] = 0;
> 
> This _might_ have some performance impact in that strbuf_addch()
> involves strbuf_grow(*, 1), which does "does it overflow to
> increment sb->len by one?"; I would say it should be unmeasurable
> because the function is expected to be used only on loose objects
> and you shouldn't have very many of them without packing in your
> repository in the first place.
> 
> I guess Peff's c1822d4f (strbuf: add an optimized 1-character
> strbuf_grow, 2015-04-04) may want to teach strbuf_addch() to use his
> new strbuf_grow_ch(), and once that happens the performance worry
> would disappear without this code to be changed at all.

I haven't re-rolled that series yet, but the discussion there showed
that strbuf_grow_ch() is unnecessary; call-sites can just check:

  if (!strbuf_avail(sb))
	strbuf_grow(sb, 1);

to get the fast inline check. Since we go to the trouble to inline
strbuf_addch, we should probably teach it the same trick. It would be
nice to identify a place with a tight strbuf_addch() loop that could
demonstrate the speed increase, though.

-Peff
