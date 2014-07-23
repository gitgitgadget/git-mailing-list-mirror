From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] rewrite git_config() to use the config-set API
Date: Wed, 23 Jul 2014 14:58:29 -0700
Message-ID: <xmqq7g33d9fe.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4Yc-0005qs-Hy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbaGWV6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:58:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61711 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933437AbaGWV6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:58:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 556842B7E4;
	Wed, 23 Jul 2014 17:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PnS1GaL5DOKT9xG7vdA1Y7oeaVQ=; b=bqeUtM
	iEV6+5WubusvylGdQNAZtJasagVksd6uqCa5hhRwNmDPiHcrWfwf6yuwZMIImNqv
	/Mv+x1VNAE5IVOJNjHbrttTSDALPOYXIywr2LT8HCB+avGAv21ckb2x96765BwyM
	4GSYx3CLNgJgrJfmer0SkGvbmh17654LsEtjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BixW6AH3FKPluB6SVllMr7OKUBOq5+nV
	LMZEDmrgBVFE6c++z+0Ic2Mx+QvoZqOqqJ0K00Vczdq6sgWosOHpfJAOpHc29LtQ
	sAlbMlePceK/6k8FEQNhCWkx8CMogSTqzO3Q8EeSq5zP2DoJyf38NQy4zjp1byKN
	uVV/4zOlsA0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BE792B7E3;
	Wed, 23 Jul 2014 17:58:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5FC702B7DD;
	Wed, 23 Jul 2014 17:58:31 -0400 (EDT)
In-Reply-To: <1406140978-9472-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 23 Jul 2014 11:42:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7C22F24E-12B4-11E4-B759-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254131>

Tanay Abhra <tanayabh@gmail.com> writes:

> Of all the functions in `git_config*()` family, `git_config()` has the
> most invocations in the whole code base. Each `git_config()` invocation
> causes config file rereads which can be avoided using the config-set API.
>
> Use the config-set API to rewrite `git_config()` to use the config caching
> layer to avoid config file rereads on each invocation during a git process
> lifetime. First invocation constructs the cache, and after that for each
> successive invocation, `git_config()` feeds values from the config cache
> instead of rereading the configuration files.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  config.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

This is the natural logical conclusion ;-)

> diff --git a/config.c b/config.c
> index 6db8f97..a7fb9a4 100644
> --- a/config.c
> +++ b/config.c
> @@ -1232,11 +1232,36 @@ int git_config_with_options(config_fn_t fn, void *data,
>  	return ret;
>  }
>  
> -int git_config(config_fn_t fn, void *data)
> +static int git_config_raw(config_fn_t fn, void *data)
>  {
>  	return git_config_with_options(fn, data, NULL, 1);
>  }
>  
> +static int configset_iter(struct config_set *cs, config_fn_t fn, void *data)
> +{
> +	int i;
> +	struct string_list *strptr;

We know string_list would hold strings, so naming the variable
strptr does not give us much information.  As this is a list of
values you would get by querying for a variable (or "key"), perhaps
name it "values" or something?

> +	struct config_set_element *entry;
> +	struct hashmap_iter iter;

Have a blank line between the local variable definitions (above) and
the first executable statement (below); it would make it easier to
read, especially because out codebase do not have decl-after-stmt.

> +	hashmap_iter_init(&cs->config_hash, &iter);
> +	while ((entry = hashmap_iter_next(&iter))) {
> +		strptr = &entry->value_list;
> +		for (i = 0; i < strptr->nr; i++) {
> +			if (fn(entry->key, strptr->items[i].string, data) < 0)
> +				die("bad config file line in (TODO: file/line info)");
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void git_config_check_init(void);
> +
> +int git_config(config_fn_t fn, void *data)
> +{
> +	git_config_check_init();
> +	return configset_iter(&the_config_set, fn, data);
> +}

Perhaps if you define this function at the right place in the file
you do not have to add an forward decl of git_config_check_init()?

>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
>  {
>  	struct config_set_element k;
> @@ -1418,7 +1443,7 @@ static void git_config_check_init(void)
>  	if (the_config_set.hash_initialized)
>  		return;
>  	git_configset_init(&the_config_set);
> -	git_config(config_set_callback, &the_config_set);
> +	git_config_raw(config_set_callback, &the_config_set);
>  }
>  
>  void git_config_clear(void)
