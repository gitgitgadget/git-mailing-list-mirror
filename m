From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2011, #03; Sun, 13)
Date: Mon, 14 Nov 2011 06:10:40 -0500
Message-ID: <20111114111040.GB10847@sigill.intra.peff.net>
References: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPuR5-0003HB-Ro
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab1KNLKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 06:10:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40993
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab1KNLKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:10:43 -0500
Received: (qmail 28115 invoked by uid 107); 14 Nov 2011 11:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 06:10:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 06:10:40 -0500
Content-Disposition: inline
In-Reply-To: <7vmxbzl5ch.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185376>

On Sun, Nov 13, 2011 at 08:01:50PM -0800, Junio C Hamano wrote:

> * jc/lookup-object-hash (2011-08-11) 6 commits
>  - object hash: replace linear probing with 4-way cuckoo hashing
>  - object hash: we know the table size is a power of two
>  - object hash: next_size() helper for readability
>  - pack-objects --count-only
>  - object.c: remove duplicated code for object hashing
>  - object.c: code movement for readability
> 
> I do not think there is anything fundamentally wrong with this series, but
> the risk of breakage far outweighs observed performance gain in one
> particular workload.

FWIW, I finally got a chance to read through this series. It was fun, as
I had not looked at cuckoo hashing before. However, the performance
results were a bit underwhelming, and the code is more complex, which
left me a bit negative. I also took a quick try at quadratic probing,
which is only a few extra lines of code.  I wasn't able to show any real
performance improvement, though.

I suspect it is because our hash table is not all that big, and we keep
it pretty sparse, so linear probing does well. Googling around, it seems
that linear probing performs well up to about 70% load factor, but
there's surprisingly little theory behind it.

I notice that the decorate.c hash keeps us below 2/3 full, but the
object.c hash keeps us at 1/2. From my reading, that's just wasting
space. Pushing the boundary up to 2/3 and trying your "--count-objects"
on git.git, I don't see a big performance difference (with my change,
the best-of-5 was a little better, but well within the noise). It does
drop the maxresident by a few percent.

So I don't think it's a big deal either way, but the code change is
pretty trivial.

-Peff
