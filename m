From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 09/10] fast-export: add support to delete refs
Date: Thu, 31 Oct 2013 13:41:15 -0600
Message-ID: <CAMP44s3vxfN5Wc+S+VjimisUgZGQMzR7Z2YkO8J4UEk7+cPy_Q@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-8-git-send-email-felipe.contreras@gmail.com>
	<6F276334-DFDB-40B8-8B24-38FFB6DBED9B@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:41:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vby7N-0001p7-RH
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab3JaTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:41:18 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52566 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab3JaTlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 15:41:17 -0400
Received: by mail-lb0-f171.google.com with SMTP id x18so2821375lbi.30
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=11TnYVI23LwhTpJpbhl5TNXNvmEvke+xnZC39MQvLhw=;
        b=j7N7MuRX42tReX50LodvJyrLckj0y8zJQVUgR2x5Vtw81QVN7in2Bh0kzLTy7cFZlO
         ZscMIVFOszwPOfVU2CykMHio5jwVnbrGJ2MTGORcJeaJ8o309GOjVgUnlgm3KHv8ZPJY
         x6OhAZdSfVF7DDziuwv8TbxBO9xKHfQzWXN411wU/5+4Xi+CyjUj8aYPprfVB7m29vHq
         UJ/eyXvLWf47TgKkOviuBDDQFXbnOWVVC1D0rfy2dRCApp4GL9C/fMGFu4BqmtBcNIUT
         2VOOEQvC92QiXy8o/VqH0DJ1Es2Zh36nkTVg+4Fh41Y5i+hvZpd+PN+jwH9evd0D6hmX
         NPvQ==
X-Received: by 10.152.45.42 with SMTP id j10mr3101436lam.15.1383248476059;
 Thu, 31 Oct 2013 12:41:16 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:41:15 -0700 (PDT)
In-Reply-To: <6F276334-DFDB-40B8-8B24-38FFB6DBED9B@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237167>

On Thu, Oct 31, 2013 at 1:29 PM, Max Horn <max@quendi.de> wrote:
> Actually, I just noticed one thing that I *do* have a question about:
>
> On 31.10.2013, at 10:36, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> builtin/fast-export.c  | 14 ++++++++++++++
>> t/t9350-fast-export.sh | 11 +++++++++++
>> 2 files changed, 25 insertions(+)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index b6f623e..8ed41b4 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -673,6 +673,19 @@ static void import_marks(char *input_file)
>>       fclose(f);
>> }
>>
>> +static void handle_deletes(void)
>> +{
>> +     int i;
>> +     for (i = 0; i < refspecs_nr; i++) {
>> +             struct refspec *refspec = &refspecs[i];
>> +             if (*refspec->src)
>> +                     continue;
>> +
>> +             printf("reset %s\nfrom %s\n\n",
>> +                             refspec->dst, sha1_to_hex(null_sha1));
>
> If I understand it right, this issues a "reset" command in the fast-import stream, resetting a ref to an all-zero SHA1. I had a look at the git-fast-import documentation, but I found that it does not explicitly cover this case. In particular, the "reset" command does not specify that an all-zero SHA1 should be treated as "delete this ref".

That's what the previous patch does.

> On the other hand, the docs for "reset" seem to indicate that one can omit the "from" part, although I couldn't tell for sure what that would mean, either.

It means something different.

> I have not yet tried to dive into the code to figure out what actually happens, but I assume Felipe did that resp. tested it, and so supposedly doing this works, at least for git resp. existing transport helpers. But I wonder if other implementers of the fast-import format would handle it properly?

Try this:

--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -519,7 +519,9 @@ test_expect_success 'delete refspec' '
        from 0000000000000000000000000000000000000000

        EOF
-       test_cmp expected actual
+       test_cmp expected actual &&
+       git fast-import < actual &&
+       test_must_fail git rev-parse -q --verify refs/heads/to-delete
 '

 test_done

-- 
Felipe Contreras
