From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 14:59:12 -0800
Message-ID: <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com>
References: <20131218171446.GA19657@kitenet.net>
	<xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
	<20131218191702.GA9083@sigill.intra.peff.net>
	<xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
	<20131218212847.GA13685@sigill.intra.peff.net>
	<xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
	<20131218214001.GA14354@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 23:59:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtQ5K-00051u-9C
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 23:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab3LRW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 17:59:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab3LRW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 17:59:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B26885C38D;
	Wed, 18 Dec 2013 17:59:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xC+cHSguuPjIitiUzEvO4QBxKhU=; b=iMbJ9p
	+t9NSKY2JiWUCFOV9FiTC2dRrztaNQyk32QYG27FN1w8Lu3As1YW+H/mhuCqNvb+
	tY19qCW/MrZcQ/cAlGyunKL5PEr26Q6xm7S1t8a3pK3XOca/8hWTENXVUFzKaUe9
	UL74+oX2P9BWPpmCz4BWYSLneSq96sJYACZrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URuOMWzxCUuU4W8x+cxXZWwXxLKdGNhv
	OmMGSpaIDcVNtLjPrfmHANYUi7DrWu5luHnWClhm5CVTu0QiVehgEr47ChVJaUGb
	VS0j/uJe/a8sY+35celT50dMSrOPjxzq2tXVCJOT+gVLTns9+Qf6TQ8RdaaSfxjr
	1B1MGUigYwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0CE95C38C;
	Wed, 18 Dec 2013 17:59:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBC3E5C38B;
	Wed, 18 Dec 2013 17:59:15 -0500 (EST)
In-Reply-To: <20131218214001.GA14354@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Dec 2013 16:40:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 04C082EC-6838-11E3-8624-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239498>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 18, 2013 at 01:37:24PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > According to the POSIX quote above, it sounds like we could do:
>> >
>> >   #if defined (_SC_OPEN_MAX)
>> >   {
>> >           long max;
>> >           errno = 0;
>> >           max = sysconf(_SC_OPEN_MAX);
>> >           if (0 < max) /* got the limit */
>> >                   return max;
>> >           else if (!errno) /* unlimited, cast to int-max */
>> >                   return max;
>> >           /* otherwise, fall through */
>> >   }
>> >   #endif
>> >
>> > Obviously you could collapse the two branches of the conditional, though
>> > I think it deserves at least a comment to explain what is going on.
>> 
>> Yes, that is locally OK, but depending on how the caller behaves, we
>> might need to have an extra saved_errno dance here, which I didn't
>> want to get into...
>
> I think we are fine. The only caller is about to clobber errno by
> closing packs anyway.
>
> -Peff

OK.

-- >8 --
Subject: [PATCH] get_max_fd_limit(): fall back to OPEN_MAX upon getrlimit/sysconf failure

On broken systems where RLIMIT_NOFILE is visible by the compliers
but underlying getrlimit() system call does not behave, we used to
simply die() when we are trying to decide how many file descriptors
to allocate for keeping packfiles open.  Instead, allow the fallback
codepath to take over when we get such a failure from getrlimit().

The same issue exists with _SC_OPEN_MAX and sysconf(); restructure
the code in a similar way to prepare for a broken sysconf() as well.

Noticed-by: Joey Hess <joey@kitenet.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 760dd60..288badd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -807,15 +807,38 @@ void free_pack_by_name(const char *pack_name)
 static unsigned int get_max_fd_limit(void)
 {
 #ifdef RLIMIT_NOFILE
-	struct rlimit lim;
+	{
+		struct rlimit lim;
 
-	if (getrlimit(RLIMIT_NOFILE, &lim))
-		die_errno("cannot get RLIMIT_NOFILE");
+		if (!getrlimit(RLIMIT_NOFILE, &lim))
+			return lim.rlim_cur;
+	}
+#endif
+
+#ifdef _SC_OPEN_MAX
+	{
+		long open_max = sysconf(_SC_OPEN_MAX);
+		if (0 < open_max)
+			return open_max;
+		/*
+		 * Otherwise, we got -1 for one of the two
+		 * reasons:
+		 *
+		 * (1) sysconf() did not understand _SC_OPEN_MAX
+		 *     and signaled an error with -1; or
+		 * (2) sysconf() said there is no limit.
+		 *
+		 * We _could_ clear errno before calling sysconf() to
+		 * tell these two cases apart and return a huge number
+		 * in the latter case to let the caller cap it to a
+		 * value that is not so selfish, but letting the
+		 * fallback OPEN_MAX codepath take care of these cases
+		 * is a lot simpler.
+		 */
+	}
+#endif
 
-	return lim.rlim_cur;
-#elif defined(_SC_OPEN_MAX)
-	return sysconf(_SC_OPEN_MAX);
-#elif defined(OPEN_MAX)
+#ifdef OPEN_MAX
 	return OPEN_MAX;
 #else
 	return 1; /* see the caller ;-) */
-- 
1.8.5.2-297-g3e57c29
