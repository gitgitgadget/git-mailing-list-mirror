From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Fri, 16 Aug 2013 17:47:15 +0100
Organization: OPDS
Message-ID: <EE5B338564E14F89B349550B37741AFF@PhilipOakley>
References: <CAPig+cQmdPo4mo69DsDmUURcw+HbxkAoNEqY08qiuJs8S+=bvQ@mail.gmail.com><1376602462-32339-1-git-send-email-stefanbeller@googlemail.com> <CAPig+cQ5Y9irLk=9Bhz09c=5yzZEcyMKn2kbhcrO_zDpgmkhGw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@fluxnic.net>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
	"Stefan Beller" <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 18:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VANBG-00067K-D4
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 18:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab3HPQrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 12:47:10 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:41710 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082Ab3HPQrH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 12:47:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AssLAC1WDlJOl3GZ/2dsb2JhbABbgwY1iSm2PgQEAYEqF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAxUDCSUUAQQaBgcXBgESCAIBAgMBh20DCQqxJQ2IXo1VgSyBT4MidwOIdYYOkwmCCIUlgTeBZjuBLA
X-IPAS-Result: AssLAC1WDlJOl3GZ/2dsb2JhbABbgwY1iSm2PgQEAYEqF3SCHwUBAQQBCAEBLh4BASEFBgIDBQIBAxUDCSUUAQQaBgcXBgESCAIBAgMBh20DCQqxJQ2IXo1VgSyBT4MidwOIdYYOkwmCCIUlgTeBZjuBLA
X-IronPort-AV: E=Sophos;i="4.89,895,1367967600"; 
   d="scan'208";a="438507770"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 16 Aug 2013 17:47:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232435>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Thu, Aug 15, 2013 at 5:34 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>> When checking the previous lines in that function, we can deduce that
>> hsize must always be smaller than (1u<<31), since 506049c7df2c6
>> (fix >4GiB source delta assertion failure), because entries is
>> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
>> value of 0x3fffffff, which is smaller than (1u<<31), so the value of
>> 'i' will never be larger than 31.
>>
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>> ---
>>
>> Eric, thanks for reviewing my patch.
>>
>> I applied the first 2 proposals (deduce, entries), but I disagree on
>> the third, so I reformulated the sentence, as I really meant the 
>> variable
>> i and not it as a pronoun.
>
> Thanks. Adding the quotes around 'i' makes your meaning clear. Without
> the quotes, apparently it was ambiguous, and my brain read it as a
> misspelling of 'it'.
>
>> Do I understand right, you're suggesting to remove the
>> source code comment? I did this now, but I have a bad feeling with 
>> it.
>>
>> The change of this patch surely removes dead code as of now and makes 
>> it
>> more readable. But also it could become alive again, once somebody
>> changes things nearby and forgets about the assumption, hsize not
>> exceeding a certain size. That's why I put a comment in there, so
>> the future changes nearby may be more careful.
>
> Indeed, I feel uncomfortable with the patch in general for the very
> reason that you state: it might become live again. Without the patch,
> the code remains safe without any extra effort.

The problem is that without the patch (or some change) the code was 
already unsafe.

The code sequence  ' (1u << i) < hsize && i < 31 ' is a multi step 
process, whose first step requires that 'i' is already less that 31, 
otherwise the result (1u << i)  is undefined (and  'undef_val < hsize' 
can therefore be assumed to be 'false'), and so the later test  i < 31 
can always be optimised away as dead code ('i' is already less than 31, 
or the short circuit 'and' applies).

Simply swapping around the code such that the i < 31 test is performed 
first would also solve the (latent optimisation) problem.

Section 2.2 of the "Undefined behavior: What happened to my code?" paper 
on http://css.csail.mit.edu/stack/ discusses this issue with an example 
from the Linux kernel.

> With this patch, even
> with the in-code comment, someone making changes needs to take special
> care. Sometimes it makes sense to leave safeties in place, even if
> they can't be triggered _today_; and safeties (such as i < 31) also
> serve as documentation.
>
>>
>> Thanks,
>> Stefan
>>
>>
>>  diff-delta.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/diff-delta.c b/diff-delta.c
>> index 93385e1..3797ce6 100644
>> --- a/diff-delta.c
>> +++ b/diff-delta.c
>> @@ -155,7 +155,7 @@ struct delta_index * create_delta_index(const 
>> void *buf, unsigned long bufsize)
>>                 entries = 0xfffffffeU / RABIN_WINDOW;
>>         }
>>         hsize = entries / 4;
>> -       for (i = 4; (1u << i) < hsize && i < 31; i++);
>> +       for (i = 4; (1u << i) < hsize; i++);
>>         hsize = 1 << i;
>>         hmask = hsize - 1;
>>
>> --
>> 1.8.4.rc3.1.gc1ebd90
>>
> --

Philip 
