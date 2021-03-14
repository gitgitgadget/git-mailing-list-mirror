Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF84C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0C364E76
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 18:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhCNR5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 13:57:39 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:11468 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNR51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 13:57:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id AED9A7D9;
        Sun, 14 Mar 2021 18:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615744616; x=1617559017; bh=rXUJsOkt/wbIr/gNL0/
        3UcsN3mDAa87Y+vJvqaoy+Bo=; b=V/V4EiTNtDEvwaauR1krtG/kqXR+fK0uvX2
        pjoJ1a4bzX979IGE4hxu9tvNARwCDtQecKcw9O0CeA8uEzMObzRyC5DAZhGY4NgU
        iCv0oKPqithlnjybj9UmwahMW2Q/falwtZTBuuv9UUfr/N16HpMqqCQN3qFY5itE
        bs/m0PFdtBpZXxhRvAU1xu9+GPAACq0J62nNIGrbj9mIn9vbIvqBqaqCFF8yl4ZJ
        cQiOWo+OQDm1oHbeJH5PtIwfqWdaeBt4OeBb11OJdmaBIJMkojNegkRPvSnEKd82
        iEZ76hfjkfYFbnUugXDvZMWE0FM06G5h3UQEqVr/yW3S+wXEPGOz6LhcjzWjZu/s
        Mj0B2p4h9arZhbcJJ4uigklPxZxh373XzrjFXhhDoZ8RVn7I1G9tcjmtCF0hJAEy
        vuVnRo+E3NS2RioG7tq7oAWUs2bCmF3bPuxSAJIA1ZMQQDeWjFJU6RW1jpbeA1fp
        1LGJzZoOua1K74TNEWBdAoPZMFv2LFeOPaGDRzwbDahcg0f8WWKyS1eA0K1+cW0J
        QFl1TOb4/3k2BpuuUCa17GloQ4weV9UQERXrZaOc8KtGjd8XL8j9Qm9gYa/mU0hP
        ddM4Jk3N9J+MYu2UQhSShdOPVhLSPSBOS75li88/1AJPhPB2YTMgblKSUSGCoEFd
        KThP/h6c=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HVstuJcXeNyo; Sun, 14 Mar 2021 18:56:56 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 04A885BB;
        Sun, 14 Mar 2021 18:56:55 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 9334F33EB;
        Sun, 14 Mar 2021 18:56:53 +0100 (CET)
Subject: Re: [PATCH 4/7] worktree: fix leak in dwim_branch()
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <ajrhunt@google.com>
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <d46a4e701620704ae3fd203c9d9dffb172cb3804.1615228580.git.gitgitgadget@gmail.com>
 <YEZ4BQTeT/vdX+tK@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <b328381d-2e38-af02-e84d-cfb8174103ee@ahunt.org>
Date:   Sun, 14 Mar 2021 18:56:51 +0100
MIME-Version: 1.0
In-Reply-To: <YEZ4BQTeT/vdX+tK@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2021 20:16, Jeff King wrote:
> On Mon, Mar 08, 2021 at 06:36:17PM +0000, Andrzej Hunt via GitGitGadget wrote:
> 
>> Make sure that we release the temporary strbuf during dwim_branch() for
>> all codepaths (and not just for the early return).
> 
> Makes sense. Two style nits:

Thank, I'll fix both.
> 
>> -	if (!strbuf_check_branch_ref(&ref, branchname) &&
>> -	    ref_exists(ref.buf)) {
>> -		strbuf_release(&ref);
>> +
>> +	branch_exists = (!strbuf_check_branch_ref(&ref, branchname) &&
>> +			 ref_exists(ref.buf));
> 
> We'd usually omit the extra parentheses here. I.e.,:
> 
>    branch_exists = !strbuf_check_branch_ref(&ref, branchname) &&
>                    ref_exists(ref.buf);

I've made this change - but I have a question about the formatting:
- In the few examples that I could find, the second line is aligned 
using spaces (i.e. same number of tabs as the previous line, followed by 
spaces to align correctly). However that appears to violate the 
indent-with-non-tab style check - should I switch to 100% tabs instead?

That check has been around since:

e2f6331a14 (.gitattributes: CR at the end of the line is an error, 
2009-06-19)

So maybe it's being intentionally ignored in the cases that I've seen (I 
only noticed it for my series because of the automated checks on Github) 
- but I thought I should ask to sure.
