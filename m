From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2] use a hashmap to make remotes faster
Date: Fri, 05 Sep 2014 11:55:06 +0200
Message-ID: <5409887A.1000602@gmail.com>
References: <25222.0938886865-sendEmail@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Patrick Reynolds <patrick.reynolds@github.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 11:55:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPqEf-0005BK-SP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 11:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbaIEJzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 05:55:10 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36917 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbaIEJzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 05:55:08 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so57199wgg.9
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 02:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=RH6Q1Nr+47lAQgpPmSGRkQaiNuvhQdT6iqZXaIDypkk=;
        b=LfQhxlFXfnSLSv6tvnwofkxzBFM3yVx0BUTRjd8SBM4yGzH7YVU9QxcFTe/BJbi00H
         K/EkIDGYdkg0LIlobWlP2rRE8jT+BWLr0llHDNceH1V23gRV14gs7CGcqKIeTJJ/4S7P
         P34JzIuGKs+3MUmRU/Eg1WFBkLIxGkdhudJXtRcZdjwUzFGaFDZs5YyD9uXnzHm//psW
         s2Fy0si2AQU2J/8Q8atylPSmiqI/ROH2buYYvHeRGYC9PUDMF9e7HPGFIVRrlvUh/ua8
         a9Oq4DRGo9pwt9gLHAzzwlivq1EgSyoankU1mcoM4Vkcw4lNDQ8qZZvw3dEKzP2FoIZh
         HnyA==
X-Received: by 10.180.188.205 with SMTP id gc13mr2361800wic.66.1409910907342;
        Fri, 05 Sep 2014 02:55:07 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id pm6sm880746wjb.36.2014.09.05.02.55.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2014 02:55:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <25222.0938886865-sendEmail@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256501>

On 29.07.2014 16:43, Patrick Reynolds wrote:
> Remotes are stored as an array, so looking one up or adding one without
> duplication is an O(n) operation.  Reading an entire config file full of
> remotes is O(n^2) in the number of remotes.  For a repository with tens of
> thousands of remotes, the running time can hit multiple minutes.
> 
> Hash tables are way faster.  So we add a hashmap from remote name to
> struct remote and use it for all lookups.  The time to add a new remote to
> a repo that already has 50,000 remotes drops from ~2 minutes to < 1
> second.
> 
> We retain the old array of remotes so iterators proceed in config-file
> order.
> 
> Signed-off-by: Patrick Reynolds <patrick.reynolds@github.com>
> ---
> mark function with no arguments as taking void
> 
>  remote.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
>  remote.h |  3 +++
>  2 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index a0701f6..52533e4 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -42,6 +42,7 @@ struct rewrites {
>  static struct remote **remotes;
>  static int remotes_alloc;
>  static int remotes_nr;
> +static struct hashmap remotes_hash;
>  
>  static struct branch **branches;
>  static int branches_alloc;
> @@ -136,26 +137,51 @@ static void add_url_alias(struct remote *remote, const char *url)
>  	add_pushurl_alias(remote, url);
>  }
>  
> +struct remotes_hash_key {
> +	const char *str;
> +	int len;
> +};
> +
> +static int remotes_hash_cmp(const struct remote *a, const struct remote *b, const struct remotes_hash_key *key)
> +{
> +	if (key)
> +		return strncmp(a->name, key->str, key->len) || a->name[key->len];
> +	else
> +		return strcmp(a->name, b->name);
> +}
> +
> +static inline void init_remotes_hash(void)
> +{
> +	if (!remotes_hash.cmpfn)
> +		hashmap_init(&remotes_hash, (hashmap_cmp_fn)remotes_hash_cmp, 0);
> +}
> +
>  static struct remote *make_remote(const char *name, int len)
>  {
> -	struct remote *ret;
> -	int i;
> +	struct remote *ret, *replaced;
> +	struct remotes_hash_key lookup;
> +	struct hashmap_entry lookup_entry;
>  
> -	for (i = 0; i < remotes_nr; i++) {
> -		if (len ? (!strncmp(name, remotes[i]->name, len) &&
> -			   !remotes[i]->name[len]) :
> -		    !strcmp(name, remotes[i]->name))
> -			return remotes[i];
> -	}
> +	if (!len)
> +		len = strlen(name);
> +
> +	init_remotes_hash();
> +	lookup.str = name;
> +	lookup.len = len;
> +	hashmap_entry_init(&lookup_entry, memhash(name, len));
> +
> +	if ((ret = hashmap_get(&remotes_hash, &lookup_entry, &lookup)) != NULL)
> +		return ret;
>  
>  	ret = xcalloc(1, sizeof(struct remote));
>  	ret->prune = -1;  /* unspecified */
>  	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
>  	remotes[remotes_nr++] = ret;
> -	if (len)
> -		ret->name = xstrndup(name, len);
> -	else
> -		ret->name = xstrdup(name);
> +	ret->name = xstrndup(name, len);
> +
> +	hashmap_entry_init(ret, lookup_entry.hash);
> +	replaced = hashmap_put(&remotes_hash, ret);
> +	assert(replaced == NULL);  /* no previous entry overwritten */
>  	return ret;
>  }
>  
> @@ -722,13 +748,16 @@ struct remote *pushremote_get(const char *name)
>  
>  int remote_is_configured(const char *name)
>  {
> -	int i;
> +	struct remotes_hash_key lookup;
> +	struct hashmap_entry lookup_entry;
>  	read_config();
>  
> -	for (i = 0; i < remotes_nr; i++)
> -		if (!strcmp(name, remotes[i]->name))
> -			return 1;
> -	return 0;
> +	init_remotes_hash();
> +	lookup.str = name;
> +	lookup.len = strlen(name);
> +	hashmap_entry_init(&lookup_entry, memhash(name, lookup.len));
> +
> +	return hashmap_get(&remotes_hash, &lookup_entry, &lookup) != NULL;
>  }
>  
>  int for_each_remote(each_remote_fn fn, void *priv)
> diff --git a/remote.h b/remote.h
> index 917d383..81cb5ff 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -1,6 +1,7 @@
>  #ifndef REMOTE_H
>  #define REMOTE_H
>  
> +#include "hashmap.h"
>  #include "parse-options.h"
>  
>  enum {
> @@ -10,6 +11,8 @@ enum {
>  };
>  
>  struct remote {
> +	struct hashmap_entry ent;  /* must be first */
> +

I stumbled about this comment  "/* must be first */"
when reading the changelog.

Why does it need to be first?
Is it a common reason I'm just not aware of,
or would it make sense to put the reason into the comment as well?

Thanks,
Stefan

>  	const char *name;
>  	int origin;
>  
> 
