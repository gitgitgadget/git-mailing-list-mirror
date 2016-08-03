Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB53B1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005AbcHCUAg (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:00:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757747AbcHCUAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:00:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD65F3073B;
	Wed,  3 Aug 2016 15:54:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qqHB96q1bhmyF3TxlnZdwFgY0eo=; b=TSsupq
	ySueSRpyZM2Tu5eSIoUpceV9oMwsDbWMNLytdglzpe480EWwRMZzVOjw2N+0Qd0j
	S0flGZdnMDYiFzLU/S4vPyC2PeBrZs5oT6ugPIJrmvHGlZAtNznOyFoeN1jWBhM9
	XZza8ZTHyixv56xIOFvfqybBwbdF7JhduMmzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcaKfG1LdT1umnxZjlTuklQkDHG6q2SG
	tEyGEpX9v0mb5Vou1Nv5m9ech8qF5Jjkl1SQ0WcMdFyHTtoX/m7tgxOibqygqLn6
	9UgR3I30Y0A13fCtgYQvB1C1TykgohjA1m/pByT664/zn/zS89QoyL5EpMvxZ+I0
	ued7ocr6QmE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2F013073A;
	Wed,  3 Aug 2016 15:54:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1366730739;
	Wed,  3 Aug 2016 15:54:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stephen Morton <stephen.morton@nokia.com>,
	Jan Smets <jan.smets@nokia.com>, git@vger.kernel.org
Subject: Re: Client exit whilst running pre-receive hook : commit accepted but no post-receive hook ran
References: <5795EB1C.1080102@nokia.com>
	<20160725222201.GC13589@sigill.intra.peff.net>
	<a3f64a09-3094-eee1-0050-9960f0674036@nokia.com>
	<20160803193018.ydhmxntikhyowmjz@sigill.intra.peff.net>
Date:	Wed, 03 Aug 2016 12:54:48 -0700
In-Reply-To: <20160803193018.ydhmxntikhyowmjz@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 15:30:18 -0400")
Message-ID: <xmqqlh0d8w6v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 233D0CAC-59B4-11E6-9228-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree it would be a good property to have. I think it's hard to do
> atomically, though. Certainly we can wait to tell the other side "your
> push has been recorded" until after the hook is run. But we would
> already have updated the refs locally at that point (and we must -- that
> is part of the interface to the post-receive hooks, that the refs are
> already in place). So would we roll-back the ref update then? Even that
> suffers from power failures, etc.
>
> So I'm not sure if making it truly atomic is all the feasible.

As long as the requirement is that post- hook must see the updated
ref in place, I do not think it is feasible to give "the hook always
runs once" guarantee, without cooperation by other parts of the flow
(think: pulling the power at an arbitrary point in the process).

A receiving repository can implement it all in the userland, I would
think, though:

 * A pre-receive hook records the intention to update a ref (from
   what old commit to what new commit), and does not return until
   that record is securely in a database;

 * A post-receive hook checks the entry in the database above (it
   _must_ find one), and atomically does its thing and marks the
   entry "done";

 * A separate sweeper scans the database for entries not yet marked
   as "done", sees if the ref has been already updated, and
   atomically does its thing and marks the entry "done" (the same
   can be done as part of a post-receive for previously pushed
   commit that pre-receive recorded but did not manage to run
   post-receive before the power was pulled or the user did \C-c).

As you originally described, the non-atomicity is not new; as long
as we have necessary hooks in place on the git-core side for
repositories that want a stronger guarantee, I do not think there is
any more thing we need to do on this topic.  If we can narrow the
window in a non-intrusive way, that would be a good thing to do,
though.

> However,
> we could certainly make things more robust than they are now.

And this change may to the "narrowing the window in a non-intrusive
way" (I wonder if we also need to lift the post-update hook the same
way, though).

But that would still not guarantee "the hook always runs once".
What we have is "the hook runs at most once".

Thanks.

> The simplest thing may be to just bump the post-receive hook before the
> status report. That opens up the question of whether clients are
> actually waiting already for the post-receive to finish. Looking at the
> code in send-pack, it looks like the network is hooked up to the
> sideband demuxer thread, which will read until EOF on the network. So we
> are waiting either way for the post-receive to run. It doesn't really
> matter if it happens before or after the report to the client.
>
> So I _think_ something like this would work:
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 15c323a..91d01f0 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1767,9 +1767,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		execute_commands(commands, unpack_status, &si);
>  		if (pack_lockfile)
>  			unlink_or_warn(pack_lockfile);
> +		run_receive_hook(commands, "post-receive", 1);
>  		if (report_status)
>  			report(commands, unpack_status);
> -		run_receive_hook(commands, "post-receive", 1);
>  		run_update_post_hook(commands);
>  		if (auto_gc) {
>  			const char *argv_gc_auto[] = {
>
> but maybe there are other gotchas.
>
> -Peff
