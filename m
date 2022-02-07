Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB5C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 20:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiBGU6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiBGU6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 15:58:01 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58136C06173B
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 12:57:59 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4321A11A70B;
        Mon,  7 Feb 2022 15:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=co3qJEEAgJixbNvMTkzYNIToZqDNknrJVb8Jku
        OV7s4=; b=fTfzQSPGQsThNejwcpzpQLIE+ZI3J3gnd0+/BNTzEiFvhrm3WW3JYx
        7Y6HPRHLOXpWUqPG0+VR1hftFwwNJ4PIB4gOVE6yN2XtnblN7KT7/N2f4Pv023ox
        tnzcBnYKW9k6gffGMA5REppJ/fFzdbv4+GRDnXkZ1NiUwCJZTv3I4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A63011A70A;
        Mon,  7 Feb 2022 15:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C96A11A708;
        Mon,  7 Feb 2022 15:57:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "Gamblin, Todd" <gamblin2@llnl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
        <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
        <xmqq1r0gjo6h.fsf@gitster.g>
        <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
        <xmqqee4fix0l.fsf@gitster.g>
        <20220207133244.kpyczjsxriepjtdt@meerkat.local>
Date:   Mon, 07 Feb 2022 12:57:55 -0800
In-Reply-To: <20220207133244.kpyczjsxriepjtdt@meerkat.local> (Konstantin
        Ryabitsev's message of "Mon, 7 Feb 2022 08:32:44 -0500")
Message-ID: <xmqqczjyiecs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A001F4AE-8858-11EC-8F4D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Sun, Feb 06, 2022 at 12:02:34PM -0800, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>> 
>> > I think part of Todd's question was how the tag and uncompressed archive
>> > 'checksums' (e.g. hashes) relate to each other and where those
>> > guarantees come from.
>> 
>> There is no such linkage, and there are no guarantees.  The trust
>> you may or may not have on the PGP key that signs the tag and the
>> checksums of the tarball is the only source of such assurance.
>> 
>> More importantly, I do not think there can be any such linkage
>> between the Git tree and release tarball:
>
> Hmm... I've actually considered writing a tool that would verify whether a
> tarball corresponds to a signed tag/commit. It should be entirely possible,
> no?

I was saying "I have this git commit (or tree) object name.  Compute
the hash for a .tar archive that would contain the contents of that
tree." has no unique answer.

You are solving a different problem: "I have this tar archive; what
git tree object would I get if I extract this archive to an empty
directory and said 'git add . && git write-tree'?".

I agree that one is computable.

Of course, even that reverse problem will break once we consider the
release tarball generation procedure where we _add_ some generated
files that are not in the Git tree, for builder's convenience.
