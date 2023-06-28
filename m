Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E37EB64D9
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 01:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjF1BX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1BX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 21:23:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130F5E4
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 18:23:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 954D71FADA;
        Tue, 27 Jun 2023 21:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cBBRdUQ0YcFIGmVc/5yqWL1FCkTpVWvRM/Bvef
        f0RJA=; b=qdTkeQdJL50+KARSiYsByiOBFn3u/42z6EPNR1w1XgPCzmYShcjSnE
        ssbvSF7WBCLcwl/MvXIoLbn0U1peB+ssSyrc2fnlwsvRBc2DWumKJ+lWaZ/m+6kn
        ucDxl2rOJj3arWfMCRk8joKBwDLByexmFAeOrU4mto4ecW10IMOpw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D2711FAD9;
        Tue, 27 Jun 2023 21:23:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0EE51FAD8;
        Tue, 27 Jun 2023 21:23:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] submodule: show inconsistent .gitmodules precedence
References: <pull.1538.git.git.1687910254473.gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 18:23:20 -0700
In-Reply-To: <pull.1538.git.git.1687910254473.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Tue, 27 Jun 2023 23:57:34 +0000")
Message-ID: <xmqqo7l0e5x3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC81DD2-1552-11EE-A092-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>   [submodule "sub"]
>     path = path1
>     path = path2
>
> It's clearly misconfigured, but our docs don't state what we do in this
> situation. If one checks this with "test-tool submodule-config", you'd
> see that we ignore every value after the first (aka first-one-wins) and
> issue a warning. *But* if you actually tried this with "git submodule",
> you'd find it practically impossible to trigger this behavior - what you
> actually see is last-one-wins!

The last-one-wins sounds like a natural outcome for reusing the
config reading machinery, and the first-one-wins sounds like a total
confusion, but we probably should fail any operation before the user
fixes the .gitmodules by removing all but one path for each
submodule.  Otherwise we risk operating on wrong submodules (e.g. we
may think we are running deinit on "sub" at path #1, but the code
may deinit something different).

Thanks.
