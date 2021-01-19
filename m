Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF1DC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A34B23100
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 00:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbhASAzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 19:55:10 -0500
Received: from mail.aerusso.net ([104.225.219.13]:57928 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbhASAzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 19:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1611017668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGdhP+C0ifGCncaW9t7d/eSVwP24EzbPHJblDix2dcQ=;
        b=X7PAtKZs7TuUyW+o+2nCui7hIZzZ9G96ONG1EAkj9qW3xTP+O6N1uW4l7agrA6Aee7EqRc
        EO9/ujamShUguXU/cMe4r4pVULQsdH/j1fchMVdwmMumuzVHNK1O50u9bxrZdyhpZSx3E+
        O2h4l6Hv8e0qv1YeSQwGCr3fk10sXDOdlqOZLQLg2kyCFGlls7MmmvzLQYhVuqjmYm3ukc
        t9pakhzaTLqMgg9xeQZPv3s4JwUZXtGWrIx62hvKL3rvF9yM37Bizjxm0RymFB4R6jN/KZ
        VJqo5DWVnbLyHhj91LK0c9F06rTZmUGNhrFKRShNHqICVSARyAmiWUcBEpB14A==
Subject: Re: DEVEL: Help with feature implementation
To:     Derrick Stolee <stolee@gmail.com>,
        Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
 <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
From:   Antonio Russo <aerusso@aerusso.net>
Message-ID: <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
Date:   Mon, 18 Jan 2021 17:54:06 -0700
MIME-Version: 1.0
In-Reply-To: <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/18/21 1:58 PM, Derrick Stolee wrote:
> On 1/18/2021 2:31 PM, Aiyee Bee wrote:
>> Hi Antonio and Derrick!
>>
>>> I think what you really want is --full-history --simplify-merges [1]. This
>>> will show the merges that "fork" the history into parallel tracks where
>>> at least two of them contain interesting commits.
>>
>> It doesn't look like the implementation of --simplify-merges helps much
>> here. That makes its decision on basis of the parents of the commit, which is
>> simple to do as it's information attached freely to each commit. I think the
>> problem here would be figuring out, given any commit, how many of its children
>> are "relevant" commits.
> 
> You should definitely give this a try instead of assuming things about the
> implementation. The algorithm uses a lot of "simplifying" that makes it look
> like the decision is a local one. However, I assure you that is not the case.

As a side note, would this list be willing to look at patches that remove
the need to use revs->limited?  Adding new features would be much easier if
we could restrict git to use streaming algorithms for these simplifications.

> Please assemble a test case that demonstrates the behavior you want and how
> that is different from what is present in --simplify-merges.

I can't figure out how to get the behavior from --simplify-merges, which is
described as

	Additional option to --full-history to remove some needless
	merges from  the resulting history, as there are no selected
	commits contributing to this merge.

It seems that the desired behavior is to include commits which are parents to
multiple branches.  Here is an example:

test_commit() {
 echo >> file
 git add file
 git commit "$@"
}

git init
test_commit -m a
test_commit -m b
test_commit -m c
git checkout -b fork
test_commit -m y
test_commit -m z
git switch master
test_commit -m d
test_commit -m e
test_commit -m f

git log --graph --oneline master fork

* 08029fd f
* 55b09fe e
* 83b7801 d
| * efc204e z
| * 316219e y
|/  
* 3594039 c
* 4321987 b
* bd44220 a

git log --graph --oneline --full-history --simplify-merges master fork

* 08029fd f
* 55b09fe e
* 83b7801 d
| * efc204e z
| * 316219e y
|/  
* 3594039 c
* 4321987 b
* bd44220 a

git log --graph --oneline --simplify-by-decoration --full-history --simplify-merges master fork

* 08029fd f
| * efc204e z
|/  
* bd44220 a

git log --graph --oneline --full-history --simplify-merges master fork

* 08029fd f
* 55b09fe e
* 83b7801 d
| * efc204e z
| * 316219e y
|/  
* 3594039 c
* 4321987 b
* bd44220 a

git --version
git version 2.30.0

I can't seem to get commit c, the crucial fork, to show up with simplifications with this mechanism.
Am I missing something here?

> 
> -Stolee
> 

Antonio
