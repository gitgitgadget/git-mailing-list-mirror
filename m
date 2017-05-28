Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFF020D0A
	for <e@80x24.org>; Sun, 28 May 2017 10:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdE1KYs (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 06:24:48 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50257 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdE1KYr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 06:24:47 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id EvNNdzLGrcpskEvNNd1Tea; Sun, 28 May 2017 11:24:45 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=Wh06_-5oCD_0kNvc6ogA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <D689F4F80DA24C78B5E0FB025B9548E6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <8CEDDC40C7D24404976929CF3E7AF6FC@PhilipOakley> <xmqq37bpbx5t.fsf@gitster.mtv.corp.google.com>
Subject: Re: mergetool: what to do about deleting precious files?
Date:   Sun, 28 May 2017 11:24:43 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPprl0pbgZnpQvvWm4uZmWZ9jxj8Nj4CoglVHWxCi6y7Z/+vdYvymA49s5dzeW+4459K6pSnKC0bZCGXAHvo0edCMxayo8Ibjx2KT7j1gnzb/q+DjqQq
 j54b9Pp1fzZXsXaYA9HTKIoBwINaxk+9wgoIY7bo80VETNoSl67sv57W12N21BxlC+xdSTDZkNegIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> The git book [1] and a few blog posts [2] show how to preserve files 
>> which
>> are in the current branch against changes that are on the branch being
>> merged in.
>>
>> e.g. (from [2])
>>
>> echo '<filemane> merge=ours' >> .gitattributes && # commit
>> git config --global merge.ours.driver true
>>
>> (test) $ git checkout demo
>> (demo) $ git merge -
>> # <filename> contents are not merged and the original retained.
>>
>>
>>
>> However what is not covered (at least in the documentation ) is the case
>> where the file to be ignored is not present on the current branch, but is
>> present on the branch to be merged in.
>
> Hmph.  Per-path 'ours' and 'theirs' kick in only after we decide to
> perform the content level three-way merge.  I wonder what would (not
> "should", but "would with the current code") happen, with the same
> attribute setting, if the file being merged were not changed by ours
> but modified by the side branch?  I suspect that we'd take the change
> made by the side branch.

Here the 'ours' strategy is defined by the user's config file merge driver 
list.

I'd understood it that once it was decided there was a merge to be performed 
(the repective blob oid's in the repo/index are different) that the problem 
of merging is then handed off to the declared merge driver.

>
>> Normal expectations would be that in such a case the new file from the
>> second parent branch would be added to the current branch.
>

The git-scm and blog posts suggest that the original is left in place at the 
%P path, the merge driver run, and its return values used to decide if the 
user has to go and resolve conflicts. By setting the driver to 'true', the 
result is then said to be that the current 'blob' (i.e. file) is accepted 
unchanged (in %P), so anything from the second parent blob was completely 
ignored.

However if we have the addition of a new file, I can't tell from the docs 
what should happen? Is this still a merge such that the merge driver is 
called, or is the added file accepted without recourse to its .gitattributes 
setting (surely that would be a bug).

Then assuming we have reached an external driver, and it wants to not add 
that very file that was added in the second parent branch, what does the %P 
path point to (/dev/null?) - in particular, shouldn't the docs say? (I've 
not tested, and one test is not proof)

It maybe that the user wants a merge driver that says "If I ever see a 
secret key or password, then remove the whole file", which (removing the 
file from the merge) is a currently undocumented process (if even possible).

> So I do not think this is not limited to "new file".  Anything that
> a tree-level three-way merge would resolve cleanly without having to
> consult the content-level three-way merge will complete without
> consulting the merge.ours.driver; per-file content-level three-way
> merge driver (which is what merge=<drivername> mechanism lets you
> specify via the attributes mechanism) is not something you would
> want to use for this kind of thing.  It is purely for resolving the
> actual content-level conflicts.
>
That (that Git knows best) sounds just wrong. If the user has set a file 
attribute strategy, why would we ignore it? We already have different 
internal strategies anyway, so how do we even know that the potential merge 
was conflict free if we have haven't checked its attribute type. Maybe I'm 
missing something.
--
Philip 

