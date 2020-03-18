Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F0C5ACD7
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DEE20770
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 11:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgCRLSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:18:24 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31216 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgCRLST (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 07:18:19 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jEWiG-0009zh-5I; Wed, 18 Mar 2020 11:18:17 +0000
Subject: Re: [RFC PATCH 2/2] upload-pack.c: allow banning certain object
 filter(s)
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, james@jramsay.com.au
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <13dd0152-b20a-51e1-5940-5e4b67242e9b@iee.email>
Date:   Wed, 18 Mar 2020 11:18:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <888d9484cf4130e90f451134c236a290a6c5e18d.1584477196.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi
On 17/03/2020 20:39, Taylor Blau wrote:
> Git clients may ask the server for a partial set of objects, where the
> set of objects being requested is refined by one or more object filters.
> Server administrators can configure 'git upload-pack' to allow or ban
> these filters by setting the 'uploadpack.allowFilter' variable to
> 'true' or 'false', respectively.
>
> However, administrators using bitmaps may wish to allow certain kinds of
> object filters, but ban others. Specifically, they may wish to allow
> object filters that can be optimized by the use of bitmaps, while
> rejecting other object filters which aren't and represent a perceived
> performance degradation (as well as an increased load factor on the
> server).
>
> Allow configuring 'git upload-pack' to support object filters on a
> case-by-case basis by introducing a new configuration variable and
> section:
>
>   - 'uploadpack.filter.allow'
>
>   - 'uploadpack.filter.<kind>.allow'
>
> where '<kind>' may be one of 'blob:none', 'blob:limit', 'tree:depth',
> and so on. The additional '.' between 'filter' and '<kind>' is part of
> the sub-section.
>
> Setting the second configuration variable for any valid value of
> '<kind>' explicitly allows or disallows restricting that kind of object
> filter.
>
> If a client requests the object filter <kind> and the respective
> configuration value is not set, 'git upload-pack' will default to the
> value of 'uploadpack.filter.allow', which itself defaults to 'true' to
> maintain backwards compatibility. Note that this differs from
> 'uploadpack.allowfilter', which controls whether or not the 'filter'
> capability is advertised.
>
> NB: this introduces an unfortunate possibility that attempt to write the
> ERR sideband will cause a SIGPIPE. This can be prevented by some of
> SZEDZER's previous work, but it is silenced in 't' for now.
> ---
>  Documentation/config/uploadpack.txt | 12 ++++++
>  t/t5616-partial-clone.sh            | 23 ++++++++++
>  upload-pack.c                       | 67 +++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>
> diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
> index ed1c835695..6213bd619c 100644
> --- a/Documentation/config/uploadpack.txt
> +++ b/Documentation/config/uploadpack.txt
> @@ -57,6 +57,18 @@ uploadpack.allowFilter::
>  	If this option is set, `upload-pack` will support partial
>  	clone and partial fetch object filtering.
>  
> +uploadpack.filter.allow::
> +	Provides a default value for unspecified object filters (see: the
> +	below configuration variable).
> +	Defaults to `true`.
> +
> +uploadpack.filter.<filter>.allow::
> +	Explicitly allow or ban the object filter corresponding to `<filter>`,
> +	where `<filter>` may be one of: `blob:none`, `blob:limit`, `tree:depth`,
> +	`sparse:oid`, or `combine`. If using combined filters, both `combine`
> +	and all of the nested filter kinds must be allowed.

Doesn't the man page at least need the part from the commit message "The
additional '.' between 'filter' and '<kind>' is part of
the sub-section." as it's not a common mechanism (other comments not
withstanding)

