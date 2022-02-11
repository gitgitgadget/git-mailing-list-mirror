Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300F6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 16:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbiBKQqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:46:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBKQqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 11:46:36 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B71D67
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 08:46:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63571186A09;
        Fri, 11 Feb 2022 11:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HwlOCpDgSWdbrBA76p4BdWphPiQ9PJl+AlB/yG
        0WyNI=; b=agJKHHu7girCULKV4UgHFXOtzGKwaufiXeoHAbcYwY3sBGQ/6SlZbC
        SRE0jAf6c/SCP48BSU8sv45U72cUI+NPkkeawpw+nM+uoNBkQ+h0jnVYaH9K2vxY
        UqPDHTUCLfSe2uPYnAdPg0MJACZiGIpOWOWvLsKy+Vax/p5L+NFjw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5620F186A08;
        Fri, 11 Feb 2022 11:46:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1BCC1869DD;
        Fri, 11 Feb 2022 11:46:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] xdiff: refactor a function
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
        <8655bb0348d7344ae85c8d521fb1ec7a5f4188d2.1644404356.git.gitgitgadget@gmail.com>
        <xmqqmtiz9aro.fsf@gitster.g> <xmqq8rujxmkf.fsf@gitster.g>
        <9c5b3acb-aabc-3a0d-f4e7-e10cec410dbe@gmail.com>
Date:   Fri, 11 Feb 2022 08:46:30 -0800
In-Reply-To: <9c5b3acb-aabc-3a0d-f4e7-e10cec410dbe@gmail.com> (Phillip Wood's
        message of "Fri, 11 Feb 2022 15:19:29 +0000")
Message-ID: <xmqqleyhe4gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A77B368-8B5A-11EC-BCCB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Oh well spotted, xdl_do_diff() only frees "env" if the myers algorithm
> has an error, if the patience or histogram algorithms have an error
> then they do not free "env" and it is not freed by xdl_do_diff(). This
> patch inadvertently fixes that leak when merging but not when calling 
> xdl_do_diff() to compact conflicts in zealous mode or when doing a
> plain diff. I think the simplest fix is to have xdl_do_diff() free
> "env" when there is an error what ever algorithm is used.

Heh, I didn't even look at the other uses of xdl_do_diff(); I am
glad you did.

> I'll try to put a patch together to fix the other cases. If we fix
> this leak in xdl_do_diff() then maybe we should go back to returning
> -1 in the hunk above and explain in the log message why that is ok.

Thanks.
