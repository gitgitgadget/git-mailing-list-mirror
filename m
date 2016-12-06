Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36A21FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbcLFS6p (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:58:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbcLFS6p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0527154951;
        Tue,  6 Dec 2016 13:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=c
        ksumpzUp3CLrBRk+rvgQmQLv4w=; b=Q226rRgyqZEu94gFR5gzKE9eiWHizCmjK
        CF7yw+hx1W5u+LHWwjYFNYAZmYjGl78Go5sMMkCLZqgrYtDEv7tKHgDeoKtOYCwG
        u8rJ6j1rB7AcWxlrbQA6sOpog0iG7sTbe7Vf3JMPOxXd/csEjkdEaMsCQ+nj5Spc
        mlOEgQUqCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=MondzO3eQ+kamZvoJitxOY7vD3P5++07/AeABMRCndUQFU5SMsNrgLH2
        jgoLxz4451aJ7Q0nkiCF0NPN+F2UtA/n7VNzUeh5suutIgxXsB9WYDxK+XsG8Jgt
        2N3CTmhmSUb8Y9uiRva0n2JHF4GNSy1bjgxnwkzi3yxrcVCwkp0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2D3554950;
        Tue,  6 Dec 2016 13:58:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4013C5494E;
        Tue,  6 Dec 2016 13:58:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Subject: BUG: "cherry-pick A..B || git reset --hard OTHER"
Date:   Tue, 06 Dec 2016 10:58:42 -0800
Message-ID: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 020F3C64-BBE6-11E6-903A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was burned a few times with this in the past few years, but it did
not irritate me often enough that I didn't write it down.  But I
think this is serious enough that deserves attention from those who
were involved.

A short reproduction recipe, using objects from git.git that are
publicly available and stable, shows how bad it is.

    $ git checkout v2.9.3^0

    $ git cherry-pick 0582a34f52..a94bb68397
    ... see conflict, decide to give up backporting to
    ... such an old fork point.
    ... the git-prompt gives "|CHERRY-PICKING" correctly.

    $ git reset --hard v2.10.2^0
    ... the git-prompt no longer says "|CHERRY-PICKING"

    $ edit && git commit -m "prelim work for backporting"
    [detached HEAD cc5a6a9219] prelim work for backporting

    $ git cherry-pick 0582a34f52..a94bb68397
    error: a cherry-pick or revert is already in progress
    hint: try "git cherry-pick (--continue | --quit | --abort)"
    fatal: cherry-pick failed

    $ git cherry-pick --abort
    ... we come back to v2.9.3^0, losing the new commit!

The above shows two bugs.

 (1) The third invocation of "cherry-pick" with "--abort" to get rid
     of the state from the unfinished cherry-pick we did previously
     is necessary, but the command does not notice that we resetted
     to a new branch AND we even did some other work there.  This
     loses end-user's work.  

     "git cherry-pick --abort" should learn from "git am --abort"
     that has an extra safety to deal with the above workflow.  The
     state from the unfinished "am" is removed, but the head is not
     rewound to avoid losing end-user's work.

     You can try by replacing two instances of

	$ git cherry-pick 0582a34f52..a94bb68397

     with

	$ git format-patch --stdout 0582a34f52..a94bb68397 | git am

     in the above sequence, and conclude with "git am--abort" to see
     how much more pleasant and safe "git am --abort" is.

 (2) The bug in "cherry-pick --abort" is made worse because the
     git-completion script seems to be unaware of $GIT_DIR/sequencer
     and stops saying "|CHERRY-PICKING" after the step to switch to
     a different state with "git reset --hard v2.10.2^0".  If the
     prompt showed it after "git reset", the end user would have
     thought twice before starting the "prelim work".

Thanks.
