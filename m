Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F4E20281
	for <e@80x24.org>; Tue, 19 Sep 2017 05:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdISFvz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 01:51:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53192 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750867AbdISFvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 01:51:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60548AC1A1;
        Tue, 19 Sep 2017 01:51:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xZ80lR/yPkML/84jyCgqPTvKLJ8=; b=Ggrd/I
        jhpua/ryYmOva76ZkWv8PgCW4vQMkK1u8OEt/RGzT3NnfT+ok+N5QQrgqKkGQX4k
        WgIqO26JFgWq4j1fych5iBjKwxAPBOq05ASklWy1n57uCT/Jeo0j5XTtFyocdeMe
        6vWnwWFfOYiJ21INCjdwBZAZBMSc3/vD0LeAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nRkk6tpT2MtQcmSXD2aFsBiZ/X+PfDpr
        9N6mmb38rc9+MUH50bFFaROxp/i+9gYpWlrEF+fQW56tQhJ4o44YEJ/NZ/KsdEqm
        fBQku2QVi3fZvcIxIyyutluuF8OP5lxSFHh2eocAKVOdPetbjht0p8pdZ+34HIDF
        s2mx0uWzoME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 583D5AC1A0;
        Tue, 19 Sep 2017 01:51:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8672DAC19F;
        Tue, 19 Sep 2017 01:51:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        git@jeffhostetler.com
Subject: Re: RFC: Design and code of partial clones (now, missing commits and trees OK)
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
Date:   Tue, 19 Sep 2017 14:51:52 +0900
In-Reply-To: <20170915134343.3814dc38@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Fri, 15 Sep 2017 13:43:43 -0700")
Message-ID: <xmqq8thbqlqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A378DE6C-9CFE-11E7-98D1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> For those interested in partial clones and/or missing objects in repos,
> I've updated my original partialclone patches to not require an explicit
> list of promises. Fetch/clone still only permits exclusion of blobs, but
> the infrastructure is there for a local repo to support missing trees
> and commits as well.
> ...
> Demo
> ====
>
> Obtain a repository.
>
>     $ make prefix=$HOME/local install
>     $ cd $HOME/tmp
>     $ git clone https://github.com/git/git
>
> Make it advertise the new feature and allow requests for arbitrary blobs.
>
>     $ git -C git config uploadpack.advertiseblobmaxbytes 1
>     $ git -C git config uploadpack.allowanysha1inwant 1
>
> Perform the partial clone and check that it is indeed smaller. Specify
> "file://" in order to test the partial clone mechanism. (If not, Git will
> perform a local clone, which unselectively copies every object.)
>
>     $ git clone --blob-max-bytes=100000 "file://$(pwd)/git" git2
>     $ git clone "file://$(pwd)/git" git3
>     $ du -sh git2 git3
>     116M	git2
>     129M	git3
>
> Observe that the new repo is automatically configured to fetch missing objects
> from the original repo. Subsequent fetches will also be partial.
>
>     $ cat git2/.git/config
>     [core]
>     	repositoryformatversion = 1
>     	filemode = true
>     	bare = false
>     	logallrefupdates = true
>     [remote "origin"]
>     	url = [snip]
>     	fetch = +refs/heads/*:refs/remotes/origin/*
>     	blobmaxbytes = 100000
>     [extensions]
>     	partialclone = origin
>     [branch "master"]
>     	remote = origin
>     	merge = refs/heads/master

The above sequence of events make quite a lot of sense.  And the
following description of how it is designed (snipped) is clear
enough (at least to me) to allow me to say that I quite like it.


