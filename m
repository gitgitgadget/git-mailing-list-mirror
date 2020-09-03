Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE3C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D64E20678
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aQBxg73Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgICV6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:58:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62102 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgICV6u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 17:58:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 571BAED96C;
        Thu,  3 Sep 2020 17:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M99xxyEB5g4iVcaInvVMXh/qmBg=; b=aQBxg7
        3YPBRKft01FOj1R6sFVU1rFwFgEIAnZx3dc1amhuy9qPSNkCNPew53hB6oqr/ATA
        uts1oaRn+F2qKdGSvUiKFylOZPq74OKqDEQ6KOFYJqnpuVxG5pkXFSHb0slO23Vp
        UaBSf/uG1xkFJCIYPjyKMJetWFvAPJfZy2Vik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vj+9uZ7lozbEg7OBUww3oFxzT1MVxKoE
        DgIbUNDk3c+HTKwQ68O8TBLMTDC/3Lmld++r8JyiwJbLsm8yLMnA+V7wPssa0yqS
        E4nfHRYhfrlkgJ/GZA+auxzWjT99iKjXjkLZeowxfuJ4OUxbalN9NVD8BEWKe7CQ
        Dv5xzQkksw0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F9B7ED96B;
        Thu,  3 Sep 2020 17:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CCEFED96A;
        Thu,  3 Sep 2020 17:58:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] revision: use repository from rev_info when parsing commits
References: <20200623205659.14297-1-mforney@mforney.org>
        <88d8b24c-a0ae-bbbf-dd1f-5adb7a36ee95@gmail.com>
Date:   Thu, 03 Sep 2020 14:58:43 -0700
In-Reply-To: <88d8b24c-a0ae-bbbf-dd1f-5adb7a36ee95@gmail.com> (Derrick
        Stolee's message of "Wed, 24 Jun 2020 10:29:41 -0400")
Message-ID: <xmqqzh667ca4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3590B9C-EE30-11EA-939B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/23/2020 4:56 PM, Michael Forney wrote:
>> This is needed when repo_init_revisions() is called with a repository
>> that is not the_repository to ensure appropriate repository is used
>> in repo_parse_commit_internal(). If the wrong repository is used,
>> a fatal error is the commit-graph machinery occurs:
>> 
>>   fatal: invalid commit position. commit-graph is likely corrupt
>> 
>> Since revision.c was the only user of the parse_commit_gently
>> compatibility define, remove it from commit.h.
>
> Is this demonstrable in a test case, to prevent regressions?

It appears that Michael tried and failed.  Even if we do not
currently have a caller that asks these functions in revision.c to
work on a repository that is not the primary one (i.e. in a
submodule), in which case these patches may not be fixing any bug
that can be triggered in the current code, it is quite obvious that
these functions misbehave once a caller starts asking them to work
on a repository other than the primary one.

So, given that ... 

>
> I counted 9 copies of parse_commit[_gently]() in my version
> of revision.c, so it looks like you caught them all.

... we should be able to proceed with the code as-is, I guess.

Thanks.
