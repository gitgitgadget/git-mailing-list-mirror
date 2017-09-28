Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB292047F
	for <e@80x24.org>; Thu, 28 Sep 2017 03:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbdI1DsE (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 23:48:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750753AbdI1DsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 23:48:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10FBE9C795;
        Wed, 27 Sep 2017 23:48:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yzjwtGuUTNdFch8nvysEjj85h3M=; b=VqdwQi
        +gaoHPRPMS/8rVzvauOSRLBIQe+BZvireEqTvcux6NmFrwpYpsZE+9mekJCBuafz
        nEB1Y4MQd3CgJVS50OtB6F99Ss79QhkifR9XZeRiGy0EZJTcnl/w+2loUzuLDqxr
        Pm/gn2BpH5kh6AXz1bbUXUnyOsnG2QngB9ESU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vy0Kz/cxf+jU6bVjuu+3kW81vhfrnLkd
        BMAZ1u/X7sg/P1eQw3/TixJKdE9lNsjgsiqWyWyqD7MQqgyTVU1OxqCJYBQn2EwN
        dpzOVDZevfP6zu8b9JOgvJuyxXJl6xvUsgFFRjHvucSnwZm0irIzDYjywf3zw8hd
        VViiMp0Rk7s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0914F9C794;
        Wed, 27 Sep 2017 23:48:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B6E49C792;
        Wed, 27 Sep 2017 23:48:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
        <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
Date:   Thu, 28 Sep 2017 12:48:00 +0900
In-Reply-To: <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
        (Eric Rannaud's message of "Wed, 27 Sep 2017 12:46:26 -0700")
Message-ID: <xmqqh8vn32mn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3DCEE92-A3FF-11E7-88D7-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 67b8c50a5ab4..9aa3470d895b 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3120,4 +3120,133 @@ test_expect_success 'U: validate root delete result' '
>  	compare_diff_raw expect actual
>  '
>  
> +###
> +### series V (checkpoint)
> +###
> +
> +# To make sure you're observing the side effects of checkpoint *before*
> +# fast-import terminates (and thus writes out its state), check that the
> +# fast-import process is still running using background_import_still_running
> +# *after* evaluating the test conditions.
> +background_import_until_checkpoint () {
> +	options=$1
> +	input_file=$2
> +
> +	mkfifo V.input
> +	exec 8<>V.input
> +	rm V.input
> +
> +	mkfifo V.output
> +	exec 9<>V.output
> +	rm V.output
> +
> +	cat $input_file >&8

It probably is a good idea to quote "$input_file" in case other
people later use a full path to the file or something; for now this
is OK.

fd#8 at this point does not have a reader; unless the contents of
the $input_file is small enough, wouldn't this "cat" block until
somebody else comes and reads from it to drain?  Should we instead
start fast-import first in the background, arrange it to be killed
when we are done with it, and then start feeding the input?

> +	git fast-import $options <&8 >&9 &
> +	echo $! >V.pid
> +	test_when_finished "kill $(cat V.pid) || true"

This '|| true' is here because the process might already have died
on its own, which sounds like a sensible precaution.

> +	error=0
> +	if read output <&9
> +	then
> +		if ! test "$output" = "progress checkpoint"
> +		then
> +			echo >&2 "no progress checkpoint received: $output"
> +			error=1
> +		fi
> +	else
> +		echo >&2 "failed to read fast-import output"
> +		error=1
> +	fi

And we expect "progress checkpoint" would be the first and only
output after fast-import consumes all the input stream up to the
"progress" thing we feed, so this is not "read and discard until
we see 'progress checkpoint'" but is "read one and that must be
'progress checkpoint'".  Makes sense to me.

If this script is (and will be in the future) all about issuing a
checkpoint command and observing its effect, we can reasonably
expect that the input file _must_ end with "checkpoint" followed by
"progress checkpoint", no?  If that is the case, perhaps feeding
these two from this helper function to >&8, instead of forcing the
caller to prepare the input file to always end with these two, may
be a better organization.

> +	exec 8>&-
> +	exec 9>&-

These are to make sure that nobody (after fast-import dies) has
these file descriptors hanging open for writing.  Makes one wonder
what happens to the reader side of the file descriptor, though ;-)

Before we return from this function, we expect (as the comment
before the function says) that fast-import is still running, waiting
further input.  Wouldn't closing the other side of the pipe here
like these make it notice that there is no more data by causing
read_next_command() find EOF?  IOW, is "use import_until_checkout,
test the outcome and then make sure import_still_running reports that
the outcome was not due to the process terminating and flushing"
somewhat racy?

Or are we closing these file descriptors for different reason
(i.e. not to tell fast-import we are done feeding it input) and I am
reading the code incorrectly?  Puzzled.

> +	if test $error -eq 1
> +	then
> +		exit 1
> +	fi
> +}
> +
> +background_import_still_running () {
> +	if ! kill -0 "$(cat V.pid)"
> +	then
> +		echo >&2 "background fast-import terminated too early"
> +		exit 1
> +	fi
> +}

I suspect these "exit 1" above should be "false", to give the calling
test_expect_success a chance to notice the failure and react to it.

> +test_expect_success 'V: checkpoint updates refs after reset' '
> +	cat >input <<-\INPUT_END &&
> +	reset refs/heads/V
> +	from refs/heads/U
> +
> +	checkpoint
> +	progress checkpoint
> +	INPUT_END
> +
> +	background_import_until_checkpoint "" input &&
> +	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
> +	background_import_still_running
> +'
