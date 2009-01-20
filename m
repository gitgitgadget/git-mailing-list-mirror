From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename detection: Avoid repeated filespec population
Date: Tue, 20 Jan 2009 16:27:23 -0500
Message-ID: <20090120212723.GA10967@coredump.intra.peff.net>
References: <20090120155957.GA23237@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPP5Y-0000Ox-0q
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZATW11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 17:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZATW11
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:27:27 -0500
Received: from peff.net ([208.65.91.99]:49517 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbZATW10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:27:26 -0500
Received: (qmail 4572 invoked by uid 107); 20 Jan 2009 21:27:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 16:27:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 16:27:23 -0500
Content-Disposition: inline
In-Reply-To: <20090120155957.GA23237@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106534>

On Tue, Jan 20, 2009 at 04:59:57PM +0100, Bj=C3=B6rn Steinbrink wrote:

> In diffcore_rename, we assume that the blob contents in the filespec
> aren't required anymore after estimate_similarity has been called and=
 thus
> we free it. But estimate_similarity might return early when the file =
sizes
> differ too much. In that case, cnt_data is never set and the next cal=
l to
> estimate_similarity will populate the filespec again, eventually rere=
ading
> the same blob over and over again.
>=20
> To fix that, we first get the blob sizes and only when the blob conte=
nts
> are actually required, and when cnt_data will be set, the full filesp=
ec is
> populated, once.

I think this is a sane thing to do, and obviously your numbers show an
impressive improvement.

However, I found your explanation a little confusing. Yes, repeatedly
loading those blobs is a problem. But what this is really about is that
estimate_similarity has two levels of checks: cheap checks involving th=
e
size, and expensive checks involving the content. What is happening now
is that we are doing extra work for the expensive checks, even if the
cheap checks are going to let us fail early.

And that's just stupid, and a waste of processing time even if we
_don't_ ever look at the same filespec again.

But what makes it even worse is that we have a system in place to cache
the expensive work, but because we only do part of it, we don't bother
to cache the result. And that's what your patch description is about.

So I think your patch is absolutely the right thing to do. But I think
from the commit message it isn't clear that it would not be equally
correct to follow through on generating cnt_data instead of an early
return (which _isn't_ right, because you might not need to generate
cnt_data at all).

> This actually affects the copy detection way more than the pure
> rename detection, due to the larger number of candidates, but it's th=
e
> same code, and I only realized that when I reran the stuff to get som=
e
> numbers to show off. ;-)

I have a pathological real-world rename test case from a long time ago.
It's so awful on rename because almost the whole repo was reorganized,
but almost every path got its content adjusted, too. I was hoping it
would be better with your patch, but it isn't: as it turns out, it is
_too_ uniform. The cheap size checks don't work because all of the file=
s
are almost the same size (they're all jpgs from a camera).

But I think for non-pathological cases, your improvement makes sense.

-Peff
