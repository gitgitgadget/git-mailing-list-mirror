Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE240CCA47D
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343749AbiFOUSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbiFOUS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:18:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79753BBE6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:18:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37532120E63;
        Wed, 15 Jun 2022 16:18:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m2iv5M65QpHKQnIl7HAD7iAHiJeBv8hzhEeVkA
        wtJT0=; b=ajYVlS9Axq870zMqm9EB6DkUxSja0WbDeJf2WKQgp9EPpn1SxDD5sb
        Dak9YIzr/fB/yb8ekQNBOvsfLBb+alHmAB+tZPKJjUbB82FXfr0XIZQxCCIXauZ9
        iYhjenxbpydHabi79XRNkf8gqwbKUS2BQvMK2Rs8Ts4QT4JteHU1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FADC120E62;
        Wed, 15 Jun 2022 16:18:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A32A120E5D;
        Wed, 15 Jun 2022 16:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote ref?
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
Date:   Wed, 15 Jun 2022 13:18:26 -0700
In-Reply-To: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
        (Tao Klerks's message of "Wed, 15 Jun 2022 21:12:18 +0200")
Message-ID: <xmqqilp1znn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50EBC4B8-ECE8-11EC-92E7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Given the following configured fetch refspec for a remote:
>
> [remote "origin"]
>         url = git@someserver:somerepo.git
>         fetch = +refs/heads/*:refs/remotes/somepath/*
>
> And given a ref of the form "refs/remotes/somepath/branch_A",
>
> I'm wondering whether there is any plumbing that would be able to tell
> me what to put in a "fetch" command, to get
> "refs/remotes/somepath/branch_A" fetched - in other words, is there
> any plumbing that can use the configured fetch refspecs to map
> "refs/remotes/somepath/branch_A" to "refs/heads/branch_A" for me, so
> that I can then do "git fetch origin refs/heads/branch_A".

I am fairly certain that I never have written one myself ;-)

I wonder how the end-user experience should look like.

	$ git refmap refs/remotes/somepath/branch-A
	origin refs/heads/branch-A

	$ git refmap refs/remotes/somepath/{branch-A,branch-B}
	origin refs/heads/branch-A
	origin refs/heads/branch-B

IOW, you give name(s) of remote-tracking branches and then you get
the remote and their ref for these?

I do not oppose to such a command existing, but I do not know what
the right answer should be for a case like this:

	[remote "origin"]
		url = ... the official project repository ...
		fetch = +refs/heads/*:refs/remotes/upstream/*

	[remote "mirror"]
		url = ... a local mirror you'd use regularly ...
		fetch = +refs/heads/*:refs/remotes/upstream/*

In order to support such a "more than one can update the same" case
sensibly, the output may have to repeat the input, e.g.

	$ git refmap refs/remotes/upstream/main
	refs/remotes/upstream/main	origin refs/heads/main
	refs/remotes/upstream/main	mirror refs/heads/main

perhaps?

