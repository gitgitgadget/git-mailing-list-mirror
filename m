Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9264220259
	for <e@80x24.org>; Wed, 23 Nov 2016 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756909AbcKWRQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:16:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59089 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753136AbcKWRQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:16:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAAD351D6A;
        Wed, 23 Nov 2016 12:16:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=71l+P5B2kMqL
        ziBDC+/u6zZ3DO0=; b=Dw2UlFbfdByZ+FcFBjr+JqIkNDlZCwDbpJSD7ULZamlM
        WfqeWVz7afMude6efp6npVBZWZ2x1TM2+HgN3xyCbzKbPvbbszn/UAzN4fnm91h9
        o6p/OgfxCdeDr5T0EwKnC3M23sJaB2AJ3zvHFd4OgoAG/eeEKBNkIjYeCuM7c5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NfQrVk
        VApo5oyt0HpMH0FNDkSiFF9oHQ81JpJEB7BbKEAreD9YnrW0SNzGrSeW5+p5TV2y
        9a1EBzSZ9Oq2gXGFv7exhSDvvjYAruuiZ2LmWCw2YBdCRxtHvIbofWhsj4WvxHI2
        FOsrR8Y7QxkRr8LZ2qeD4uxbaFksdT7ojbRt8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2DB451D68;
        Wed, 23 Nov 2016 12:16:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31F9951D65;
        Wed, 23 Nov 2016 12:16:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rappazzo@gmail.com
Subject: Re: [PATCH 3/3] worktree list: keep the list sorted
References: <20161122100046.8341-1-pclouds@gmail.com>
        <20161122100046.8341-4-pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 09:16:46 -0800
In-Reply-To: <20161122100046.8341-4-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 22 Nov 2016 17:00:46 +0700")
Message-ID: <xmqqwpfum801.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9DD480C8-B1A0-11E6-BEBB-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +		for (i =3D nr =3D 0; worktrees[i]; i++)
> +			nr++;
> +
> +		/*
> +		 * don't sort the first item (main worktree), which will
> +		 * always be the first
> +		 */
> +		QSORT(worktrees + 1, nr - 1, compare_worktree);
> +

This is somewhat curious.

	for (i =3D 0; worktrees[i]; i++)
		; /* just counting */
	QSORT(worktrees + 1, i - 1, compare_worktree);

would have been a lot more idiomatic (you do not use nr after sorting).

More importantly, perhaps get_worktrees() should learn to take an
optional pointer to int that returns how many items are in the list?

Alternatively, other existing callers of the function do not care
about the order, so it may not be such a good idea to always sort
the result, but it may be a good idea to teach it to take a boolean
that signals that the list should be sorted in a "natural order",
which is how "worktree list" would show them to the user?

This should be easily protectable with a new test.  Please do.
