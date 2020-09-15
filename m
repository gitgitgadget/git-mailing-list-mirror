Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E1DC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E13120756
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V6DWn10l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgIOVFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:05:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64777 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgIOVCp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:02:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DAA8DC710;
        Tue, 15 Sep 2020 17:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TQsueLYMzLCuS5JfJONhOo8MTcI=; b=V6DWn1
        0l7WhnpKlhkOQhDNO9TQY/1ND4DEbJJhJgWcdzfFtSsj3HlZXuIj5AcV+He6i2TT
        Z4xlKvCa6AYr8oviY4Z/GWIYxNLXMsz8cs0/5laFzDVqjx9nNf1OxrJNxs0giGSv
        5eOacDQyNmgvyE5R6St1aRBXWfRE2s+er9tqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w5aP5w/vG83KXbpMgi9az4Z6087vsKbq
        o02tJGvkeoDOESuxE7wjurbkLKyr/Z/ReCbbYFDQeuyi9EWijbptcWi0MFSXTNgn
        iuB6zHq/LSZYJMCOA/0RrldfVc4aTbFNhRLdmfnQ2/II2+8CwjJGC93ur9jIBkqS
        cYJpnXBEgDs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 259B7DC70F;
        Tue, 15 Sep 2020 17:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B4B7DC70E;
        Tue, 15 Sep 2020 17:02:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
        <20200915095827.52047-2-hanxin.hx@alibaba-inc.com>
Date:   Tue, 15 Sep 2020 14:02:35 -0700
In-Reply-To: <20200915095827.52047-2-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Tue, 15 Sep 2020 17:58:27 +0800")
Message-ID: <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8D161CA-F796-11EA-8B13-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> Atomic push may be rejected, which makes it meanigless to generate push
> cert first. Therefore, the push cert generation was moved after atomic
> check.

The overstatement "may be rejected" is probably a bit misleading the
readers and reviewers.  REF_STATUS_REJECT_NONFASTFORWARD may be
observed by check_to_send_update() but the reason is set in
set_ref_status_for_push(), which locally decides not to propose a
no-ff ref update to the other side.  At this point of the control
flow, the other side hasn't have a chance to reject the push,
because "we want you to update these refs to these new values" is
yet to be sent (it is done after composing the push certificate).

    We may decide not to push (e.g. their ref may not fast forward
    to what we are pushing) at this point in the code.  Checking the
    condition first will save us to ask GPG to sign the push
    certificate, since we will not send it to the other side.


> -	if (!args->dry_run)
> -		advertise_shallow_grafts_buf(&req_buf);

Why should this be moved?  It doesn't seem to have anything to do
with the push certificate.

> -
> -	if (!args->dry_run && push_cert_nonce)
> -		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
> -					       cap_buf.buf, push_cert_nonce);
> -
>  	/*
>  	 * Clear the status for each ref and see if we need to send
>  	 * the pack data.

This "Clear the status for each ref" worries me.  

The generate_push_cert() function RELIES on ref->status and filters
out the ref that failed to pass the local check from the generated
push certificate.  If you let the loop (post context of this hunk)
run, ref->status will be updated by it, so the net effect of this
patch is that it breaks "non-atomic" case that pushes multiple refs
and one of ref fails to pass the local check.

IOW, generate_push_cert() MUST be called before this loop "clears
the status for each ref" by assigning to ref->status.

> @@ -489,6 +482,13 @@ int send_pack(struct send_pack_args *args,
>  			ref->status = REF_STATUS_EXPECTING_REPORT;
>  	}
>  
> +	if (!args->dry_run)
> +		advertise_shallow_grafts_buf(&req_buf);
> +
> +	if (!args->dry_run && push_cert_nonce)
> +		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
> +					       cap_buf.buf, push_cert_nonce);
> +

So, this change as-is is probably a bad idea.

I wonder if generate_push_cert() can be told about atomicity of the
push, though.  There is this loop in the function:

	int update_seen = 0;

	...
	for (ref = remote_refs; ref; ref = ref->next) {
		if (check_to_send_update(ref, args) < 0)
			continue;
		update_seen = 1;
		strbuf_addf(&cert, "%s %s %s\n",
			    oid_to_hex(&ref->old_oid),
			    oid_to_hex(&ref->new_oid),
			    ref->name);
	}
	if (!update_seen)
		goto free_return;

that makes it a no-op without invoking GPG if no update is needed.
Perhaps we can extend it to

	int failure_seen = 0;
        int update_seen = 0;

	...
	for (ref = remote_refs; ref; ref = ref->next) {
		switch (check_to_send_update(ref, args)) {
		case CHECK_REF_STATUS_REJECTED:
			failure_seen = 1;
			break;
		case 0:
			update_seen = 1;
			break;
                case REF_STATUS_UPTODATE:
			break; /* OK */
		default:
			BUG("should not happen");
		}
		strbuf_addf(&cert, "%s %s %s\n",
			    oid_to_hex(&ref->old_oid),
			    oid_to_hex(&ref->new_oid),
			    ref->name);
	}
	if (!update_seen || (use_atomic && failure_seen))
		goto free_return;

to make it also a no-op when any local rejection under atomic mode?

Thanks.
