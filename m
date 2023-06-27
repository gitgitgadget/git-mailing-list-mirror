Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708C8EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjF0SWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF0SWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 14:22:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AB10DB
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 11:22:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 184581838D1;
        Tue, 27 Jun 2023 14:22:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gpqO+7UIOIbSn02ASqgUqhAdivFSF35SCNJqd/
        AWztk=; b=n8Go3q68YN2eFaf93KYauaB2C8QC1nSqXVPyGmMgHofIIn3DQ3sxOv
        LP+gWxG46Vmjzr/924UBQTMOOpbSveM8gFmVdg7ESi4gQoogmrQoYjJtTtwotG4I
        rSzNSP3gayEIC2+YqQxsU6QkM22dGQoiiDiwLOPgxCTMaPrrWrlGI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE4121838D0;
        Tue, 27 Jun 2023 14:22:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 911C91838CF;
        Tue, 27 Jun 2023 14:22:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
        <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
        <20230627073007.GD1226768@coredump.intra.peff.net>
        <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com>
Date:   Tue, 27 Jun 2023 11:22:02 -0700
In-Reply-To: <f6fd39bc-65d4-76e3-94b4-9163194c89dd@gmail.com> (Phillip Wood's
        message of "Tue, 27 Jun 2023 11:05:29 +0100")
Message-ID: <xmqqmt0khik5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83E2E6DC-1517-11EE-A4FC-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I'm a bit suspicious of the massive speed up I'm seeing by avoiding
> the default format but it appears to be repeatable.

This is interesting.  The default format over just 'x' is to
concatenate the refname with hexadecimal form of the object name,
while (at least as the code originally was intended):

 * the cost of parsing the "--format=<format>" string into series of
   atoms is one-time O(1), and there is nothing specially tricky in
   there.

 * the cost of computing these atoms should be miniscule, as
   in the default format, the per-ref cost come from these:

   - populate_value() -> get_refname() -> show_ref() for the refname
     would merely be a xstrdup() of the refname.

   - populate_value() -> grab_oid() -> do_grab_oid() should be using
     O_FULL so there shouldn't be any find_unique_abbrev() cost.
     Just binary-to-hex.

   - populate_value() -> get_object() -> oid_object_info_extended() ->
     grab_common_values() asks for ATOM_OBJECTTYPE that should be a
     single xstrdup(), but oid_object_info_extended() needs to parse
     the object, but .info.contentp ought to be NULL and we should
     not be calling parse_object_buffer().

So it might be worth looking into where the time is going (didn't
Peff or somebody do that a few years ago, though?) when using the
default format and optimize or special case the codepath, but the
responses I have seen from two of you makes me suspect that the new
option is not the best general approach.

Thanks.




