Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D2820193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965673AbcHDULU (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:11:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965116AbcHDULT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:11:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8DB306DD;
	Thu,  4 Aug 2016 16:11:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K3/qZl8FBw5spY3O4FCQ12vJpns=; b=yAYDTM
	7P2YCfgHsMrKPv+B1uS+M+HfxyThq57Yk/maHwr5J/b8AJtOKBTfBKElUMt3yk8g
	pmv4hnEN71HpYZSmEt3PdvgvAXBCvaZ5TpowCWXLWSrnRJ4GFXWNxqNt9OCot3yx
	F+9GTtjCzvpNUMcabimEy6dtH1Orjjpi7IA5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MKqr018RqrV6hus3wxEQ3Zzs/guGdHkB
	uWze8V/xXU5Sz8S5ab/xVjBEgacRthhu+REVYJPabqkUMQx/rdqx/EhspQUxJwTF
	EzUamNW6msAbMp8tnWqUO1Mo91ZQ5i08WrhYhSCbKfTz/zqqUevwS1rQrVQ9fIPq
	tIt+K/Vw1SQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61E9E306DC;
	Thu,  4 Aug 2016 16:11:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA263306DB;
	Thu,  4 Aug 2016 16:11:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: [BUG?] --boundary inconsistent with path limiting
References: <20160804194043.z4nbosr4wpbzljdl@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 13:11:15 -0700
In-Reply-To: <20160804194043.z4nbosr4wpbzljdl@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 4 Aug 2016 15:40:43 -0400")
Message-ID: <xmqqr3a41eho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A64E07C-5A7F-11E6-A256-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But now if I limit to "a.t", I get no output at all:
>
>   $ git log --format='%m %s' --boundary a..c -- a.t
>
> whereas I would have expected "- a" to show the boundary.
>
> Is this a bug, or are my expectations wrong?

In a range a..c, there is nothing that touches the path, so there is
no positive outcome.  As boundaries are essentially the parents of
the "last" positive outcome, I would not be surprised if I see an
empty output in that scenario.

But to be honest, I do not think anybody cared between the
distinction between a bug and intended behaviour in this case.

The boundary started as a debugging aid for the traversal machinery
and not as a serious feature to support end-user workflow.  In its
early days, I do not think we even showed _all_ boundaries (instead
we showed only ones that we have already parsed, or something like
that).  I think we added code to do a bit more work when asked to
show boundaries to show boundary commits that the traditional
"primarily for debugging" logic wouldn't have shown later, losing
its value as a debugging aid (because it no longer showed precisely
where the traversal machinery stopped digging).



