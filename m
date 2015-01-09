From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v2] gettext.h: add parentheses around N_ expansion if supported
Date: Thu, 8 Jan 2015 20:55:11 -0800
Message-ID: <61CC69D2-A0F2-4BE2-B37A-F1D8FE19C45A@gmail.com>
References: <aea96640a01b65776eb0474aaceded5@74d39fa044aa309eaea14b9f57fe79c> <xmqqa91tf5ql.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 05:55:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9RbX-0003Sp-DJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 05:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbbAIEzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 23:55:16 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62388 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658AbbAIEzO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 23:55:14 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so16174542pad.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 20:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=FNVy3lqRagdSzF8QaiJLnwlSfGex7bpnA0abnhaAL1o=;
        b=ZQ62RBOa0J+Z9LaRdCqh+BELKVyz5Z92kUPpdAmyOLuSjL1VtvXEEsZgifO6QOsh1p
         Jj3XmlhNNcj9wP59abtKCSFyR0x1S9r9mcK97IKa5g8mO4pwlyD+nMOSjhj6VTQTEwkC
         nP0M3WlQIPCPoaVJcq7GwKMYE7OzpRW/43YgU2ClnwTfdrXE1QBQcLD2zyMl3vJB9Nvy
         lMeRsBvqX/ufIi0cj9cI3+OSlhXtmFugpOPOKFCCdix96cYOfyFxIKLhTXJrMRktCYf6
         uLWvc+K8nHMhOOebUpa6FCz86djjgLAsNfCIgVkr1u8CTPkMnFn4iLS/oovGaoBg4lku
         m2cg==
X-Received: by 10.70.38.71 with SMTP id e7mr20879417pdk.130.1420779314029;
        Thu, 08 Jan 2015 20:55:14 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id rr9sm5876983pab.15.2015.01.08.20.55.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Jan 2015 20:55:13 -0800 (PST)
In-Reply-To: <xmqqa91tf5ql.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262227>

On Jan 8, 2015, at 11:10, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> For now only __GNUC__ is tested which covers both gcc and clang
>> which should result in early detection of any adjacent N_ macros.
>
> I didn't check the list of -W options, but if there were a way to
> tell gcc to stick to the C standard in a more strict way than its
> default, wouldn't this patch start causing trouble?

With this test program:

-----BEGIN TEST.C-----
#include <stdio.h>

#define msg1(x) x
#define msg2(x) (x)

static const char *const a1[] = {
	msg1("hi"),
	msg2("bye") /* line 8 */
};

static const char s1[] = msg1("hi");

static const char s2[] = msg2("bye"); /* line 13 */

int main()
{
	puts(a1[0]);
	puts(a1[1]);
	puts(s1);
	puts(s2);
	return 0;
}
-----END TEST.C-----

gcc, (but not clang) emits a warning (it still compiles just fine)  
when -pedantic is used:

   test.c:13: warning: array initialized from parenthesized string  
constant

However, none of -ansi, -Wall or -Wextra trigger that warning.

Neither does using -ansi -Wall -Wextra together cause a warning to be  
emitted (by either gcc or clang).

Note that line 8 never causes a problem (nor should it), only line 13  
is in question.

After a quick read-through of the -Wxxx options there does not appear  
to be a separate -Wxxx option to get that particular warning.

And compiling Git with -pedantic spits out a LOT of warnings (over  
7200) even before making the "(msgid)" change so I don't think there's  
an issue as apparently -pedantic is not normally used to compile Git.

Note that Git will not compile with gcc using -ansi (unless you add - 
Dinline=__inline__) and the change does not cause any new warnings to  
be emitted with -ansi (after adding the needed -Dinline=__inline__)  
since -pedantic is required for the "parenthesized string constant"  
warning.

I'm not super attached to this change, it's just that it seems to me  
that translation support for Git is a scarce resource.  I'm guessing  
that when considering the 7 complete translations (bg, ca, de, fr, sv,  
vi and zh_CN) the average number of translators per language is in the  
low single digits.  So I hate to see unnecessary translation churn,  
not when it can be so easily prevented.

-Kyle

>> Although the necessary #ifdef makes the header less elegant,
>> the benefit of avoiding propagation of a translation-marking
>> error to all the translation teams thus creating extra work
>> for them when the error is eventually detected and fixed would
>> seem to outweigh the minor inelegance the #ifdef introduces.
>>
>> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
>> ---
>> gettext.h | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/gettext.h b/gettext.h
>> index 7671d09d..80ec29b5 100644
>> --- a/gettext.h
>> +++ b/gettext.h
>> @@ -62,7 +62,19 @@ const char *Q_(const char *msgid, const char  
>> *plu, unsigned long n)
>> 	return ngettext(msgid, plu, n);
>> }
>>
>> -/* Mark msgid for translation but do not translate it. */
>> +/* Mark msgid for translation but do not translate it.
>> + *
>> + * In order to prevent accidents where two adjacent N_ macros
>> + * are mistakenly used, this macro is defined with parentheses
>> + * when the compiler is known to support parenthesized string
>> + * literal assignments.  This guarantees a compiler error in
>> + * such a case rather than a silent conjoining of the strings
>> + * by the preprocessor which results in translation failures.
>> + */
>> +#ifdef __GNUC__
>> +#define N_(msgid) (msgid)
>> +#else
>> #define N_(msgid) msgid
>> +#endif
>>
>> #endif
