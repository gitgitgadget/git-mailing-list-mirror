Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C5EC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9112072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 22:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tyvMmIQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0WAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:00:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62731 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgC0WAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 18:00:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 741D1B95F9;
        Fri, 27 Mar 2020 18:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7i2Bjzgc5GnWss4SVHSGSf+QfpE=; b=tyvMmI
        QidPfrh7Lo84a4qw8aIpZX9upIf4LgYqczDVlHjeqnJi4p7meOGYI6P3Tlg7EVZU
        HF/Bw9GekhlTuPZyYA0vn7icZ/Truq2tv2qbmwe++8zkzkr+zI3aP0CzP1ZKIqTj
        JEU+tEyoPXUahi8dxl/orcI84hshQGPVRohys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cnvAWyWfTr4cXixtPSpBA+Il0n5mav+A
        Ao/Ec6W70qWDATYfP20UoZJKdHYxyXeEEVFnRQK87qI5L48KTZ/o2ExT4LXIMXoT
        RTMUn6gH8NfbKHAFATGQxbdCJZ73tBLC8po5bui7dKXVsVF1yR1JbVTH1aiAvNiO
        qr68xOQwY3o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D190B95F8;
        Fri, 27 Mar 2020 18:00:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7AAB1B95F5;
        Fri, 27 Mar 2020 18:00:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 9/9] update-ref: implement interactive transaction handling
References: <cover.1585129842.git.ps@pks.im>
        <88c0089bb50bca13efc79a1f8fd42b80286af949.1585129843.git.ps@pks.im>
Date:   Fri, 27 Mar 2020 15:00:19 -0700
In-Reply-To: <88c0089bb50bca13efc79a1f8fd42b80286af949.1585129843.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 25 Mar 2020 10:54:29 +0100")
Message-ID: <xmqqk135e9vw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8298A8-7076-11EA-9294-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The git-update-ref(1) command can only handle queueing transactions
> right now via its "--stdin" parameter, but there is no way for users to
> handle the transaction itself in a more explicit way. E.g. in a
> replicated scenario, one may imagine a coordinator that spawns
> git-update-ref(1) for multiple repositories and only if all agree that
> an update is possible will the coordinator send a commit. Such a
> transactional session could look like
>
>     > start
>     < start: ok
>     > update refs/heads/master $OLD $NEW
>     > prepare
>     < prepare: ok
>     # All nodes have returned "ok"
>     > commit
>     < commit: ok
>
> or
>
>     > start
>     < start: ok
>     > create refs/heads/master $OLD $NEW
>     > prepare
>     < fatal: cannot lock ref 'refs/heads/master': reference already exists
>     # On all other nodes:
>     > abort
>     < abort: ok
>
> In order to allow for such transactional sessions, this commit
> introduces four new commands for git-update-ref(1), which matches those
> we have internally already with the exception of "start":
>
>     - start: start a new transaction
>
>     - prepare: prepare the transaction, that is try to lock all
>                references and verify their current value matches the
>                expected one
>
>     - commit: explicitly commit a session, that is update references to
>               match their new expected state
>
>     - abort: abort a session and roll back all changes

OK, this is a fun stuff, and explains why we wanted to do [7/9].

