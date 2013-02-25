From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix unsigned time_t comparison
Date: Mon, 25 Feb 2013 14:10:56 -0800
Message-ID: <7vvc9gnixb.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrMZODO07_dPep-yKgrzD1228iSMGUXX06xkKDmoZF4+qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:12:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA6HD-0000G5-B2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825Ab3BYWL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:11:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759826Ab3BYWK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 17:10:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 548E1AE69;
	Mon, 25 Feb 2013 17:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgiwjJBaJP23yD45JQocRJnU4S4=; b=llgeWN
	WoaNunSCz+7ka1FgbBP+Lw4HcIpRSs5HF22XEOzA3BxN22ZZs+k32Nf+M3ahpOJI
	CIw/rMOrZcbclxqFK9DsIxWKkqRn+dxrlRrv/AuhVkH8WmujJgvuuQqMBZjR7BA5
	Pk7PbmsQVGepX9LJR2WDxtayGO+r/JmXWYZNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cq8+StkSHIgbj5w9NIZ8Pvy91TAqxIoe
	PDGYpRO/T3o49cRWGqpnMuwQIfLpNEVHoUWoDlECFIjTbBA/yrnDOMH/eap1fx1X
	vJyla8N6q60h6H2F34GlOYE0d0A/4Erh2Ee5Tpf4EareH5cckQIxu8dUu0Av19yc
	JmkirRyC8tU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AC27AE68;
	Mon, 25 Feb 2013 17:10:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1164AE66; Mon, 25 Feb 2013
 17:10:57 -0500 (EST)
In-Reply-To: <CAHXAxrMZODO07_dPep-yKgrzD1228iSMGUXX06xkKDmoZF4+qA@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 23:51:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B1BF81E-7F98-11E2-924E-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217113>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> Do not compare time_t (less comparison) with -1. If time_t
> is unsigned this leads to always true comparison.
>
> Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
> ---
>  date.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 57331ed..1ac28e5 100644
> --- a/date.c
> +++ b/date.c
> @@ -383,7 +383,7 @@ static int is_date(int year, int month, int day,
> struct tm *now_tm, time_t now,
>  		 * sense to specify timestamp way into the future.  Make
>  		 * sure it is not later than ten days from now...
>  		 */
> -		if (now + 10*24*3600 < specified)
> +		if ((specified != -1) && (now + 10*24*3600 < specified))
>  			return 0;
>  		tm->tm_mon = r->tm_mon;
>  		tm->tm_mday = r->tm_mday;

This is good enough band-aid for now (as it won't change the
semantics for anybody), but I suspect in the longer term we would
want to pick a different mechanims to signal errors, so that we can
specify timestamp that is before 1970.

Thanks, will queue.
