From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 16:38:54 -0700
Message-ID: <7vsjnizxf5.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org>
 <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>, <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KlK-000803-5v
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab1IZXi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083Ab1IZXi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:38:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9C0751A0;
	Mon, 26 Sep 2011 19:38:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iCLpHTwww5Q/4emJM5e6jY5PHn0=; b=LYBVWc
	nFJceOPYTo9RIw8j2Z9rKv9AIe1IsjHeK1gMhBaGz2bvB94WkFER5g1akRPZN7gp
	4Do50lvYiHNugnSW/BUn1w0rbwJAJ6KAjiQLsUK5AJwRSlcl1BO0DXigxWlXlsBS
	otY+rha0kHUY3TQOXggSuxZWbT8RtmTST89OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wPOVlOzEfvW954I4H0+7mzxi/LHmGNKG
	XKPv0UQRJxUsYywe9BIvTjHjAjlkKsbUMsgHADkGoNLeOOPYZEUotY7lmQ0w6QFX
	3B/am27hKC1yKSOTT9K3OOWpO+TtfuF/34bakyjTn44G2M8RxegpZU4rFMK9yjH2
	/T0oDNfn0xE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF301519F;
	Mon, 26 Sep 2011 19:38:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1695D519E; Mon, 26 Sep 2011
 19:38:55 -0400 (EDT)
In-Reply-To: <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk> (Julian
 Phillips's message of "Tue, 27 Sep 2011 00:26:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B33FC85E-E898-11E0-8DB9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182192>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> Back when I made that change, I failed to notice that get_ref_dir was
> recursive for subdirectories ... sorry ...

Aha, I also was blind while I was watching this discussion from the
sideline, and I thought I re-read the codepath involved X-<. Indeed
we were sorting the list way too early and the patch looks correct.

Thanks.

> Hopefully this should speed things up.  My test repo went from ~17m
> user time, to ~2.5s.
> Packing still make things much faster of course.
>
> diff --git a/refs.c b/refs.c
> index a615043..212e7ec 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -319,7 +319,7 @@ static struct ref_list *get_ref_dir(const char
> *submodule, c
>                 free(ref);
>                 closedir(dir);
>         }
> -       return sort_ref_list(list);
> +       return list;
>  }
>
>  struct warn_if_dangling_data {
> @@ -361,11 +361,13 @@ static struct ref_list *get_loose_refs(const
> char *submodu
>         if (submodule) {
>                 free_ref_list(submodule_refs.loose);
>                 submodule_refs.loose = get_ref_dir(submodule, "refs",
> NULL);
> +               submodule_refs.loose =
> sort_refs_list(submodule_refs.loose);
>                 return submodule_refs.loose;
>         }
>
>         if (!cached_refs.did_loose) {
>                 cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
> +               cached_refs.loose = sort_refs_list(cached_refs.loose);
>                 cached_refs.did_loose = 1;
>         }
>         return cached_refs.loose;
>
>
>
>>
>>
>> -Martin
