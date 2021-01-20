Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69EC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6956C23437
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbhAUAzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:55:42 -0500
Received: from mout02.posteo.de ([185.67.36.66]:59061 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbhAUABb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 19:01:31 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 71FE22400FB
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 00:59:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1611187198; bh=nR1+8pSZTD63X0s7q8VmEeI+EO8cZhR5/rveKb06MtE=;
        h=Date:From:To:Cc:Subject:From;
        b=XesfuNIAf1eEYh/GnTbcJl2XVQD07AFbRA1NogJRc1Ja0NR/+zVmuzg5NsoJmNp+J
         kXUFv0UDe33w6DwsBUtb7EP9lunv0+5Pl4wqk+pURrg9hxeptpELDZRNFqhvWaIfP7
         H5sB0mupUwFejg4S7p5RUBE667w3rbJCNo/kEX3fLz8ebYrgjYv3dNekYC3BdCeta5
         EQNYgzQ7Fu8OaHLB24Juk8NxdL+2jiaQm7r5TgF/nUaYpjJg/X7Jge1kWb2ptX25Rg
         sfJdv4OK/bwwx4CpiPPka1A309gim1VOLbFmQvPvRVG6w6gWVaQ5icGEq65FRjcZ5b
         7pbokGBaetXYg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DLjF86W09z9rxL;
        Thu, 21 Jan 2021 00:59:56 +0100 (CET)
Date:   Thu, 21 Jan 2021 10:59:52 +1100
From:   asymptosis <asymptosis@posteo.net>
To:     Rich Davis <crashvb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unable to push to local bare repository
Message-ID: <YAjD+Gtm1QwdwXCq@sleipnir.acausal.realm>
References: <8f1df022-0e0e-2451-b32d-2d9918604ea1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f1df022-0e0e-2451-b32d-2d9918604ea1@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rich,

>$ git init barerepo
>Initialized empty Git repository in /tmp/am_i_crazy/barerepo/.git/

This looks like your problem: without passing the --bare flag, it's not a bare repo. It even says it's initialized under barerepo/.git instead of barerepo.

Compare with the result of passing --bare:

```
testuser /tmp $ git init --bare barerepo
Initialized empty Git repository in /tmp/barerepo/

testuser /tmp $ git clone --dissociate --no-hardlinks --no-local barerepo clonerepo
Cloning into 'clonerepo'...
warning: You appear to have cloned an empty repository.

testuser /tmp $ cd clonerepo/

testuser /tmp/clonerepo $ printf "This is a test file created on %s\n" "$(date +%Y-%m-%dT%H:%M:%S)" | tee test.txt
This is a test file created on 2021-01-21T10:55:35

testuser /tmp/clonerepo $ git add test.txt

testuser /tmp/clonerepo $ git commit -m "Initial commit"
[master (root-commit) b71804b] Initial commit
  1 file changed, 1 insertion(+)
  create mode 100644 test.txt

testuser /tmp/clonerepo $ git push origin master
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), 253 bytes | 253.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /tmp/barerepo
  * [new branch]      master -> master
```

Hope this helps.
