Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71FD91F454
	for <e@80x24.org>; Sun, 10 Nov 2019 07:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfKJH0i (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 02:26:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfKJH0h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 02:26:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8512AB31C;
        Sun, 10 Nov 2019 02:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TTBVGFOneAxU
        a0yaEEMmAfetC14=; b=YBd7E9WsGaXgFxRsL1/NlCnWKiumjQKY7gg+YoE/JN1r
        2sV2h18kHFbPgehUxk3ewuaoWTNi8NfvfFPZ7OG83UeA8f/OWd2JFo4eY6Bwzs4j
        N1RQyVMmer8LQvmBBAvPl48JjbAJ1QD1fB9SqqrJJktjuQGGRS9n9FAg5//Hzek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SEtgn5
        CDIASTgNNd/KluK65jUpz61mL9+CkYhgQ+pMgURLPsLcVVFF89+czGtyzVFzuLxW
        mm2oh7anId8F0ccSArvUJjQcmNgYkJcK09vPFp9S5pT6A5CoHLSbma+PrrFl1m8K
        hjlSuAoPjTAFXdLG1sol0PMJl0/CZZk9DMiaM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4D9DAB31B;
        Sun, 10 Nov 2019 02:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C08C5AB319;
        Sun, 10 Nov 2019 02:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?R=C3=A9da?= Housni Alaoui <reda.housnialaoui@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Sometimes unable to lock the index during pre-commit hook
References: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
Date:   Sun, 10 Nov 2019 16:26:29 +0900
In-Reply-To: <CAE0unxyojHVWP4aM3C+DdMYORmcoCuq-0wwLGjE8ok6dLj_E8w@mail.gmail.com>
        (=?utf-8?Q?=22R=C3=A9da?= Housni Alaoui"'s message of "Sat, 9 Nov 2019
 22:39:04 +0100")
Message-ID: <xmqqpni0jioq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AF5511A-038B-11EA-A201-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R=C3=A9da Housni Alaoui <reda.housnialaoui@gmail.com> writes:

> Are pre-commit hooks expected to be able to manipulate the index?

Hooks are described in githooks(5) manual pages; we may want to
clarify what is not allowed, but back when most of the entries were
written, the stance was that anything that is not explicitly allowed
there is forbidden.

In general, a pre-<something> hook is a way to inspect (i.e. look
but not touch) what is proposed to be done and veto it by exiting
with non-zero.  It is not expected to change the state of the
repository in any way.

The code does not necessarily enforce it, because it is costly to
take a snapshot of everything (including the index, the working tree
files, the files that are untracked, the objects in the object
database, etc.) before calling a hook and ensure that the hook did
not touch anything.

Thanks.
