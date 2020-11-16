Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A6C2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44F620829
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jpf64oWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKPTwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:52:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKPTwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 14:52:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8942F96084;
        Mon, 16 Nov 2020 14:52:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Izk98feR0ZX1drzh+GvqYMNdHng=; b=Jpf64o
        WtsZQRxBsOI4+u1+I0eRAm3BCuQ0Gk3AwdG/9y2QS5gLJF/N97ztygjvo4/de8Gr
        NHyAMDyeJqOc4E3jSeZ40C0r+UPot6tKzV1sPRX6kLhXPDpOT0NPLqT9qsIhGSez
        v0r1QpQqVBRui0qbNGQR2ypmG3Om5LNsxrUCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtxjcOdYfuYXojeWEuiipL/fUOFBKIMh
        sG9tFoHIgkDINQv3OIXV9Cqc/Jppr9viAzINYMwhe+o+vMGIwfbWwl5ubwzyuA/P
        BHQ6Q4SyXGHv1Ek/haQ6iViXZTWY7K8zuMeH1QRCJlE+CcviRZvtHeriaWJfQts7
        gzH9Oj7Os+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8210996083;
        Mon, 16 Nov 2020 14:52:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BCB796082;
        Mon, 16 Nov 2020 14:52:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <xmqq361ccvot.fsf@gitster.c.googlers.com>
Date:   Mon, 16 Nov 2020 11:52:40 -0800
In-Reply-To: <xmqq361ccvot.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 13 Nov 2020 22:13:38 -0800")
Message-ID: <xmqqr1ot84fr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 492FA9A6-2845-11EB-89B6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>    Some test scripts may require setting init.defaultBranch='master'
>    at the top in the 'setup' part (I've shown how in my response to
>    t4013 patchset) if the body of the test relies too heavily on the
>    primary branch to be 'master'.

Ah, I realized we have much better mechanism already in the form of
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME environment.

So, my three wishes in this message now become

 - lose PREPARE_FOR_MAIN_BRANCH prerequisite as quickly as possible
   by doing the following two.

 - Use that mechanism to force 'main' in test scripts that now only
   can work with 'main', even before we change the fallback default
   from master to main in the production code, so that we won't lose
   test coverage.

 - The same for test scripts that are not converted yet to force use
   of 'master', so that we could change the fallback default from
   master to main in the production code even before converting
   these other scripts, so that we won't lose test coverage.

Thanks.
