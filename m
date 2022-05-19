Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C565C433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiESPvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 11:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiESPu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 11:50:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9710625C
        for <git@vger.kernel.org>; Thu, 19 May 2022 08:50:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD37B192192;
        Thu, 19 May 2022 11:50:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QV6H7n3WBvum
        xMdgaBC+ddq9KhpZABGYK+bdEgBXdbM=; b=aKS2PGKuNPF5MJrmE9MfxI2hOXQb
        O2i0UTWwmBTU16unQSt4dq92O/etaWnVhM/tRmotRy5qYZq2kAGzo7ey+5YwMfTK
        bnoBUStD0rk6o5/jflPLr0euijb5KaRfB+QN7K4wYCpoxbNFd7Edize4K3GIBwXg
        NQlUOsJZN62xRY4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B53E0192191;
        Thu, 19 May 2022 11:50:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61BBA19218F;
        Thu, 19 May 2022 11:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [RFC PATCH 2/2] hash API: add and use a hash_short_id_by_algo()
 function
References: <cover.1652915424.git.me@ttaylorr.com>
        <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
        <RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com>
Date:   Thu, 19 May 2022 08:50:18 -0700
In-Reply-To: <RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 19 May
 2022 13:42:28
        +0200")
Message-ID: <xmqqbkvtr079.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6278F95C-D78B-11EC-9DA5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add and use a hash_short_id_by_algo() function. As noted in the
> comment being modified here (added in [1]) the intention wasn't to
> have these end up in on-disk formats, but since [2], [3] and [3]

double [3]?

> that's been the case, and there's an outstanding patch to add another
> format that uses these[5].
>
> So let's expose this functionality as a documented utility function,
> instead of copy/pasting this code in various places.
>
> Replacing the die() in the existing functions with a BUG() might be
> overzelous, it's correct for the case of
> e.g. write_commit_graph_file() and write_midx_header(), but we also
> use this for parsing on-disk files, e.g. in parse_commit_graph().

If we know the offending data can come from outside, not from
literals in the code, then there is no "might be", such a use of
BUG() is simply wrong.

> We could add a "gently" version of this, but for now I think that
> worrying about the distinction would be worrying too much. If we ever
> end up parsing such files that'll almost certainly be a bug in our own
> writing code, so the distinction would be rather academic, even though

It would be a file written by an ancient buggy version of our code,
or a buggy third-party reimplementation of Git.  It could be that a
new version of Git is using a yet-to-be-invented algorithm this
version of Git does not know about.

The distinction matters in that "The version of Git I downloaded and
built last week out of the latest release tag said BUG" should mean
only one thing: that version that reports BUG() is the culprit, not
some random other thing we do not even know where it came from that
left a corrupt data on disk.
