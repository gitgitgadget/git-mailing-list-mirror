From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] config: add support for http.<url>.* settings
Date: Mon, 15 Jul 2013 01:06:54 -0400
Message-ID: <20130715050654.GB21127@sigill.intra.peff.net>
References: <9e7edfbc83a7284615af4ca0de39c1b@f74d39fa044aa309eaea14b9f57fe79>
 <7voba8pu6r.fsf@alter.siamese.dyndns.org>
 <455666C5-7663-4361-BF34-378D3EAE2891@gmail.com>
 <7vsizjn390.fsf@alter.siamese.dyndns.org>
 <7v4nbyic57.fsf@alter.siamese.dyndns.org>
 <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 07:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyb01-00023O-Ls
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 07:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab3GOFG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 01:06:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:35950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab3GOFG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 01:06:57 -0400
Received: (qmail 22733 invoked by uid 102); 15 Jul 2013 05:08:17 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Jul 2013 00:08:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jul 2013 01:06:54 -0400
Content-Disposition: inline
In-Reply-To: <47B58075-3FDD-48E5-9047-8650F7FC5E3B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230418>

On Sat, Jul 13, 2013 at 12:46:17PM -0700, Kyle J. McKay wrote:

> I expect it will be easier just to normalize the URL without
> splitting.  That is, lowercase the parts that are case-insensitive
> (scheme and host name) and adjust the URL-escaping to remove URL
> escaping (%xx) from characters that don't need it but add it to any
> for which it is required that are not escaped (according to RFC
> 1738).

I think you are suggesting doing better than this, but just to be clear,
we cannot treat the URL as a simple string and just decode and
re-encode.

One of the things that gets encoded are the delimiting characters. So if
I have the URL:

  https://foo%3abar@example.com

you would "canonicalize" it into:

  https://foo:bar@example.com

But those are two different URLs entirely; the first has the username
"foo:bar", and the second has the username "foo" and the password "bar".

I admit that these are unlikely to come up in practice, but I am worried
that there is some room for mischief here. For example:

  https://example.com%2ftricky.host/repo.git

If we canonicalize that into:

  https://example.com/tricky.host/repo.git

and do a lookup, we think we are hitting example.com, but we are
actually hitting example.comtricky.host (i.e., that is how curl will
interpret it).  If we were deciding to use a stored credential based on
that information, it would be quite bad (we would leak credentials to
the owner of comtricky.host). I know your patch does not impact the
credential lookup behavior, but it would be nice in the long run if the
two lookups followed the same rules.

So I think the three options are basically:

  1. No decoding, require the user to use a consistent prefix between
     config and other uses of the URL. I.e., your current patch. The
     downside is that it doesn't handle any variation of input.

  2. Full decoding into constituent parts. This handles canonicalization
     of encoding, and also allows "wildcard" components (e.g., a URL
     with username can match the generic "https://example.com" in the
     config). The downside is that you cannot do a "longest prefix wins"
     rule for overriding.

  3. Full decoding as in (2), but then re-assemble into a canonicalized
     encoded URL. The upside is that you get to do "longest prefix
     wins", but you can no longer have wildcard components. I think this
     is what you are suggesting in your mail.

I'm still in favor of (2), because I think the wildcard components are
important (and while I agree that the "longest prefix wins" is nicer, we
already have "last one wins" for the rest of the config, including the
credential URL matcher). But I certainly think (3) is better than (1).

-Peff