Philip
> +	Defaults to `uploadpack.filter.allow`.
> +
>  uploadpack.allowRefInWant::
>  	If this option is set, `upload-pack` will support the `ref-in-want`
>  	feature of the protocol version 2 `fetch` command.  This feature
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 77bb91e976..ee1af9b682 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -235,6 +235,29 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
>  	test_cmp unique_types.expected unique_types.actual
>  '
>  
> +test_expect_success 'upload-pack fails banned object filters' '
> +	# Ensure that configuration keys are normalized by capitalizing
> +	# "blob:None" below:
> +	test_config -C srv.bare uploadpack.filter.blob:None.allow false &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter.blob:none \
> +		"file://$(pwd)/srv.bare" pc3
> +'
> +
> +test_expect_success 'upload-pack fails banned combine object filters' '
> +	test_config -C srv.bare uploadpack.filter.allow false &&
> +	test_config -C srv.bare uploadpack.filter.combine.allow true &&
> +	test_config -C srv.bare uploadpack.filter.tree:depth.allow true &&
> +	test_config -C srv.bare uploadpack.filter.blob:none.allow false &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
> +		--filter=blob:none "file://$(pwd)/srv.bare" pc3
> +'
> +
> +test_expect_success 'upload-pack fails banned object filters with fallback' '
> +	test_config -C srv.bare uploadpack.filter.allow false &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
> +		"file://$(pwd)/srv.bare" pc3
> +'
> +
>  test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
>  	rm -rf src dst &&
>  	git init src &&
> diff --git a/upload-pack.c b/upload-pack.c
> index c53249cac1..81f2701f99 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -69,6 +69,8 @@ static int filter_capability_requested;
>  static int allow_filter;
>  static int allow_ref_in_want;
>  static struct list_objects_filter_options filter_options;
> +static struct string_list allowed_filters = STRING_LIST_INIT_DUP;
> +static int allow_filter_fallback = 1;
>  
>  static int allow_sideband_all;
>  
> @@ -848,6 +850,45 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
>  	return 0;
>  }
>  
> +static int allows_filter_choice(enum list_objects_filter_choice c)
> +{
> +	const char *key = list_object_filter_config_name(c);
> +	struct string_list_item *item = string_list_lookup(&allowed_filters,
> +							   key);
> +	if (item)
> +		return (intptr_t) item->util;
> +	return allow_filter_fallback;
> +}
> +
> +static struct list_objects_filter_options *banned_filter(
> +	struct list_objects_filter_options *opts)
> +{
> +	size_t i;
> +
> +	if (!allows_filter_choice(opts->choice))
> +		return opts;
> +
> +	if (opts->choice == LOFC_COMBINE)
> +		for (i = 0; i < opts->sub_nr; i++) {
> +			struct list_objects_filter_options *sub = &opts->sub[i];
> +			if (banned_filter(sub))
> +				return sub;
> +		}
> +	return NULL;
> +}
> +
> +static void die_if_using_banned_filter(struct packet_writer *w,
> +				       struct list_objects_filter_options *opts)
> +{
> +	struct list_objects_filter_options *banned = banned_filter(opts);
> +	if (!banned)
> +		return;
> +
> +	packet_writer_error(w, _("filter '%s' not supported\n"),
> +			    list_object_filter_config_name(banned->choice));
> +	die(_("git upload-pack: banned object filter requested"));
> +}
> +
>  static void receive_needs(struct packet_reader *reader, struct object_array *want_obj)
>  {
>  	struct object_array shallows = OBJECT_ARRAY_INIT;
> @@ -885,6 +926,7 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
>  				die("git upload-pack: filtering capability not negotiated");
>  			list_objects_filter_die_if_populated(&filter_options);
>  			parse_list_objects_filter(&filter_options, arg);
> +			die_if_using_banned_filter(&writer, &filter_options);
>  			continue;
>  		}
>  
> @@ -1044,6 +1086,9 @@ static int find_symref(const char *refname, const struct object_id *oid,
>  
>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
> +	const char *sub, *key;
> +	int sub_len;
> +
>  	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
>  		if (git_config_bool(var, value))
>  			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
> @@ -1065,6 +1110,26 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  			keepalive = -1;
>  	} else if (!strcmp("uploadpack.allowfilter", var)) {
>  		allow_filter = git_config_bool(var, value);
> +	} else if (!parse_config_key(var, "uploadpack", &sub, &sub_len, &key) &&
> +		   key && !strcmp(key, "allow")) {
> +		if (sub && skip_prefix(sub, "filter.", &sub) && sub_len >= 7) {
> +			struct string_list_item *item;
> +			char *spec;
> +
> +			/*
> +			 * normalize the filter, and chomp off '.allow' from the
> +			 * end
> +			 */
> +			spec = xstrdup_tolower(sub);
> +			spec[sub_len - 7] = 0;
> +
> +			item = string_list_insert(&allowed_filters, spec);
> +			item->util = (void *) (intptr_t) git_config_bool(var, value);
> +
> +			free(spec);
> +		} else if (!strcmp("uploadpack.filter.allow", var)) {
> +			allow_filter_fallback = git_config_bool(var, value);
> +		}
>  	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
>  		allow_ref_in_want = git_config_bool(var, value);
>  	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
> @@ -1308,6 +1373,8 @@ static void process_args(struct packet_reader *request,
>  		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
>  			list_objects_filter_die_if_populated(&filter_options);
>  			parse_list_objects_filter(&filter_options, p);
> +			die_if_using_banned_filter(&data->writer,
> +						   &filter_options);
>  			continue;
>  		}
>  

