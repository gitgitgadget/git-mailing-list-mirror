Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354BE1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbcHIRR2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:17:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932238AbcHIRR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:17:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D0F52343BC;
	Tue,  9 Aug 2016 13:17:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s85HoDxliJXh6mLTesXghwy5qM4=; b=Im2HL8
	8sOjP1xr2qbBa40nrZzn+/CmRdnHCxVp6kgi39kp1esfM8vGUEjkKfn3ue75vlg9
	u8I4S9xP4+s6P5CFx3EEfGYVZj5k6uUUeHKL37lWxSjOtYvvALyrcq836LMgXD+a
	GK33O7q3P/MpDn9+I7SlqKDQaA4kAnzEbtB+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J9QoLRtYGrkcuLXK+RcR5jme+R4My1V+
	NnxJOfAu3mnsLsSyF0DDFKk8F7/a1eK9xO0AlKadunm7sEDKoCDX0ym7vZSGendr
	2XVnGgN6lLuGcijBmgzO+9f15ZoKoUzF6wgTt7OwTKyedNM0OV/5TJXPaS4+hjlO
	VYk7j5xMVrY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C91F7343BB;
	Tue,  9 Aug 2016 13:17:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A20E343B8;
	Tue,  9 Aug 2016 13:17:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] commit-slab.h: avoid duplicated global static variables
References: <57A9E5C1.3030205@kdbg.org> <57A9E614.6050601@kdbg.org>
Date:	Tue, 09 Aug 2016 10:17:23 -0700
In-Reply-To: <57A9E614.6050601@kdbg.org> (Johannes Sixt's message of "Tue, 9
	Aug 2016 16:17:56 +0200")
Message-ID: <xmqqpophc15o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24270690-5E55-11E6-A903-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>   * like function declarations.  I.e., the expansion of
>   *
>   *    define_commit_slab(indegree, int);
>   *
> - * ends in 'static int stat_indegreerealloc;'.  This would otherwise
> + * ends in 'struct indegree;'.  This would otherwise
>   * be a syntax error according (at least) to ISO C.  It's hard to
>   * catch because GCC silently parses it by default.
>   */

I briefly wondered what "otherwise" and "it" in "silently parses it"
refer to; it is having a hanging semicolon after the definition of
the *_peek() function, i.e.

	...
        static int *indegree_peek(...)
        {
		return indegree_at_peek(s, c, 0);
	}
	;

so all is fine.

Needless to say, using "struct slabname;" is indeed a much nicer
solution you found to the original issue.  Thanks.
