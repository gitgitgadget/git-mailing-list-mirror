From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Tue, 4 Dec 2012 00:29:39 +0100
Message-ID: <CABPQNSb2NQesbjKc8LUT0TL4=xrnw2A_sJyjX72j9Je_zX1sQw@mail.gmail.com>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com> <7vfw3oka68.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:30:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TffTB-00078n-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 00:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab2LCXaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 18:30:22 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:44900 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2LCXaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 18:30:21 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so2406688vcd.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 15:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kUSSLRVxyzrPoNQTFAwZ5bnHgZCjlgftSai1uIc98LE=;
        b=FiCk821wzAB4XBZmpIoZm75y456CV0YhwvXe6iuzBrws3Xtt45aeUrZeErruKeMI2E
         2Mcoi8zBxJz/y+jOFfgUYTSWDojrp7IspnyHQvfVmOIiG5Yqkq6jlwMLvD1MGhuQQj9L
         804Kp/PE96kUs/WBf9PBIEX3q7obN9b2aye4H0x+6z4dP7qrIQaw3BGLHkYvfmH3+oL9
         /i0vzF1CZyJDTYM/j3t1j48NXhqfF1DXdqaGE1cYGcMJPVz1PACPiBJHuYG5ONPk2M/G
         1WZYEtDnl8DDTjl7Yv5oSxdo2DKyxO66KOG77vfq6TtyZGdaqN021LUtCYYETwaFL1AK
         SVvQ==
Received: by 10.220.239.143 with SMTP id kw15mr9759394vcb.62.1354577420658;
 Mon, 03 Dec 2012 15:30:20 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Mon, 3 Dec 2012 15:29:39 -0800 (PST)
In-Reply-To: <7vfw3oka68.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211063>

On Sun, Dec 2, 2012 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> @@ -1538,13 +1563,7 @@ static sig_handler_t timer_fn = SIG_DFL;
>>  static unsigned __stdcall ticktack(void *dummy)
>>  {
>>       while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
>> -             if (timer_fn == SIG_DFL) {
>> -                     if (isatty(STDERR_FILENO))
>> -                             fputs("Alarm clock\n", stderr);
>> -                     exit(128 + SIGALRM);
>> -             }
>> -             if (timer_fn != SIG_IGN)
>> -                     timer_fn(SIGALRM);
>> +             mingw_raise(SIGALRM);
>>               if (one_shot)
>>                       break;
>>       }
>
> This hunk seems to have been based on a slightly newer codebase than
> what I have, and I had to wiggle the patch a bit to make the series
> apply.

Huh, no, it shouldn't be; it's based on 8c7a786 ("Git 1.8.0").

OH! I see now what the problem is... I *missed* a patch in the series! :P

That patch corrected the exit-code for our SIGALRM's SIG_DFL routine;
the old code did "die("Alarm");", but the new one does "fputs("Alarm
clock\n", stderr); exit(128 + SIGALRM)"

> Please double check the result when I push out the 'pu'
> branch.

The resolution is fine; you effectively got the two commits squashed.
I'll send out a new version with the extra patch added, and your
signature-fixup squashed in, OK?
