Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DD9C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9653207AA
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAANcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:32:15 -0500
Received: from mout.web.de ([212.227.17.12]:41595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbhAANcO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609507818;
        bh=LdjlXp/D395+pZtXO3KglC+h59Ttr5gE9Tc/i76o97Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=S8iQg/E4pn0uYO53KeXbmJirZv4TILdhGYlz8a6w3l0BkMiB7Gw1sNrtTm3ql+BwR
         j1YFzX9+iTAl7E7/cuELPiwVwExeg7mmBMfw+WfY6zRlMwLyKEECNjoHgun+yBtLwk
         ZI4GlG08LRV3XPp3uhvqJ6d+TBB+9Vy4/tuS9wC0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Bb-1kcQZz2GGr-00J5ml; Fri, 01
 Jan 2021 14:30:18 +0100
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
 <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c9427a35-b2e0-0142-e5c2-4d1baf97315a@web.de>
Date:   Fri, 1 Jan 2021 14:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EyUyZhzu2kFjAkIxpnzOOhIxkZZK8QcCM8Fjj/WN8n/72DZWVSd
 9oGnf6RYq6uwdZy56cYhdesMOLTaSNfqhqyJoFT4dOrSPUKphmqbLC//J/DX+hS3uGr9y+I
 h4p1/oR4+YIDXnDgDQVfG/l/9Ryoe0zbmYBS2xn0Z4iG6ZIda1W9WROZUWneEMLNndFIGcT
 njr/0wG+tv9DiWkddzMww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OzEvHoKgnA4=:9o6sz/7yblNrquKP0qCwAX
 Bi2IKs+/tUqMwwCqcDnsusB0C3tHEl2uXuoGOj6Azg3K/0k5MEN3Dgo0Y5eOSxKMzwDfw5uFN
 FHBNFoklYZORY3/uzlmG/1pMPgRqXprYZP2yYBMZOHfkSDqmcyy5sfNz+nDXbURzgo7o2fB3W
 wLnVjKivZVk5XzvFvFMpgXehKCdWfmGSEVioYAo1Ig0/13BiEsx/xfPceWMvGvkZO0+j9np2f
 fifBV7/V85oqhJ+qNubV66rYiBbtrUAfYuCBVF83SPIkPatplIgNl/7Uua72OHIlL53jt3YQh
 bm01FXM8wH2WxzToIezahlKChYhTWakmZqy9JCx+Kt4WXSeQZSD7HHFq1W46RXT6Wzm6v+QZE
 PunBCXhWq6fiozX79hQVUlnVKVFfehJ6yZ9UODfIDpNb8Gq0XlS2kpMFu7fGCe4Zmhfq+2cvC
 CHf6iCaesf0QYvtvLJkzDNObdOy+mG3GyE4o9yTGEqGq/uoG2ga82wqmhqC8HlAchdyOx1ONO
 lqDSygMTLVMoA61kQkzc/H8CkoOsHRm8zOYeUR1n61YU2ff0nSb5P/N4IHswiBR4EV5tjo0RN
 3aagw+jZxEX0UNGzDsawTTg99HmD+mcy/ARytxa6eAUuTAO0KWN5ZNe7hmXQvw2Cj/JC1+wqv
 dnAeTgXJVL9BenQej8VlLOOyUVdZn/4qdxk8mmsKvZ+E7U8p4AoWfa7VPg20trR8nvdJSNy90
 xxGjt26DZ/jsBHQY/05QOEVIUwqgrBU6/mPOYxhtfjXO+slBtUf3w38K7hqRy/s6BFp+26zFj
 yLASGde/00TtReATAXP7jHW66CV9jFTJjs/2udX6EqcVP92u8+Rtezkg/Oh9ovtxudTyWGxtE
 6pMIDBgoE8iU81vifh3Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.12.20 um 17:46 schrieb Derrick Stolee:
> On 12/31/2020 7:34 AM, Ren=C3=A9 Scharfe wrote:
>> diff --git a/cache-tree.c b/cache-tree.c
>> index a537a806c1..1105cfe6b7 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -187,10 +187,8 @@ static int verify_cache(struct cache_entry **cache=
,
>>  		 */
>>  		const char *this_name =3D cache[i]->name;
>>  		const char *next_name =3D cache[i+1]->name;
>> -		int this_len =3D strlen(this_name);
>> -		if (this_len < strlen(next_name) &&
>> -		    strncmp(this_name, next_name, this_len) =3D=3D 0 &&
>> -		    next_name[this_len] =3D=3D '/') {
>> +		const char *p;
>> +		if (skip_prefix(next_name, this_name, &p) && *p =3D=3D '/') {
>>  			if (10 < ++funny) {
>>  				fprintf(stderr, "...\n");
>>  				break;
>
> This performs consistently worse than both cases (see performance test
> later in this message). I think the strlen is saving us some time here.
Thanks for checking!  I was expecting skip_prefix to be faster, because
it stops as soon as it reaches a non-matching character, while strlen
has to always walk to the end.  But consecutive entries of a sorted list
of paths can share long prefixes, in particular if there are long
directory names and directories contain lots of files.

> In fact, I think the compiler is doing some magic to save our strlen
> results, as I get identical performance results when doing this:
>
> diff --git a/cache-tree.c b/cache-tree.c
> index c6c084463b..a076e7cec5 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -156,6 +156,8 @@ static int verify_cache(struct cache_entry **cache,
>  {
>         int i, funny;
>         int silent =3D flags & WRITE_TREE_SILENT;
> +       const char *this_name;
> +       size_t this_len;
>
>         /* Verify that the tree is merged */
>         funny =3D 0;
> @@ -182,18 +184,21 @@ static int verify_cache(struct cache_entry **cache=
,
>          * and they should not exist unless a bug was introduced along
>          * the way.
>          */
> -       if (silent)
> -               return 0;
>         funny =3D 0;
> -       for (i =3D 0; i < entries - 1; i++) {
> +
> +       if (!entries)
> +               return 0;
> +       this_name =3D cache[0]->name;
> +       this_len =3D strlen(this_name);
> +
> +       for (i =3D 1; i < entries; i++) {
>                 /* path/file always comes after path because of the way
>                  * the cache is sorted.  Also path can appear only once,
>                  * which means conflicting one would immediately follow.
>                  */
> -               const char *this_name =3D cache[i]->name;
> -               const char *next_name =3D cache[i+1]->name;
> -               int this_len =3D strlen(this_name);
> -               if (this_len < strlen(next_name) &&
> +               const char *next_name =3D cache[i]->name;
> +               size_t next_len =3D strlen(next_name);
> +               if (this_len < next_len &&
>                     strncmp(this_name, next_name, this_len) =3D=3D 0 &&
>                     next_name[this_len] =3D=3D '/') {
>                         if (10 < ++funny) {
> @@ -203,6 +208,8 @@ static int verify_cache(struct cache_entry **cache,
>                         fprintf(stderr, "You have both %s and %s\n",
>                                 this_name, next_name);
>                 }
> +               this_name =3D next_name;
> +               this_len =3D next_len;
>         }
>         if (funny)
>                 return -1;
>

The compiler can do that because strlen() is a pure function; glibc
declares it like this:

   extern size_t strlen (const char *__s)
        __THROW __attribute_pure__ __nonnull ((1));

> HOWEVER, if we swap the order of the conditionals to be
>
> 		if (this_len < next_len &&
> 		    strncmp(this_name, next_name, this_len) =3D=3D 0 &&
> 		    next_name[this_len] =3D=3D '/') {
>
> then we _do_ get a measurable, consistent speedup.

That's the original order there, but I get it.  The trailing slash has
only a low probability of being present, so in the common case the
strncmp call can be skipped.  And I guess that check is easier to
handle for the branch predictor as well.

Since we know the length of both strings we can use memcmp instead of
strncmp.  It can compare words instead of bytes, so I'd expect it to
be faster.  Checking the slash first should make that difference moot,
though, as it probably eliminates most of the strncmp calls anyway.

Ren=C3=A9
