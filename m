From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Tue, 04 Mar 2014 00:22:15 +0100
Message-ID: <87bnxmkguw.fsf@fencepost.gnu.org>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	<xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
	<xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Siddharth Goel <siddharth98391@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:22:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcBi-0002eM-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbaCCXWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:22:18 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:34383 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbaCCXWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:22:17 -0500
Received: from localhost ([127.0.0.1]:33423 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKcBb-0000mV-R4; Mon, 03 Mar 2014 18:22:16 -0500
Received: by lola (Postfix, from userid 1000)
	id 76B92E065F; Tue,  4 Mar 2014 00:22:15 +0100 (CET)
In-Reply-To: <xmqq61nuoqd5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 03 Mar 2014 14:43:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243307>

Junio C Hamano <gitster@pobox.com> writes:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const char *suffix);
>  
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> +	while (1) {
> +		if (!*prefix)
> +			return str;
> +		if (*str != *prefix)
> +			return NULL;
> +		prefix++;
> +		str++;
> +	}
>  }

How about a function body of

	do {
        	if (!*prefix)
                	return str;
        } while (*str++ == *prefix++);
        return NULL;

I'm not too fond of while (1) and tend to use for (;;) instead, but that
may again partly be due to some incredibly non-optimizing compiler back
in the days of my youth.  At any rate, the do-while loop seems a bit
brisker.

-- 
David Kastrup
