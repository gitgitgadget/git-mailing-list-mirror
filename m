From: Steve Hoelzer <shoelzer@gmail.com>
Subject: Re: [PATCH 1/2] userdiff: support C# async methods and correct C# keywords
Date: Sat, 7 Jun 2014 11:00:57 -0500
Message-ID: <CACbrTHeue4VW7B6vBLyaBFGHEghQ-reQX_Rnk_PKKTDLsgi+xg@mail.gmail.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
 <xmqqy4xbq7xo.fsf@gitster.dls.corp.google.com> <CACbrTHcVNmffTHPPnPYDXXwYQacmiS77573Y+GpyjSv-yHQM7g@mail.gmail.com>
 <xmqq61keq6wc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sup Yut Sum <ch3cooli@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:01:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtJ3a-0001Ef-Mu
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 18:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaFGQBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 12:01:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:52923 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbaFGQBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 12:01:18 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so4159055oag.3
        for <git@vger.kernel.org>; Sat, 07 Jun 2014 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SWOposeLNwnrvYmfYKiR2/w4yVbXOYphucpP/b6LSX8=;
        b=HyOxSMTWX6zpUuZn3x8uU463PU4NPQrjwMJnVELWCoBGFSM19dpWwsYPoSmaEGakN4
         NHYkANsll1/8aLRGL7wRqzRvoDdzwpwcvAz4jE3/RhnXKlkIxJxNvcWs+DlLtmng1HB9
         4lWZP9Fz9Cg3x4oZIDzJZgG2Rq3vxrfLibSaqr0kYszsn5s3AUlgvpvS3MkyttyU2EmH
         Ho7tQRi7V7wBrN+9zir71+vLyaLVVsHwP68QYgiQ5u2o+IQ1zgPwwrg4YobpT76xbouC
         FSQ1eVal1C/j9TOnKhgWHi74xq1nMyhVBYRkeYgDkhz68G2lkYv+/VwJidbK0UAIt+4h
         bcLQ==
X-Received: by 10.60.47.111 with SMTP id c15mr2753272oen.80.1402156877608;
 Sat, 07 Jun 2014 09:01:17 -0700 (PDT)
Received: by 10.202.190.198 with HTTP; Sat, 7 Jun 2014 09:00:57 -0700 (PDT)
In-Reply-To: <xmqq61keq6wc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251045>

On Fri, Jun 6, 2014 at 12:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Steve Hoelzer <shoelzer@gmail.com> writes:
>
>> instanceof() is listed as keywords, but there is no such thing (it is
>> in Java, though); in C# we use typeof(), 'is', and 'as for similar
>> purposes
>
> You would need to balance the quotes around "as" ;-)

Indeed. Doh.

> But reading the patch again after noticing that you have () after
> typeof but not after is/as, I am not sure if the change proposed
> here is even correct for the latter two.  I do not speal c-sharp, so
> I asked http://msdn.microsoft.com/en-us/library/cscsdfbt.aspx for
> some examples and here are what I found:
>
>     Type t = typeof(ExampleClass)
>     Base b = derived as Base;
>     if (obj is MyObject) ...
>
> Unlike the control-flow keywords (e.g. do/while/for/...), do they
> typically appear at the beginning of lines?

No, I would never expect to see 'is' or 'as' at the beginning of a line.

> Isn't the purpose of these !^[ \t]* patterns to reject lines that
> begin with the language keywords that do not start functions, so
> listing a keyword that does not usually appear at the beginning of
> line looks like a churn that is not useful.

Not sure about the purpose of those lines, but I think you're correct.

Steve

>> diff --git a/userdiff.c b/userdiff.c
>> index fad52d6..96eda6c 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -134,9 +134,9 @@ PATTERNS("cpp",
>>        "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
>>  PATTERNS("csharp",
>>        /* Keywords */
>> -      "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
>> +      "!^[ \t]*(do|while|for|foreach|if|else|typeof|is|as|new|return|switch|case|default|throw|try|catch|using)\n"
>>        /* Methods and constructors */
>> -      "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>> +      "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
>>        /* Properties */
>>        "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>>        /* Type definitions */
