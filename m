From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 10/21] pack-bitmap: add support for bitmap indexes
Date: Sun, 24 Nov 2013 22:36:55 +0100
Message-ID: <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
	<20131114124432.GJ10757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Vicent =?utf-8?Q?Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 24 22:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkhN9-00019x-VX
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 22:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab3KXVhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 16:37:39 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:54391 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab3KXVhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 16:37:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 3E3284D65C8;
	Sun, 24 Nov 2013 22:37:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vhOPvGMw_wN8; Sun, 24 Nov 2013 22:37:26 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [89.204.135.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E877A4D658E;
	Sun, 24 Nov 2013 22:37:21 +0100 (CET)
In-Reply-To: <20131114124432.GJ10757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 07:44:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238268>

Jeff King <peff@peff.net> writes:

>  khash.h       | 338 ++++++++++++++++++++
[...]
> diff --git a/khash.h b/khash.h
> new file mode 100644
> index 0000000..57ff603
> --- /dev/null
> +++ b/khash.h
> @@ -0,0 +1,338 @@
> +/* The MIT License
> +
> +   Copyright (c) 2008, 2009, 2011 by Attractive Chaos <attractor@live.co.uk>
> +
> +   Permission is hereby granted, free of charge, to any person obtaining
> +   a copy of this software and associated documentation files (the
> +   "Software"), to deal in the Software without restriction, including
> +   without limitation the rights to use, copy, modify, merge, publish,
> +   distribute, sublicense, and/or sell copies of the Software, and to
> +   permit persons to whom the Software is furnished to do so, subject to
> +   the following conditions:
> +
> +   The above copyright notice and this permission notice shall be
> +   included in all copies or substantial portions of the Software.
> +
> +   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> +   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> +   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> +   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> +   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> +   SOFTWARE.
> +*/
> +
> +#ifndef __AC_KHASH_H
> +#define __AC_KHASH_H
[...]
> +static inline khint_t __kh_oid_hash(const unsigned char *oid)
> +{
> +	khint_t hash;
> +	memcpy(&hash, oid, sizeof(hash));
> +	return hash;
> +}
> +
> +#define __kh_oid_cmp(a, b) (hashcmp(a, b) == 0)
> +
> +KHASH_INIT(sha1, const unsigned char *, void *, 1, __kh_oid_hash, __kh_oid_cmp)
> +typedef kh_sha1_t khash_sha1;
> +
> +KHASH_INIT(sha1_pos, const unsigned char *, int, 1, __kh_oid_hash, __kh_oid_cmp)
> +typedef kh_sha1_pos_t khash_sha1_pos;
> +
> +#endif /* __AC_KHASH_H */

AFAICS, the part after the [...] are additions specific to git.  Is that
right?

Can we store them in a separate khash-sha1.h or some such, to make it
clearer what's what?  As things stand, one has to look for an identifier
that is built from macros at the far end of a file that looks like it
was imported verbatim from klib(?).  I don't know about you, but that
just took me far too long to get right.

I think I'll also lend you a hand writing Documentation/technical/api-khash.txt
(expect it tomorrow) so that we also have documentation in the git
style, where gitters can be expected to find it on their own.

All that could then nicely fit into a commit that actually says where
you conjured khash.h from and such.  This information seems
conspicuously absent from this commit's message :-)

Furthermore, would it be a problem to name the second hash sha1_int
instead?  I have another use for such a hash, and I can't imagine I'm
the only one.  (That's not critical however, I can do the required
editing in that other series.)

-- 
Thomas Rast
tr@thomasrast.ch
