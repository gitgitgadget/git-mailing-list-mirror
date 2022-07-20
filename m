Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5506CCA480
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbiGTQVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGTQVM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:21:12 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7C45984
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:21:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FF59123EAC;
        Wed, 20 Jul 2022 12:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sobKLDbKL0x+GOIuooMQcZW3xhgkZrd+hwFMh3
        1wXeA=; b=TQmn9Hd4VpEVQUjPLAEKSWmfgfhX4Z6I1wb5c2qr3GIe2b91jbXI0U
        8XFBYEdjuTj9m8FgAaz7Hg2YtEJqwAFw/xfmYeBqbUAVey7ed8usafrLfZ5K6UOa
        sLKLKKkgqiK67BMejx/YoD9ig9nx2aYuCq/r012I1pn/N7adJaioE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 002E3123EA9;
        Wed, 20 Jul 2022 12:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F0F52123EA8;
        Wed, 20 Jul 2022 12:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Subject: Re: [PATCH 2/2] git-p4: fix error handling in
 P4Unshelve.renameBranch()
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <69c9fd5fbec859c2cced95930ac4d427a09aee90.1658298900.git.gitgitgadget@gmail.com>
        <xmqqa6934v2c.fsf@gitster.g>
Date:   Wed, 20 Jul 2022 09:21:07 -0700
In-Reply-To: <xmqqa6934v2c.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Jul 2022 09:18:03 -0700")
Message-ID: <xmqq5yjr4ux8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F687D504-0847-11ED-A244-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  
>> -        found = True
>
> This has to be initialized to False, because ...
>
>>          for i in range(0, 1000):
>>              backup_branch_name = "{0}.{1}".format(branch_name, i)
>>              if not gitBranchExists(backup_branch_name):
>>                  # Copy ref to backup
>>                  gitUpdateRef(backup_branch_name, branch_name)
>>                  gitDeleteRef(branch_name)
>> -                found = True
>>                  print("renamed old unshelve branch to {0}".format(backup_branch_name))
>
> ... we flip it to True when we find an available unused name and
> break out ...
>
>>                  break
>> -
>> -        if not found:
>> -            sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
>
> ... so that we can complain when we didn't find anything usable.

By the way, isn't this a typical time-of-check to time-of-use bug?
Not the problem with the fix in the patch but in the original, but
regardless of whose fault it is, it may be good to fix it (outside
the topic of this patch).

Thanks.

