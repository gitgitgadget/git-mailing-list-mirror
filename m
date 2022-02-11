Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50399C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 17:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiBKRTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 12:19:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiBKRTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 12:19:22 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3909E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 09:19:21 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC954186C8C;
        Fri, 11 Feb 2022 12:19:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nfYtW4TIW4jDdEYu88ll7O7LYer6mCu+vxuGKw
        gyJUw=; b=Db0+lfCc+7jeHLoOqn82g9UdMEtDCywN9m81rdZQ4Sn7n2YloN2j5q
        kpCCgxh3ka+/1tXlsHaUBFkE/StTy3URKrCV7NH2tP2w/27qTlxB9DrkpxOWosBy
        1Z4jk/BDX9qkJVR4/pr8vM4x9NSmb5n4VxJq/v4BHwTWMQFk0IfJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D098186C8B;
        Fri, 11 Feb 2022 12:19:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 064CB186C8A;
        Fri, 11 Feb 2022 12:19:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 8/8] submodule: fix bug and remove add_submodule_odb()
References: <20220210230422.690368-1-jonathantanmy@google.com>
Date:   Fri, 11 Feb 2022 09:19:16 -0800
In-Reply-To: <20220210230422.690368-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 10 Feb 2022 15:04:22 -0800")
Message-ID: <xmqqy22hcodn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE78BC66-8B5E-11EC-A2BC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I would write the commit message like this:
>
>   submodule: fix latent check_has_commit() bug
>
>   check_has_commit() will attempt to clear a non-initialized struct
>   repository if initialization fails. This bug is masked by its only
>   caller, submodule_has_commits(), first calling add_submodule_odb().
>   The latter fails if the repo does not exist, making
>   submodule_has_commits() exit early and not invoke check_has_commit()
>   in a situation in which initialization would fail.
>
>   Fix this bug, and because calling add_submodule_odb() is no longer
>   necessary as of 13a2f620b2 (submodule: pass repo to
>   check_has_commit(), 2021-10-08), remove that call too.
>
>   This is the last caller of add_submodule_odb(), so remove that
>   function. (Adding submodule ODBs as alternates is still present in the
>   form of add_submodule_odb_by_path().)

Looks more clearly explained.  

We still end up calling add_to_alternate_memory(), so I take the
"let's have this early" back.
