From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 15:31:01 -0500
Message-ID: <CAPig+cS54yTsZ8NWjyh6kj6nXy966EkYPHh_sjMbMcDGemnFuA@mail.gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
	<CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
	<56437F3F.7050305@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:31:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwc2v-00049M-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbbKKUbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:31:04 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36292 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbbKKUbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:31:03 -0500
Received: by ykdr82 with SMTP id r82so68938623ykd.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H9aGejVPhvtE3GDvfXX9BweaT5GJCpIh57xq+Bs8xzw=;
        b=Dq3XUEo5Y8OkIo1gxUJwChAabQ9Gl1xZrT//d3sq8Na5Msif6LDSzm+69f+RJBOj0h
         VjcYZ/etNvawuRJBz5qjWRx6cuULw/w4V80r5sLsX7niPOS7deotoZ3Y+1wdEZs88Z4S
         rjH9c5f36LxEvecJ1A9YvMpxx7Z2flbJl0rgR9lJtLb++5jhLQvFBKw5qwY+VpgNR8l2
         wlKw7Cnrkrk/+65cvMkkXG581cskxzlqG0VffvBzfbl4Ja7mDYsKYEjpMy0WTBCQmJkw
         UvoQUYBp2RBAkroruE8vrmI4p1I8fhibILu2VbwJFq6LPOzuSr0Y4KkW1Z+N84UapO1c
         oQrw==
X-Received: by 10.129.132.136 with SMTP id u130mr11720632ywf.208.1447273861762;
 Wed, 11 Nov 2015 12:31:01 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Wed, 11 Nov 2015 12:31:01 -0800 (PST)
In-Reply-To: <56437F3F.7050305@ramsayjones.plus.com>
X-Google-Sender-Auth: _dFdFbfOpKQgLIwaRi-YFFgd5-k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281196>

On Wed, Nov 11, 2015 at 12:47 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> On 11/11/15 01:22, Eric Sunshine wrote:
>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>> My machine is 64-bit, though, so perhaps it's misleading to
>> characterize this as a fix for 32-bit builds. In particular, off_t is
>> 'long long' on this machine, so it complains about the "long" format
>> specifier.
>
> ... but this seems to imply that sizeof(long) is 4 on your machine, right?
> (on x86_64 linux it's 8, which is why I hadn't noticed before).

This code on my Mac:

    printf("sizeof(long)=%zu\n", sizeof(long));
    printf("sizeof(long long)=%zu\n", sizeof(long long));
    printf("sizeof(off_t)=%zu\n", sizeof(off_t));

produces:

    sizeof(long)=8
    sizeof(long long)=8
    sizeof(off_t)=8

The fact that 'long' and 'long long' happen to be the same size (in
this case) is immaterial. What is important is that the code is just
wrong to be using the "%l" specifier for 'long' when the actual
datatype is 'long long' (which is what 'off_t' is under-the-hood in
this case).
