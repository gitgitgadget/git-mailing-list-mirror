Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2883CC433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B043F2078E
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jhJFN013"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgIOVkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:40:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63130 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgIOVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:40:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD09ADCBB9;
        Tue, 15 Sep 2020 17:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=04+VWUc++KH+qNbQLSaccsXKM+k=; b=jhJFN0
        13ZSHlKz0qahOd7yevYCrYu0xZzhJIj+YQIVRn3de1FIxEAvMdwCxhYohKVxh2ia
        p2b5rRJyNptqn7CeSGGTxmhY7WlEjapLwgoy75/HqKj33XwfJqlHIJh19rZkOQh7
        qfNknnSGzhLuqlRJLhVmdN1kaERE7AuwdKlak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tE/ree5Bfrt1imRoMWzuXAOZbjX7ItD3
        Q1l3cQa5b3Z3r/WoGvUmvdvyezFHrIpO9SJl57nbBaScmvXA/EizT3hEMuaPoX6g
        le7ezeaa53CJ+y2zFx4pDIBy4eNkUqbZ4tE5ozPe8UABCJ8prhWMyqrUHnuUUV0Q
        MAW0DhUxkGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6DC1DCBB8;
        Tue, 15 Sep 2020 17:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 16E36DCBB4;
        Tue, 15 Sep 2020 17:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
        <20200915095827.52047-2-hanxin.hx@alibaba-inc.com>
        <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
Date:   Tue, 15 Sep 2020 14:40:03 -0700
In-Reply-To: <xmqqmu1qzrbo.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Sep 2020 14:02:35 -0700")
Message-ID: <xmqq5z8ezpl8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04867F0C-F79C-11EA-A3A4-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if generate_push_cert() can be told about atomicity of the
> push, though.  There is this loop in the function:
>
> 	int update_seen = 0;
>
> 	...
> 	for (ref = remote_refs; ref; ref = ref->next) {
> 		if (check_to_send_update(ref, args) < 0)
> 			continue;
> 		update_seen = 1;
> 		strbuf_addf(&cert, "%s %s %s\n",
> 			    oid_to_hex(&ref->old_oid),
> 			    oid_to_hex(&ref->new_oid),
> 			    ref->name);
> 	}
> 	if (!update_seen)
> 		goto free_return;
>
> that makes it a no-op without invoking GPG if no update is needed.
> Perhaps we can extend it to
>
> 	int failure_seen = 0;
>         int update_seen = 0;
>
> 	...
> 	for (ref = remote_refs; ref; ref = ref->next) {
> 		switch (check_to_send_update(ref, args)) {
> 		case CHECK_REF_STATUS_REJECTED:
> 			failure_seen = 1;
> 			break;

This "break" should be "continue" here.  We want to exclude the ones
that we are not going to send to the other side from the push
certificate (in non-atomic case).

> 		case 0:
> 			update_seen = 1;
> 			break;
>               case REF_STATUS_UPTODATE:
> 			break; /* OK */
> 		default:
> 			BUG("should not happen");
> 		}
> 		strbuf_addf(&cert, "%s %s %s\n",
> 			    oid_to_hex(&ref->old_oid),
> 			    oid_to_hex(&ref->new_oid),
> 			    ref->name);
> 	}
> 	if (!update_seen || (use_atomic && failure_seen))
> 		goto free_return;
>
> to make it also a no-op when any local rejection under atomic mode?
>
> Thanks.
