From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: free cache entry when refreshing fails
Date: Tue, 17 Feb 2015 10:14:54 -0800
Message-ID: <xmqqoaos2yn5.fsf@gitster.dls.corp.google.com>
References: <1424196374-29509-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmfn-0006Vj-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 19:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbbBQSO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 13:14:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752657AbbBQSO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 13:14:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B2193804E;
	Tue, 17 Feb 2015 13:14:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g4Anl40bEU4hizgmxKaHvafjmdM=; b=tfF1NG
	Np71iKQXZrGJosKM2D0mI0gojTqSkING8C7x7MqXBOmxi6o9ZO9hgDy4BChclLzh
	vjs6GBcqYoQWTzQDU+/VSy0C9NRVGdUm/6fqRFvpPk8Z0UAGTYsG3mnzdrLVQMSo
	8yrM0nUS/ubp325RqSZQFo2Vrar5zJc8JS3Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EWj3B4Ss5OKUGKkphV+eYMgf2H9t4OHA
	68qZnP7mTumBdTYiS6fIpFY0T/hggUYkZPcZUxacQpaOSKrFOmyFYM+J936hE2fq
	2SQniRlmmbWsYxQ8yV07k9geLY6uFxlPHliARGNAzLDLbeqQbzZALNA9w8k1lbKs
	V1blKFiV5Ww=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DBF03804D;
	Tue, 17 Feb 2015 13:14:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADE8A3804C;
	Tue, 17 Feb 2015 13:14:55 -0500 (EST)
In-Reply-To: <1424196374-29509-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 17 Feb 2015 10:06:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E01A593E-B6D0-11E4-B89B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263973>

Stefan Beller <sbeller@google.com> writes:

> This fixes a memory leak, when building the cache entries as
> refresh_cache_entry may decide to return NULL in case of
>

in case of what?

I briefly wondered if refresh_cache_ent() should do the freeing but
that does not make sense at all if done unconditionally because the
other caller of the function does want to retain ce on error, and it
makes little sense to invent FREE_CE_ON_ERROR bit in refresh_option,
either, so this fix looks sensible.

> I am not sure how severe this memory leak is as it was found by
> scan.coverity.com, CID 290041.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  read-cache.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 9cff715..8d71860 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -725,7 +725,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>  		unsigned int refresh_options)
>  {
>  	int size, len;
> -	struct cache_entry *ce;
> +	struct cache_entry *ce, *ret;
>  
>  	if (!verify_path(path)) {
>  		error("Invalid path '%s'", path);
> @@ -742,7 +742,13 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>  	ce->ce_namelen = len;
>  	ce->ce_mode = create_ce_mode(mode);
>  
> -	return refresh_cache_entry(ce, refresh_options);
> +	ret = refresh_cache_entry(ce, refresh_options);
> +	if (!ret) {
> +		free(ce);
> +		return NULL;
> +	} else {
> +		return ret;
> +	}
>  }
>  
>  int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
