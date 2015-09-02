From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 2 Sep 2015 18:21:29 +0530
Message-ID: <CAOLa=ZRTDAD1wi8=Nz6uWfgS=Nsowf9CkDFsv+BC7b3L9w9Z=Q@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <vpq613tusat.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 14:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX7WJ-0007nE-4b
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 14:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbbIBMwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 08:52:02 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36363 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbbIBMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 08:52:00 -0400
Received: by oibi136 with SMTP id i136so4792571oib.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eGqxRKm6o42y1T0KndeykYG+5Q2avksqOWgne1lM7AI=;
        b=i+j7znX6I5BlC2JFlcP01W6+6wDq+pg8QKaOBZsiJG7iqtQzzqkRaQCyNqSaA+cjNu
         h2jLJ2RdQ5vBkkJ+FBrBEbyzm9TbzYV3n3N/vJLivPg2ak6miG2lc+od951BLbuxEv3i
         GTXXcDhmxaeTVFJ4JvW3FKPlYnleqGLZJnkQ7sVoRTuUlI6B6ewKfOyH/4DZlWHg9GEA
         eIgVFJ/gw7Xfg7qwN/DN2CIGpUsz6xCavjvt67/oDfLUKYnGCGVdG+k4DgNBDzSQl1KC
         zaD5pMtfFluaq0YVCfuYj1JMG1w4yV91+G2vO6jp7USipca6LspTNUDBZCLJLZUWY8kc
         cxFw==
X-Received: by 10.202.203.194 with SMTP id b185mr12018950oig.104.1441198320039;
 Wed, 02 Sep 2015 05:52:00 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 05:51:29 -0700 (PDT)
In-Reply-To: <vpq613tusat.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277088>

On Wed, Sep 2, 2015 at 2:11 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +test_expect_success 'alignment with format quote' '
>> +     cat >expect <<-EOF &&
>> +     refname is ${sq}           ${sq}\\${sq}${sq}master${sq}\\${sq}${sq}           ${sq}|
>> +     refname is ${sq}            ${sq}\\${sq}${sq}side${sq}\\${sq}${sq}            ${sq}|
>> +     refname is ${sq}          ${sq}\\${sq}${sq}odd/spot${sq}\\${sq}${sq}          ${sq}|
>> +     refname is ${sq}         ${sq}\\${sq}${sq}double-tag${sq}\\${sq}${sq}         ${sq}|
>> +     refname is ${sq}            ${sq}\\${sq}${sq}four${sq}\\${sq}${sq}            ${sq}|
>> +     refname is ${sq}            ${sq}\\${sq}${sq}one${sq}\\${sq}${sq}             ${sq}|
>> +     refname is ${sq}         ${sq}\\${sq}${sq}signed-tag${sq}\\${sq}${sq}         ${sq}|
>> +     refname is ${sq}           ${sq}\\${sq}${sq}three${sq}\\${sq}${sq}            ${sq}|
>> +     refname is ${sq}            ${sq}\\${sq}${sq}two${sq}\\${sq}${sq}             ${sq}|
>> +     EOF
>> +     git for-each-ref --shell --format="refname is %(align:30,middle)${sq}%(refname:short)${sq}%(end)|" >actual &&
>> +     test_cmp expect actual
>> +'
>
> Someone (Eric IIRC) suggested using double-quotes around the last
> argument of test_expect_success. Even though I'm the one who suggested
> this ${sq}, I have to agree with this suggestion. The result looks like
>
> test_expect_success 'alignment with quote' "
>         cat >expect <<-\EOF &&
>         refname is '               '\\'''master'\\''
>         ...
> "
>
> Because you used "" at the toplevel, ' is not a special character
> anymore. You do have to be careful with \\ though, but adding before EOF
> as I did should do the trick. Untested.
>

Oops! I missed that out, thanks for bringing that up again, will do it.

> You don't have test for nested alignment with quotes. I think it
> deserves to be tested, if only to cast in stone that the current
> behavior is your intention.
>
> Perhaps just adding --shell to the test below would be OK to avoid the
> proliferation of tests :
>

Makes sense will add it to the following test.

>> +test_expect_success 'nested alignment' '
>> +     cat >expect <<-\EOF &&
>> +     |         master               |
>> +     |           side               |
>> +     |       odd/spot               |
>> +     |     double-tag               |
>> +     |           four               |
>> +     |            one               |
>> +     |     signed-tag               |
>> +     |          three               |
>> +     |            two               |
>> +     EOF
>> +     git for-each-ref --format="|%(align:30,left)%(align:15,right)%(refname:short)%(end)%(end)|" >actual &&
>> +     test_cmp expect actual
>> +'
>> +
>>  test_done
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
Regards,
Karthik Nayak
