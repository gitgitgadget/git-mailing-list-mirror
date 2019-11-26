Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B3CC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFF520727
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nottheoilrig.com header.i=@nottheoilrig.com header.b="eIH+H7Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKZSNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:13:48 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:54854 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfKZSNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 13:13:48 -0500
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 13:13:48 EST
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 40DB6203D8
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1574791649;
        bh=Z1LHqx3jXcb64hhcXk8vYmrJqj+eAMk0HIKY4bdnXzA=;
        h=To:From:Subject:Date:From;
        b=eIH+H7ExT04rzA/nwqCMM4CQw7ad+/W5F3Z3KranEFa1Tkk8/nTf9v867haB72+TP
         xQoBflCUA2fNr6JJZ6AR36erH5yWWcGDIWEob+LhzrwCkD4AtRUNmHVmiiyXDXM398
         PCwKgY5p3Xj3pU/D+pXoLw6pe9yHvFspQCiDw71U=
Received: from [192.168.1.101] (198-48-158-226.cpe.pppoe.ca [198.48.158.226])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:07:28 +0000 (UTC)
To:     git@vger.kernel.org
From:   Jack Bates <bk874k@nottheoilrig.com>
Subject: Bug? clone ignores --git-dir
Message-ID: <7d28416e-c927-4cd3-bac2-d8bfd02ce949@nottheoilrig.com>
Date:   Tue, 26 Nov 2019 11:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you `git rebase --exec 'gulp runtests-parallel --runners user'` this 
project, the tests perform Git operations on various subprojects [1], 
but because Git exports `GIT_DIR` and `GIT_WORK_TREE`, they end up 
operating on the parent project instead.

Adding `--git-dir` and `--work-tree` overrides `GIT_DIR` and 
`GIT_WORK_TREE` [2], forcing the tests to operate on the correct 
repositories, however `clone` ignores `--git-dir`:

> git init repository
> git --git-dir git-dir clone repository directory
I'd expect Git to create a directory `git-dir` and put the index, etc. 
there, but instead it creates `directory/.git`, as usual. I'm not sure 
if this is a bug or the expected behavior?

[1] 
https://github.com/microsoft/TypeScript/blob/master/src/testRunner/externalCompileRunner.ts#L58
[2] https://github.com/microsoft/TypeScript/pull/35362
