From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: don't skip modify/remove conflicts
Date: Wed, 09 Feb 2011 13:45:11 -0800
Message-ID: <7vzkq4opaw.fsf@alter.siamese.dyndns.org>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 22:45:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnHqo-0008Kf-SN
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 22:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab1BIVpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 16:45:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab1BIVpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 16:45:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 475C54164;
	Wed,  9 Feb 2011 16:46:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wJ6oxQ06xByGXfdJt+xMFOxZItA=; b=pmH0xt
	h5h1eq0MN1HygOohaq5G1SBV2h+axd7a0Gfs+9bypthwEGpUmu0FkMk5K/hxScwi
	ZERY2AB/9pu9P6+nb2K2jGNtyIVcg1CPYvP5Wa/cYWhozl1OoVBxwz4+gnYPUNH7
	o8Lkbm1GYDWnf1jnJV8NbAyrNxqxqKIhjZktQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YqFIuH0+4acgD7dvJRc7VbJQHyMVPXAv
	Qd664isgkkIbTyp8c21WVoKusbBtG9T90uCKfAjTAVkkziyeP9uMlUziRz+trzRh
	cMvLqGEyk0Rr79usY402dWjiI0GNKSF9cZ08iyXykqdZYxzY6RfaMrjgwv+WGBXm
	AzD1HibFcIY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 230674161;
	Wed,  9 Feb 2011 16:46:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 127D9415F; Wed,  9 Feb 2011
 16:46:13 -0500 (EST)
In-Reply-To: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Mon\,  7 Feb 2011 22\:08\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05F8B202-3496-11E0-8C7F-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166444>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> diff --git a/rerere.h b/rerere.h
> index eaa9004..107a2bc 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -6,6 +6,9 @@
>  #define RERERE_AUTOUPDATE   01
>  #define RERERE_NOAUTOUPDATE 02
>  
> +extern void *RERERE_UTIL_PUNTED;

This is for paths without three-stages, i.e. ones rerere won't help. 
Needs some comment for these two symbols.

Leading "RERERE_" is necessary for clarifying the namespace, PUNTED is
necessary because it defines what the symbols means, but why do we need
UTIL in the name?  Drop it.

> +extern void *RERERE_UTIL_STAGED;

This is for what kind?  The contents on the filesystem is ready to go,
added to the index, but still in MERGE_RR (i.e. "git rerere" not run yet)?

Is the real problem that git-mergetool is not running rerere when it
should, I wonder...

> diff --git a/rerere.c b/rerere.c
> index eb47f97..61cac54 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -7,6 +7,10 @@
>  #include "ll-merge.h"
>  #include "attr.h"
>  
> +#define RERERE_UTIL_ELIGIBLE NULL
> +void *RERERE_UTIL_PUNTED = &RERERE_UTIL_PUNTED;
> +void *RERERE_UTIL_STAGED = &RERERE_UTIL_STAGED;
> +

Same for "ELIGIBLE"; describe what it means.

>  	for (i = 0; i < active_nr; i++) {
>  		struct cache_entry *e = active_cache[i];
>  		struct string_list_item *it;
>  
> -		if (!ce_stage(e))
> +		if (!ce_stage(e)) {
>  			continue;
> +		}

Unnecessary change.

>  		it = string_list_insert(conflict, (const char *)e->name);
> -		it->util = NULL;
> +		it->util = RERERE_UTIL_PUNTED;
>  		if (ce_stage(e) == 1) {
> +			it->util = RERERE_UTIL_STAGED;

Hmm, I thought that you were taling about paths that the user
hand-resolved and then ran "git add" on.  Why is this marked "STAGED"?

Either your logic is wrong, or the name of the symbol is.

In any case, the original code is letting rerere handle both two-way
merge (stage #2 and #3 exist without state #1) and three-way merge (all
three stages exist) case, and changing only the body of this if statement
smells there is extremely fishy going on.

> @@ -487,8 +494,9 @@ static int do_plain_rerere(struct string_list *rr, int fd)
>  
>  	for (i = 0; i < conflict.nr; i++) {
>  		const char *path = conflict.items[i].string;
> -		if (!conflict.items[i].util)
> -			continue; /* punted */
> +		if (conflict.items[i].util == RERERE_UTIL_PUNTED ||
> +			conflict.items[i].util == RERERE_UTIL_STAGED)
> +			continue;
>  		if (!string_list_has_string(rr, path)) {
>  			unsigned char sha1[20];
>  			char *hex;
> @@ -648,8 +656,9 @@ int rerere_forget(const char **pathspec)
>  	find_conflict(&conflict);
>  	for (i = 0; i < conflict.nr; i++) {
>  		struct string_list_item *it = &conflict.items[i];
> -		if (!conflict.items[i].util)
> -			continue; /* punted */
> +		if (conflict.items[i].util == RERERE_UTIL_PUNTED ||
> +			conflict.items[i].util == RERERE_UTIL_STAGED)
> +			continue;

There are a few repetition of "if it is marked with PUNTED or STAGED"; can
you make it into a small helper function and give it a _meaningful_ name?
What does it mean for an entry to be marked with either of these marks?

Thanks.
