From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/6] rewrite git_config() to use the config-set API
Date: Fri, 25 Jul 2014 15:58:58 +0200
Message-ID: <vpq38dppmjh.fsf@anie.imag.fr>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
	<1406293095-15920-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:00:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAg2U-0001TT-8o
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 16:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbaGYN76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 09:59:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58513 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbaGYN75 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 09:59:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDwvXs029868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 15:58:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDwwNU020410;
	Fri, 25 Jul 2014 15:58:58 +0200
In-Reply-To: <1406293095-15920-4-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 25 Jul 2014 05:58:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Jul 2014 15:58:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PDwvXs029868
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406901539.08531@e5F8tZFzS/jGAuOGFJhb+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254222>

Tanay Abhra <tanayabh@gmail.com> writes:

> +struct config_set_element {
> +	struct hashmap_entry ent;
> +	char *key;
> +	struct string_list value_list;
> +};
> +
> +struct configset_list_item {
> +	struct config_set_element *e;
> +	int value_index;
> +};

I originally wondered why you had two levels of pointers, but
config_set_element is not new, just moved. It's OK.

> +/*
> + * the contents of the list are ordered according to their
> + * position in the config files and order of parsing the files.
> + * (i.e. key-value pair at the last position of .git/config will
> + * be at the last item of the list)
> + */
> +
> +struct configset_list {

I wouldn't put a blank line between comment and decl if the comment
applies to the decl.

> -int git_config(config_fn_t fn, void *data)
> +static int git_config_raw(config_fn_t fn, void *data)
>  {
>  	return git_config_with_options(fn, data, NULL, 1);
>  }

I would have done this and the new git_config() as a separate patch, but
I do not mind strongly.

>  static struct config_set_element *configset_find_element(struct config_set *cs, const char *key)
>  {
>  	struct config_set_element k;
> @@ -1268,6 +1295,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  {
>  	struct config_set_element *e;
>  	struct string_list_item *si;
> +	struct configset_list_item *l_item;
>  	struct key_value_info *kv_info = xmalloc(sizeof(*kv_info));
>  
>  	e = configset_find_element(cs, key);
> @@ -1283,6 +1311,13 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
>  		hashmap_add(&cs->config_hash, e);
>  	}
>  	si = string_list_append_nodup(&e->value_list, value ? xstrdup(value) : NULL);
> +
> +	if (cs->list.nr + 1 > cs->list.alloc)

The "if" is already in ALLOC_GROW.

> +		ALLOC_GROW(cs->list.items, cs->list.nr + 20, cs->list.alloc);

The 20 should be just 1 I guess. You're adding 1 element, and ALLOC_GROW
will take care of allocating more than 1 for you (see alloc_nr and
ALLOC_GROW's defs in cache.h).

> @@ -1318,10 +1356,14 @@ void git_configset_clear(struct config_set *cs)
>  	hashmap_iter_init(&cs->config_hash, &iter);
>  	while ((entry = hashmap_iter_next(&iter))) {
>  		free(entry->key);
> -		string_list_clear(&entry->value_list, 0);
> +		string_list_clear(&entry->value_list, 1);

Doesn't this change belong to PATCH 2/6 ?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
