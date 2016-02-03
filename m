From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] submodule-config: remove name_and_item_from_var
Date: Wed, 03 Feb 2016 15:09:18 -0800
Message-ID: <xmqqk2mll7c1.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:09:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6YH-0005Su-7B
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbcBCXJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:09:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754074AbcBCXJV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:09:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7012440EA1;
	Wed,  3 Feb 2016 18:09:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=K+3vLRTyHIxAHioVCNSGGobOkqc=; b=O6x+pGNJYWx/GDJ4AuB6
	k1f1v9QG7ZP4UP9zdDB8UjEQsdBmiWXCiN/Fyo4FoZvQ8kQmWC8xQruJj2pbfbsr
	dYmjpsKb35FWnVOYnSaEHdUr36mNoVx9mb9K9sMPfw3rOtK9YNgaQatdg/1UQ3/i
	f9qw85anpbUvDKxD0NarU1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=er9cxeb/5TAUo05gjqqpN7JjpBoUpxCIihVFJrE396RPG3
	HG/sBQHjeNwrEZlznZSIoUdj8lJDsjDBt4BLEUyv41g1Ec8hDpGIq9UL5TZk9JKu
	GNz6Itaqyx4zzvC5iuSnR/iQVnY4ktikC85GuRMkgcyVC+LzhfksdWdPdhXgU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 66EFF40EA0;
	Wed,  3 Feb 2016 18:09:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E04D640E9F;
	Wed,  3 Feb 2016 18:09:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 27C8B820-CACB-11E5-AD6E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285378>

Stefan Beller <sbeller@google.com> writes:

> `name_and_item_from_var` does not provide the proper abstraction
> we need here in a later patch.

... so the idea is to first open-code the calling site in this
patch, and bring a different abstraction that is better suited to
this machinery in a later step?  Makes sense, especially it only
have a single callsite--let's continue reading...

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  submodule-config.c | 48 ++++++++++++++++--------------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 6d01941..b826841 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -161,31 +161,17 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
>  	return NULL;
>  }
>  
> -static int name_and_item_from_var(const char *var, struct strbuf *name,
> -				  struct strbuf *item)
> -{
> -	const char *subsection, *key;
> -	int subsection_len, parse;
> -	parse = parse_config_key(var, "submodule", &subsection,
> -			&subsection_len, &key);
> -	if (parse < 0 || !subsection)
> -		return 0;
> -
> -	strbuf_add(name, subsection, subsection_len);
> -	strbuf_addstr(item, key);
> -
> -	return 1;
> -}
> -
>  static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
> -		const unsigned char *gitmodules_sha1, const char *name)
> +						  const unsigned char *gitmodules_sha1,
> +						  const char *name_ptr, int name_len)
>  {
>  	struct submodule *submodule;
>  	struct strbuf name_buf = STRBUF_INIT;
> +	char *name = xmemdupz(name_ptr, name_len);

This used to be fed the whole name, but now the caller uses
parse_config_key() and we get a <ptr,len> pair, hence a pair of new
variable allocation and release in this function.  OK.

>  	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
>  	if (submodule)
> -		return submodule;
> +		goto out;
>  
>  	submodule = xmalloc(sizeof(*submodule));
>  
> @@ -201,7 +187,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>  	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
>  
>  	cache_add(cache, submodule);
> -
> +out:
> +	free(name);
>  	return submodule;
>  }
>  
> @@ -251,18 +238,18 @@ static int parse_config(const char *var, const char *value, void *data)
>  {
>  	struct parse_config_parameter *me = data;
>  	struct submodule *submodule;
> -	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
> -	int ret = 0;
> +	int subsection_len, ret = 0;
> +	const char *subsection, *key;
>  
> -	/* this also ensures that we only parse submodule entries */
> -	if (!name_and_item_from_var(var, &name, &item))
> +	if (parse_config_key(var, "submodule", &subsection,
> +			     &subsection_len, &key) < 0 || !subsection_len)
>  		return 0;

The strbuf name became subsection ptr,len pair [*1*].
>  	submodule = lookup_or_create_by_name(me->cache,
>  					     me->gitmodules_sha1,
> -					     name.buf);
> +					     subsection, subsection_len);

... and that is used here.

>  
> -	if (!strcmp(item.buf, "path")) {
> +	if (!strcmp(key, "path")) {

... and the "item" that used to hold the third-level variable name
is now a variable "key".  Looks correct.


[Footnote]

*1* I notice that the error detection has been slightly changed.
    The original code used to detect a two-level variable name by
    checking if the subsection pointer is NULL.  Now you check the
    length.

    I didn't check the implementation of parse_config_key(), but it
    feels to me that the original would be "more" correct.  Even
    though we may not accept an empty second level name (or do we
    already?), it would be a good idea to get the code prepared to
    differentiate between the lack of subsection and having a
    subsection that happens to be an empty string, i.e.

	[section ""]
        	variable = value
