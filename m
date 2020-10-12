Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D14C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE992206CB
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mCicMkn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390799AbgJLRqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:46:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60420 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbgJLRqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 13:46:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57B068C6D8;
        Mon, 12 Oct 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PULjh7C+OjT1Zk7Trz3W2tpLzK4=; b=mCicMk
        n67KPYOPIwEa/zPaQG9syMEgOIdUEstKU5PZ/KwDJFOJEvZcE8Y2RnFN6DNSeIRX
        PR6Y0Anqllmd9b+mvkQ2iVTTKb8l7iusoBeEtXwRBAKMiKlA+HrUQt9bIh6LmI+l
        oRNdlLazieA2feQH1colAYAWuFEkq7pReUDBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MPQZ/NpMmSEyRt0WIPL0GF64tv4N8wdt
        ZHK4QheN17uHxNhNKtncsjxrmARr2k5lpv5YDQBrh7zKdPXuS2cQ1ZwrZacBGmwi
        zg1bl9RlW1Fem2oclTi4nr215tMafqzwKWO6biLvfCaxw6tEIbzCtMFbOKdKJVL/
        ao2GN6yH+h0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EA848C6D7;
        Mon, 12 Oct 2020 13:46:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D14748C6CE;
        Mon, 12 Oct 2020 13:46:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Deepak Patankar <patankardeepak04@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to Verify the Git Credentials supplied by the User
References: <CABmmNJOGBdEO+AT0_8dSwmFxomFE7A5x354+YgfxiU5N+mOroA@mail.gmail.com>
Date:   Mon, 12 Oct 2020 10:46:40 -0700
In-Reply-To: <CABmmNJOGBdEO+AT0_8dSwmFxomFE7A5x354+YgfxiU5N+mOroA@mail.gmail.com>
        (Deepak Patankar's message of "Mon, 12 Oct 2020 19:20:42 +0530")
Message-ID: <xmqqsgajpcan.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2806DE2-0CB2-11EB-B873-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Deepak Patankar <patankardeepak04@gmail.com> writes:

> I am writing an application in which we will support git integration.
> The user will provide us with his/her git credentials so that we can
> push some files on his git. The git credentials which user will supply
> can be
>
> HTTP (Username and Password/ Kerberos)
> SSH
>
> Before saving the user credentials I want to validate that the
> credentials entered is valid.

It obviously depends on the remote side, but a relatively safe thing
to try is to run things like "ls-remote" or "push --dry-run" that
will not cause any actual damage against the remote, and see if your
authentication fail.

But you might be asking a XY question.  I would expect that any
reasonable application that manages authentication material for the
user and drives "git fetch" and "git push" would act as a credential
helper and uses the credential protocol to talk to Git, so it will
learn an authentication failure upon the first use, at which point
it has the chance to drop the authentication material it obtained
earlier and ask the user for the corrected one---there is no need
for the application to see if the authentication material is correct
before the user does anything else.


> The user might be using GithHub/BitBucket/GitLab. I am trying to find
> some git command which I can use to validate the credentials. Can you
> please point me to some command/logic which I can try?
>
> What I have tried?
> I tried git ls-remote command, but it requires the repo name/url. In
> one of our use case, the user won't specify the repository name
> beforehand. Because of which I am not able to use this command.

This assumes there always is a single authentication material
regardless of the URL, which is probably not a good security posture
to encourage the users to adopt.
