Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 545CE1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdGaVWD (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:22:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52682 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751052AbdGaVWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:22:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC679905D9;
        Mon, 31 Jul 2017 17:21:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x9qAOqm/I9+dzXJStx0a00YmQTY=; b=M5/eS/
        EcsFoY2scZAcO3/WCrhWyfZMBgvvTYQiFhdhE0DhKsrxd45j2UvpAUbMNypTM83l
        gCxRXayNVSpapGqYVBBD4TBdwulXSSSd2PwL4Ih9Bnavcm283xpJ1FlWnovLwlQA
        DfcOmyBWX/7W4Sm3EkEy5yBBYge07ACqaNgfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gzjLWhA0iQ235vMDqv0bRoCsJlQx6Ec7
        bTZySEssCS73PT+ODutwz+M9NSoJLxLsGBInoHDb0J5YuNh8Xrpw16wtsXFjb5Fl
        wPZXaWszlU3Db/6dorBYCZhyPGNsCERKyd3PhZILoCUPJpOJIEnd/cx3ylnv+Xfd
        72pzUKUD5qU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3BE9905D7;
        Mon, 31 Jul 2017 17:21:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19DEF905D6;
        Mon, 31 Jul 2017 17:21:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
Date:   Mon, 31 Jul 2017 14:21:56 -0700
In-Reply-To: <cover.1501532294.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 31 Jul 2017 14:02:42 -0700")
Message-ID: <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48EC150C-7636-11E7-A2B4-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Besides review changes, this patch set now includes my rewritten
> lazy-loading sha1_file patch, so you can now do this (excerpted from one
> of the tests):
>
>     test_create_repo server
>     test_commit -C server 1 1.t abcdefgh
>     HASH=$(git hash-object server/1.t)
>     
>     test_create_repo client
>     test_must_fail git -C client cat-file -p "$HASH"
>     git -C client config core.repositoryformatversion 1
>     git -C client config extensions.lazyobject \
>         "\"$TEST_DIRECTORY/t0410/lazy-object\" \"$(pwd)/server/.git\""
>     git -C client cat-file -p "$HASH"
>
> with fsck still working. Also, there is no need for a list of promised
> blobs, and the long-running process protocol is being used.

I do not think I read your response to my last comment on this
series, so I could be missing something large, but I am afraid that
the resulting fsck is only half as useful as the normal fsck.  I do
not see it any better than a hypothetical castrated version of fsck
that only checks the integrity of objects that appear in the local
object store, without doing any connectivity checks.

Don't get me wrong.  The integrity check on local objects you still
do is important---that is what allows us to make sure that the local
"cache" does not prevent us from going to the real source of the
remote object store by having a corrupt copy.  

But not being able to tell if a missing object is OK to be missing
(because we can get them if/as needed from elsewhere) or we lost the
sole copy of an object that we created and have not pushed out
(hence we are in deep yogurt) makes it pretty much pointless to run
"fsck", doesn't it?  It does not give us any guarantee that our
repository plus perfect network connectivity gives us an environment
to build further work on.

Or am I missing something fundamental?
