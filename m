From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 14:06:29 -0700
Message-ID: <AANLkTinW=1M81X4-7iqVXX0gKoAW8Rvvt+A7zkoQBnN8@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
 <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com> <AANLkTimviqUqcy40aR=DC--tqKHWXfX9gLMoX7tyjafe@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 23:06:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyt0L-0006bP-ST
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 23:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0IWVGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 17:06:52 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41504 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0IWVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 17:06:52 -0400
Received: by qyk36 with SMTP id 36so228985qyk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=yD9Yza5hiLc0qjKdMsnMpXE5fSAcgwgE7Y1igwlaApM=;
        b=ID+T4+Fd36ecUN7wO/TxAc7olBdzhqGczvgAcKdjMKoT/dRD4hKURwhCvt/GOqpyKC
         DyAD9y10FFSmb7aSjKMunory7qVSLvjbmoU27cY9S4nWlFmnkAdk8lOEA4FKOu0VOR9W
         Ul3AIEUYhWRCnol/js6GZ0GRGVSApevv0dJx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=AiOm45s0s81QCW/3YsYnmiMZw+NcpUcP6VagtBYv5jclLe4BrUFvrAPloOS739Hz1i
         zsmx1JzpCwwESaTcO2HPnWgKTO1ZbjrD0e4mub0plX6Eaq8DkXQa99Ib2f67lZ02I5pP
         nQ6a3hqP3sG4Sm9y7mq8H+dRzGmLfGJnp1YEM=
Received: by 10.220.121.165 with SMTP id h37mr980602vcr.148.1285276010702;
 Thu, 23 Sep 2010 14:06:50 -0700 (PDT)
Received: by 10.220.95.193 with HTTP; Thu, 23 Sep 2010 14:06:29 -0700 (PDT)
In-Reply-To: <AANLkTimviqUqcy40aR=DC--tqKHWXfX9gLMoX7tyjafe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156911>

On Thu, Sep 23, 2010 at 1:27 PM, Pat Thoyts <patthoyts@gmail.com> wrote:
> (Apparently gmail on a phone insists on top posting)

Fixed ;)

> On 23 Sep 2010 19:00, "Erik Faye-Lund" <kusmabite@gmail.com> wrote:
>> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com>
>> wrote:
>>> Since open() already sets errno correctly for the NULL-case, let's just
>>> avoid the problematic strcmp.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>
>> I guess I should add a comment as to why this patch is needed:
>>
>> This seems to be the culprit for issue 523 in the msysGit issue
>> tracker: http://code.google.com/p/msysgit/issues/detail?id=523
>>
>> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
>> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
>> which again pass it to open(). This all looks intentional to my
>> (http.c-untrained) eye.
>>
>> The code in mingw_open was introduced in commit 3e4a1ba (by Johannes
>> Sixt), and the lack of a NULL-check looks like a simple oversight.
>
> It looks like this problem was missed by the test suite. Any chance of a
> test as well? Got to catch those regressions.
>

I don't think it's practical to test CRT functions directly, but
perhaps a test for parse_pack_index() or some level above that might
make sense. I tried looking at the this has been done for sha1_file
previously, but it seems there's not really any tests at this level.
And all tests for http.c seems to depend on Apache being installed
(something we do not have in msysGit), so adding a test at this level
wouldn't have helped us any...

In other words, I don't think there is any natural point to add a test
for this. Feel free to make suggestions, though.
