Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B224C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3F20409
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZsowtkM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK0Mdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:33:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60697 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfK0Mdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:33:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAD6320D49;
        Wed, 27 Nov 2019 07:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=G7nnpPchHAK28Q5MKHqKvypVa7o=; b=ZsowtkM5skOwLn+uJYJp
        xGZYzUYk5Dt8WDwdpR42//WuF8GQLPFYq6L3AFj/vCZGASCZHJI/uxIZyVCC+/nV
        0zgTYJBH4nSNvE7+dyU+eJLVhZMqcyBi62j8fDadCkFr3I/6yRGp3ax1qbX5XFqH
        Y0gaDsd78kIpLrVCd8TfYs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=xebmY40gm/0LBzj/QEgjG30OcriCTNhgvRllaiDZni7b0p
        dKGaDpy+P9j9p+5MPOYtNPb7dJHUYKjqEm3AtLinEB7RpxhpzX2gu0XAGvjTVAQ8
        Ns6agZYVqSRr6rA4l8N3ep4weO61At2zf2ITfS6Xic2aWLxijdqLhrNz7aNc0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2AF120D48;
        Wed, 27 Nov 2019 07:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54AF820D47;
        Wed, 27 Nov 2019 07:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug? clone ignores --git-dir
References: <7d28416e-c927-4cd3-bac2-d8bfd02ce949@nottheoilrig.com>
Date:   Wed, 27 Nov 2019 21:33:41 +0900
Message-ID: <xmqqh82pv6qi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25731EC6-1112-11EA-92DF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jack Bates <bk874k@nottheoilrig.com> writes:

> ... repositories, however `clone` ignores `--git-dir`:

An intentional design decision (and it may be an unfortunate one by
now [*1*]) was to have the GIT_DIR (hence --git-dir) talk about the
*source side* of the clone, not the destination, e.g.

	cd /home/me/working/tree
	export GIT_DIR=/home/me/repo/sitory
	export GIT_WORK_TREE=$(pwd)

	# the above told Git that /home/me/working/tree has a
	# checkout but its repository body is not anywhere in its
	# subdirectory -- it is /home/me/repo/sitory.

	# now we clone the repository we are currently working on
	# without GIT_DIR applying to the source side, it won't
	# work.
	git clone . /else/where

And we cannot allow /home/me/repo/sitory (i.e. GIT_DIR for the
source repository) become the GIT_DIR for the resulting /else/where
repository (you'd be cloning to yourself).


[Footnote]

*1* with use of "git worktree" gaining traction, perhaps the need to
    create local clone out of the shared/same GIT_DIR may have
    diminished.

