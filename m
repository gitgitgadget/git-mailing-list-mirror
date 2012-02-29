From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] grep: use static trans-case table
Date: Wed, 29 Feb 2012 03:28:14 -0500
Message-ID: <20120229082814.GB14181@sigill.intra.peff.net>
References: <1330474831-9030-1-git-send-email-gitster@pobox.com>
 <1330474831-9030-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2eta-0001Kc-Rf
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab2B2I2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 03:28:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab2B2I2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:28:17 -0500
Received: (qmail 20284 invoked by uid 107); 29 Feb 2012 08:28:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 03:28:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 03:28:14 -0500
Content-Disposition: inline
In-Reply-To: <1330474831-9030-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191818>

On Tue, Feb 28, 2012 at 04:20:30PM -0800, Junio C Hamano wrote:

> In order to prepare the kwset machinery for a case-insensitive search=
, we
> used to use a static table of 256 elements and filled it every time b=
efore
> calling kwsalloc().  Because the kwset machinery will never modify th=
is
> table, just allocate a single instance globally and fill it at the co=
mpile
> time.

Hmm. I was going to complain that the original code used tolower() to
generate the table at run-time, and therefore respected the current
locale. But of course we have replaced tolower() with a
locale-independent version, so it should behave identically.

But that does make me wonder. Do people expect their case-insensitive
searches to work on non-ASCII characters? I would think yes, but I do
not use non-ASCII characters in the first place, so my opinion may not
mean much.

=46or that matter, does REG_ICASE respect locales? The glibc code appea=
rs
to consider it, but I couldn't make it work in some simple tests. But i=
f
it does, that raises another weirdness: we fall back to kwset
transparently when a grep pattern contains no metacharacters. So you
would get different results for "-i --grep=3D=C3=A9" versus "-i --grep=3D=
=C3=A9.*".

Of course, even if we used a locale-respecting version of tolower in th=
e
original code, I suspect that a byte table would be fundamentally
insufficient, anyway, in the face of multi-byte encodings like utf8.

So I don't think your patch is making the problem any worse. And even i=
f
somebody wants to tackle the problem later, the solution would look so
unlike the original code that your change is not hurting their effort.

-Peff
