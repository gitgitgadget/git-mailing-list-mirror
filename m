From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 4/4] hashmap: add string interning API
Date: Mon, 07 Jul 2014 10:44:31 -0700
Message-ID: <xmqqfviddpxc.fsf@gitster.dls.corp.google.com>
References: <53B48540.5070600@gmail.com> <53B4863E.1020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:44:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Cy8-00009I-3M
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbaGGRoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:44:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59044 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbaGGRoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:44:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF0BF27000;
	Mon,  7 Jul 2014 13:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wo+RzzZa1bT0WqORrE8kr5kZQ24=; b=WUINbW
	z+PgpFIa3ciqirtI/rfhkHRpPl6CLNRz27IDTXkmiY9SvOQk+fP65JNb3FlyXZxx
	JnrzA+2vJi6AD2z8EAZU5nU4LNNBFh/3xTxIeBVh3gwEhBzSTDEcOSUhFHCgUMIP
	RkVvVSoV+Bw05R4BJ12Hm7satx5+59LGepE7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDB2Zr52w37yxY7Ya66iqV2YQO0EmBMw
	uex117bektzSQZJ+Y3JPnPEiD0d3rMdUSxiHQCSWBRVaH7MTug/208Oqr3oaRHUw
	6ys+KntMiyWJGxle2/zARAABK8zkboYlRj0X4grsZTHNGkL76KhvP7ACjuvynPDi
	/tUvnVAIo6I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3D4126FFF;
	Mon,  7 Jul 2014 13:44:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0949E26FEE;
	Mon,  7 Jul 2014 13:44:19 -0400 (EDT)
In-Reply-To: <53B4863E.1020701@gmail.com> (Karsten Blees's message of "Thu, 03
	Jul 2014 00:22:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5302FADE-05FE-11E4-8BA5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252976>

Karsten Blees <karsten.blees@gmail.com> writes:

> Interning short strings with high probability of duplicates can reduce the
> memory footprint and speed up comparisons.
>
> Add strintern() and memintern() APIs that use a hashmap to manage the pool
> of unique, interned strings.
>
> Note: strintern(getenv()) could be used to sanitize git's use of getenv(),
> in case we ever encounter a platform where a call to getenv() invalidates
> previous getenv() results (which is allowed by POSIX).

I think the attribute name/value strings are already interned, so
they may want to be converted to use this (or vice-versa).

>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  Documentation/technical/api-hashmap.txt | 15 +++++++++++++
>  hashmap.c                               | 38 +++++++++++++++++++++++++++++++++
>  hashmap.h                               |  8 +++++++
>  t/t0011-hashmap.sh                      | 13 +++++++++++
>  test-hashmap.c                          | 14 ++++++++++++
>  5 files changed, 88 insertions(+)
>
> diff --git a/Documentation/technical/api-hashmap.txt b/Documentation/technical/api-hashmap.txt
> index f9215d6..00c4c29 100644
> --- a/Documentation/technical/api-hashmap.txt
> +++ b/Documentation/technical/api-hashmap.txt
> @@ -193,6 +193,21 @@ more entries.
>  `hashmap_iter_first` is a combination of both (i.e. initializes the iterator
>  and returns the first entry, if any).
>  
> +`const char *strintern(const char *string)`::
> +`const void *memintern(const void *data, size_t len)`::
> +
> +	Returns the unique, interned version of the specified string or data,
> +	similar to the `String.intern` API in Java and .NET, respectively.
> +	Interned strings remain valid for the entire lifetime of the process.
> ++
> +Can be used as `[x]strdup()` or `xmemdupz` replacement, except that interned
> +strings / data must not be modified or freed.
> ++
> +Interned strings are best used for short strings with high probability of
> +duplicates.
> ++
> +Uses a hashmap to store the pool of interned strings.
> +
>  Usage example
>  -------------
>  
> diff --git a/hashmap.c b/hashmap.c
> index d1b8056..f693839 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -226,3 +226,41 @@ void *hashmap_iter_next(struct hashmap_iter *iter)
>  		current = iter->map->table[iter->tablepos++];
>  	}
>  }
> +
> +struct pool_entry {
> +	struct hashmap_entry ent;
> +	size_t len;
> +	unsigned char data[FLEX_ARRAY];
> +};
> +
> +static int pool_entry_cmp(const struct pool_entry *e1,
> +			  const struct pool_entry *e2,
> +			  const unsigned char *keydata)
> +{
> +	return e1->data != keydata &&
> +	       (e1->len != e2->len || memcmp(e1->data, keydata, e1->len));
> +}
> +
> +const void *memintern(const void *data, size_t len)
> +{
> +	static struct hashmap map;
> +	struct pool_entry key, *e;
> +
> +	/* initialize string pool hashmap */
> +	if (!map.tablesize)
> +		hashmap_init(&map, (hashmap_cmp_fn) pool_entry_cmp, 0);
> +
> +	/* lookup interned string in pool */
> +	hashmap_entry_init(&key, memhash(data, len));
> +	key.len = len;
> +	e = hashmap_get(&map, &key, data);
> +	if (!e) {
> +		/* not found: create it */
> +		e = xmallocz(sizeof(struct pool_entry) + len);
> +		hashmap_entry_init(e, key.ent.hash);
> +		e->len = len;
> +		memcpy(e->data, data, len);
> +		hashmap_add(&map, e);
> +	}
> +	return e->data;
> +}
> diff --git a/hashmap.h b/hashmap.h
> index 12f0668..507884b 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -87,4 +87,12 @@ static inline void *hashmap_iter_first(struct hashmap *map,
>  	return hashmap_iter_next(iter);
>  }
>  
> +/* string interning */
> +
> +extern const void *memintern(const void *data, size_t len);
> +static inline const char *strintern(const char *string)
> +{
> +	return memintern(string, strlen(string));
> +}
> +
>  #endif
> diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
> index 391e2b6..f97c805 100755
> --- a/t/t0011-hashmap.sh
> +++ b/t/t0011-hashmap.sh
> @@ -237,4 +237,17 @@ test_expect_success 'grow / shrink' '
>  
>  '
>  
> +test_expect_success 'string interning' '
> +
> +test_hashmap "intern value1
> +intern Value1
> +intern value2
> +intern value2
> +" "value1
> +Value1
> +value2
> +value2"
> +
> +'
> +
>  test_done
> diff --git a/test-hashmap.c b/test-hashmap.c
> index 3c9f67b..07aa7ec 100644
> --- a/test-hashmap.c
> +++ b/test-hashmap.c
> @@ -234,6 +234,20 @@ int main(int argc, char *argv[])
>  			/* print table sizes */
>  			printf("%u %u\n", map.tablesize, map.size);
>  
> +		} else if (!strcmp("intern", cmd) && l1) {
> +
> +			/* test that strintern works */
> +			const char *i1 = strintern(p1);
> +			const char *i2 = strintern(p1);
> +			if (strcmp(i1, p1))
> +				printf("strintern(%s) returns %s\n", p1, i1);
> +			else if (i1 == p1)
> +				printf("strintern(%s) returns input pointer\n", p1);
> +			else if (i1 != i2)
> +				printf("strintern(%s) != strintern(%s)", i1, i2);
> +			else
> +				printf("%s\n", i1);
> +
>  		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
>  
>  			perf_hashmap(atoi(p1), atoi(p2));
