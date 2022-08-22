Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812FEC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiHVSVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiHVSVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:21:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04F474E0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:21:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F17D1AC43E;
        Mon, 22 Aug 2022 14:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R8803O51lAzKV0lzLXt9XqxMPTMf3Eu5m5xkJX
        RZhO8=; b=mO/x7Be7RFyxS05hlpm3yEV8iV7ZtzMVZrNVgasKOsaAJJrFmZhl03
        b9hpqgW5Be6sYOCR36iuvqq67Q3/no97sQb4jAJz7POcCin7THG46dNXJAlFuf43
        mHdHUMbvpJzNHsgTUHrIYiboMt2W7FrFA+RxTGDrJgWItkY1aelEU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7760E1AC43D;
        Mon, 22 Aug 2022 14:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20A521AC43A;
        Mon, 22 Aug 2022 14:21:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/7] bundle-uri: create base key-value pair parsing
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 11:20:58 -0700
In-Reply-To: <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 22 Aug 2022
        15:12:49 +0000")
Message-ID: <xmqqzgfwcf79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C69FDE6-2247-11ED-B2C1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e376d547ce0..4280af6992e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -387,6 +387,8 @@ include::config/branch.txt[]
>  
>  include::config/browser.txt[]
>  
> +include::config/bundle.txt[]
> +

The file that records a list of bundles may borrow the format of git
config files, but will we store their contents in configuration
files in the receiving (or originating) repository?  With the
presence of fields like "bundle.version", I somehow doubt it.

Should "git config --help" list them?

> diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
> new file mode 100644
> index 00000000000..3515bfe38d1
> --- /dev/null
> +++ b/Documentation/config/bundle.txt

If the answer is "no", then this file looks out of place.

> diff --git a/bundle-uri.c b/bundle-uri.c
> index ceeef0b6641..ade7eccce39 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -66,6 +66,80 @@ int for_all_bundles_in_list(struct bundle_list *list,
>  	return 0;
>  }
>  
> +/**
> + * Given a key-value pair, update the state of the given bundle list.
> + * Returns 0 if the key-value pair is understood. Returns 1 if the key
> + * is not understood or the value is malformed.

Let's stick to the "error is negative" if we do not have a strong
reason not to.

> + */
> +MAYBE_UNUSED
> +static int bundle_list_update(const char *key, const char *value,
> +			      struct bundle_list *list)
> +{
> +	const char *pkey, *dot;
> +	struct strbuf id = STRBUF_INIT;
> +	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
> +	struct remote_bundle_info *bundle;
> +
> +	if (!skip_prefix(key, "bundle.", &pkey))
> +		return 1;
> +	dot = strchr(pkey, '.');
> +	if (!dot) {
> +		if (!strcmp(pkey, "version")) {
> +			int version = atoi(value);

Can atoi() safely fail?  Are we happy of pkey that says "1A" and we
parse it as "1"?

> +			if (version != 1)
> +				return 1;
> +
> +			list->version = version;
> +			return 0;
> +		}

Is it OK for a bundle list described in the config-file format to
have "bundle.version" twice, giving different values?  It feels
counter-intuitive to apply the "last one wins" rule that is usual
for configuration files.

> +		if (!strcmp(pkey, "mode")) {
> +			if (!strcmp(value, "all"))
> +				list->mode = BUNDLE_MODE_ALL;
> +			else if (!strcmp(value, "any"))
> +				list->mode = BUNDLE_MODE_ANY;
> +			else
> +				return 1;
> +			return 0;
> +		}

Likewise for bundle.mode

> +		/* Ignore other unknown global keys. */
> +		return 0;
> +	}
> +
> +	strbuf_add(&id, pkey, dot - pkey);
> +	dot++;
> +
> +	/*
> +	 * Check for an existing bundle with this <id>, or create one
> +	 * if necessary.
> +	 */
> +	lookup.id = id.buf;
> +	hashmap_entry_init(&lookup.ent, strhash(lookup.id));
> +	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
> +		CALLOC_ARRAY(bundle, 1);
> +		bundle->id = strbuf_detach(&id, NULL);
> +		strbuf_init(&bundle->file, 0);
> +		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
> +		hashmap_add(&list->bundles, &bundle->ent);
> +	}
> +	strbuf_release(&id);
> +
> +	if (!strcmp(dot, "uri")) {
> +		free(bundle->uri);
> +		bundle->uri = xstrdup(value);
> +		return 0;
> +	}

This explicitly implements "the last one wins".  Would it really
make sense for a server to serve a bundle list that says redundant
and wasteful pieces of information, i.e.

    [bundle "1"]
	url = one
	url = two

It is not like doing so would allow us to reuse an otherwise mostly
good file by appending new information and that would be a performance
or storage win.  So I am not quite sure why we want "the last one wins"
rule here.  It instead looks like something we want to sanity check
and complain about.

> +	/*
> +	 * At this point, we ignore any information that we don't
> +	 * understand, assuming it to be hints for a heuristic the client
> +	 * does not currently understand.
> +	 */

This is sensible.

> +	return 0;
> +}
> +
>  static int find_temp_filename(struct strbuf *name)
>  {
>  	int fd;
