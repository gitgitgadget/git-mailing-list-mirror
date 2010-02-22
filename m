From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable OpenSSL SHA1 implementation by default
Date: Mon, 22 Feb 2010 06:23:26 -0500
Message-ID: <20100222112326.GA21929@coredump.intra.peff.net>
References: <20100222110814.GA3247@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Robert Shearman <robertshearman@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 13:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjWNx-0007lq-4Q
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 12:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab0BVLX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2010 06:23:28 -0500
Received: from peff.net ([208.65.91.99]:49374 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab0BVLX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 06:23:27 -0500
Received: (qmail 26184 invoked by uid 107); 22 Feb 2010 11:23:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 06:23:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 06:23:26 -0500
Content-Disposition: inline
In-Reply-To: <20100222110814.GA3247@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140672>

On Mon, Feb 22, 2010 at 05:08:14AM -0600, Jonathan Nieder wrote:

> The OpenSSL SHA-1 routine is about as fast as block-sha1, but linking
> to libcrypto slows down the startup of git commands by an appreciable
> amount.  Use the BLK_SHA1 implementation by default instead.

What is your definition of "about as fast"? I benchmarked up to a 20%
slow-down a while back:

  http://article.gmane.org/gmane.comp.version-control.git/126995

Now my complaint then was specifically about removing openssl sha1
support entirely, and I have no problem with setting OPENSSL_SHA1 in my
build options, but it does make sense to me that the default should
be whatever is fastest for most people. And that means benchmarking
blk_sha1 versus the libcrypto linking slow-down on several machines to
get actual numbers.

Unfortunately, I think we may end up with an apples-to-oranges
comparison, as sha1-heavy tasks are affected one way, and scripted
many-git-invocation tasks the other way.

> Typed =E2=80=9Cmake NO_OPENSSL=3D1=E2=80=9D for the umpteenth time to=
day, but this time
> I thought I should something about it.

echo 'NO_OPENSSL=3D1' >config.mak ?

> -ifndef NO_OPENSSL
> +ifdef OPENSSL_TLS
> +	BASIC_CFLAGS +=3D -DOPENSSL_TLS
> +	USE_OPENSSL =3D Yes
> +endif

Doesn't this flip the default for using TLS on imap-send?

-Peff
