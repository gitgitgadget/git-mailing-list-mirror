Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819D61F4B6
	for <e@80x24.org>; Mon, 24 Jun 2019 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfFXTP5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 15:15:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:53580 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFXTP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 15:15:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9D1723F413E;
        Mon, 24 Jun 2019 15:15:55 -0400 (EDT)
Received: from [192.168.1.6] (152.sub-174-229-150.myvzw.com [174.229.150.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DB9553F412C;
        Mon, 24 Jun 2019 15:15:54 -0400 (EDT)
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-2-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
Date:   Mon, 24 Jun 2019 15:15:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624130226.17293-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/24/2019 9:02 AM, Nguyễn Thái Ngọc Duy wrote:
> So far we don't have a command to basically dump the index file out,
> with all its glory details. Checking some info, for example, stat
> time, usually involves either writing new code or firing up "xxd" and
> decoding values by yourself.
> 
> This --json is supposed to help that. It dumps the index in a human
> readable format but also easy to be processed with tools. And it will
> print almost enough info to reconstruct the index later.
> 
> In this patch we only dump the main part, not extensions. But at the
> end of the series, the entire index is dumped. The end result could be
> very verbose even on a small repository such as git.git.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

...

> diff --git a/json-writer.c b/json-writer.c
> index aadb9dbddc..0608726512 100644
> --- a/json-writer.c
> +++ b/json-writer.c
> @@ -202,6 +202,28 @@ void jw_object_null(struct json_writer *jw, const char *key)
>   	strbuf_addstr(&jw->json, "null");
>   }
>   
> +void jw_object_filemode(struct json_writer *jw, const char *key, mode_t mode)
> +{
> +	object_common(jw, key);
> +	strbuf_addf(&jw->json, "\"%06o\"", mode);
> +}
> +
> +void jw_object_stat_data(struct json_writer *jw, const char *name,
> +			 const struct stat_data *sd)

Should this be in json_writer.c or in read-cache.c ?
Currently, json_writer.c is concerned with formatting
JSON on basic/scalar types.  Do we want to start
extending it to handle arbitrary structures?  Or would
it be better for the code that defines/manipulates the
structure to define a "stat_data_dump_json()" function.

I'm torn on the jw_object_filemode() function, JSON format
limits us to decimal integers and there are places where
I'd like to have hex, or in this case octal values.

I'm thinking it'd be better to have a helper function in
read-cache.c that formats a local strbuf and calls
js_object_string(&jw, key, buf);


> +{
> +	jw_object_inline_begin_object(jw, name);
> +	jw_object_intmax(jw, "ctime_sec", sd->sd_ctime.sec);
> +	jw_object_intmax(jw, "ctime_nsec", sd->sd_ctime.nsec);
> +	jw_object_intmax(jw, "mtime_sec", sd->sd_mtime.sec);
> +	jw_object_intmax(jw, "mtime_nsec", sd->sd_mtime.nsec);

It'd be nice if we could also have a formatted date
for the mtime and ctime in addition to the integer
values.  (I'm not sure whether you'd always want them
or make it a verbose option.)

> +	jw_object_intmax(jw, "device", sd->sd_dev);
> +	jw_object_intmax(jw, "inode", sd->sd_ino);
> +	jw_object_intmax(jw, "uid", sd->sd_uid);
> +	jw_object_intmax(jw, "gid", sd->sd_gid);
> +	jw_object_intmax(jw, "size", sd->sd_size);
> +	jw_end(jw);
> +}
> +
>   static void increase_indent(struct strbuf *sb,
>   			    const struct json_writer *jw,
>   			    int indent)
> diff --git a/json-writer.h b/json-writer.h
> index 83906b09c1..c48c4cbf33 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -42,8 +42,11 @@
>    * of the given strings.
>    */
>   
> +#include "git-compat-util.h"
>   #include "strbuf.h"
>   
> +struct stat_data;
> +
>   struct json_writer
>   {
>   	/*
> @@ -81,6 +84,9 @@ void jw_object_true(struct json_writer *jw, const char *key);
>   void jw_object_false(struct json_writer *jw, const char *key);
>   void jw_object_bool(struct json_writer *jw, const char *key, int value);
>   void jw_object_null(struct json_writer *jw, const char *key);
> +void jw_object_filemode(struct json_writer *jw, const char *key, mode_t value);
> +void jw_object_stat_data(struct json_writer *jw, const char *key,
> +			 const struct stat_data *sd);
>   void jw_object_sub_jw(struct json_writer *jw, const char *key,
>   		      const struct json_writer *value);
>   
> @@ -104,4 +110,21 @@ void jw_array_inline_begin_array(struct json_writer *jw);
>   int jw_is_terminated(const struct json_writer *jw);
>   void jw_end(struct json_writer *jw);
>   
> +/*
> + * These _gently versions accept NULL json_writer to reduce too much
> + * branching at the call site.
> + */
> +static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
> +						       const char *name)
> +{
> +	if (jw)
> +		jw_object_inline_begin_array(jw, name);
> +}
> +
> +static inline void jw_end_gently(struct json_writer *jw)
> +{
> +	if (jw)
> +		jw_end(jw);
> +}
> +
>   #endif /* JSON_WRITER_H */
> diff --git a/read-cache.c b/read-cache.c
> index 4dd22f4f6e..db5147d088 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -25,6 +25,7 @@
>   #include "fsmonitor.h"
>   #include "thread-utils.h"
>   #include "progress.h"
> +#include "json-writer.h"
>   
>   /* Mask for the name length in ce_flags in the on-disk index */
>   
> @@ -1952,6 +1953,49 @@ static void *load_index_extensions(void *_data)
>   	return NULL;
>   }
>   
> +static void dump_cache_entry(struct index_state *istate,
> +			     int index,
> +			     unsigned long offset,
> +			     const struct cache_entry *ce)
> +{
> +	struct json_writer *jw = istate->jw;
> +
> +	jw_array_inline_begin_object(jw);
> +
> +	/*
> +	 * this is technically redundant, but it's for easier
> +	 * navigation when there hundreds of entries
> +	 */
> +	jw_object_intmax(jw, "id", index);
> +
> +	jw_object_string(jw, "name", ce->name);
> +
> +	jw_object_filemode(jw, "mode", ce->ce_mode);
> +
> +	jw_object_intmax(jw, "flags", ce->ce_flags);

It would be nice to have the flags as a hex-formatted string
in addition to (or instead of) the decimal integer value.

> +	/*
> +	 * again redundant info, just so you don't have to decode
> +	 * flags values manually
> +	 */
> +	if (ce->ce_flags & CE_EXTENDED)
> +		jw_object_true(jw, "extended_flags");
> +	if (ce->ce_flags & CE_VALID)
> +		jw_object_true(jw, "assume_unchanged");
> +	if (ce->ce_flags & CE_INTENT_TO_ADD)
> +		jw_object_true(jw, "intent_to_add");
> +	if (ce->ce_flags & CE_SKIP_WORKTREE)
> +		jw_object_true(jw, "skip_worktree");
> +	if (ce_stage(ce))
> +		jw_object_intmax(jw, "stage", ce_stage(ce));
> +
> +	jw_object_string(jw, "oid", oid_to_hex(&ce->oid));
> +
> +	jw_object_stat_data(jw, "stat", &ce->ce_stat_data);
> +	jw_object_intmax(jw, "file_offset", offset);
> +
> +	jw_end(jw);
> +}
> +
>   /*
>    * A helper function that will load the specified range of cache entries
>    * from the memory mapped file and add them to the given index.
> @@ -1972,6 +2016,9 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
>   		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
>   		set_index_entry(istate, i, ce);
>   
> +		if (istate->jw)
> +			dump_cache_entry(istate, i, src_offset, ce);
> +
>   		src_offset += consumed;
>   		previous_ce = ce;
>   	}
> @@ -1983,6 +2030,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
>   {
>   	unsigned long consumed;
>   
> +	jw_object_inline_begin_array_gently(istate->jw, "entries");
> +
>   	if (istate->version == 4) {
>   		mem_pool_init(&istate->ce_mem_pool,
>   				estimate_cache_size_from_compressed(istate->cache_nr));
> @@ -1993,6 +2042,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
>   
>   	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
>   					0, istate->cache_nr, mmap, src_offset, NULL);
> +
> +	jw_end_gently(istate->jw);
>   	return consumed;
>   }
>   
> @@ -2120,6 +2171,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	size_t extension_offset = 0;
>   	int nr_threads, cpus;
>   	struct index_entry_offset_table *ieot = NULL;
> +	int jw_pretty = 1;
>   
>   	if (istate->initialized)
>   		return istate->cache_nr;
> @@ -2154,6 +2206,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	istate->cache_nr = ntohl(hdr->hdr_entries);
>   	istate->cache_alloc = alloc_nr(istate->cache_nr);
>   	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
> +	istate->timestamp.sec = st.st_mtime;
> +	istate->timestamp.nsec = ST_MTIME_NSEC(st);
>   	istate->initialized = 1;
>   
>   	p.istate = istate;
> @@ -2176,6 +2230,20 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	if (!HAVE_THREADS)
>   		nr_threads = 1;
>   
> +	if (istate->jw) {
> +		jw_object_begin(istate->jw, jw_pretty);
> +		jw_object_intmax(istate->jw, "version", istate->version);
> +		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
> +		jw_object_intmax(istate->jw, "mtime_sec", istate->timestamp.sec);
> +		jw_object_intmax(istate->jw, "mtime_nsec", istate->timestamp.nsec);

again, it would be nice to also have a formated version of the mtime.

> +
> +		/*
> +		 * Threading may mess up json writing. This is for
> +		 * debugging only, so performance is not a concern.
> +		 */
> +		nr_threads = 1;

yes. we should turn off threading when dumping to json.

> +	}
> +
>   	if (nr_threads > 1) {
>   		extension_offset = read_eoie_extension(mmap, mmap_size);
>   		if (extension_offset) {
> @@ -2204,8 +2272,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
>   	}
>   
> -	istate->timestamp.sec = st.st_mtime;
> -	istate->timestamp.nsec = ST_MTIME_NSEC(st);
>   
>   	/* if we created a thread, join it otherwise load the extensions on the primary thread */
>   	if (extension_offset) {
> @@ -2216,6 +2282,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   		p.src_offset = src_offset;
>   		load_index_extensions(&p);
>   	}
> +	jw_end_gently(istate->jw);
> +
>   	munmap((void *)mmap, mmap_size);
>   
>   	/*
> 
...

Thanks
Jeff
