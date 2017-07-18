Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1CB91FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbdGRWcz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 18:32:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751997AbdGRWcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 18:32:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BDCB80C77;
        Tue, 18 Jul 2017 18:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tX0KaH6CdDruqbtVTNwBP42UUSc=; b=i0xGH0
        IowqaSm02H9sb67Lm/6GCCH5wo4fn0NSfs3fvIateV9wDlYqwMe/9lGw4UwCyvWC
        NfQKGh4fNedkD51AgHjq3rjOUsxhfiX4FsZ6rYWuhB6ESqkK/jFvotl/Ok+ecbUN
        ZrdWRGd9fQ1E1ZJmXMPatpVsyTt0JFs8c0lqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KbZJ4l7mHTVNC1nOKRDaJHTal3Ebc2Kw
        HdAMFoa1ttXQSxHGykIJ/gaZLqKmtf6ok5Yd2yv0Ssm1s95zj1S2t39Yaw0Fwkia
        pMl0LeBhZzhMd/4zey4xiUiESb+mJsMOzvnjYFlUZRtxtFQtUxKVePr698hY7UyZ
        ymKT5UjGLXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1525280C76;
        Tue, 18 Jul 2017 18:32:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A00880C74;
        Tue, 18 Jul 2017 18:32:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC][PATCH 4/8] submodule: port submodule subcommand 'status' from shell to C
References: <20170718204904.3768-1-pc44800@gmail.com>
        <20170718204904.3768-5-pc44800@gmail.com>
        <CAGZ79kb48kNggPv64ubbBNK-Sk8AW4eXxhZt=PZZCPKr9OiuLQ@mail.gmail.com>
Date:   Tue, 18 Jul 2017 15:32:45 -0700
In-Reply-To: <CAGZ79kb48kNggPv64ubbBNK-Sk8AW4eXxhZt=PZZCPKr9OiuLQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Jul 2017 14:39:39 -0700")
Message-ID: <xmqqmv81ml4i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05B6CA3E-6C09-11E7-BC23-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> +       if (!lstat(list_item->name, &st) && !ce_match_stat(list_item, &st, 0)) {
>> +               print_status(info, ' ', list_item->name, sub_sha1, displaypath);
>
> The question from the last round still stands
> https://public-inbox.org/git/CAGZ79kb18z5zc9iu3Vv5aVZWJmoZzmwbMVpy89VC-t-ei2M+bw@mail.gmail.com/
>
>   I am not an expert in the diff area  and wonder how
>   the cmd_diff_files functionality is achieved with just a stat call
>   and then comparing it to  ce_match_stat. 'Using "dirty" ignores
>   all changes to the work tree of submodules, only changes to the
>   commits stored in the superproject are shown.' So I'd have
>   expected ce->oid to be compared (is there an index entry differing,
>   i.e. more than one stage?)

ce_match_stat() calls into ce_compare_gitlink() for a 160000 entry,
which would resolve HEAD ref there and compares ce->oid with it.

But as you said, this is probably insufficient to emulate the
original.  Shouldn't it call into run_diff_files(), which is the
in-core way to run the equivalent of "diff-files"?
