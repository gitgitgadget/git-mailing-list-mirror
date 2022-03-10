Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A7C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiCJAWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiCJAWK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:22:10 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4784123BD6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:21:10 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDB6612596A;
        Wed,  9 Mar 2022 19:21:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=efCZvwiGCIqCo6NhZOdc5BCNCvMfb7mu+g2IZ+
        cfW4A=; b=kLRKzeNqVMzIGxTB2B70xcQW7mysSN9r62o3hq5Q8+lx3QSm/cUBrm
        Z4RWPO1yWgg1P0JsLkQbpRYdR7VCXLUg1QcFgntWuccvxs0vF8m5ov/Rbypcbz8k
        YEUE3xQb541qQLy7IrnkpEn3berEnIuLb0Qq627Ml6kOIA+yraeKc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B350F125969;
        Wed,  9 Mar 2022 19:21:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26A2A125968;
        Wed,  9 Mar 2022 19:21:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:21:08 -0800
In-Reply-To: <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 09 Mar 2022 23:03:16
        +0000")
Message-ID: <xmqqo82eirnv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBD3294E-A007-11EC-9406-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * These values are used to help identify parts of a repository to fsync.
> + * FSYNC_COMPONENT_NONE identifies data that will not be a persistent part of the
> + * repository and so shouldn't be fsynced.
> + */
> +enum fsync_component {
> +	FSYNC_COMPONENT_NONE,
> +	FSYNC_COMPONENT_LOOSE_OBJECT		= 1 << 0,
> +	FSYNC_COMPONENT_PACK			= 1 << 1,
> +	FSYNC_COMPONENT_PACK_METADATA		= 1 << 2,
> +	FSYNC_COMPONENT_COMMIT_GRAPH		= 1 << 3,
> +};

OK, so the idea is that Patrick's "we need to fsync refs" will be
done by adding a new component to this list, and sprinkling a call
to fsync_component_or_die() in the code of ref-files backend?

I am wondering if fsync_or_die() interface is abstracted well
enough, or we need things like "the fd is inside this directory; in
addition to doing the fsync of the fd, please sync the parent
directory as well" support before we start adding more components
(if there is such a need, perhaps it comes before this step).

> +#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
> +				  FSYNC_COMPONENT_PACK_METADATA | \
> +				  FSYNC_COMPONENT_COMMIT_GRAPH)

IOW, everything other than loose object, which already has a
separate core.fsyncObjectFiles knob to loosen.  Everything else we
currently sync unconditionally and the default keeps that
arrangement?

> +static inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
> +{
> +	if (fsync_components & component)
> +		fsync_or_die(fd, msg);
> +}

Do we have a compelling reason to have this as a static inline
function?  We are talking about concluding an I/O operation and
I doubt there is a good performance argument for it.

> +static const struct fsync_component_entry {
> +	const char *name;
> +	enum fsync_component component_bits;
> +} fsync_component_table[] = {

thing[] is an array of "thing" (and thing[4] is the "fourth" such
thing), but this is not an array of a table (it is a name-to-bit
mapping).

I wonder if this array works without "_table" suffix in its name.

> +	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> +	{ "pack", FSYNC_COMPONENT_PACK },
> +	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> +	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> +};
> +
> +static enum fsync_component parse_fsync_components(const char *var, const char *string)
> +{
> +	enum fsync_component output = 0;
> +
> +	if (!strcmp(string, "none"))
> +		return FSYNC_COMPONENT_NONE;
> +
> +	while (string) {
> +		int i;
> +		size_t len;
> +		const char *ep;
> +		int negated = 0;
> +		int found = 0;
> +
> +		string = string + strspn(string, ", \t\n\r");
> +		ep = strchrnul(string, ',');
> +		len = ep - string;
> +
> +		if (*string == '-') {
> +			negated = 1;
> +			string++;
> +			len--;
> +			if (!len)
> +				warning(_("invalid value for variable %s"), var);
> +		}
> +
> +		if (!len)
> +			break;
> +
> +		for (i = 0; i < ARRAY_SIZE(fsync_component_table); ++i) {
> +			const struct fsync_component_entry *entry = &fsync_component_table[i];
> +
> +			if (strncmp(entry->name, string, len))
> +				continue;
> +
> +			found = 1;
> +			if (negated)
> +				output &= ~entry->component_bits;
> +			else
> +				output |= entry->component_bits;
> +		}
> +
> +		if (!found) {
> +			char *component = xstrndup(string, len);
> +			warning(_("ignoring unknown core.fsync component '%s'"), component);
> +			free(component);
> +		}
> +
> +		string = ep;
> +	}
> +
> +	return output;
> +}

Hmph.  I would have expected, with built-in default of
pack,pack-metadata,commit-graph,

 - "none,pack" would choose only "pack" by first clearing the
   built-in default (or whatever was set in configuration files that
   are lower precedence than what we are reading) and then OR'ing
   the "pack" bit in.

 - "-pack" would choose "pack-metadata,commit-graph" by first
   starting from the built-in default and then CLR'ing the "pack"
   bit out.  If there were already changes made by the lower
   precedence configuration files like /etc/gitconfig, the result
   might be different and the only definite thing we can say is that
   the pack bit is cleared.

 - "loose-object" would choose all of the bits by first starting
   from the built-in default and then OR'ing the "loose-object" bit
   in.

Otherwise, parsing "none" is more or less pointless, as the above
parser always start from 0 and OR's in or CLR's out the named bit.
Whoever writes "none" can just write an empty string, no?

I wonder you'd rather want to do it this way?

parse_fsync_components(var, value, current) {
	enum fsync_component positive = 0, negative = 0;

	while (string) {
		int negated = 0;
		enum fsync_component bits;

		parse out a single component into <negated, bits>;

		if (bits == 0) { /* "none" given */
                	current = 0;
		} else if (negated) {
			negative |= bits;
		} else {
			positive |= bits;
		}
		advance <string> pointer;
	}

	return (current | positive) & ~negative;
}

And then ...

> +	if (!strcmp(var, "core.fsync")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		fsync_components = parse_fsync_components(var, value);
> +		return 0;
> +	}
> +

... this part would pass the current value of fsync_components as
the third parameter to the parse_fsync_components().  The variable
would be initialized to the FSYNC_COMPONENTS_DEFAULT we saw earlier.


> @@ -1613,7 +1684,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "core.fsyncobjectfiles")) {
> -		fsync_object_files = git_config_bool(var, value);
> +		warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));

This is not deprecating but removing the support, which I am not
sure is a sensible thing to do.  Rather we should pretend that
core.fsync = "loose-object" (or "-loose-object") were found in the
configuration, shouldn't we?

