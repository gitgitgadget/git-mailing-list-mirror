From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/11] t8001/t8002: blame: demonstrate -L bounds checking bug
Date: Mon, 5 Aug 2013 15:45:03 -0400
Message-ID: <CAPig+cRYASsHyujx3uhHtRqSnfC8e1cAEMAa2thS3mgOyF2Ozw@mail.gmail.com>
References: <1375258545-42240-1-git-send-email-sunshine@sunshineco.com>
	<1375258545-42240-3-git-send-email-sunshine@sunshineco.com>
	<7v4nb4j5qu.fsf@alter.siamese.dyndns.org>
	<CAPig+cTDrhruSHouGrKwFy3TqUe1_4YxJi-oWTUUe6KpZ7p4Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:45:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QiR-0006cO-NK
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023Ab3HETpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:45:09 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:62902 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab3HETpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:45:06 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so2410181lab.33
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=TE/W1cZUv30Cn6eciLOh1+1mzLV5GXVM16lqxEeH2/Y=;
        b=N5zl5exUFg9ZbdRrhpyT2l5ncWJsRstd+nok56OL5z71DdTaABsPDpUPvIApA4zmwW
         kiOBGZoaziuMCly4nq7+W/ljiZ3ofTXn+9sHyHSHGXU/b3Em6kG42WO1CHQ0uEPS/jlL
         2gCZkVALNL1C64fnmgXNbCY/q4CKSjhKHnHzBCHje8HYo8TmnIZ+stJEaNAHJWU+vHFz
         R1kh5B6sjBqzNFa1IT5gdTXZ8HqENugzb7VddTKbi7AH+jG4pbNnPpd/32Z/FL0+xjhV
         2s6cZpP0MgfnXZMxuLKSRCKvlgARQZq0sAGgc5Y5KXj4mSheAjqRHwXXWvWtdATXgPcL
         MdHw==
X-Received: by 10.152.10.2 with SMTP id e2mr9275834lab.61.1375731903910; Mon,
 05 Aug 2013 12:45:03 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 5 Aug 2013 12:45:03 -0700 (PDT)
In-Reply-To: <CAPig+cTDrhruSHouGrKwFy3TqUe1_4YxJi-oWTUUe6KpZ7p4Qw@mail.gmail.com>
X-Google-Sender-Auth: wab_fICkbcEtsvim2f-VBsgXGbU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231697>

On Mon, Aug 5, 2013 at 3:35 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 5, 2013 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> A bounds checking bug allows the X in -LX to extend one line past the
>>> end of file. For example, given a file with 5 lines, -L6 is accepted as
>>> valid. Demonstrate this problem.
>>>
>>> While here, also add tests to check that the remaining cases of X and Y
>>> in -LX,Y are handled correctly at and in the vicinity of end-of-file.
>>>
>>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>> ---
>>>  t/annotate-tests.sh | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
>>> index 3524eaf..02fbbf1 100644
>>> --- a/t/annotate-tests.sh
>>> +++ b/t/annotate-tests.sh
>>> @@ -225,10 +225,32 @@ test_expect_success 'blame -L /RE/,-N' '
>>>       check_count -L/99/,-3 B 1 B2 1 D 1
>>>  '
>>>
>>> +# 'file' ends with an incomplete line, so 'wc' reports one fewer lines than
>>> +# git-blame sees, hence the last line is actually $(wc...)+1.
>>> +test_expect_success 'blame -L X (X == nlines)' '
>>> +     n=$(expr $(wc -l <file) + 1) &&
>>> +     check_count -L$n C 1
>>
>> This is somewhat curious.
>>
>> Does the problem triggers only on a file that ends with an
>> incomplete line, or the test was inserted at this location only
>> because it was convenient and the problem exists with or without the
>> incomplete final line?
>>
>> I am guessing that it is the latter.
>
> The problem exists with and without the incomplete line. The comment
> mentioning "incomplete line" and "wc" was inserted to explain why it
> was necessary to add one to the result of wc, which might not
> otherwise be obvious.

Would the comment be clearer if phrased like this?

  # We want to test -LX where X is the last line of the file, so we need
  # to compute the number of lines in the file, which normally would be
  # done via 'wc -l'.  In this case, however, the last line of 'file' is
  # incomplete, so 'wc' reports one fewer than the actual line count. To
  # adjust for this anomaly, we must add one to the result of 'wc'.
