From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sun, 30 Mar 2008 00:39:21 -0400
Message-ID: <20080330043920.GB18603@sigill.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291039.43355.robin.rosenberg.lists@dewire.com> <20080329094322.GA21814@coredump.intra.peff.net> <200803291354.47269.robin.rosenberg.lists@dewire.com> <20080329214516.GB30851@coredump.intra.peff.net> <47EF0BC5.4040102@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 06:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfpKu-0000SW-OZ
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 06:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYC3EjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 00:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbYC3EjX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 00:39:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2441 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbYC3EjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 00:39:23 -0400
Received: (qmail 1303 invoked by uid 111); 30 Mar 2008 04:39:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 30 Mar 2008 00:39:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Mar 2008 00:39:21 -0400
Content-Disposition: inline
In-Reply-To: <47EF0BC5.4040102@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78500>

On Sun, Mar 30, 2008 at 04:40:53PM +1300, Sam Vilain wrote:

> > My point is that we don't _know_ what is happening in between the decode
> > and encode. Does that intermediate form have the information required to
> > convert back to the exact same bytes as the original form?
> No, it doesn't.  If you want that, save a copy of the string (it's a
> lazy copy anyway).

We do already save a copy. The question is that Robin is proposing
decode/encode to check for validity. It was not clear to me that such a
process would always return the exact same bytes even for valid utf-8.

But it seems like you are saying below that it is really just the
"decode" part of that which is interesting:

> utf8::decode works in-place; it is essentially checking that the string
> is valid, and if so, marking it as UTF8.
> 
>    my ($encoding);
>    if (utf8::decode($string)) {
>        if (utf8::is_utf($string)) {
>            $encoding = "UTF-8";
>        }
>        else {
>            $encoding = "US-ASCII";
>        }
>    }
>    else {
>        $encoding = "ISO8859-1"
>    }

OK, that was the magic invocation we were looking for. Thank you.

> For US-ASCII, you'll only have to encode if the string contains special
> characters (those below \037) or any "=" characters.

Ah, yeah. I think our tests are lacking in that they check for only
[^[:ascii:]].

> Anyway, I guess all this rubbish is why people use CPAN modules, so that
> they don't have to continually rediscover every single protocol quirk
> and reinvent the wheel.
> 
> ie, it would be much, much simpler to use MIME::Entity->build for all of
> this, and remove the duplication of code.

Yes, I actually made a similar comment recently. send-email could
probably be shorter, easier to read, and have fewer bugs if it used one
of the many mail-handling CPAN modules. I think it would pretty much
involve scrapping the current send-email and starting fresh, though.

Thanks for your input.

-Peff
