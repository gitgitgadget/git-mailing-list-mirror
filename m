Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F226520899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdHUASY (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:18:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51743 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753408AbdHUASX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 20:18:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0444FA1324;
        Sun, 20 Aug 2017 20:18:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ds+23Xy18yxUNzAGvS5W8hzJotY=; b=hsfe09
        7oAwCX3B2WCMSBpVFsVl1FFMmyR+pHMXqYVrY935ioNze2VTJKz6uZ8EGLKkMP9q
        wDKZHGm0kt4JfbS2jS4gX0Wu87N7uacf41ctw9N6JWi19BDUO/ZL1vvhqBMUWHfJ
        Uecn29TJ0krytQFNyHawiX8aiUwx56MJJJ4rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xYyOTeAShQ4YZHWMfetFiF6zXjM+9gC+
        fVEJclatg6okB/aNxRWAvfWEu09tZobGuZ61isqkeAtG4nbrzoYi4OTOPBcS/dHR
        ZdCNSgZy7akQKpZYuOcwPPADjGFJZuvGNx4Vw+cI3JbN0PpsD5WdGqZT/UIFI1lg
        RjuI7d1fUi8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB62A1323;
        Sun, 20 Aug 2017 20:18:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43843A1322;
        Sun, 20 Aug 2017 20:18:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Hash Abstraction
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Date:   Sun, 20 Aug 2017 17:18:14 -0700
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 21 Aug 2017 00:00:16 +0000")
Message-ID: <xmqqefs57ozd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39A19AE2-8606-11E7-883E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> brian m. carlson (6):
>   vcs-svn: remove unused prototypes
>   vcs-svn: rename repo functions to "svn_repo"
>   setup: expose enumerated repo info
>   Add structure representing hash algorithm
>   Integrate hash algorithm support with repo setup
>   Switch empty tree and blob lookups to use hash abstraction

The first two are about very quiescent code that can go in and sail
thru 'next' very quickly without problems, I would think.

After the third one alone, the discovered format information may not
be fully plumbed through (i.e. after setup finishes there is no way
for outside callers to peek at the repo_fmt instance that was on
stack), but it seems that this is sufficient for the purpose of this
step and it looks a very sensible first step.,

As to patch 4, I tend to agree with the analysis you had in this
cover letter--it did make me wonder if we want to have union of hash
contenxt structures, for example.  But the enumeration of virtual
functions looks about right.

I wondered if we wanted "binery size" and "hex size" separately,
because the latter will always be twice as big as the former as long
as the latter's definition is "hex", but that is a minor point.

Thanks for starting this.

>  builtin/am.c        |  2 +-
>  builtin/checkout.c  |  2 +-
>  builtin/diff.c      |  2 +-
>  builtin/pull.c      |  2 +-
>  cache.h             | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  diff-lib.c          |  2 +-
>  merge-recursive.c   |  2 +-
>  notes-merge.c       |  2 +-
>  repository.c        |  7 +++++++
>  repository.h        |  5 +++++
>  sequencer.c         |  6 +++---
>  setup.c             | 48 +++++++++++++++++++++++++++---------------------
>  sha1_file.c         | 29 +++++++++++++++++++++++++++++
>  submodule.c         |  2 +-
>  vcs-svn/repo_tree.c |  6 +++---
>  vcs-svn/repo_tree.h | 13 +++----------
>  vcs-svn/svndump.c   |  8 ++++----
>  17 files changed, 133 insertions(+), 53 deletions(-)
