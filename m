Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A33C5517A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB2F20897
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FsHixOPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756023AbgJWUWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 16:22:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50511 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbgJWUWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 16:22:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DDAD8C90A;
        Fri, 23 Oct 2020 16:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=T7Kk24N2qAMgFLLsBZalDUsd0aA=; b=FsHixOPG+C4JoXG1F7o4
        vitMYM7/QgOZos5+ABqkt1HFgo3gwGMve7Gr6ch4veZZFxo8WasbDlzgvWmKSWEl
        w7gRDsLKHnZATdDPZrYopeU0DcHUuCHMo9GjdsjGUZAW9zgZKqa3DzcLmMx+BuY0
        x5e1G5koMfPvxNtsbZwY+Dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=K2q65hWsI3wmwWWlp4BtefF7yRMqQY738cmnSVRBEKFoXu
        Ayoc0TrPsbK6H8lx+0VHpXlKRtf2UrezoKSPwajbA0ozitbx7TxoqIooxOIf9Sh6
        f5Y4ghc9T2wS3DsWZ/hiPjly4gAeBPaDUHK5BvKW8vmt2Wu2V2XrEIT6Rti5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 758CE8C908;
        Fri, 23 Oct 2020 16:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01EE88C907;
        Fri, 23 Oct 2020 16:22:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] diff: do not show submodule with untracked files as
 "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201023111711.38739-1-sangunb09@gmail.com>
        <xmqq7drhhr5o.fsf@gitster.c.googlers.com>
        <CAHjREB5Uye1b=bVZsAc1WPcrWrqxnrMZxBtLT345CrpU7gTpVg@mail.gmail.com>
Date:   Fri, 23 Oct 2020 13:22:38 -0700
Message-ID: <xmqqtuukg0a9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EF05FB2-156D-11EB-824D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

>> By the way, in builtin/describe.c there is an invocation of
>> "diff-index" without any --ignore-submodules=<what> option.
>>
>>         /* diff-index command arguments to check if working tree is dirty. */
>>         static const char *diff_index_args[] = {
>>                 "diff-index", "--quiet", "HEAD", "--", NULL
>>         };
>>
>> Would the behaviour of diff-index invocation in "git describe --dirty"
>> affected by the change of the default in any way?
>
> I don't think so because describe was already behaving in the way that
> we won't. We changed the behavior of git diff to match it with that.
> So it doesn't make sense to add anything to that. Tell me if I am
> missing something.

How does "describe" see if the working tree is dirty?  What
mechanism does it use?  Doesn't it run the "diff-index" command
internally?

And with this patch, aren't you changing the default behaviour of
"diff" family of commands by touching repo_diff_setup() function?
How does it not affect the behaviour of the "diff-index" command,
hence the input "git describe" uses to formulate its output?
