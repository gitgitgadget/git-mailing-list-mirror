From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fast-import possible memory corruption problem
Date: Sat, 13 Dec 2008 19:42:13 -0800
Message-ID: <7vd4fv4e3u.fsf@gitster.siamese.dyndns.org>
References: <20081214020822.GB4121@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: YONETANI Tomokazu <qhwt+git@les.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 14 04:43:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBhtN-0002uM-4V
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 04:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYLNDmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 22:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbYLNDmV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 22:42:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYLNDmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 22:42:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3480B1A402;
	Sat, 13 Dec 2008 22:42:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D0971A401; Sat,
 13 Dec 2008 22:42:15 -0500 (EST)
In-Reply-To: <20081214020822.GB4121@les.ath.cx> (YONETANI Tomokazu's message
 of "Sun, 14 Dec 2008 11:08:22 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 354352BE-C991-11DD-B90C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103047>

YONETANI Tomokazu <qhwt+git@les.ath.cx> writes:

> While trying to convert NetBSD CVS repository to Git, I've been
> experiencing 100% reproducible crash of git-fast-import.  After
> poking here and there and I noticed a dubious code fragment in
> pool_alloc():
> 	:
>
>         r = p->next_free;
>         /* round out to a 'uintmax_t' alignment */
>         if (len & (sizeof(uintmax_t) - 1))
>                 len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
>         p->next_free += len;
>         return r;
>
> As the `round out' takes place AFTER it found the room in the mem_pool,
> there's a small chance of p->next_free being set outside of the chosen
> area, up to (sizeof(uintmax_t) - 1) bytes.  pool_strdup() is one of the
> functions which can trigger the problem, when pool_alloc() finds a room
> at the end of a pool entry and the requested length is not multiple of
> size(uintmax_t).  I believe attached patch addresses this problem.

Thanks -- do you mean your reproducible crash does not reproduce with the
patch anymore?

I think your change to move the "round up" logic up in the codepath makes
perfect sense.  But your patch seems to conflate totally unrelated change
to move memzero from the caller to callee into it, and I do not see the
reason why it should be that way.  If the caller asked 10 bytes to calloc
from the pool, and the underlying pool allocator gives you a 16-byte
block, you only have to guarantee that the first 10 bytes are cleared, and
can leave the trailing padding 6 bytes at the end untouched.
