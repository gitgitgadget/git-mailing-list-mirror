Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D289DC433E6
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FB964E6C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBYScC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:32:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64829 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhBYSaa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 13:30:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6D9D1203CE;
        Thu, 25 Feb 2021 13:29:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MVhMaCOUUuXLXIqhvI2SpIcfWMU=; b=rZYgkR
        xNZZtvMlIJwj13bKMGPjevhjeg1PlLIS43gSfc8/rhssMDKvY9TueiCSF/ETlgjk
        tduleI6oo18WstAT77qhs67WuJM937ZuHA2+ECL5uNXwgB1wYzBzHoQzRAenxZo5
        feuaYOTv9swg7wRCCB1z5GqwkYSK71ux97scU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MK7SZIa1nS9JKY3yNvFXPqFUBieIO8pd
        KbE7g1k3m3JwpWrOrzIHN6AjrE8OZNgdnHlyKluBdZt9np+rMKBRy2GmWVcJXntK
        KBRKF/7Z+095tBGxmeTFmJ3vHTUrYnMWQyOimh9nGBn/FqIWV9meBN4Ef4fAjJ/8
        W4EOyJY/hv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BFF61203CD;
        Thu, 25 Feb 2021 13:29:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1C581203C9;
        Thu, 25 Feb 2021 13:29:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Nicolay <m.nicolay@osm-ag.de>
Cc:     git@vger.kernel.org
Subject: Re: bug: setting GIT_DIR to $(git rev-parse --git-dir) changes
 behavior
References: <alpine.LSU.2.20.2102251549330.20742@cpza.bfz-tzou.qr>
Date:   Thu, 25 Feb 2021 10:29:35 -0800
In-Reply-To: <alpine.LSU.2.20.2102251549330.20742@cpza.bfz-tzou.qr> (Martin
        Nicolay's message of "Thu, 25 Feb 2021 15:54:27 +0100 (CET)")
Message-ID: <xmqqtuq0uhkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AA7E9F8-7797-11EB-81AB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Nicolay <m.nicolay@osm-ag.de> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)

Thanks for concise and clear descriptions for us to learn everything
you did.  I wish all the reports were written like this one.

> $ env | grep GIT
> $ git --version
> git version 2.30.1

Showed there is no funny environment variable involved and the
version.  Good.

> $ git init t
> Initialized empty Git repository in /tmp/t/.git/
> $ mkdir t/foo
> $ cd t/foo
> $ git rev-parse --show-toplevel
> /tmp/t

The root of the working tree is at /tmp/t/, the repository at
/tmp/t/.git/, and you are in the foo/ subdirectory.  When you ask
"where is the top level of the working tree in this state, because
you do not have GIT_DIR or GIT_WORK_TREE environment variables, you
are asking Git to "discover" both the .git/ directory and the top of
the working tree, by starting at the current directory,
i.e. /tmp/t/foo, which is where you are.

First Git looks to see /tmp/t/foo/.git/ exists and is a repository;
it is not.  So it goes one level up and does so for /tmp/t/.git/ and
it finds that it is the repository.  The directory in which the
repository was discovered is the top of the working tree, hence you
get /tmp/t back.

> $ GIT_DIR=$(git rev-parse --git-dir) git rev-parse --show-toplevel
> /tmp/t/foo

When you give the GIT_DIR environment variable, you are telling Git
not to perform the repository discovery, AND also you are telling
Git that you are at the top-level of the working tree.  So this is
quite expected (it is a feature that is used by folks who want to
have their repository data in a distant and unrelated directory from
their working tree).

In other words, this is 100% expected behaviour.

If you want to also tell Git where the top-level of your working
tree is, you can export GIT_WORK_TREE at the same time.

    Side note: the latter environment variable was invented for this
    exact reason.  Back when only GIT_DIR existed as a way to tell
    Git where the distant repository is, those who wanted to use the
    "split" layout had to stay at the top-level of their working
    tree, and they got tired of not being able to work from a
    subdirectory.  GIT_WORK_TREE was introduced to tell where the
    top-level is separately from GIT_DIR when GIT_DIR environment
    variable is in use.

> $ git rev-parse --git-dir
> /tmp/t/.git
