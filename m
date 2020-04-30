Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E9FC47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D982074A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="U0Ai+T0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgD3Ow1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:52:27 -0400
Received: from mx1.riseup.net ([198.252.153.129]:51494 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgD3Ow1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 10:52:27 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49Cddk6DBWzFg8W;
        Thu, 30 Apr 2020 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588258346; bh=bpyuTYMz4sK9QGeEqafD5PxJWAfEIIFzAexRZsWUDbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0Ai+T0rIA4IA5AtH4CgASfprearSUfGLCm2bLZyFqKnJm1imeR3GOPyCrWhnvWdR
         LcqYaIMi8xeXF2VRP75jgMAqvawDRXWf7+KURXwpARQh/7PQ2HWhcGmimhoUndyFG5
         fLNvmbJ2nWXcRhUrtLnrkKUeo6gggWTAi58h9kiM=
X-Riseup-User-ID: 7DD4D1A2DCBBC6D1BF8EB4C167E45D95D5930CB66103EA14549AD868D314FCBA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 49Cddj2BTYz8vMp;
        Thu, 30 Apr 2020 07:52:25 -0700 (PDT)
Date:   Thu, 30 Apr 2020 22:52:21 +0800
From:   Ivan Tham <pickfire@riseup.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200430145221.z3lpgjstybqztfqb@arch>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <20200429185851.GF83442@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200429185851.GF83442@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 12:58:51PM -0600, Taylor Blau wrote:
>On Wed, Apr 29, 2020 at 09:01:33PM +0800, Ivan Tham wrote:
>> Add support to delete previous branch from git checkout/switch to have
>> feature parity with git switch -.
>>
>> Signed-off-by: Ivan Tham <pickfire@riseup.net>
>> ---
>>  Documentation/git-branch.txt | 10 ++++++++++
>>  builtin/branch.c             |  6 +++++-
>>  t/t3200-branch.sh            |  7 +++++++
>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
>> index 135206ff4a..37e7cbbc52 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -265,6 +265,10 @@ start-point is either a local or remote-tracking branch.
>>  	The new branch name must pass all checks defined by
>>  	linkgit:git-check-ref-format[1].  Some of these checks
>>  	may restrict the characters allowed in a branch name.
>> ++
>> +You can use the `@{-N}` syntax to refer to the N-th last branch checked out
>> +using "git checkout" operation. You may also specify `-` which is synonymous to
>> +`@{-1}`.
>
>Interesting; we're already using strbuf_branchname, so the first part of
>this documentation was true even before this commit. Would you consider
>splitting this into two patches?
>
>The first should include the first sentence of this documentation, an
>additional test in t3200 exercising an explicit 'git branch -D @{-N}'
>for some 'N', but no changes in builtin/branch.c. The second patch would
>then make '-' a synonym for '@{-1}'.

Is not this already true? Why do we need to split it? Currently using
'@{-N}' to delete branch already works.
