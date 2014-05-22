From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 35/44] refs.c: make delete_ref use a transaction
Date: Thu, 22 May 2014 08:32:47 -0700
Message-ID: <CAL=YDWmwfdb7BEoyFV4SQjC+wySDWzE1E4S3hrhsVy3UZOa5Lw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-36-git-send-email-sahlberg@google.com>
	<20140521232211.GK12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 17:32:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnUzF-000855-DR
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 17:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbaEVPct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 11:32:49 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:33599 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaEVPcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 11:32:48 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so4676485veb.32
        for <git@vger.kernel.org>; Thu, 22 May 2014 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C3/k2CShJusrzTDEFnNZCDEgRyhCX5VXsyjdLr0RN/c=;
        b=XWfEFh8eIsLnX7RR34iRcEtVXIn9Qq4OOK8tzZnQwSoM5tozFDi9TG424lrNsBgAJm
         hBc/3rz39BgslJYg08d2OkVzv07QgQBiP2/tjLzjdEBSr8WwuXICvb2qIJwa2+0tCJbH
         CTvTgsrU9zFypiTXto0kJKUALsGdpsY3KJrNb80e9RaVknoRcRbZQZvgVLZd3cbAjfx+
         HNOsQKFz1b87p4yiEwbA9J5IRDVc4tCDjawUNGyUoSBkEEmYbJOZHTuraf3Swa9hzlND
         b7CgV4yRTgIwXZCjD7J5x/p/Sp7dId7FoC7o/eoBpJ62pl6IWMoFPvTnQ0PQLSq2sCFO
         pSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C3/k2CShJusrzTDEFnNZCDEgRyhCX5VXsyjdLr0RN/c=;
        b=BbuWI6/j2pIL5ZyqIVK9huzu+Y5HRO7m+qOt7TTu00OHEKcSEOI/QFOlwbXoD8YdpX
         O+wOsJyUV7tloVtUW89Xk9R2dv7nOaGJr1mDAk1lLju4lgbLnHwpwIr7sGMZa7LRyKy7
         Tr4O97gx+Npn7vm2VviymEzDh3if0RxiIQk2v+tnRipyhkT1NFeoPF8ny/bC4BSS01Ti
         nX07InnxglX1Oadp95jqnmpMN7UTKWsMNsFayqNnAahnejcJcaeFowv37ABPM5nMqv5K
         J4q5jlJbvO9MC+9mcM/pTExikjSdCnetB77IX9PZRy99JIa6D1mqwok6KpDIfpPgJVpK
         m1LQ==
X-Gm-Message-State: ALoCoQlxeq/ltCsmG8MrW7WnI+AUpz/4iLkIzjqnCUA/oz/gWHcgvPyer9F6Sasrg9efznKAj7Op
X-Received: by 10.52.95.135 with SMTP id dk7mr14006531vdb.38.1400772768048;
 Thu, 22 May 2014 08:32:48 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 08:32:47 -0700 (PDT)
In-Reply-To: <20140521232211.GK12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249909>

On Wed, May 21, 2014 at 4:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
> [...]
>> @@ -2515,24 +2510,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>>
>>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>>  {
>> -     struct ref_lock *lock;
>> -     int ret = 0, flag = 0;
>> +     struct ref_transaction *transaction;
>>
> [...]
>> -     lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
>> +     if (!transaction ||
>> +         ref_transaction_delete(transaction, refname, sha1, delopt,
>> +                                sha1 && !is_null_sha1(sha1), &err) ||
>
> What should happen when is_null_sha1(sha1)?  In that case the
> caller has asked us to check that the ref doesn't exist before
> deleting it, which doesn't make a lot of sense, but the old
> code did exactly that if I read it correctly.  The new code
> seems to disable verification instead.
>
> Do we know that no callers call delete_ref with such an argument?
> Would it make sense to just die with a "BUG:" message to make
> the contract more clear?

There are no callers that pass in null_sha1 explicitely and all tests pass.
I have changed it to a die("BUG... to make it more explicit as you suggested.

>
> [...]
>> -     unlink_or_warn(git_path("logs/%s", lock->ref_name));
>
> When does the reflog get deleted in the new code?

It is deleted towards the end of ref_transaction_commit, after the ref
itself has been deleted.

Thanks!

ronnie sahlberg
