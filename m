From: Bryan Turner <bturner@atlassian.com>
Subject: Re: 2.2.0-rc behavior changes (1/2)
Date: Mon, 10 Nov 2014 21:43:37 +1100
Message-ID: <CAGyf7-HSJfQtceWTQferNvxEMDLU1DEz6xf4kemCXyo72WuNRQ@mail.gmail.com>
References: <CAGyf7-GxJ6XHjKqwktKqpo_mFuC_D3gzeOGNTdt4sweAnFqNRg@mail.gmail.com>
	<20141110092219.GA11387@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnmRn-0003JJ-Dp
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 11:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbaKJKnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 05:43:43 -0500
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37064 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751992AbaKJKnn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 05:43:43 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]) (using TLSv1) by na3sys009aob112.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVGCW2Vym8ehTG6qKLH7hLyx/WkqG3ilU@postini.com; Mon, 10 Nov 2014 02:43:42 PST
Received: by mail-ob0-f173.google.com with SMTP id wn1so5467485obc.4
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 02:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EKyUfk9OA2nTny8w7yHviA00wPLrbA5yEhQcg+9wffQ=;
        b=aOTAJFxesmYaxFZJuWvFI6P4pw7TkyPU7HaUA969NbLSmtWznKeLAwA7niZCVuLOOm
         2uaWkFw9jpE4zxNNA4gejf3XJBUFdmrV+mU1vTt9QjzviBjaCsSkowHsaMzUb/Lp83a3
         rS4iNp1fRXLSDnyUvXT3YkjZ8X9MBaYOsm1upe5eMrZVF/qvDPa0d/JJDeMdN0aGIsFB
         Sb1c05bXjaj13ewAhqCyI1RXKc5+6kClBzjNeLswmM4QYUDl89RKOdZnqg521CZz9SUA
         MyvwCpexRChztWEkQpMYh7O4rQ1NuhcgmFPe50A4wqYbsDoWxg6gLhEw6RrPBCItnQf/
         cpYw==
X-Gm-Message-State: ALoCoQkd3kAs/3dLpqE5eT1oDXU3DhcqvX/0y0w1BNZrjMpC/OPrpatRbQQDOFAQH64yQ7WRKdxldntd9SRpoZAENRGRobFj5SAOOAPoZxa0LvnKu4AM55iomlW8YDVRt4/JZ1Qv35xXKMUgv4q/HtaJiJhhJDaEzQ==
X-Received: by 10.202.229.74 with SMTP id c71mr1141762oih.69.1415616217163;
        Mon, 10 Nov 2014 02:43:37 -0800 (PST)
X-Received: by 10.202.229.74 with SMTP id c71mr1141753oih.69.1415616217065;
 Mon, 10 Nov 2014 02:43:37 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Mon, 10 Nov 2014 02:43:37 -0800 (PST)
In-Reply-To: <20141110092219.GA11387@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 8:22 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 10, 2014 at 07:47:32PM +1100, Bryan Turner wrote:
>
>> First change: git update-ref -d /refs/heads/nonexistent
>> <some-valid-sha1> now produces an error about ref locking that it
>> didn't produce before
>>
>> Git 2.1.x and prior produced this output:
>> error: unable to resolve reference refs/heads/nonexistent: No such
>> file or directory
>>
>> Now, in the 2.2.0 RCs, it says:
>> error: unable to resolve reference refs/heads/nonexistent: No such
>> file or directory
>> error: Cannot lock the ref 'refs/heads/nonexistent'.
>>
>> This one feels more like a bug, but again may not be. I say it feels
>> like a bug because of the order of the messages: If git has decided
>> the ref doesn't exist, why is it still trying to lock it?
>
> I don't think this is a bug. The order you see is because the code goes
> something like this:
>
>   1. the parent function calls a sub-function to lock
>
>   2. the sub-function generates the error "no such file or directory"
>      and returns failure to the caller
>
>   3. the caller reports that acquiring the lock failed
>
> The only thing that has changed between the two is step (3), but it is
> not an extra lock action after the error. It is just a more verbose
> report of the same error.
>
> That being said, the sub-function (lock_ref_sha1_basic) gives a much
> more useful message. So it would be a nice enhancement to make sure that
> it prints something useful in every return case, and then drop the
> message from the caller.
>
> As an aside, I'm also slightly confused by your output. Are you feeding
> "/refs/heads/nonexistent" (with a leading slash), or
> "refs/heads/nonexistent" (no leading slash)? If the latter, then that
> should silently succeed (and seems to in my tests). If the former, then
> the real problem is not ENOENT, but rather EINVAL; that name is not a
> valid refname.
>
> Older versions of git would produce:
>
>   error: unable to resolve reference /refs/heads/nonexistent: No such file or directory
>
> which is like the error you showed, but note that the refname is
> reported with the leading slash. In v2.2.0-rc1, this is:
>
>   error: unable to resolve reference /refs/heads/nonexistent: Invalid argument
>   error: Cannot lock the ref '/refs/heads/nonexistent'.
>
> which is more accurate. I could explain the differences in our output
> from some simple transcription errors when writing your email, but I
> wanted to make sure I am not missing something.

Sorry, no, you're not missing anything. That is indeed a transcription
error from my e-mail. The test in question is using
"refs/heads/nonexistent".

Thanks for the quick response, Jeff. With the sub-function the
ordering of the messages makes perfect sense.

>
> -Peff
