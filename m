Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B3B1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935112AbcIVUFi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:05:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933737AbcIVUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:05:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CE41EDBE;
        Thu, 22 Sep 2016 16:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lQwU+KQUVn34bf5065wb/5WICh0=; b=WX64Kn
        9OpR+nnnRx7fCWCSDktySjVvgypUO0J7ijHQWjoYYWatUSL49QSoH9qFT5RC65Zw
        Uzq8du+zp2jcYBSCshV2oTVn2jbgzfWhd6FubzovGPBLGGHRUbnKATo+5trMSoEZ
        QhvowO74nvmsxwlNS+Fd789vZmqFT1VaNzwsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kyBwAvsot2lcmJrhk6vcRSbGwHCEuiFl
        liNjKFppLoBPimRDuNzMaF1u0TDvmme2D6nnFRFn6v0pJQt7Xg29ZQnUO9hU2e8x
        FnV4aWObyVo6K1Ru+x5UmWY4uANvkhQxwFN56524DzDWerNGkkW+FqM8d23TIzId
        QW797ZETKLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56148EDBD;
        Thu, 22 Sep 2016 16:05:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB6C2EDBC;
        Thu, 22 Sep 2016 16:05:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: do not reset in_vain on non-novel acks
References: <cover.1474568670.git.jonathantanmy@google.com>
        <cover.1474568670.git.jonathantanmy@google.com>
        <5a258c5dbed0683760e2ffb1bd6a1749ea66b2d5.1474568670.git.jonathantanmy@google.com>
Date:   Thu, 22 Sep 2016 13:05:32 -0700
In-Reply-To: <5a258c5dbed0683760e2ffb1bd6a1749ea66b2d5.1474568670.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 22 Sep 2016 11:36:55 -0700")
Message-ID: <xmqqfuor4s4z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC1E3D7C-80FF-11E6-A5E1-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The MAX_IN_VAIN mechanism was introduced in commit f061e5f ("fetch-pack:
> give up after getting too many "ack continue"", 2006-05-24) to stop ref
> negotiation if a number of consecutive "have"s have been sent with no
> corresponding new acks. A use case (as described in that commit) is the
> scenario in which the local repository has more roots than the remote
> repository.

To those who know what the mechanism is about, the above is
sufficient to refresh their memory, but to others, a brief
explanation of _why_ it is a good idea to stop is needed to
understand what you are trying to achieve with this change.

It may help to add something like "This will stop the client to dig
too deep in an irrelevant side branch in vain without ever finding a
common ancestor." before "A use case is ...", perhaps?

By the way, you made me run "git show -W f061e5f" and then compare
it with "less fetch-pack.c"; I am kind of surprised to see that
find_common() has grown quite a bit over the years.

> However, during a negotiation in which stateless RPCs are used,
> MAX_IN_VAIN will (almost) never trigger (in the more-roots scenario
> above and others) because in each new request, the client has to inform
> the server of objects it already has and knows the server has (to remind
> the server of the state), which the server then acks.

Hmph.  So the problem you are trying to solve is that the current
code sees that the other side said 'yeah, that is a common commit'
by giving us ACK common, and resets the in_vain counter, when in
fact we haven't made _any_ progress at that point.

> Make fetch-pack only consider novel acks (acks for objects for which the
> client has never received an ack before in this session) as new acks for
> the purpose of MAX_IN_VAIN.

Makes sense.

Just a hint, because you are relatively new to the project.
Whenever you are tempted to say "In other words...", "That
means...", or further elaborte in parentheses, it pays to stop and
think if you can do without whatever you said before that.  In the
above paragraph and in the comment in the patch, a newly invented
term "novel ack" is used exactly once, and because it is a newly
invented word, you need to explain what you want it to mean, but
there is no need to do so.  "Make fetch-pack only consider acks for
objects for which no earlier acks have been seen ..." is equally
readable and does not burden the readers with "Ah, the author
introduced a new term 'novel ack', so I need to remember that this
is the definition of the word when I see it mentioned next time".

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 85e77af..1141e3c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -428,10 +428,18 @@ static int find_common(struct fetch_pack_args *args,
>  						const char *hex = sha1_to_hex(result_sha1);
>  						packet_buf_write(&req_buf, "have %s\n", hex);
>  						state_len = req_buf.len;
> -					}
> +						/*
> +						 * Reset in_vain because this
> +						 * ack is a novel ack (that is,
> +						 * an ack for this commit has
> +						 * not been seen).
> +						 */

Side note.  Having to wrap the multi-line comment like this is a
sign that the loop got a bit too big to fit in brain.  We may want
to see if there is way to reduce the complexity by introducing a
helper function or something.

> +						in_vain = 0;
> +					} else if (!args->stateless_rpc
> +						   || ack != ACK_common)
> +						in_vain = 0;

It is a bit hard to read this hunk without pre-context.  The
original reads like so:


	...
	case ACK_common:
	case ACK_ready:
	case ACK_continue: {
		struct commit *commit =
			lookup_commit(result_sha1);
		if (!commit)
			die("invalid commit %s", sha1_to_hex(result_sha1));
		if (args->stateless_rpc
		 && ack == ACK_common
		 && !(commit->object.flags & COMMON)) {

Here, they told us that this is a common ancestor by giving us "ACK
common", and this is not a response to our attempt to prime a new
incarnation of stateless server.  It is curious that only ACK_common
is checked, but it is OK because --stateless requires multi-ack and
ACK_continue is not used.

			/* We need to replay the have for this object
			 * on the next RPC request so the peer knows
			 * it is in common with us.
			 */
			const char *hex = sha1_to_hex(result_sha1);
			packet_buf_write(&req_buf, "have %s\n", hex);
			state_len = req_buf.len;

And we store it away so that the next found will start with these
objects as "have" to remind the other side where we were.

> +			in_vain = 0;

And at this point, you reset in_vain counter with your change.
Which makes sense.  This is a newly discovered common one, i.e. we
are making progress.

-		}
> +		} else if (!args->stateless_rpc
> +			   || ack != ACK_common)
> +			in_vain = 0;

And you add an else clause here to reset in_vain counter, which we
used to unconditionally do, when stateless is not in use, or when we
are doing stateless and got something other than "ACK common".  The
latter is to make sure that "ACK common" for commits we have already
known are common do not count as making progress.

Makes perfect sense to me.

		mark_common(commit, 0, 1);
		retval = 0;
-		in_vain = 0;

And you remove the unconditional reset.

		got_continue = 1;
		if (ack == ACK_ready) {
			clear_prio_queue(&rev_list);
			got_ready = 1;
		}
		break;
		}
	}

Everything looks good to me and well thought-out.

Thanks.
