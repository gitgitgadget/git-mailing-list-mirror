Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06627C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiBQTKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243867AbiBQTK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 14:10:29 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7C8594F
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 11:10:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DB07102737;
        Thu, 17 Feb 2022 14:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UatyEBAuhlicTA0R9jooVx5os6SZIi4ttlqlMb
        UYW98=; b=xeSf9dk7DhWWxjRxZkjTSbRdqFlrW620sgttJ+O8blnrmc8XAavVCx
        LkbJ5edBniy68AkOpQ/wxZzh/NwOI/JUM4n0zNRD+oF/uAqVr5TvNEyaVuALqelE
        IX1DSwpB7E3cus58PrjKTJd2r8DNNcif40tl5T7zg9cJQ0HxkhE38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CB93102735;
        Thu, 17 Feb 2022 14:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70F1810272A;
        Thu, 17 Feb 2022 14:10:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        <xmqqiltmwufw.fsf@gitster.g>
        <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
        <xmqqh796tw34.fsf@gitster.g>
        <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
        <xmqqczjuttyw.fsf@gitster.g>
        <CAFQ2z_O=WguSAJDD4DRpwtX54A5dWQZQPCuQDR81idknQgchaA@mail.gmail.com>
Date:   Thu, 17 Feb 2022 11:10:07 -0800
In-Reply-To: <CAFQ2z_O=WguSAJDD4DRpwtX54A5dWQZQPCuQDR81idknQgchaA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 17 Feb 2022 11:00:12 +0100")
Message-ID: <xmqqtucx8g34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 398ED6C2-9025-11EC-92E2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> For FETCH_HEAD, doing
>
>   git fetch host refs/changes/23/123/1 && git checkout FETCH_HEAD
>
> is the standard idiom for downloading a change from Gerrit. I suspect
> there might be other similar idioms. This means we have to read them
> through the refs machinery.

This merely means we have to read them through the object-name
machinery around get_oid().  Historically that was done by calling
repo_dwin_ref() from get_oid_basic(), which is where refs machinery
enters the picture, and because we had only files backend, it was OK
and convenient to treat .git/FETCH_HEAD and .git/refs/heads/master
in the same codepath.  But there is no reason for the arrangement to
stay that way.  .git/FOOBAR_HEAD files can be read as a file (we can
say we let files-backend to handle it, but we can also extract a helper
function out of it and make it clear that it truly has no dependence
on the refs machinery) while .git/refs/* can be read from the refs
machinery that may be backed by reftable backend.

> I think the most sensible approach is to pass the read/write through
> refs_* functions, but special-case the storage, so it doesn't go
> through reftable. We already do this for FETCH_HEAD and MERGE_HEAD in
> refs_read_raw_refs.

I think we are more or less on the same page.  I do not think these
files behave like refs (they have no reflog, and they do not serve
as anchoring points for the purpose of gc/fsck) and we need a
special code path, which might be identical to the current ref-files
backend code, to handle them no matter what backend is used for true
refs.

> This means we need a formal definition of which refs should be treated
> as files. Maybe we could do as follows:
>
> Pseudorefs are
>   1) all uppercase toplevel names except for HEAD
>   2) all refs that are not under refs/* (for example:
> rebase-{merge,apply}/autostash)
>
> Pseudorefs are always stored as files containing a hex object_id.
>
> Pseudorefs can be read or written through refs_* functions, but given
> the storage guarantees, it's also valid to read/write them outside
> refs_* functions
>
> It is forbidden to make cross-ref transactions that involve pseudorefs.
