Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5741F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 22:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdGYWZU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 18:25:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55255 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750996AbdGYWZT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 18:25:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98FDB79EF6;
        Tue, 25 Jul 2017 18:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sYkn6j/iLe8zS7pu1DsFoui2o+M=; b=o/0EW0
        qqIAiG4bMHckCTpBYAh67t9sfTORx76U4+mnoyeuLSYwH41DVjU9YxTbP9cZZ5C8
        BIr9RKOjzyeCD+ISuccDJT7oquICKhLtemPMfWkiVCR8uLFJ4/g1AFtrS90djfyx
        DtdmIGWkIHWwzO5wIRrEhBKsIty4PeJPivk0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=geXFDnhayS++LTBhjQQ4GMAIOp5Q0ruB
        hPSX2aVqBnwl/Qb8cO6k5aek/i0RvQjjcsSNvwuRo7JwCFHZkhuGPp4LySKEuyRj
        4Sxnmwhbq6NCxbT3nyZUM59zRVvjkiQIbEqhW193wxVr4W4NGPyMPX2NoD5T989s
        3kCBeyZVU7k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 904F379EF5;
        Tue, 25 Jul 2017 18:25:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFA9779EF2;
        Tue, 25 Jul 2017 18:25:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peartben@gmail.com
Subject: Re: [PATCH v2 2/2] sub-process: refactor handshake to common function
References: <cover.1501007300.git.jonathantanmy@google.com>
        <20170724213810.29831-1-jonathantanmy@google.com>
        <cover.1501007300.git.jonathantanmy@google.com>
        <e47344b6e4bce2a038ba62abb158ec720221a96c.1501007300.git.jonathantanmy@google.com>
Date:   Tue, 25 Jul 2017 15:25:15 -0700
In-Reply-To: <e47344b6e4bce2a038ba62abb158ec720221a96c.1501007300.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 25 Jul 2017 11:29:38 -0700")
Message-ID: <xmqqinigtar8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22B660D4-7188-11E7-9F07-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Refactor, into a common function, the version and capability negotiation
> done when invoking a long-running process as a clean or smudge filter.
> This will be useful for other Git code that needs to interact similarly
> with a long-running process.
>
> As you can see in the change to t0021, this commit changes the error
> message reported when the long-running process does not introduce itself
> with the expected "server"-terminated line. Originally, the error
> message reports that the filter "does not support filter protocol
> version 2", differentiating between the old single-file filter protocol
> and the new multi-file filter protocol - I have updated it to something
> more generic and useful.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Overall I like the direction, even though the abstraction the
resulting code results in seems to me a bit too tightly defined; in
other words, I cannot be sure that this will be useful enough in a
more general context, or make some potential applications feel a bit
too constrained.

> +	static int versions[] = {2, 0};
> +	static struct subprocess_capability capabilities[] = {
> +		{"clean", CAP_CLEAN}, {"smudge", CAP_SMUDGE}, {NULL, 0}
> +	};
>  	struct cmd2process *entry = (struct cmd2process *)subprocess;
> ...
> +	return subprocess_handshake(subprocess, "git-filter-", versions, NULL,
> +				    capabilities,
> +				    &entry->supported_capabilities);
>  }

I would have defined the welcome prefix to lack the final dash,
i.e. forcing the hardcoded suffixes for clients and servers in any
protocol that uses this API to end with "-client" and "-server",
i.e. with dash.

