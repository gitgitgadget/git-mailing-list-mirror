From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gettext.h: add parentheses around N_ expansion if supported
Date: Thu, 08 Jan 2015 11:10:42 -0800
Message-ID: <xmqqa91tf5ql.fsf@gitster.dls.corp.google.com>
References: <aea96640a01b65776eb0474aaceded5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:11:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9ITr-0008IF-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbbAHTKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:10:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754002AbbAHTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:10:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADE742E01C;
	Thu,  8 Jan 2015 14:10:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HWdfvS/NBT/HTKK3YC39lgB6mtE=; b=Y7nZEu
	D7rd64PFPuytPIRn+Daf3IygoHaYgHIzX02X97ZweSZIXT9YmiwFcoIudvDqvkcH
	Pc+5zT6wH3U7ImGl/SIgSH3YgoYNd+wk8/63ypR6lCyHdnuYcISLVQ83SGr2B/TV
	d7HxG5nri0cZFyV5QVs5Dv9BG+DwA/WMnu4gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUHNGuUSd0EGJ/vcpO6eKQuCtBUbXwdV
	uNocm9jvzxb0W0JLWz2qeQ2r6CwWiIr7T7LzPVX23yhYFv1yMQ5DzqMzERYFZ/nA
	RA4p4QNRud9IQ9Y6sHX3uoGHD/oBRzpnRXr0JpxdKBNITpYJ+NVKDjW7Q3cE0R0R
	yr+Y3K3ZbYw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 918ED2E01B;
	Thu,  8 Jan 2015 14:10:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0992B2E01A;
	Thu,  8 Jan 2015 14:10:43 -0500 (EST)
In-Reply-To: <aea96640a01b65776eb0474aaceded5@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Thu, 8 Jan 2015 00:46:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B57CCF2-976A-11E4-9DD0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262208>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> For now only __GNUC__ is tested which covers both gcc and clang
> which should result in early detection of any adjacent N_ macros.

I didn't check the list of -W options, but if there were a way to
tell gcc to stick to the C standard in a more strict way than its
default, wouldn't this patch start causing trouble?

> Although the necessary #ifdef makes the header less elegant,
> the benefit of avoiding propagation of a translation-marking
> error to all the translation teams thus creating extra work
> for them when the error is eventually detected and fixed would
> seem to outweigh the minor inelegance the #ifdef introduces.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  gettext.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/gettext.h b/gettext.h
> index 7671d09d..80ec29b5 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -62,7 +62,19 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
>  	return ngettext(msgid, plu, n);
>  }
>  
> -/* Mark msgid for translation but do not translate it. */
> +/* Mark msgid for translation but do not translate it.
> + *
> + * In order to prevent accidents where two adjacent N_ macros
> + * are mistakenly used, this macro is defined with parentheses
> + * when the compiler is known to support parenthesized string
> + * literal assignments.  This guarantees a compiler error in
> + * such a case rather than a silent conjoining of the strings
> + * by the preprocessor which results in translation failures.
> + */
> +#ifdef __GNUC__
> +#define N_(msgid) (msgid)
> +#else
>  #define N_(msgid) msgid
> +#endif
>  
>  #endif
