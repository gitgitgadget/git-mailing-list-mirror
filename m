From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 35/44] refs.c: make delete_ref use a transaction
Date: Thu, 22 May 2014 09:31:11 -0700
Message-ID: <CAL=YDWmPDFOgcFLDgogKQxqkP+D1bUsywWC+Xca1AxwA-8Y6hQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-36-git-send-email-sahlberg@google.com>
	<20140521232211.GK12314@google.com>
	<CAL=YDWmwfdb7BEoyFV4SQjC+wySDWzE1E4S3hrhsVy3UZOa5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 18:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnVtp-0002cG-11
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 18:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbaEVQbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 12:31:15 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:38959 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaEVQbN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 12:31:13 -0400
Received: by mail-vc0-f175.google.com with SMTP id id10so1390213vcb.34
        for <git@vger.kernel.org>; Thu, 22 May 2014 09:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FM/YJKMSxRen/rbdBW0I7dF0QYEuBHw7ffCPbf1Xh6I=;
        b=e6nOkM4VV+EOzC3L9nkUf7O6573QLQarYClRbtsPsbT9ybPClwTMZt2xUYEWbzhUBO
         Wb9zooae3nYzUzqyBc9XRN0tqKP/mCxHSLIeWZcn71CG74+vSthZJSFET5R3ZQVJbXgd
         RejDQtZvwWjA1qscluJvH/++hiBBBj0QqBm8UW8FhYisFI0bgq7iTeYy1X7pDEHvKHsE
         faiWoR+NSfsaoH8aUOnHj9DdyW28yalWofNvZOmlgQrGhHthh81u7SeE4fh4ayGdFFlg
         dvP3IKp+69fqyszQb+u4ZeyAZyThO5lAxPUbao3TzIE8Rc7uFI2LT9uak11Zw9Elj7Fl
         VJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FM/YJKMSxRen/rbdBW0I7dF0QYEuBHw7ffCPbf1Xh6I=;
        b=VQO96aIxyzt0MD0/AXuanJHkOGvTS5Cn9ByQPrFsBlzrkfn9HH9Ienh/a+gJBbEiIE
         6ygkN+WgtSci25Qlwa09WohyXXcdkwERPlFFluzjgxQhWe2larUFX2C3N2FZjrzscm1i
         4x7ZG3pqEgJwS/E3dUYHgklluHptJDIkKT4znozNPFmgnWmkc59wYu6zPWS5aMq5G2gL
         4UaUL0tMeuvaIp168ujzP8WYTTev7hhP2ugHPC8CNQ1pbuLRDI1j5/iBml1MM8PeiBEo
         pPodOW21uD2r0e5FpoDZBONv78VrrOpGhuQ3zI6AQ6WltaSQKHPsJi81qRIIM7C+olz5
         ULeQ==
X-Gm-Message-State: ALoCoQnKhPizrrnWfXeqyunYo95zabUF9sXtQOHy5u92cI7BLer8+g/zM4cKRVdGzEWWThb31N2Q
X-Received: by 10.58.46.83 with SMTP id t19mr1485414vem.60.1400776271221; Thu,
 22 May 2014 09:31:11 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 09:31:11 -0700 (PDT)
In-Reply-To: <CAL=YDWmwfdb7BEoyFV4SQjC+wySDWzE1E4S3hrhsVy3UZOa5Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249913>

On Thu, May 22, 2014 at 8:32 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Wed, May 21, 2014 at 4:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:
>>
>>> --- a/refs.c
>>> +++ b/refs.c
>> [...]
>>> @@ -2515,24 +2510,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>>>
>>>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>>>  {
>>> -     struct ref_lock *lock;
>>> -     int ret = 0, flag = 0;
>>> +     struct ref_transaction *transaction;
>>>
>> [...]
>>> -     lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
>>> +     if (!transaction ||
>>> +         ref_transaction_delete(transaction, refname, sha1, delopt,
>>> +                                sha1 && !is_null_sha1(sha1), &err) ||
>>
>> What should happen when is_null_sha1(sha1)?  In that case the
>> caller has asked us to check that the ref doesn't exist before
>> deleting it, which doesn't make a lot of sense, but the old
>> code did exactly that if I read it correctly.  The new code
>> seems to disable verification instead.
>>
>> Do we know that no callers call delete_ref with such an argument?
>> Would it make sense to just die with a "BUG:" message to make
>> the contract more clear?
>
> There are no callers that pass in null_sha1 explicitely and all tests pass.
> I have changed it to a die("BUG... to make it more explicit as you suggested.

Strike that.

While there are no callers I can see that deliberately send null_sha1
it can happen because resolve_ref_unsafe(reading=0) calls
handle_missing_loose_ref which will clear sha1
if the ref is missing.

This can happen for either symrefs or refs that are soft links that
point to a nonexisting ref.



>
>>
>> [...]
>>> -     unlink_or_warn(git_path("logs/%s", lock->ref_name));
>>
>> When does the reflog get deleted in the new code?
>
> It is deleted towards the end of ref_transaction_commit, after the ref
> itself has been deleted.
>
> Thanks!
>
> ronnie sahlberg
