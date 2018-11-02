Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02FA1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 16:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeKCBvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:51:32 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:29573 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKCBvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:51:32 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42mnvh4Nwwz5tlC;
        Fri,  2 Nov 2018 17:43:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C1F611C8F;
        Fri,  2 Nov 2018 17:43:43 +0100 (CET)
Subject: Re: [PATCH 1/1] poll: use GetTickCount64() to avoid wrap-around
 issues
To:     Steve Hoelzer <shoelzer@gmail.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.64.git.gitgitgadget@gmail.com>
 <69bc5924f94b56f92d9653b3a64f721bd03f1956.1541020294.git.gitgitgadget@gmail.com>
 <c9e001de-3598-182d-416e-1e94f234c249@kdbg.org>
 <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e8b7b173-eaa1-0fad-7e6a-771389872886@kdbg.org>
Date:   Fri, 2 Nov 2018 17:43:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACbrTHctZejfDTjqWqVfPYdb=ssD253Cd2isr3BxWsL1AqsH2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.18 um 15:47 schrieb Steve Hoelzer:
> On Thu, Nov 1, 2018 at 5:22 AM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 31.10.18 um 22:11 schrieb Steve Hoelzer via GitGitGadget:
>>> @@ -614,7 +618,7 @@ restart:
>>>
>>>      if (!rc && orig_timeout && timeout != INFTIM)
>>>        {
>>> -      elapsed = GetTickCount() - start;
>>> +      elapsed = (DWORD)(GetTickCount64() - start);
>>
>> AFAICS, this subtraction in the old code is the correct way to take
>> account of wrap-arounds in the tick count. The new code truncates the 64
>> bit difference to 32 bits; the result is exactly identical to a
>> difference computed from truncated 32 bit values, which is what we had
>> in the old code.
>>
>> IOW, there is no change in behavior. The statement "avoid wrap-around
>> issues" in the subject line is not correct. The patch's only effect is
>> that it removes Warning C28159.
>>
>> What is really needed is that all quantities in the calculations are
>> promoted to ULONGLONG. Unless, of course, we agree that a timeout of
>> more than 49 days cannot happen ;)
> 
> Yep, correct on all counts. I'm in favor of changing the commit message to
> only say that this patch removes Warning C28159.

How about this fixup instead?

---- 8< ----
squash! poll: use GetTickCount64() to avoid wrap-around issues

The value of timeout starts as an int value, and for this reason it
cannot overflow unsigned long long aka ULONGLONG. The unsigned version
of this initial value is available in orig_timeout. The difference
(orig_timeout - elapsed) cannot wrap around because it is protected by
a conditional (as can be seen in the patch text). Hence, the ULONGLONG
difference can only have values that are smaller than the initial
timeout value and truncation to int cannot overflow.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/poll/poll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 4abbfcb6a4..4459408c7d 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -452,7 +452,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
   static HANDLE hEvent;
   WSANETWORKEVENTS ev;
   HANDLE h, handle_array[FD_SETSIZE + 2];
-  DWORD ret, wait_timeout, nhandles, elapsed, orig_timeout = 0;
+  DWORD ret, wait_timeout, nhandles, orig_timeout = 0;
   ULONGLONG start = 0;
   fd_set rfds, wfds, xfds;
   BOOL poll_again;
@@ -618,8 +618,8 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
 
   if (!rc && orig_timeout && timeout != INFTIM)
     {
-      elapsed = (DWORD)(GetTickCount64() - start);
-      timeout = elapsed >= orig_timeout ? 0 : orig_timeout - elapsed;
+      ULONGLONG elapsed = GetTickCount64() - start;
+      timeout = elapsed >= orig_timeout ? 0 : (int)(orig_timeout - elapsed);
     }
 
   if (!rc && timeout)
-- 
2.19.1.406.g1aa3f475f3
