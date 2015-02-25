From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/1] http: Add Accept-Language header if possible
Date: Wed, 25 Feb 2015 14:52:26 -0800
Message-ID: <xmqqpp8xmwnp.fsf@gitster.dls.corp.google.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershaus?= =?utf-8?Q?en?= 
	<tboegi@web.de>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQkok-0000AN-Jw
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 23:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbbBYWwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 17:52:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752617AbbBYWw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 17:52:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 66B223BB8B;
	Wed, 25 Feb 2015 17:52:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/O7L3bcgmNx03yLhbqH5QxPWx4s=; b=FyErYF
	8VkI0/Hnu7j0Y52uq9hP4/yniMqiKjQtN0AHnhf7L92p0YNhISVUmxjhQUAQaISd
	0dGlQfrK3OejXEwfQv1w1T5kUhbWJIPqRWpRxXRpq8zGwlJi6s2Xq0Tol1HxFsIy
	imt2gy9i9iqERl9mc3wPmh1uOsdxVb53kPgjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+YLOYReEvbkVRGg3NPH3mVOLnQtRjzH
	gSTCYHk8CnJR+3ucc5HH6XtDxXYfIKNpU/GrCRHje02mvyqbfYnT1KOr+qFYO7QQ
	voZWV6tzTSsQPePcPCMNp/GRTnuOvq6T5C9PS6SCEtBZMJQxXmZKPUmkUxtvzdNd
	MvFxabTA12Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59D0E3BB8A;
	Wed, 25 Feb 2015 17:52:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8F853BB88;
	Wed, 25 Feb 2015 17:52:27 -0500 (EST)
In-Reply-To: <1422446677-8415-2-git-send-email-eungjun.yi@navercorp.com> (Yi
	EungJun's message of "Wed, 28 Jan 2015 21:04:37 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8D700B4-BD40-11E4-95D1-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264421>

Yi EungJun <semtlenori@gmail.com> writes:

> From: Yi EungJun <eungjun.yi@navercorp.com>
>
> Add an Accept-Language header which indicates the user's preferred
> languages defined by $LANGUAGE, $LC_ALL, $LC_MESSAGES and $LANG.
> ...
> Signed-off-by: Yi EungJun <eungjun.yi@navercorp.com>
> ---

Yikes.

This is now in 'master', but I wonder if people are getting
compilation errors because of this change.  I do.

It introduces a call to setlocale() without causing <locale.h> to be
included, and runs afoul of -Wimplicit-function-declaration.

Other call sites of setlocale() are in gettext.c, which does include
the header at the beginning.

> diff --git a/http.c b/http.c
> index 040f362..b2ad2a8 100644
> --- a/http.c
> +++ b/http.c
> ...
> +#ifndef NO_GETTEXT
> +	retval = setlocale(LC_MESSAGES, NULL);
> +	if (retval && *retval &&
> +		strcmp(retval, "C") &&
> +		strcmp(retval, "POSIX"))
> +		return retval;
> +#endif

I really do not like a conditional inclusion of system header files
inside any *.c file, but here is a minimum emergency fix-up I am
running with today.  It should go to somewhere in git-compat-util.h.

Somebody care to throw a tested fix-up patch at me?

Thanks.

 http.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.c b/http.c
index efdab09..7e79cbd 100644
--- a/http.c
+++ b/http.c
@@ -9,6 +9,10 @@
 #include "version.h"
 #include "pkt-line.h"
 
+#ifndef NO_GETTEXT
+#include <locale.h>
+#endif
+
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
