Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F839C3F68F
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545D20730
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfL3SqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:46:18 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:36759 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfL3SqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:46:17 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47mmbq3dg6z5tlB;
        Mon, 30 Dec 2019 19:46:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0C8D0238;
        Mon, 30 Dec 2019 19:46:13 +0100 (CET)
Subject: Re: ERANGE strikes again on my Windows build; RFH
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
 <20191230180653.GA57251@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <54522fee-0796-df46-a3cf-4331537ecf59@kdbg.org>
Date:   Mon, 30 Dec 2019 19:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191230180653.GA57251@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.19 um 19:06 schrieb Jonathan Nieder:
> Johannes Sixt wrote:
> 
>> In sha1-file.c:read_object_file_extended() we have the following pattern:
>>
>> 	errno = 0;
>> 	data = read_object(r, repl, type, size);
>> 	if (data)
>> 		return data;
>>
>> 	if (errno && errno != ENOENT)
>> 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
>>
>> That is, it is expected that read_object() does not change the value of
>> errno in the non-error case. I find it intriguing that we expect a quite
>> large call graph that is behind read_object() to behave this way.
> 
> Yes, this seems dubious.
> 
> In fact this is only inspecting errno in the returned-NULL case.  If I
> look only at the code above and not at the implementation of
> read_object, then I would say that the bug is the 'errno &&' part: when
> errno is meaningful for a function for a given return value, the usual
> convention is
> 
>  (1) it *always* sets errno for errors, not conditionally

You seem to understand that errno isn't set somewhere where it should be
set. But the problem is not absence of setting errno, but abundance of
setting errno; in particular, when functions receive errors from
lower-level functions, but then indicate to the higher levels that
everything's fine; then the higher levels observe errno when they shouldn't.

>  (2) it never sets errno to 0
> 
> There are some exceptions (like strtoul) but they are few and
> unfortunate, not something to be imitated.
> 
> Do you have more details about the case where read_object is expected
> to produce errno == 0?  I'm wondering whether we forgot to set 'errno
> = ENOENT' explicitly somewhere.

I don't think that forgetting to set ENOENT is the problem.

It happens reproducibly in test 5 of t0410-partial-clone:

    ++ git -C repo fsck
    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (1/1), done.
    fatal: failed to read object
383670739c2f993999f3c10911ac5cb5c6591523: Result too large

when it should be

    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (1/1), done.
    dangling tag e5f4cb9fd329c512b08fb81a8e6b1f5e27658263

-- Hannes
