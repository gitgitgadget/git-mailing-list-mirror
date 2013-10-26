From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 07/19] compat: add endianness helpers
Date: Sat, 26 Oct 2013 09:55:36 +0200
Message-ID: <87txg4sbyf.fsf@linux-k42r.v.cablecom.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
	<20131024180157.GG24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 09:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZyj7-0002jM-AH
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 09:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab3JZHzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 03:55:51 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50236 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab3JZHzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 03:55:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5E44D4D658B;
	Sat, 26 Oct 2013 09:55:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2WCr91ZAaX3u; Sat, 26 Oct 2013 09:55:39 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B1F114D6414;
	Sat, 26 Oct 2013 09:55:38 +0200 (CEST)
In-Reply-To: <20131024180157.GG24180@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Oct 2013 14:01:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236739>

Jeff King <peff@peff.net> writes:

> From: Vicent Marti <tanoku@gmail.com>
>
> The POSIX standard doesn't currently define a `nothll`/`htonll`

typo: ntohll

> function pair to perform network-to-host and host-to-network
> swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
> storage of EWAH bitmaps if they are not in native byte order.
[...]
> +#		include <byteswap.h>

Do we need a hack on top similar to what ntoh_l and hton_l do, for
platforms that do not support unaligned access?

---- read-cache.c:1316 ----
#ifndef NEEDS_ALIGNED_ACCESS
#define ntoh_s(var) ntohs(var)
#define ntoh_l(var) ntohl(var)
#else
static inline uint16_t ntoh_s_force_align(void *p)
{
	uint16_t x;
	memcpy(&x, p, sizeof(x));
	return ntohs(x);
}
static inline uint32_t ntoh_l_force_align(void *p)
{
	uint32_t x;
	memcpy(&x, p, sizeof(x));
	return ntohl(x);
}
#define ntoh_s(var) ntoh_s_force_align(&(var))
#define ntoh_l(var) ntoh_l_force_align(&(var))
#endif

-- 
Thomas Rast
tr@thomasrast.ch
