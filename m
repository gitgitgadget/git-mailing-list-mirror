From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fast-import possible memory corruption problem
Date: Sat, 13 Dec 2008 21:53:55 -0800
Message-ID: <7vskor2tfw.fsf@gitster.siamese.dyndns.org>
References: <20081214020822.GB4121@les.ath.cx>
 <7vd4fv4e3u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: YONETANI Tomokazu <qhwt+git@les.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 14 06:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBjwy-0004L5-3c
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 06:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbYLNFyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 00:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbYLNFyE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 00:54:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbYLNFyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 00:54:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DFA287960;
	Sun, 14 Dec 2008 00:54:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2FC168795B; Sun,
 14 Dec 2008 00:53:57 -0500 (EST)
In-Reply-To: <7vd4fv4e3u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 13 Dec 2008 19:42:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B3493A0-C9A3-11DD-B315-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103050>

Junio C Hamano <gitster@pobox.com> writes:

>> As the `round out' takes place AFTER it found the room in the mem_pool,
>> there's a small chance of p->next_free being set outside of the chosen
>> area, up to (sizeof(uintmax_t) - 1) bytes.  pool_strdup() is one of the
>> functions which can trigger the problem, when pool_alloc() finds a room
>> at the end of a pool entry and the requested length is not multiple of
>> size(uintmax_t).  I believe attached patch addresses this problem.
>
> Thanks -- do you mean your reproducible crash does not reproduce with the
> patch anymore?
>
> I think your change to move the "round up" logic up in the codepath makes
> perfect sense.  But your patch seems to conflate totally unrelated change
> to move memzero from the caller to callee into it, and I do not see the
> reason why it should be that way.  If the caller asked 10 bytes to calloc
> from the pool, and the underlying pool allocator gives you a 16-byte
> block, you only have to guarantee that the first 10 bytes are cleared, and
> can leave the trailing padding 6 bytes at the end untouched.

That is, something like this...

 fast-import.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git c/fast-import.c w/fast-import.c
index 3c035a5..3276d5d 100644
--- c/fast-import.c
+++ w/fast-import.c
@@ -554,6 +554,10 @@ static void *pool_alloc(size_t len)
 	struct mem_pool *p;
 	void *r;
 
+	/* round up to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
 	for (p = mem_pool; p; p = p->next_pool)
 		if ((p->end - p->next_free >= len))
 			break;
@@ -572,9 +576,6 @@ static void *pool_alloc(size_t len)
 	}
 
 	r = p->next_free;
-	/* round out to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 	p->next_free += len;
 	return r;
 }
