From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Tue, 07 Dec 2010 12:56:17 -0800
Message-ID: <7v62v5paj2.fsf@alter.siamese.dyndns.org>
References: <20101207181633.GF25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4aT-0001QO-GR
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab0LGU4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 15:56:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391Ab0LGU4a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:56:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1741D3DFE;
	Tue,  7 Dec 2010 15:56:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8QYL3ZbKNAA4eyyc/V6nHsoxZnA=; b=FTtrFq
	PYvu7fFNjeYCd10Kt7ea0zdkKuqF/QBaI1CHtc1aFZGync3GksPoL7izE2zsJYOc
	R9yOBi3Y/YDhrSuYdi6GnOAl6u9F0mbrqX73xeM89u6KIQEXUY1wvb9vA3+c03nn
	FA/h8VhURdj1oQbffuvNYBpumdJYRiQBCGou0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WzrKcrK8EAwsUjifsx9adwhSA0uR1vlT
	FW3mh1xXj6uD21W11r/PP/yFvjYeaXiEW8g48BTbMtFr7fXq5pPZ+/IoOl3J0Fty
	IDnfdqSVgiw2OrO+8HgCCpTOSAadGGkCcwzaKdpY/uZusq7VJP0hNQJTcaSOgAke
	hZkyzrBbijM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2EA43DFD;
	Tue,  7 Dec 2010 15:56:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B05CC3DFB; Tue,  7 Dec 2010
 15:56:42 -0500 (EST)
In-Reply-To: <20101207181633.GF25767@bzzt.net> (Arnout Engelen's message of
 "Tue\, 7 Dec 2010 19\:16\:33 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 808CF192-0244-11E0-ACC7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163131>

Arnout Engelen <arnouten@bzzt.net> writes:

> This patch has been submitted/discussed before, but that version doesn't apply
> cleanly to the newest git anymore, so here's an updated version. 

Thanks, but that comes after "---", no?

> It improves diagnostic error messages when creating a temporary file fails.
>
> Signed-off-by: Arnout Engelen <arnouten@bzzt.net>
> ---

> diff --git a/wrapper.c b/wrapper.c
> index 4c1639f..6640c87 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -2,6 +2,7 @@
>   * Various trivial helper wrappers around standard functions
>   */
>  #include "cache.h"
> +#include "wrapper.h"
>  
>  static void do_nothing(size_t size)
>  {
> @@ -196,10 +197,20 @@ FILE *xfdopen(int fd, const char *mode)
>  int xmkstemp(char *template)
>  {
>  	int fd;
> +	char origtemplate[255];
> +	strlcpy(origtemplate, template, 255);

Why "255"?

It may happen to be sufficiently large for the current callers, but what
provisions if any are made to help the compiler or the runtime protect us
from new and broken callers?  Use of strlcpy() there hides the issue from
the runtime by avoiding segfault, but it actively harms us by making the
code silently behave incorrectly without segfaulting, no?

> diff --git a/wrapper.h b/wrapper.h
> new file mode 100644
> index 0000000..b06ff0d
> --- /dev/null
> +++ b/wrapper.h
> @@ -0,0 +1,4 @@
> +/*
> + * Various trivial helper wrappers around standard functions
> + */
> +int xmkstemp(char *template);

Somewhat questionable...

Why doesn't this say "extern"?
What happend to another copy of this line in git-compat-util.h?  IOW, what
protects this and the other one from drifting apart?
Why doesn't users include wrapper.h but only wrapper.c?
Why yet another header is needed only for this function and nothing else?
Why isn't this protected with the standard #ifndef .../#define .../#endif?
