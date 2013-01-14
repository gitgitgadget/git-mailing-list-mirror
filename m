From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] config: add helper function for parsing key names
Date: Mon, 14 Jan 2013 10:08:47 -0800
Message-ID: <7v8v7veixc.fsf@alter.siamese.dyndns.org>
References: <20130114145845.GA16497@sigill.intra.peff.net>
 <20130114150012.GA16828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoT9-000749-C5
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab3ANSIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:08:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363Ab3ANSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:08:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2324CB3F6;
	Mon, 14 Jan 2013 13:08:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=9UgrWDsLvHr948CNJ93CFNEuNqY=; b=NskYQ0ScIdUsaNYc517s
	gKfJG9b6DUYa2T6W28BYOtQN6Gbq1tKgwtopYohG+OHVORRB7dTv+aCpEqwyhAx1
	69ucvWDnnIU5DjFfbs0Tllw5jRuVGVhLsl1t7CjZT+2zdEV/9HIwo9u9b5eciFQ0
	HUw6rW/Ak2XVHAwxeR9J5Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bVbKYQCczhvok6QjfK/LjgIvafk+PC9D4KrxzIYqFRNVSx
	DFogFaHLcEyTs2E2l59ReNHG0J4gym2v/ZIAfrZuCqzUCMItnAOhjJgsgH7h6HGL
	xj3E0jhqVU1CkwePhttdfKAz2MzMk/3eaTjIiHxmMMBRM/Ia/ZkEj0sTzw+p8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D511B3F5;
	Mon, 14 Jan 2013 13:08:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61B67B3F1; Mon, 14 Jan 2013
 13:08:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 722A46C4-5E75-11E2-88F5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213510>

Jeff King <peff@peff.net> writes:

> The config callback functions get keys of the general form:
>
>   section.subsection.key
>
> (where the subsection may be contain arbitrary data, or may
> be missing). For matching keys without subsections, it is
> simple enough to call "strcmp". Matching keys with
> subsections is a little more complicated, and each callback
> does it in an ad-hoc way, usually involving error-prone
> pointer arithmetic.
>
> Let's provide a helper that keeps the pointer arithmetic all
> in one place.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> No users yet; they come in future patches.
>
>  cache.h  | 15 +++++++++++++++
>  config.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index c257953..14003b8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1164,6 +1164,21 @@ extern int git_config_include(const char *name, const char *value, void *data);
>  #define CONFIG_INCLUDE_INIT { 0 }
>  extern int git_config_include(const char *name, const char *value, void *data);
>  
> +/*
> + * Match and parse a config key of the form:
> + *
> + *   section.(subsection.)?key
> + *
> + * (i.e., what gets handed to a config_fn_t). The caller provides the section;
> + * we return -1 if it does not match, 0 otherwise. The subsection and key
> + * out-parameters are filled by the function (and subsection is NULL if it is
> + * missing).
> + */
> +extern int match_config_key(const char *var,
> +		     const char *section,
> +		     const char **subsection, int *subsection_len,
> +		     const char **key);
> +

I agree with Jonathan about the naming s/match/parse/.

After looking at the callers in your later patches, I think the
counted interface to subsection is probably fine.  The caller can
check !subsection to see if it is a two- or three- level name, and

    if (parse_config_key(var, "submodule", &name, &namelen,  &key) < 0 ||
	!name)
	return 0;

is very easy to follow (that is the result of your 5th step).
