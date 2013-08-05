From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/11] t8001/t8002: blame: demonstrate -L bounds checking bug
Date: Mon, 5 Aug 2013 15:35:37 -0400
Message-ID: <CAPig+cTDrhruSHouGrKwFy3TqUe1_4YxJi-oWTUUe6KpZ7p4Qw@mail.gmail.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
	<1375258545-42240-3-git-send-email-sunshine@sunshineco.com>
	<7v4nb4j5qu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QZE-00027s-CD
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab3HETfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:35:40 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:53363 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab3HETfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:35:39 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so2396854lbf.32
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ORJyy1qOQ+gMP6IJFU8q6loICTgvhHa9Jg+hbl4aHrc=;
        b=batCWCRsYTYeuMuEygbavugRg7HNqU3QkhqikrVLgumszeHxFsDC0aRmvXCLQO6I9/
         ijC10YEGPRZHPhwDgdkcKtaNdBaNZLd8w9s0/ZoGUzEtjBHuQfqeTY/UBIzDFTgt4CrB
         F5+vaCWAQrSQddWxfTDHCtK81rJ38HHOYxpvrzCbqC9hx5/7Je1I+PWJlWCVe38Vru0U
         mixiGLND2KSjv+okXVHkXQzpcNxDf0Gs7/qXwEkQBmNhineE3kFngOxNw0MCAKuTM2kc
         GMENyOMH8rfS9EvGPZ8z5AREZJERcSmXMg1xBegykr84uGfhCj9GO0a1iN8TncEBELAv
         7qAg==
X-Received: by 10.112.198.39 with SMTP id iz7mr1992133lbc.24.1375731337992;
 Mon, 05 Aug 2013 12:35:37 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 5 Aug 2013 12:35:37 -0700 (PDT)
In-Reply-To: <7v4nb4j5qu.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: PuzbVcbGJNBff0_aSazrFm6PVbs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231696>

On Mon, Aug 5, 2013 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> A bounds checking bug allows the X in -LX to extend one line past the
>> end of file. For example, given a file with 5 lines, -L6 is accepted as
>> valid. Demonstrate this problem.
>>
>> While here, also add tests to check that the remaining cases of X and Y
>> in -LX,Y are handled correctly at and in the vicinity of end-of-file.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  t/annotate-tests.sh | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>> index 3524eaf..02fbbf1 100644
>> --- a/t/annotate-tests.sh
>> +++ b/t/annotate-tests.sh
>> @@ -225,10 +225,32 @@ test_expect_success 'blame -L /RE/,-N' '
>>       check_count -L/99/,-3 B 1 B2 1 D 1
>>  '
>>
>> +# 'file' ends with an incomplete line, so 'wc' reports one fewer lines than
>> +# git-blame sees, hence the last line is actually $(wc...)+1.
>> +test_expect_success 'blame -L X (X == nlines)' '
>> +     n=$(expr $(wc -l <file) + 1) &&
>> +     check_count -L$n C 1
>> +'
>> +
>> +test_expect_failure 'blame -L X (X == nlines + 1)' '
>> +     n=$(expr $(wc -l <file) + 2) &&
>> +     test_must_fail $PROG -L$n file
>> +'
>> +
>>  test_expect_success 'blame -L X (X > nlines)' '
>>       test_must_fail $PROG -L12345 file
>>  '
>> +test_expect_success 'blame -L ,Y (Y == nlines)' '
>> +     n=$(expr $(wc -l <file) + 1) &&
>> +     check_count -L,$n A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1 E 1
>> +'
>> +
>> +test_expect_success 'blame -L ,Y (Y == nlines + 1)' '
>> +     n=$(expr $(wc -l <file) + 2) &&
>> +     test_must_fail $PROG -L,$n file
>> +'
>> +
>
> This is somewhat curious.
>
> Does the problem triggers only on a file that ends with an
> incomplete line, or the test was inserted at this location only
> because it was convenient and the problem exists with or without the
> incomplete final line?
>
> I am guessing that it is the latter.

The problem exists with and without the incomplete line. The comment
mentioning "incomplete line" and "wc" was inserted to explain why it
was necessary to add one to the result of wc, which might not
otherwise be obvious.

The tests were inserted at this location because they are semantically
related to the "blame -L ,Y (Y > nlines)" test which already exists in
the file (quote just below this response).

>>  test_expect_success 'blame -L ,Y (Y > nlines)' '
>>       test_must_fail $PROG -L,12345 file
>>  '
