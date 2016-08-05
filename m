Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C222018E
	for <e@80x24.org>; Fri,  5 Aug 2016 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbcHENWW (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 09:22:22 -0400
Received: from atl4mhob08.myregisteredsite.com ([209.17.115.46]:55442 "EHLO
	atl4mhob08.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759655AbcHENWV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 09:22:21 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u75DMIkj004879
	for <git@vger.kernel.org>; Fri, 5 Aug 2016 09:22:18 -0400
Received: (qmail 6048 invoked by uid 0); 5 Aug 2016 13:22:18 -0000
X-TCPREMOTEIP: 69.47.70.101
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.190?) (andrew@kellerfarm.com@69.47.70.101)
  by 0 with ESMTPA; 5 Aug 2016 13:22:18 -0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <xmqq60rg5vq5.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 5 Aug 2016 09:22:14 -0400
Cc:	Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B126EBED-AA93-4B5B-A932-149E4CB88C2B@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com> <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com> <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com> <CDE30958-C112-4C26-A0EA-499BFCD4E07F@kellerfarm.com> <xmqq60rg5vq5.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Am 04.08.2016 um 12:45 nachm. schrieb Junio C Hamano <gitster@pobox.com>:
> Andrew Keller <andrew@kellerfarm.com> writes:
> 
>> In summary, I think I prefer #2 from a usability point of view, however I’m having
>> trouble proving that #1 is actually *bad* and should be disallowed.
> 
> Yeah, I agree with your argument from the usability and safety point
> of view.
> 
>> Any thoughts?  Would it be better for the pre-commit hook to be
>> officially allowed to edit the index [1], or would it be better
>> for the pre-commit hook to explicitly *not* be allowed to edit the
>> index [2], or would it be yet even better to simply leave it as it
>> is?
> 
> It is clear that our stance has been the third one so far.
> 
> Another thing I did not see in your analysis is what happens if the
> user is doing a partial commit, and how the changes made by
> pre-commit hook is propagated back to the main index and the working
> tree.
> 
> The HEAD may have a file with contents in the "original" state, the
> index may have the file with "update 1", and the working tree file
> may have it with "update 2".  After the commit is made, the user
> will continue working from a state where the HEAD and the index have
> "update 1", and the working tree has "update 2".  "git diff file"
> output before and after the commit will be identical (i.e. the
> difference between "update 1" and "update 2") as expected.

Excellent point — one I had discovered myself but neglected to include in
my email.  In my post-commit hook, I have logic in both versions of my
experiment that disallows [1] fixing up diffs that are partially staged.  Both
scripts then update both the index and the working copy.  (Sort of like how
rebase works — clean working directory required, and then it updates the
index and the work tree)

[1] In version #1, if any files it wants to change are partially staged, it
    prints a detailed error message and aborts the commit outright.  In
    version #2, the pre-commit hook sees the change it _wants_ to make,
    informs the user that he/she should run the fixup command, aborts
    the commit, and when the user runs the fixup command, the fixup
    command sees the partially staged file, prints the same detailed error
    message, and dies.

Thanks for your help on this.  it’s really been interesting.  I’ll leave it as-is
for now.

Thanks,
 - Andrew Keller

