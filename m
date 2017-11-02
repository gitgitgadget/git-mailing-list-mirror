Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26195202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 04:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbdKBEya (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 00:54:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64874 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750704AbdKBEy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 00:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F727ADDC1;
        Thu,  2 Nov 2017 00:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XYJ3eUophTns
        s+o9L/lxnvOrms8=; b=r2BWuanwj/7VcDSUqiPaieotCEKS9i2D8ElePLy8pD7i
        8trCEFRdRCh+XKvw6bv/Gez546CcrFLtpTymNfhrmUCCQxSUjFH3O2ElZdMvQ5Bq
        wTiTzjPN8mR/sGA3ry2rHqiJoW/iR4AJM73T2fR61MLr25WtX+PNtMRSbk9e55Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yPEIlr
        I1KV07dgSml1ltufNccehHuA+lMxrx2p/3S3PfkxhTJxbpA8i000na7L/YHO6TVt
        +9RbozVBhroKNkkvK5PmWDU/T/aispbhFSsfPNv9Plz1QkNUa0EKeIshTUINfFiK
        v8NmLfWYtjFvtZJAJYscepm1O6dSUCmmVu03U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 282A6ADDC0;
        Thu,  2 Nov 2017 00:54:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 989D7ADDBE;
        Thu,  2 Nov 2017 00:54:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] bisect: fix memory leak and document `find_bisection()`
References: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
Date:   Thu, 02 Nov 2017 13:54:27 +0900
In-Reply-To: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 1 Nov 2017 21:34:37
 +0100")
Message-ID: <xmqqr2thqnzw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E845F1EE-BF89-11E7-AEAD-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> `find_bisection()` rebuilds the commit list it is given by reversing it
> and skipping uninteresting commits. The uninteresting list entries are
> leaked. Free them to fix the leak.
>
> While we're here and understand what's going on, document the function.
> In particular, make sure to document that the original list should not
> be examined by the caller.

Good.  Thanks.

I notice that this has only two callers and both of them do

	revs.commits =3D find_bisection(revs.commits, ...);

I wonder if updating its calling convention to

	(void) find_bisection(&revs.commits, ...);

makes sense.  This is obviously outside the scope of this patch.

> +/*
> + * Find bisection. If something is found, `reaches` will be the number=
 of
> + * commits that the best commit reaches. `all` will be the count of
> + * non-SAMETREE commits. If `find_all` is set, all non-SAMETREE commit=
s are
> + * returned sorted, otherwise only a single best commit is returned. T=
he
> + * original list will be left in an undefined state and should not be =
examined.
> + */
>  extern struct commit_list *find_bisection(struct commit_list *list,
>  					  int *reaches, int *all,
>  					  int find_all);
