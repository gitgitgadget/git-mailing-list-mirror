Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684FC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 04:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiGVEMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVEMg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 00:12:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748289AA0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 21:12:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D61913C6CA;
        Fri, 22 Jul 2022 00:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0yic02i/ltp2vZXWujijknnbhFBZEN7+jh7TCe
        FX+s8=; b=X95dOrfIZ46J6teEiR1xfp0GOAjsRLw5xjDzIvvj6snkeCTsLi93x8
        pZUXS9MCIVK29fDkKPc3UbZkkNX43lp7c7HlCAEf8cIfAs/SApay1iZVi4+W8NnG
        lO6rAILS/0aMdrUo2O7XBJPim3zWACi6ryomP/gHpjzPIaF73mFEQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4519613C6C9;
        Fri, 22 Jul 2022 00:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF8A513C6C8;
        Fri, 22 Jul 2022 00:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Wang, Lei" <lei4.wang@intel.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug Report] The since date of "git log" will have influence on
 the until date of it.
References: <6cfda280-44bb-cdcc-a6fb-e0e4795edc65@intel.com>
Date:   Thu, 21 Jul 2022 21:12:32 -0700
In-Reply-To: <6cfda280-44bb-cdcc-a6fb-e0e4795edc65@intel.com> (Lei Wang's
        message of "Fri, 22 Jul 2022 10:39:52 +0800")
Message-ID: <xmqqwnc5dbv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83050ACE-0974-11ED-BB9B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Wang, Lei" <lei4.wang@intel.com> writes:

> The since date of "git log --since" will have influence on the until
> date of it.
>
> How to reproduce?
>
> 1. clone this repo https://erol.kernel.org/lkml/git/8/
> 2. run "git log --since="2020-05-30" --until="2020-06-02"", it won't
>    output anything
> 3. change the since date to 2020-05-29: run "git log
>    --since="2020-05-29" --until="2020-06-02""
> 4. it will output the commits in 2020-06-02 (The until date)
>
> Why would that happen, I just change the since date from 2020-05-30 to
> 2020-05-29, why it suddenly output the commits in 2020-06-02?

Perhaps there are clock skews in the history recorded in the
repository?  IOW, some commits have committer dates that are older
than those of their ancestors?

For example, if you had a commit that has committer date of June 1st
noon, and one of its children has committer date of May 29th noon,
starting the history traversal from that misdated child and saying
"I don't want to see commits before May 30th midnight, so stop the
traversal immediately if you see a commit with timestamp older than
that" with "--since=May.30th", the traversal stops even before the
misdated child is shown.  If you shift the cut-off date and ask to
stop at May 29th midnight, then the misdated child is newer than
that cut-off date and would be shown, and its parent, which has the
date of June 1st, would also be shown.

