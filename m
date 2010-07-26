From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 17:57:48 +0000
Message-ID: <AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com>
References: <201007231518.31071.trast@student.ethz.ch>
	<20100726154041.GA18762@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	jstpierre@mecheye.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:58:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRw6-0007px-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0GZR5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 13:57:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab0GZR5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:57:49 -0400
Received: by gyg10 with SMTP id 10so926142gyg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=t6yZIgrhmGkXgUS8f0EYwJVWAA/cOM/l6V0y0h3tT4s=;
        b=ehKuKOU2LbtBWACc1R5/NijHhNSP8/74skrgJflSpw+82OXmJc73ZDQ6aTpLAFx/9v
         t3kFjQyYnd92VS5Wi0mJN1SCDStOl5CwyN5ud4gwqxz57YIyQrqg1xCwB+A00mdVh4jC
         weXpBjSSGJNWEdRRmOahJG3NZmPdj9YZwRZWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=upOS8kfMFF/gUgg67cGGrIm2FIuIgKcTBTDnhUe/NEXyki4l2u5UkZED3TiQ7fJ1x3
         9O/OsLMTu+59MHR8jSsUxxVGOuZVhTYEco0xL6TTL0pcHdvAau/rUM2Z7CBiW/ht5uy5
         AHOrlgxxskEig/ydLtySSBla4CaJ2b2qPMJ3Q=
Received: by 10.101.144.11 with SMTP id w11mr8193103ann.236.1280167068424; 
	Mon, 26 Jul 2010 10:57:48 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 10:57:48 -0700 (PDT)
In-Reply-To: <20100726154041.GA18762@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151865>

On Mon, Jul 26, 2010 at 15:40, Jeff King <peff@peff.net> wrote:

> As Jasper noted, "+" is a reserved character, which means "gtk+"
> probably _should_ be escaped. But clearly it doesn't happen in practice,
> and I am more interested in not breaking current use than in nitpicking
> with a standard.

Reserved characters only have to be escaped in certain contexts, from
RFC 2396:

   Many URI include components consisting of or delimited by, certain
   special characters.  These characters are called "reserved", since
   their usage within the URI component is limited to their reserved
   purpose.  If the data for a URI component would conflict with the
   reserved purpose, then the conflicting data must be escaped before
   forming the URI.

      reserved    = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
                    "$" | ","

E.g. @ is special in the hostname part (http://user@example.org), but
writing http://example.org/Git@Big%20companies:%20A%20Study is just
fine.

Which is why curl passes it along literally, it *can* escape them, and
real webservers like Apache handle reserved characters equivalently
(in their unreserved contexts) whether they're escaped or not, but the
git-daemon at git.gnome.org evidently doesn't implement RFC 2396
carefully enough.

So we shouldn't escape + for backwards compatibility and because it's
not necessary, but we should probably also fix git-daemon to accept
both forms if that hasn't been done already.