> diff --git a/sub-process.c b/sub-process.c
> index a3cfab1a9..1a3f39bdf 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -105,3 +105,97 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>  	hashmap_add(hashmap, entry);
>  	return 0;
>  }
> +
> +int subprocess_handshake(struct subprocess_entry *entry,
> +			 const char *welcome_prefix,
> +			 int *versions,
> +			 int *chosen_version,
> +			 struct subprocess_capability *capabilities,
> +			 unsigned int *supported_capabilities) {
> +	int version_scratch;
> +	unsigned int capabilities_scratch;
> +	struct child_process *process = &entry->process;
> +	int i;
> +	char *line;
> +	const char *p;
> +
> +	if (!chosen_version)
> +		chosen_version = &version_scratch;
> +	if (!supported_capabilities)
> +		supported_capabilities = &capabilities_scratch;
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	if (packet_write_fmt_gently(process->in, "%sclient\n",
> +				    welcome_prefix)) {
> +		error("Could not write client identification");
> +		goto error;
> +	}
> +	for (i = 0; versions[i]; i++) {
> +		if (packet_write_fmt_gently(process->in, "version=%d\n",
> +					    versions[i])) {
> +			error("Could not write requested version");
> +			goto error;
> +		}
> +	}

This forces version numbers to be positive integers, which is OK, as
I do not see it a downside that any potential application cannot use
"version=0".

> +	if (packet_flush_gently(process->in))
> +		goto error;
> +
> +	if (!(line = packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, welcome_prefix, &p) ||
> +	    strcmp(p, "server")) {
> +		error("Unexpected line '%s', expected %sserver",
> +		      line ? line : "<flush packet>", welcome_prefix);
> +		goto error;
> +	}
> +	if (!(line = packet_read_line(process->out, NULL)) ||
> +	    !skip_prefix(line, "version=", &p) ||
> +	    strtol_i(p, 10, chosen_version)) {
> +		error("Unexpected line '%s', expected version",
> +		      line ? line : "<flush packet>");
> +		goto error;
> +	}
> +	for (i = 0; versions[i]; i++) {
> +		if (versions[i] == *chosen_version)
> +			goto version_found;
> +	}
> +	error("Version %d not supported", *chosen_version);
> +	goto error;
> +version_found:

It would have been more natural to do

	for (i = 0; versions[i]; i++)
		if (versions[i] == *chosen_version)
			break;
	if (versions[i]) {
		error("...");
		goto error;
	}

without "version_found:" label.  In general, I'd prefer to avoid
jumping to a label in the normal/expected case and reserve "goto"
for error handling.

> +	if ((line = packet_read_line(process->out, NULL))) {
> +		error("Unexpected line '%s', expected flush", line);
> +		goto error;
> +	}
> +
> +	for (i = 0; capabilities[i].name; i++) {
> +		if (packet_write_fmt_gently(process->in, "capability=%s\n",
> +					    capabilities[i].name)) {
> +			error("Could not write requested capability");
> +			goto error;
> +		}
> +	}
> +	if (packet_flush_gently(process->in))
> +		goto error;
> +
> +	while ((line = packet_read_line(process->out, NULL))) {
> +		if (!skip_prefix(line, "capability=", &p))
> +			continue;
> +
> +		for (i = 0; capabilities[i].name; i++) {
> +			if (!strcmp(p, capabilities[i].name)) {
> +				*supported_capabilities |= capabilities[i].flag;
> +				goto capability_found;
> +			}
> +		}
> +		warning("external filter requested unsupported filter capability '%s'",
> +			p);
> +capability_found:
> +		;

Likewise.

Also, this is the reason why I said this might make future
applications feel a bit too constrained; is the set of fields in the
subprocess_capability struct general enough?  It can only say "a
capability with this name was found" with a single bit, so you can
have only 32 (or 64) capabilities that are all yes/no.  I am not
saying that is definitely insufficient (not yet anyway); I am
wondering if future applications may need to have something like:

	capability=buffer-size=64k

where "=64k" part is not known at this layer but is known by the
user of the API.

> +	}
> +
> +	sigchain_pop(SIGPIPE);
> +	return 0;
> +error:
> +	sigchain_pop(SIGPIPE);
> +	return 1;

I would prepare at the beginning of the function:

	int retval = -1; /* assume failure */

and rewrite the above to

                retval = 0;
        error:
                sigchain_pop(SIGPIPE);
                return retval;

if I were writing this code.
