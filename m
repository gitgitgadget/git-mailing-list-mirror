Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34F41F407
	for <e@80x24.org>; Fri, 15 Dec 2017 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756733AbdLOQdZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 11:33:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53090 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756697AbdLOQdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 11:33:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DB04B2693;
        Fri, 15 Dec 2017 11:33:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+yj4RZ78odilgLS+WsszOKxJtD8=; b=pLqEHe
        HsMXXf5CUnA7q3r0i2YHwxq3XV0ZXeL/C6qqQZEnGLiWipAplbC2sp812sM06gAw
        qfMAH1UY7VqLJqO8cqwPBgfNwrSNjkqjEdXaJiBSbmFGX0YXofWath8AcSZpYuvX
        2rn5aanYSN7MszKg8FRTYgxEa3n2wYPBtK3JE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tJ5n6StlqV2v1k/eByWbzquEeirepsD4
        DbS2Jd4Lw+JmgXJUwG7pCHmiK+ZAYVGCh4tROv5ON/lvUjjlW+a+DMGZUrBK0oHu
        Ho3TZJ9QHJUNnRCo6usaMk8EsX6Moy1H9mTxIqETomrFp2Zj5e3ZB3QPacRS8zXz
        jkqAvilqI7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 827FCB2692;
        Fri, 15 Dec 2017 11:33:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE178B2691;
        Fri, 15 Dec 2017 11:33:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josef Wolf <jw@raven.inka.de>
Cc:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
References: <20171214130933.GA18542@raven.inka.de>
Date:   Fri, 15 Dec 2017 08:33:19 -0800
In-Reply-To: <20171214130933.GA18542@raven.inka.de> (Josef Wolf's message of
        "Thu, 14 Dec 2017 14:09:33 +0100")
Message-ID: <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9A9F9BE-E1B5-11E7-87C1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josef Wolf <jw@raven.inka.de> writes:

> With git, by contrast, this won't work. Git will refuse to pull anything as
> long as there are ANY local modifications. The cron job would need to
>
>    git stash
>    git pull
>    git stash pop

I'd assume that this "pull" is expected to be fast-forward, as
otherwise you have no way of dealing with conflicted merges.

> But this will temporarily remove my local modifications. If I happen to do
> a test run at this time, the test run would NOT contain the local
> modifications which I was about to test. Even worse: if I happen to save
> one of the modified files while the modifications are in the stash, the
> "git stash pop" will definitely cause a conflict, although nothing really
> changed.
>
> So, how would I get this workflow with git? Is it possible to emulate the
> behavior of "svn update"?

You do not mind a temporary inconsistency while "svn update" runs
(it starts to update a file you may have local changes, but your
test may run while the update is in the middle of it).  So perhaps
something along the lines of this would help.  Assuming

    <remote> <branch>: the branch at the remote you are pulling from
    <master>: whatever branch you are using

are in your three-command example above:

    $ git fetch <remote> <branch>
    $ git checkout -m -B <master> FETCH_HEAD

should give you pretty-much identical result as

    $ git stash && git pull --ff-only && git stash pop

including a possible merge conflicts at 'git stash pop' stage.
