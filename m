From: Jeff King <peff@peff.net>
Subject: Re: Handle HTTP error 511 Network Authentication Required (standard
 secure proxy authentification/captive portal detection)
Date: Sun, 19 Feb 2012 20:06:17 -0500
Message-ID: <20120220010617.GB4140@sigill.intra.peff.net>
References: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 02:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzHhx-0006oF-4n
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 02:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2BTBGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 20:06:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43231
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab2BTBGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2012 20:06:19 -0500
Received: (qmail 28852 invoked by uid 107); 20 Feb 2012 01:06:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 19 Feb 2012 20:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Feb 2012 20:06:17 -0500
Content-Disposition: inline
In-Reply-To: <4b8f33ba4c870528a82ab85d6dad68bd.squirrel@arekh.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191035>

On Sun, Feb 19, 2012 at 10:03:37PM +0100, Nicolas Mailhot wrote:

> The IETF finally set up to fix this problem and defined a standard HT=
TP error
> that lets access control equipments tell the web client authenticatio=
n or
> re-authentication is needed and where the authentication form is loca=
ted.
>=20
> http://tools.ietf.org/id/draft-nottingham-http-new-status-04.txt
>=20
> =E2=86=92 <http://www.rfc-editor.org/queue2.html#draft-nottingham-htt=
p-new-status> (the
> spec is approved and in the queue for publication as RFC)
>=20
> Please add error 511 handling in git, so git users that try to access=
 external
> git repositories over http can authenticate on the corporate proxy

If I'm reading this right, the process works something like this:

  1. Git wants to make a request to http://example.com

  2. We make our request to a proxy server which is transparently
     proxying our traffic (i.e, a "captive portal").

  3. The proxy returns 511 along with some URL (e.g.,
     "http://login.corporatenetwork"), indicating that we need
     to go to that URL to complete some authentication.

As a non-browser client, what should git do? We can't make sense of the
content at http://login.corporatenetwork, which is most likely an HTML
form asking for credentials (or even money, if the captive portal is
something like a public wireless provider). The best we can probably do
is die and say "apparently you need to go http://login.corporatenetwork
in a browser before making your request".

Reading that rfc draft, the man impetus for non-browser clients seems
not to get them to do anything useful, but rather to return them a code
that is clearly not from the actual site (if it were a redirect, for
example, then we would think that example.com is redirecting is, which
is simply not true).

-Peff
