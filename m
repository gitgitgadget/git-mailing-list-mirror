Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59061F859
	for <e@80x24.org>; Wed,  7 Sep 2016 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757017AbcIGRCt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 13:02:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755116AbcIGRCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 13:02:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA88E3B23C;
        Wed,  7 Sep 2016 13:02:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w3P3JdFJ79ZfbvdBNp9rfJO9GPw=; b=PTVUco
        2/ZCQuJNdfZW1nEKN3Z3bMKkl2TGRjNCvFCDLkfA2oMsymUphIkvJdeWQc06lDve
        K7XwGdMvjHXqGRB1DVAM0LiWFeKxnj+aqP/Fup0OO5os+G+iNq+oXX9zmx1BeWJR
        oXW4G03dTsJLdxpbdN8LDvr6WaQ+veOJSVJiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QmrVptZxjxAcQsioe/Q2zZJeSZSvyKe5
        WhjuteF/XA1epVb2qggk7nGu1RMYMASnlqbmSYNKUo0bLbd/C/X0rsqM1flCmx6Q
        +33nkMjjrMziUJR1hjrCkcez6ke4B2VLVsoVT9Xgw9t+xNZ5aOBXJo/P5VxEQphR
        0mgTk503mIM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A241B3B23B;
        Wed,  7 Sep 2016 13:02:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A8CB3B23A;
        Wed,  7 Sep 2016 13:02:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, spearce@spearce.org,
        sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
References: <cover.1472853827.git.jonathantanmy@google.com>
        <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1472853827.git.jonathantanmy@google.com>
        <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
Date:   Wed, 07 Sep 2016 10:02:45 -0700
In-Reply-To: <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 2 Sep 2016 15:06:12 -0700")
Message-ID: <xmqqshtbod6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6C39226-751C-11E6-BB93-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Git advertises the same capabilities^{} ref in its ref advertisement for push
> but since it never remembered to do so for fetch, the client forgot to handle
> this case. Handle it.
> ...
> In this aspect, JGit is compliant with the specification in pack-protocol.txt.

I agree with Peff that the above explanation distorts the history.
It should be reworded.

I do not have an issue with being more lenient to what JGit servers
have been doing for a few years, though.

> Because git client versions without this fix are expected to exist in the wild
> for a while, we should not change the server to always send the capabilities^{}
> line when there are no refs to advertise yet.  A transition will take multiple
> steps:
>
>  1. This patch, which updates the client
>
>  2. Update pack-protocol to clarify that both server behaviors must be
>     tolerated.
>
>  3. Add a configuration variable to allow git upload-pack to advertise
>     capabilities when there are no refs to advertise.  Leave it disabled
>     by default since git clients can't be counted on to have this patch (1)
>     yet.
>
>  4. After a year or so, flip the default for that server configuration
>     variable to true.

The above assumes it is an unconditionally good thing to send
capabilities^{}; I do not think we established that in this
discussion, and more importantly, this client-side change is a good
thing to do regardless of the outcome of the discussion.

I'd suggest dropping everything below "Because Git client versions
without...".

> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 819b9dd..2de52f5 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -207,5 +207,44 @@ test_expect_success 'ls-remote --symref omits filtered-out matches' '
>  	test_cmp expect actual
>  '
>  
> +test_lazy_prereq GIT_DAEMON '
> +	test_tristate GIT_TEST_GIT_DAEMON &&
> +	test "$GIT_TEST_GIT_DAEMON" != false
> +'
> +
> +JGIT_DAEMON_PORT=${JGIT_DAEMON_PORT-${this_test#t}}

Shouldn't this be inside the next expect_success?

> +# This test spawns a daemon, so run it only if the user would be OK with
> +# testing with git-daemon.
> +test_expect_success PIPE,JGIT,GIT_DAEMON 'indicate no refs in standards-compliant empty remote' '
> +	JGIT_DAEMON_PID= &&
> +	git init --bare empty.git &&
> +	touch empty.git/git-daemon-export-ok &&

To make it clear that the existence of the file is the thing you
care the most, not that the file having a recent timestamp:

	>empty.git/git-daemon-export-ok &&

> +	mkfifo jgit_daemon_output &&
> +	{
> +		jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
> +		JGIT_DAEMON_PID=$!
> +	} &&
> +	test_when_finished kill "$JGIT_DAEMON_PID" &&
> +	{
> +		read line &&
> +		case $line in
> +		Exporting*)
> +			;;
> +		*)
> +			echo "Expected: Exporting" &&
> +			false;;
> +		esac &&
> +		read line &&
> +		case $line in
> +		"Listening on"*)
> +			;;
> +		*)
> +			echo "Expected: Listening on" &&
> +			false;;
> +		esac

OK, so this is a nice way to wait until the daemon becomes ready to
serve.

> +	} <jgit_daemon_output &&

An in-code comment that explains what the significance of "2" here

	# --exit-code asks the command to exit with 2 when no
        # matching refs are found.

would be nice.

> +	test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
> +'

Thanks.
