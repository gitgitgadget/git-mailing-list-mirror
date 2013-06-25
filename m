From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v14 01/16] test: add test cases for relative_path
Date: Tue, 25 Jun 2013 09:06:51 +0800
Message-ID: <CANYiYbEK-vc2h64rfNDL5k5yhRsxQR=8xtNJJQwUXmyVHH4Cng@mail.gmail.com>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<85c9aa4d05dba4320a7cc85eae7570e0f450e58e.1372087065.git.worldhello.net@gmail.com>
	<7vli5z8ha0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 03:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrHil-0007Bo-Mu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 03:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab3FYBG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 21:06:56 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:53978 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab3FYBGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 21:06:54 -0400
Received: by mail-wi0-f177.google.com with SMTP id ey16so218491wid.16
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 18:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=POa8jG+8IC0777Qdyu3pom36m5yPxbtE/uuR/4Cb/8k=;
        b=KICRneLfH4ZDt8rHDpC9h/NhZJYV9rBRO5yZO+PpCQHtAYmdbq5H9Ru6R6JaQ07gqA
         8y6kl47Pvkybh7ZAX6rvLBgxekvyjeuEfOYx1cqpVIXIBcKJY6C0D9QGw6TIG2qo8ana
         lWOoDCjDUAqZTIb93zCX4DgidoFtkcVeqeDM+vBV/Qe/6EwUMdNk2gQD5wXi6LQc714f
         G/ZoA2ITJKTXvWlgdn5AFH/WBWuuUdXLNrWRAu8Jx8YzUS2QhOQqMiMPXtSkCrHQ6f+b
         DkPECYrku736fsoC6y5YXedFvp+ch4xiXHAFjMsqlAcGsFW4Yu2PF8Yyrm3xEsT2kwiO
         xkOw==
X-Received: by 10.194.249.129 with SMTP id yu1mr18813802wjc.10.1372122411561;
 Mon, 24 Jun 2013 18:06:51 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Mon, 24 Jun 2013 18:06:51 -0700 (PDT)
In-Reply-To: <7vli5z8ha0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228937>

2013/6/25 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> diff --git a/test-path-utils.c b/test-path-utils.c
>> index 0092cb..dcc530 100644
>> --- a/test-path-utils.c
>> +++ b/test-path-utils.c
>> @@ -28,6 +28,19 @@ static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
>>       return 1;
>>  }
>>
>> +static void normalize_argv_string(const char **var, const char *input)
>> +{
>> +     if (!strcmp(input, "<null>"))
>> +             *var = NULL;
>> +     else if (!strcmp(input, "<empty>"))
>> +             *var = "";
>> +     else
>> +             *var = input;
>> +
>> +     if (*var && (**var == '<' || **var == '('))
>> +             die("Bad value: %s\n", input);
>> +}
>> +
>
> If you have to munge the input string like this anyway, perhaps you
> can work around the command line mangling done by Windows bash
> runtime, perhaps add something like:
>
>         if (*input == '_')
>                 input++;
>
> and then protecting the path with the underscore, like so?
>
>         relative_path _/a/b/c/  _/a/b/          c/
>
> Wouldn't that let you avoid having to handle "POSIX" prereq for
> these paths?
>

In order to test NULL pointer in t/t0060, I have to write normalize_argv_string
to convert "<null>" to NULL. So that I can write test case in
t/t0060-path-utils.sh like this:

    relative_path "<null>"  "<null>"        ./

And for the same reason, output would be "(null)" for NULL pointer.
Use "(null)" not "<null>" for output, because I want to make sure the
conversion must happen for input and output.

I found it would be nice to wrap input empty string as "<empty>" and
wrap output of empty string as "(empty)" for the readability of both
input and output of test cases.

Add prefix _ to workaround the absolute path rewritten issue in
msysGit is interesting, but these test cases have already been
tested in Linux, right?  Patch 16/16 turns on most of the test cases
which could only run under POSIX previously, and test these test
cases in Windows way.

-- 
Jiang Xin
