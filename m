From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object
 of unknown type
Date: Fri, 17 Apr 2015 10:23:10 -0400
Message-ID: <20150417142310.GA12479@peff.net>
References: <552E9816.6040502@gmail.com>
 <1429117143-4882-1-git-send-email-karthik.188@gmail.com>
 <xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
 <20150415221824.GB27566@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 16:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7Av-0005gh-IE
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934382AbbDQOXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:23:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:46707 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933935AbbDQOXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 10:23:13 -0400
Received: (qmail 2782 invoked by uid 102); 17 Apr 2015 14:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 09:23:12 -0500
Received: (qmail 2364 invoked by uid 107); 17 Apr 2015 14:23:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 10:23:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 10:23:10 -0400
Content-Disposition: inline
In-Reply-To: <20150415221824.GB27566@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267356>

On Wed, Apr 15, 2015 at 06:18:24PM -0400, Jeff King wrote:

> > This _might_ have some performance impact in that strbuf_addch()
> > involves strbuf_grow(*, 1), which does "does it overflow to
> > increment sb->len by one?"; I would say it should be unmeasurable
> > because the function is expected to be used only on loose objects
> > and you shouldn't have very many of them without packing in your
> > repository in the first place.
> > 
> > I guess Peff's c1822d4f (strbuf: add an optimized 1-character
> > strbuf_grow, 2015-04-04) may want to teach strbuf_addch() to use his
> > new strbuf_grow_ch(), and once that happens the performance worry
> > would disappear without this code to be changed at all.
> 
> I haven't re-rolled that series yet, but the discussion there showed
> that strbuf_grow_ch() is unnecessary; call-sites can just check:
> 
>   if (!strbuf_avail(sb))
> 	strbuf_grow(sb, 1);
> 
> to get the fast inline check. Since we go to the trouble to inline
> strbuf_addch, we should probably teach it the same trick. It would be
> nice to identify a place with a tight strbuf_addch() loop that could
> demonstrate the speed increase, though.

Just for reference, I did teach strbuf_addch this trick. And the config
code is the tight loop to test it with. Results are here:

  http://article.gmane.org/gmane.comp.version-control.git/267266

In this code path, we are typically only seeing short strings (the
original code used a 10-byte static buffer). So I doubt it makes all
that much difference.

If there _is_ a performance implication to worry about here, I think it
would be that we are doing an extra malloc/free. I'm not sure I
understand why we are copying it at all. The original code copied from
the hdr into type[10] so that we could NUL-terminate it, which was
required for type_from_string().

But now we use type_from_string_gently, which can accept a length[1]. So
we could just count the bytes to the first space and pass the original
buffer along with that length, no?

-Peff

[1] Not related to your patch, but it looks like type_from_string_gently
    is overly lax. It does a strncmp() with the length of the candidate
    name, but does not check that we consumed all of the matching name.
    So "tr" would match "tree", "comm" would match "commit", and so
    forth.
