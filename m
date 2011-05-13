From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] Submodules: Don't parse .gitmodules when it
 contains merge conflicts
Date: Thu, 12 May 2011 23:19:03 -0700
Message-ID: <7vmxir9l7s.fsf@alter.siamese.dyndns.org>
References: <4DCC4A9D.3060007@web.de> <4DCC4B05.9070205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri May 13 08:19:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKliW-0007lS-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 08:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161Ab1EMGTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 02:19:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab1EMGTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 02:19:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A633D35F0;
	Fri, 13 May 2011 02:21:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IS16/De+u06ytdNsg0Xe7jlndw=; b=Nn5eXa
	9dB4TXVMpJSJkJnwFvBK6VOuFMfog9EDFxTblj5jJfcTQgVbgzjnadnoiTsM6Jra
	m18GMbXpqbKs3SLnJPEN+VutkfWw8vK7LQ0sIJ1ytDMIkCJwqL6WeSucNdpJ6wqG
	0bdrhbzr905SgC6jZm2OXiTY3Vu/IopEjRUew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aiKrB07OMERhxDBbHVcPWNm7PB1REaib
	dFLgMdjgOVlyBUEuzpT//ZDZTYlVLMJYj+bhPlzdbtyEpcyg4YceC+tIJClTA7rz
	rbNtf/3yJuXU1ULvWAC7MuLpANTv41Z4QhhLAS3SgrUlvlX+64TzBidjQWX3Fhlc
	UKYNNQWhmWE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8476535ED;
	Fri, 13 May 2011 02:21:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9193435E5; Fri, 13 May 2011
 02:21:11 -0400 (EDT)
In-Reply-To: <4DCC4B05.9070205@web.de> (Jens Lehmann's message of "Thu, 12
 May 2011 23:03:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 343B20BA-7D29-11E0-A588-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173505>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Until now commands like "git status", "git diff" and "git fetch" would

s/Until now c/C/;

> fail when the .gitmodules file contained merge conflicts because the
> config parser would call die() when hitting the conflict markers:
>
>     "fatal: bad config file line <n> in <path>/.gitmodules"
>
> While this was behavior was on the safe side, it is really unhelpful to

was--was

> diff --git a/submodule.c b/submodule.c
> index 5294cef..cdf844c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -14,6 +14,13 @@ static struct string_list config_fetch_recurse_submodules_for_name;
>  static struct string_list config_ignore_for_name;
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
>  static struct string_list changed_submodule_paths;
> +/* The following flag is set if the .gitmodules file is unmerged. We then
> + * disable recursion for all submodules where .git/config doesn't have a
> + * matching config entry because we can't guess what might be configured in
> + * .gitmodules unless the user resolves the conflict. When a command line
> + * option is given (which always overrides configuration) this flag will be
> + * ignored. */

/*
 * We write our multi-line
 * comments like
 * this.
 */

> +static int gitmodules_is_unmerged;

Is it too cumbersome to pass this down the callchain as an argument?

> +		if (read_cache() < 0)
> +			die("index file corrupt");
> +		pos = cache_name_pos(".gitmodules", 11);
> +		if (pos >= -1) {
> +			/* We have a clean, untracked or missing .gitmodules, try to parse it */
> +			git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
> +		} else {
> +			gitmodules_is_unmerged = 1;
> +		}

I do not think this is correct.

If pos is zero or positive, you know you found ".gitmodules" that is
merged. If it is -1, that means ".gitmodules" at stage #0 would be
inserted at the beginning of the index, but that may perhaps be because
the first cache entry in the index may be an unmerged ".gitmodules", no?

	pos = cache_name_pos(".gitmodules", 11);
	if (0 <= pos)
		; /* .gitmodules found and is merged */
	else {
        	pos = -1 - pos;
		if (active_nr <= pos)
	        	; /* .gitmodules does not exist */
	        ce = active_cache[pos];
	        if (ce_namelen(ce) == 11 &&
                    !memcmp(ce->name, ".gitmodules", 11))
			; /* .gitmodules unmerged */
		else
			; /* there is no .gitmodules */
	}
