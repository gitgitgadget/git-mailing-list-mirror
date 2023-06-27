Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF0EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 21:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjF0V0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjF0V0P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 17:26:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA41A3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 14:26:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83160184FA1;
        Tue, 27 Jun 2023 17:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nXHUiUw1BtYEg8Q9ZUOs2TuXogXtiW34CTpb8y
        GMbdU=; b=SiTkEbl/LX6OA20HOEkxKtWkQhrRC+9KSF7FXhYS05KO9bfkYv81x3
        ESVHfMRtuU9hriUtaU9OySY131hFE5IH1HTbauS/6ukJqCUofmEUr9ojVtfBwAVB
        O1G6l2WJOwKngeFE4wyNtcxOgNg+JS6Shuot4jdDkAeOxwHFuRmPA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A2B6184FA0;
        Tue, 27 Jun 2023 17:26:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2036184F9F;
        Tue, 27 Jun 2023 17:26:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joshua Hudson <jhudson@cedaron.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
        <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
        <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
        <xmqqedlwhgf9.fsf@gitster.g>
        <4f28a9c4-b422-69b7-ccc1-2661d756d876@cedaron.com>
        <xmqqttusfz9b.fsf@gitster.g>
        <cd5046d4-d66c-9dac-87e7-cdb638124170@cedaron.com>
Date:   Tue, 27 Jun 2023 14:26:09 -0700
In-Reply-To: <cd5046d4-d66c-9dac-87e7-cdb638124170@cedaron.com> (Joshua
        Hudson's message of "Tue, 27 Jun 2023 14:14:31 -0700")
Message-ID: <xmqqilb8fvgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C9A212C-1531-11EE-B132-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joshua Hudson <jhudson@cedaron.com> writes:

> Try changing kill -9 $$ to exit 137 # 128 + 9

Yeah, but then (1) we are not simulating a case where the external
merge driver hits a segfault or receives a signal from outside and
dies involuntarily, and (2) we are codifying that even on Windows,
program that was killed by signal N must exit with 128 + N, and
these are the reasons why I did not go that route.

Stepping back a bit, how does one typically diagnose programatically
on Windows, after "spawning" a separate program, if the program died
involuntarily and/or got killed?  It does not have to be "exit with
128 + signal number"---as long as it can be done programatically and
reliably, we would be happy.  The code to diagnose how the spawned
program exited in run_command(), which is in finish_command() and
then in wait_or_whine(), may have to be updated with such a piece of
Windows specific knowledge.
