Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73819C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 04:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiI0Epj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 00:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI0Eph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 00:45:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391CA9246
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 21:45:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3BA8C1C9AEA;
        Tue, 27 Sep 2022 00:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z4ZCldtOn9spH/Kbxjcb3nlPrutycM/1tFWoSu
        Q7GnA=; b=ovgUAT7HX58nD8dy4MMCouP4x5vjVazNtAj+gyVLhLHFKkVAWKHxXO
        yloA11WqfeyQ8+J7Wd34hlkWecJycI7ugk+qiCuIs6SivJtYmhDGMiCvq51vDkna
        fAI5WVWUcO8pCrHNVjFhpnA4YUo9aXoilE6K9ffAOrhs+IPY41hyE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 267E01C9AE9;
        Tue, 27 Sep 2022 00:45:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A8DF81C9AE8;
        Tue, 27 Sep 2022 00:45:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-2-calvinwan@google.com>
        <xmqqy1u9uddc.fsf@gitster.g>
        <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
Date:   Mon, 26 Sep 2022 21:45:31 -0700
In-Reply-To: <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
        (Calvin Wan's message of "Mon, 26 Sep 2022 10:31:05 -0700")
Message-ID: <xmqqpmfh8lxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 384159AE-3E1F-11ED-A5DB-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> You are correct that storing unbounded output doesn't seem like a good
> idea. One idea I have is to parse output during the periodic collection rather
> than waiting till the end. The other idea I had was to add another
> "git status --porcelain" option that would only output the necessary
> pieces of information so we wouldn't have to bother with worrying about
> unbounded output.
>
> Any other thoughts as to how I can workaround this?

I wonder if you can arrange not to let them make unbounded progress?

In order to run diff-files with path A B C D E ... where B and D are
submodules and others are not submodules, you do not have to run and
finish comparison for B and D before you can do the comparison for
other paths, in order to preserve the proper output order.  You can
start child task for B and D and arrange so that they will run for
any other submodules, and then you

 - run comparison for A.  The child task for B and D may be running
   and starting to talk back to you, in which case their write may
   get stuck waiting for you to read from them, but that is OK, as
   you will read from them shortly.

 - wait for the child task for B.  This is done by reading from the
   pipe connected to it and waiting for its death synchronously.
   The child task for D is still running and may be making progress,
   but you are not obligated to read its output to the end.  You can
   postpone reading to conserve memory and it will fill the pipe and
   stall automatically.  Then accept the result for B.

 - run comparison for C.

 - wait for the child task for D.  You may have some data read
   already while dealing with B, but you may still have some reading
   to do at this point.  Let it finish synchronously.

 - run comparison for E.

etc., perhaps?

