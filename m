From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Mon, 15 Feb 2010 18:39:48 -0800
Message-ID: <7vljetlx8r.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhDMH-00072q-Kr
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab0BPCkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:40:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab0BPCj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:39:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F6529A575;
	Mon, 15 Feb 2010 21:39:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IyXdC8teEXrYo+OLiSbJ8u8ryFc=; b=DjMy4/
	8Eq3TFicSOAKoS/MI1+OUmsSmKBEU7Vpk/v4GTYUWvBcTyTgp8OTJnZNUAT9lk4J
	hS4NTL3CHycVQndZyhwh+Bp0oycXZqZMKfn9H6fy4jJG3o/91PePtzjquCPP64WU
	Apxdr6IJMzueOF3M9WSdfh3YDQ1Z26kB2SAn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LzxHKQANPqiow8TNHNlmaCJ+lN1DvLts
	GXVS+3m2kZsz0m0mTddWA393FshW2dHXM0oiP2TpTsq/ByEEgARVQoR2yu/uVdfw
	AAZD8iJgsmbja8Uv7yDPq6yzX4LATS5HzllkIthc8ChU4LyLhMJm0wGXQe7Ez4WC
	+ZNBecAN59E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD84B9A573;
	Mon, 15 Feb 2010 21:39:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC2829A56F; Mon, 15 Feb
 2010 21:39:49 -0500 (EST)
In-Reply-To: <7vocjpnc5v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Feb 2010 18\:32\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 90A4EA7C-1AA4-11DF-826B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140062>

Junio C Hamano <gitster@pobox.com> writes:

> Is this the answer to my question?

IOW, please try this patch.  I am planning to queue it to 'maint' as part
of 1.7.0.1 if this is the right solution (which I obviously think it is).

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 15 Feb 2010 18:34:28 -0800
Subject: [PATCH] Fix use of mutex in threaded grep

The program can decide at runtime not to use threading even if the
support is compiled in.  In such a case, mutexes are not necessary
and left uninitialized.  But the code incorrectly tried to take and
release the read_sha1_mutex unconditionally.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..5c1545e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
 
 #define grep_lock() pthread_mutex_lock(&grep_mutex)
 #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
-#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
-#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
+#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
+#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
 
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
-- 
1.7.0.17.g7e5eb
