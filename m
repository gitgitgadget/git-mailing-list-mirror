From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 15:34:51 -0500
Message-ID: <20160215203451.GA29705@sigill.intra.peff.net>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
 <1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
 <CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
 <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:34:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPrG-0003Tn-DN
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbcBOUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:34:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:42360 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751472AbcBOUey (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:34:54 -0500
Received: (qmail 31189 invoked by uid 102); 15 Feb 2016 20:34:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 15:34:54 -0500
Received: (qmail 11009 invoked by uid 107); 15 Feb 2016 20:34:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 15:34:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 15:34:51 -0500
Content-Disposition: inline
In-Reply-To: <20160215202937.GA57185@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286234>

On Mon, Feb 15, 2016 at 08:29:37PM +0000, brian m. carlson wrote:

> > Rather than sprinkling curl_empty_auth special cases here and there,
> > would it be possible to simply set http_auth.username and
> > http_auth.password to empty strings early on if they are not already
> > set and curl_empty_auth is true, and then let the:
> > 
> >     strbuf_addf(&up, "%s:%s",
> >         http_auth.username, http_auth.password);
> > 
> > in init_curl_http_auth() handle them in the normal fashion, with the
> > end result being the same ":" set explicitly by this patch?
> 
> That would work.  I was concerned about the credential_fill call
> actually prompting the user, but it appears that it doesn't do that if
> the password already exists.  I don't know if we want to rely on that
> functionality, though.

Yeah, credential_fill() will treat that as a noop, as it is no different
than getting "https://user:pass@example.com" in the URL in the first
place. But it will _also_ send the result to credential_approve() and
credential_reject(), which you probably don't want (because you do not
want to store these useless dummy credentials in your keystore).

So I think this hack should remain purely at the curl level, and never
touch the credential struct at all.

Which is a shame, because I think Eric's suggestion is otherwise much
more readable. :)

-Peff
