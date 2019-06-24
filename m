Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB9F1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfFXTc6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 15:32:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:56075 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfFXTc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 15:32:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BCB873F412B;
        Mon, 24 Jun 2019 15:32:56 -0400 (EDT)
Received: from [192.168.1.6] (152.sub-174-229-150.myvzw.com [174.229.150.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C733C3F40EB;
        Mon, 24 Jun 2019 15:32:55 -0400 (EDT)
Subject: Re: [PATCH v2 04/10] dir.c: dump "UNTR" extension as json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-5-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ec6bdf73-0c05-80cd-ecab-9a6ebf6aad6e@jeffhostetler.com>
Date:   Mon, 24 Jun 2019 15:32:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624130226.17293-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/24/2019 9:02 AM, Nguyễn Thái Ngọc Duy wrote:
> The big part of UNTR extension is dumped at the end instead of dumping
> as soon as we read it, because we actually "patch" some fields in
> untracked_cache_dir with EWAH bitmaps at the end.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   dir.c                    | 57 +++++++++++++++++++++++++++++++++++++++-
>   dir.h                    |  4 ++-
>   json-writer.h            |  6 +++++
>   read-cache.c             |  2 +-
>   t/t3011-ls-files-json.sh |  3 ++-
>   t/t3011/basic            | 39 +++++++++++++++++++++++++++
>   6 files changed, 107 insertions(+), 4 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index ba4a51c296..8808577ea3 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -19,6 +19,7 @@
>   #include "varint.h"
>   #include "ewah/ewok.h"
>   #include "fsmonitor.h"
> +#include "json-writer.h"
>   #include "submodule-config.h"
>   
>   /*
> @@ -2826,7 +2827,42 @@ static void load_oid_stat(struct oid_stat *oid_stat, const unsigned char *data,
>   	oid_stat->valid = 1;
>   }
>   
> -struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz)
> +static void jw_object_oid_stat(struct json_writer *jw, const char *key,
> +			       const struct oid_stat *oid_stat)

I was hoping to reserve the jw_, jw_object_, and jw_array_ prefixes
to refer to public functions in the json-writer.[ch] files, rather
than private functions elsewhere in the code.  I think it is less
confusing that way.  IMHO.

It's fine to have such helper functions for local structure types,
but I think it'd be better for them to not be named like other
public functions.

> +{
> +	jw_object_inline_begin_object(jw, key);
> +	jw_object_bool(jw, "valid", oid_stat->valid);
> +	jw_object_string(jw, "oid", oid_to_hex(&oid_stat->oid));
> +	jw_object_stat_data(jw, "stat", &oid_stat->stat);
> +	jw_end(jw);
> +}
> +
> +static void jw_object_untracked_cache_dir(struct json_writer *jw,
> +					  const struct untracked_cache_dir *ucd)
> +{
> +	int i;
> +
> +	jw_object_bool(jw, "valid", ucd->valid);
> +	jw_object_bool(jw, "check-only", ucd->check_only);
> +	jw_object_stat_data(jw, "stat", &ucd->stat_data);
> +	jw_object_string(jw, "exclude-oid", oid_to_hex(&ucd->exclude_oid));
> +	jw_object_inline_begin_array(jw, "untracked");
> +	for (i = 0; i < ucd->untracked_nr; i++)
> +		jw_array_string(jw, ucd->untracked[i]);
> +	jw_end(jw);
> +
> +	jw_object_inline_begin_object(jw, "dirs");
> +	for (i = 0; i < ucd->dirs_nr; i++) {
> +		jw_object_inline_begin_object(jw, ucd->dirs[i]->name);
> +		jw_object_untracked_cache_dir(jw, ucd->dirs[i]);
> +		jw_end(jw);
> +	}
> +	jw_end(jw);
> +}
> +
> +struct untracked_cache *read_untracked_extension(const void *data,
> +						 unsigned long sz,
> +						 struct json_writer *jw)
>   {
>   	struct untracked_cache *uc;
>   	struct read_data rd;
> @@ -2864,6 +2900,19 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
>   	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
>   	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
>   	uc->exclude_per_dir = xstrdup(exclude_per_dir);
> +
> +	if (jw) {
> +		jw_object_string(jw, "ident", ident);
> +		jw_object_oid_stat(jw, "info_exclude", &uc->ss_info_exclude);
> +		jw_object_oid_stat(jw, "excludes_file", &uc->ss_excludes_file);
> +		jw_object_intmax(jw, "flags", uc->dir_flags);
> +		if (uc->dir_flags & DIR_SHOW_OTHER_DIRECTORIES)
> +			jw_object_bool(jw, "show_other_directories", 1);
> +		if (uc->dir_flags & DIR_HIDE_EMPTY_DIRECTORIES)
> +			jw_object_bool(jw, "hide_empty_directories", 1);
> +		jw_object_string(jw, "excludes_per_dir", uc->exclude_per_dir);
> +	}
> +
>   	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
>   	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
>   	if (next >= end)
> @@ -2905,6 +2954,12 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
>   	ewah_each_bit(rd.sha1_valid, read_oid, &rd);
>   	next = rd.data;
>   
> +	if (jw) {
> +		jw_object_inline_begin_object(jw, "root");
> +		jw_object_untracked_cache_dir(jw, uc->root);
> +		jw_end(jw);
> +	}
> +
>   done:
>   	free(rd.ucd);
>   	ewah_free(rd.valid);
> diff --git a/dir.h b/dir.h
> index 680079bbe3..80efdd05c4 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -6,6 +6,8 @@
>   #include "cache.h"
>   #include "strbuf.h"
>   
> +struct json_writer;
> +
>   struct dir_entry {
>   	unsigned int len;
>   	char name[FLEX_ARRAY]; /* more */
> @@ -362,7 +364,7 @@ void untracked_cache_remove_from_index(struct index_state *, const char *);
>   void untracked_cache_add_to_index(struct index_state *, const char *);
>   
>   void free_untracked_cache(struct untracked_cache *);
> -struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
> +struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz, struct json_writer *jw);
>   void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
>   void add_untracked_cache(struct index_state *istate);
>   void remove_untracked_cache(struct index_state *istate);
> diff --git a/json-writer.h b/json-writer.h
> index c48c4cbf33..c3d0fbd1ef 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -121,6 +121,12 @@ static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
>   		jw_object_inline_begin_array(jw, name);
>   }
>   
> +static inline void jw_array_inline_begin_object_gently(struct json_writer *jw)
> +{
> +	if (jw)
> +		jw_array_inline_begin_object(jw);
> +}
> +
>   static inline void jw_end_gently(struct json_writer *jw)
>   {
>   	if (jw)

I'm not sure about the need for these _gently versions, but
maybe make them macros in json-writer.h

Jeff
