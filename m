From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 02/15] refs.c: return error instead of dying when locking
 fails during transaction
Date: Tue, 11 Nov 2014 07:42:53 -0800
Message-ID: <CAL=YDWkTr5n=jMKzdCM2oFAyb9v5s=sDALg3Yo7bph5n98PffQ@mail.gmail.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
	<1413923820-14457-3-git-send-email-sahlberg@google.com>
	<20141111103449.GA8371@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 16:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoDat-00069e-KU
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 16:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbaKKPmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 10:42:55 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:63337 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaKKPmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 10:42:54 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so29748yha.36
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0ZgGr2p+OZnoTQzPvhJhKDqbaYwD+O+uFdkfiYvbxLM=;
        b=cM55AZ8If5rjROmev+XTgsCbM0vhbX+h8HxwaYH5EFu+AgNecIQzu3OoU8EP5n4+7C
         M44t5tgVPo6dQ5/ZwE+2iNP7L5vQZYmNG+IkGzjrPahqd8UxeTC7JOxRcf+wcm6Z3lnH
         HhFULwgeJ+xh94Fe7j3Nmpyh42X3IfmuBfnGaqiFsgD26J/HR3fVzu6ZxuXnnc7c9sQY
         K+bAjimr5/qAgkpMiIrbVLHk2yrCCrKIralnjjQ2ZA1pZ8wj4ZevknlPwtU57dkRI3ug
         GbOAUDcFZvV2xxjMgU/Hhl66QQMZ7lHAXtoDzyPpF+Re8FyRGesgrGpWtOOsmVjiv9hR
         y7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0ZgGr2p+OZnoTQzPvhJhKDqbaYwD+O+uFdkfiYvbxLM=;
        b=J4EIauAVvLJNO6Ao+LFsnfRE4bfao4kNd1oQm/OqjnUEvRLUQa5l89cj7/tZlJAWN6
         MmNhLdNBj+FkyLWEPasI48/etqGRssA0W4VsCfKCxShdI5xyxDRwpGXFuMx44ooMAfgk
         HYxkdOvKF8JXEoBUKfMN144r3y/a/i6aHn8EabaAxKGuXUCgVOuR0zw5zc1LEh5L/UUv
         jALWLAjoXp/mGM8ba26PifXPsldKMrZh4JduHRKhlMwclSgFk4739lY2n1f/3/pra1MW
         xOclhfpHBmM+4RPNrO1DEh+qtjoeVQD9i9jHjCku7oozW2t2ND2qtET7uGs75AtHxhbj
         BXLA==
X-Gm-Message-State: ALoCoQlgLsdVAHcF8thX0bAVnF3sXkSSqHNtMM3NRNYoZnyVT+8nYXNHnm1TfWkz7DoyC7F+3RBU
X-Received: by 10.221.63.8 with SMTP id xc8mr2227223vcb.37.1415720573998; Tue,
 11 Nov 2014 07:42:53 -0800 (PST)
Received: by 10.52.76.167 with HTTP; Tue, 11 Nov 2014 07:42:53 -0800 (PST)
In-Reply-To: <20141111103449.GA8371@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 11, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 21, 2014 at 01:36:47PM -0700, Ronnie Sahlberg wrote:
>
>> commit e193c10fc4f9274d1e751cfcdcc4507818e8d498 upstream.
>>
>> Change lock_ref_sha1_basic to return an error instead of dying when
>> we fail to lock a file during a transaction.
>> This function is only called from transaction_commit() and it knows how
>> to handle these failures.
>> [...]
>> -             else
>> -                     unable_to_lock_die(ref_file, errno);
>> +             else {
>> +                     struct strbuf err = STRBUF_INIT;
>> +                     unable_to_lock_message(ref_file, errno, &err);
>> +                     error("%s", err.buf);
>> +                     strbuf_reset(&err);
>> +                     goto error_return;
>> +             }
>
> I coincidentally just wrote almost the identical patch, because this
> isn't just a cleanup; it fixes a real bug. During pack_refs, we call
> prune_ref to lock and delete the loose ref. If the lock fails, that's
> OK; that just means somebody else is updating it at the same time, and
> we can skip our pruning step. But due to the unable_to_lock_die call
> here in lock_ref_sha1_basic, the pack-refs process may die prematurely.
>
> I wonder if it is worth pulling this one out from the rest of the
> series, as it has value (and can be applied) on its own. I did some
> digging on the history of this, too. Here's the rationale I wrote:
>
>
>     lock_ref_sha1_basic: do not die on locking errors
>
>     lock_ref_sha1_basic is inconsistent about when it calls
>     die() and when it returns NULL to signal an error. This is
>     annoying to any callers that want to recover from a locking
>     error.
>
>     This seems to be mostly historical accident. It was added in
>     4bd18c4 (Improve abstraction of ref lock/write.,
>     2006-05-17), which returned an error in all cases except
>     calling safe_create_leading_directories, in which case it
>     died.  Later, 40aaae8 (Better error message when we are
>     unable to lock the index file, 2006-08-12) asked
>     hold_lock_file_for_update to die for us, leaving the
>     resolve_ref code-path the only one which returned NULL.
>
>     We tried to correct that in 5cc3cef (lock_ref_sha1(): do not
>     sometimes error() and sometimes die()., 2006-09-30),
>     by converting all of the die() calls into returns. But we
>     missed the "die" flag passed to the lock code, leaving us
>     inconsistent. This state persisted until e5c223e
>     (lock_ref_sha1_basic(): if locking fails with ENOENT, retry,
>     2014-01-18). Because of its retry scheme, it does not ask
>     the lock code to die, but instead manually dies with
>     unable_to_lock_die().
>
>     We can make this consistent with the other return paths by
>     converting this to use unable_to_lock_message(), and
>     returning NULL. This is safe to do because all callers
>     already needed to check the return value of the function,
>     since it could fail (and return NULL) for other reasons.
>
> I also have some other cleanups to lock_ref_sha1_basic's error handling.
> I'd be happy to take over this patch and send it along with those
> cleanups as a separate series.


 Sounds Good To Me.


Thanks,
Ronnie Sahlberg
