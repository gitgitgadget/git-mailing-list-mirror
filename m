Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFBC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiDNRhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiDNRho (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:37:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9FCDE0BE
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 10:35:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B26E9188BAD;
        Thu, 14 Apr 2022 13:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OiYfM1/x6OthjydtmdckGkN84cQaqevsMhh49
        DZ9y8=; b=cMYCIBZn20iVJF047cZa2L/+KAr+WYR3T0I4+NiP16YUEfthZoJY26
        9HpNuq1hI7npBqLenURJ7g5efFUPBPGmhdmsVLXPxz3y2dawPPRio9WRwMdGnpC+
        ntB7nrUkjewc7ms6cdEzIV/3lchpnTIEW6S6NSpC+nH2+UP0uRAr0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8DF9188BAC;
        Thu, 14 Apr 2022 13:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96582188BAB;
        Thu, 14 Apr 2022 13:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnfs4kud.fsf@gitster.g>
        <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 14 Apr 2022 10:35:11 -0700
In-Reply-To: <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 14 Apr 2022 09:41:36 -0700")
Message-ID: <xmqqbkx31sc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DA8E3AE-BC19-11EC-93E3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Yes, I mean that even the current directory will be ignored when
> discovery is disabled.

OK.

>>                                                I am not sure that
>> is realistically feasible (I am thinking of cases like "git fetch"
>> going to the remote repository on the local disk that is bare to run
>> "git upload-pack"), but if the fallout is not too bad, it may be a
>> good heuristics.
>
> Good detail - I hadn't considered the impact on our own child processes.
> I suspect this might be a huge undertaking. Unless there is significant
> interest in this option, I probably won't pursue it further.

I do not necessarily think so.  The entry points to transport on the
server side are quite limited (and the client side is dealing with
your own repositories anyway), and they already know which directory
in the server filesystem to hand to the upload-pack and friends, so
it would be a matter of passing GIT_DIR=$there when they call into the
run_command() API, if they are not already doing so.
