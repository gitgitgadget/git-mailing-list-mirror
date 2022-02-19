Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9279EC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 00:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiBSAMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:12:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiBSAMG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 19:12:06 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D5937A8B
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:11:47 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1CF710F8FB;
        Fri, 18 Feb 2022 19:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NCroM88Ng+QMMuSa+Q2V7xQDnlNYLA1hHZU66n
        MBhMA=; b=OckZSsdVHiFwPQNSvuWKESLbQGSuWWNgQXwNx5RppSB9meWFsX6tCH
        0DLFh1FOwaezDvAtwq3B3vRz03eHwQkdEPNsL4r+3FIMCgOjQG9xE7PX0MZ9FLnS
        mJ6eXUo6pl9e9g1LTxwzgQT/YWVm73BUhjZjf/9g69OeEmjZH9r9U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E99C510F8FA;
        Fri, 18 Feb 2022 19:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 560B010F8F9;
        Fri, 18 Feb 2022 19:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 2/2] hooks: fix a TOCTOU in "did we run a hook?" heuristic
References: <cover-0.2-00000000000-20220218T203834Z-avarab@gmail.com>
        <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
Date:   Fri, 18 Feb 2022 16:11:45 -0800
In-Reply-To: <patch-2.2-d01d088073b-20220218T203834Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 18 Feb
 2022 21:43:52 +0100")
Message-ID: <xmqq4k4vyata.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86853EE6-9118-11EC-86B8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
> +int run_commit_hook(int editor_is_used, const char *index_file,
> +		    int *invoked_hook, const char *name, ...);
>  

Even though my gut feeling tells me that turning the "yes/no"
integer into an enum that includes "there was no such hook", "I
tried to run it, but it failed to run" [*], "I ran it and it was
happy".  would be a more viable approach for the longer term, I
guess this extra and ad-hoc parameter would be sufficient as a
shorter term improvement.

    Side note: optionally "failed to run" may be split into "failed
    to even start (e.g. ENOEXEC)" and "started successfully but
    exited with non-zero status".  There may or may not be callers
    that wants to see them as distinct cases right now, but an
    interface based on returned enum value would be easier to extend
    than having to add a pointer to return variable every time we
    need to know more details.

Thanks.
