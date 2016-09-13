Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A33720984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbcIMQbY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:31:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754132AbcIMQbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:31:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 767213DB39;
        Tue, 13 Sep 2016 12:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qcULtBpXe3imN0mw6o9aud0tNMo=; b=MMiZ5X
        6UBvQJPDNX4moAas+3/P/CCVdHgu7MwQ+JIaWXmZvpWdmMeJ6MBN2ZWxbJK9uzsz
        jQVGxskcDVTW0fancZJhFtJqJCrbkZInGb5Mtz6V+nu+tioMGXhTneWLwqu2JF8C
        bHurcezfCYL0s9OmpHkB7wBuBnyF41XGMlC3g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rzB7tzc4JKrKL7qOTkXzYgaBAG65Fcv4
        J7p1aAb7fddvav8mOniYQ3KAAxlDZBMCgbx1+h3l4evDRHigMbHp9JDxIypla2b7
        YTDj5rEIRjy6qb6uo+zu4f0W4KU2SNbdXX//WjEMk6KS/CxPN59fyECCWlSw/Zkp
        PBSRgPJAHH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6305B3DB38;
        Tue, 13 Sep 2016 12:31:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1AD53DB37;
        Tue, 13 Sep 2016 12:31:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <1473726835-143289-1-git-send-email-bmwill@google.com>
Date:   Tue, 13 Sep 2016 09:31:18 -0700
In-Reply-To: <1473726835-143289-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 12 Sep 2016 17:33:55 -0700")
Message-ID: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80DFC968-79CF-11E6-81EE-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Allow ls-files to recognize submodules in order to retrieve a list of
> files from a repository's submodules.  This is done by forking off a
> process to recursively call ls-files on all submodules. Also added an
> output-path-prefix command in order to prepend paths to child processes.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

> @@ -68,6 +71,21 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
>  static void write_name(const char *name)
>  {
>  	/*
> +	 * NEEDSWORK: To make this thread-safe, full_name would have to be owned
> +	 * by the caller.
> +	 *
> +	 * full_name get reused across output lines to minimize the allocation
> +	 * churn.
> +	 */
> +	static struct strbuf full_name = STRBUF_INIT;
> +	if (output_path_prefix != '\0') {
> +		strbuf_reset(&full_name);
> +		strbuf_addstr(&full_name, output_path_prefix);
> +		strbuf_addstr(&full_name, name);
> +		name = full_name.buf;
> +	}

At first glance it was surprising that no test caught this lack of
dereference; the reason is because you initialize output_path_prefix
to an empty string, not NULL, causing full_name.buf always used,
which does not have an impact on the output.

I think initializing it to NULL is a more typical way to say "this
option has not been given", and if you took that route, the
condition would become

	if (output_path_prefix && *output_path_prefix) {
        	...

In any case, the fact that only this much change was required to add
output-path-prefix shows two good things: (1) the original code was
already well structured, funneling any pathname we need to emit
through this single function so that we can do this kind of updates,
and (2) the author of the patch was competent to spot this single
point that needs to be updated.

Nice.

> +	status = run_command(&cp);
> +	if (status)
> +		exit(status);

run_command()'s return value comes from either start_command() or
finish_command().  These signal failure by returning a non-zero
value, and in practice they are negative small integers.  Feeding
negative value to exit() is not quite kosher.  Perhaps exit(128)
to mimick as if we called die() is better.

If your primary interest is to support the "find in the working tree
files that are tracked, recursively in submodules" grep, I think
this "when we hit a submodule, spawn a separate ls-files in there"
is sufficient and a solid base to build on it.

On the other hand, if you are more ambitious and "grep" is merely an
example of things that can be helped by having a list of paths
across module boundaries, we may want to "libify" ls-files in such a
way that a single process can instantiate one or more instances of
"ls-files machinery", that takes which repository to work in and
other arguments that specifies which paths to report, and instead of
always showing the result to the standard output, makes repeated
calls to a callback function to report the discovered path and other
attributes associated with the path that were asked for (the object
name, values of tag_*, etc.), without spawning a separate "ls-files"
process.

The latter would be a lot bigger task and I do not necessarily think
it is needed, but that is one possible future direction to keep in
mind.

Thanks, will queue with a minimum fix.
