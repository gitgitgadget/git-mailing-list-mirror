Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCAED20193
	for <e@80x24.org>; Sun, 30 Oct 2016 23:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755392AbcJ3XDO (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 19:03:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50287 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755298AbcJ3XDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 19:03:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A44784AF0B;
        Sun, 30 Oct 2016 19:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=umAlruB+nyXr
        rIt99ZJ4fK62CMc=; b=foH1gS5Ec97pvT8GryuBI/0gfskSzVXZU0c79mRuAJFD
        jwX+znr3kwXeAcZNKr1r3VdCh5s2xUi9qQd5b+/AivmYe/vIpLtREpn1V1w1wxpL
        mo3OfjvzJx6yDLRVf2PWZdz5qJtsUeo/xPiY8h8oXZejy608Ym8bdiNeVMhTLL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dWbHR8
        wWBosHWVBpBwuQeRteKNXjwPKlV/o/knauna73krPJCyJP1XNJds4EL1SpM8QxaD
        QLsotrzOXMH/UnExzcfzfmlMy4TrwBgFligq3i92HDzN8kqVzWcd0yqevIFKmgwX
        3hGVqdeqztQ1D2tvh+Ygod/BUWmwCEKpTSdsw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C44B4AF0A;
        Sun, 30 Oct 2016 19:03:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2178E4AF09;
        Sun, 30 Oct 2016 19:03:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: simplify building parents list
References: <30afdbeb-7a45-70b2-495e-35fd3b62419a@web.de>
Date:   Sun, 30 Oct 2016 16:03:06 -0700
In-Reply-To: <30afdbeb-7a45-70b2-495e-35fd3b62419a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 29 Oct 2016 14:55:36 +0200")
Message-ID: <xmqqd1ihv3rp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05B83B58-9EF5-11E6-9FA2-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Push pptr down into the FROM_MERGE branch of the if/else statement,
> where it's actually used, and call commit_list_append() for appending
> elements instead of playing tricks with commit_list_insert().  Call
> copy_commit_list() in the amend branch instead of open-coding it.  Don'=
t
> bother setting pptr in the final branch as it's not used thereafter.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> ...
> @@ -1729,7 +1727,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
>  			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
>  					? "commit (cherry-pick)"
>  					: "commit";
> -		pptr =3D &commit_list_insert(current_head, pptr)->next;
> +		commit_list_insert(current_head, &parents);
>  	}

I needed to read the full preimage to determine why this hunk is
equivalent to the original.  Which is a good demonstration that what
motivated this patch is a valid issue to tackle---initializing the
pptr variable to point at &parents too early and have the long
if/elseif/... cascade work with it made the code unnecessarily
harder to understand and this update untangles that.

Thanks.


