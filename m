From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 09:40:18 -0700
Message-ID: <CAL=YDW=3aYhMNjCtT7BV=RDkRN2=Ac0uC_iEiQrO45i4C3zeDw@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X75mC-0002ai-5P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 18:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbaGOQkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 12:40:21 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60047 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaGOQkT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 12:40:19 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so5690759vcb.33
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TjKyZwvlWKm1YgpebNtot5oxZWPnfNARyATXY3ihzfI=;
        b=MCRewA/iQENS4IB/yy79PGnYu7rkBB4x6ZpqX7mne4qpN4kOX8VkUnrSQlCUqoCQSl
         WHdva1nJq+s/JJnmun8tOqWzBB9B07PDGZiCh77wTdzeAGyYqJuOZ70bLKnO0sFlwIht
         VM7a/mXavoylLFNUSI3xib1aNMdRcdm1fD/bCAs10bqS1QI1DEXUaVqZbCck/yzmgynI
         0FkAkFf+LU9g8TGgMgxJ/2sWMQD6JjL0am/aeF6ptJLPWibfVLr7WJY+OssMbClKMzoP
         2kpksR6Pg3jQTDjK5MWKZmgtJvIk9S/NZC6FL/lUYYMvx8rKblEaPQ0ymEdavWkiL8R6
         RHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TjKyZwvlWKm1YgpebNtot5oxZWPnfNARyATXY3ihzfI=;
        b=lctTHSFDYw/xbEDcXorjSVDRQsZAfXZlGFsw2P+95MW/iNIiv62ITdxS90VCx4rEgN
         7Dm/nR1oAgeMMH+ytl4oBx1dyuFY5e27/TR2dH7fkJJoMY1X/phSHpcxRO4xaRAOIm5i
         9pqmdnCxpagshhvoWlY4EbCnTzyvGVmK8fDWqbrH7zb8E3t3iGTse30iBQ/6sNdt5N/7
         FNkxPpQO+x+LPDdM0spJAHu+WExZlf4drWpyDii9ydRFym6DgYN77gg3syQVTvutEYXe
         xM1ahT7HDxW3U7M78Org/I2yBWGrvzw7lNoG2JNEgQCqZpNostACuL+iaykejXlMu5NG
         4BoQ==
X-Gm-Message-State: ALoCoQk9EKntIl25zeRvW3zbLMXsXz64IkzOJMOxgzGJc9bDVAlzk8yZwiEyiiC+K3zHr5DUtRMS
X-Received: by 10.58.197.193 with SMTP id iw1mr1896908vec.57.1405442418562;
 Tue, 15 Jul 2014 09:40:18 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 15 Jul 2014 09:40:18 -0700 (PDT)
In-Reply-To: <53BC07FC.8080601@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253571>

On Tue, Jul 8, 2014 at 8:02 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Move the check for check_refname_format from lock_any_ref_for_update
>> to lock_ref_sha1_basic. At some later stage we will get rid of
>> lock_any_ref_for_update completely.
>>
>> If lock_ref_sha1_basic fails the check_refname_format test, set errno to
>> EINVAL before returning NULL. This to guarantee that we will not return an
>> error without updating errno.
>>
>> This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
>> But this wrapper is also called from an external caller and we will soon
>> make changes to the signature to lock_ref_sha1_basic that we do not want to
>> expose to that caller.
>>
>> This changes semantics for lock_ref_sha1_basic slightly. With this change
>> it is no longer possible to open a ref that has a badly name which breaks
>
> s/badly name/bad name,/
>
>> any codepaths that tries to open and repair badly named refs. The normal refs
>
> s/tries/try/
>
>> API should not allow neither creating nor accessing refs with invalid names.
>
> s/not allow neither/allow neither/
>
>> If we need such recovery code we could add it as an option to git fsck and have
>> git fsck be the only sanctioned way of bypassing the normal API and checks.
>
> I like the sentiment, but in the real world I'm not sure we can take
> such a step based only on good intentions.  Which callers would be
> affected?  Where is this "git fsck" code that would be needed to help
> people rescue their repos?
>

I think the repair things are already busted since a while, so I don't
think this will make things worse,
but I will change it to make it better than this patch and better than
current master,  please see below.

<current git>
$ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
$ git branch
   fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
$ git branch -D master.....@\*@\\.
  error: branch 'master.....@*@\.' not found.

git fsck does report that there is a problem with a broken ref
  fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'

But I don't think there is any way to fix this other than manually
deleting the file from the command line.
(this is because we need to do a resolve_ref_unsafe which will not
work and if we can not do a resolve_ref_unsafe we can not delete the
ref,
 there is also the issue where we can not read the ref into ref-cache)


What I suggest doing here is to create a new patch towards the end of
the series that will :
* change the resolve_ref_unsafe(... , int reading, ...) argument to be
a bitmask of flags with
    #define RESOLVE_REF_READING 0x01  (== current flag)
    #define RESOLVE_REF_ALLOW_BAD_NAME 0x02  (== disable checking the
refname format during resolve)
* then provide the flag for RESOLVE_REF_ALLOW_BAD_NAME for the cases
where we try to resolve a ref in builtin/branch.c where we try to
delete a ref

* then also pass the same flag to lock_ref_sha1_basic when we are
deleting a ref from transaction_commit so we can disable the "check
refname" check there too.

I think that is all that is needed but I will see if there are
additional changes needed once I implement it.



This will mean that the semantics will become :
* you can not create or access a branch with a bad name since both
resolving it and locking it will fail.
* but you can always delete a branch regardless of whether the name is
good or bad.
(this will also mean that you will be able to rename a bad branch name
to a new good name)

which I think would be pretty sane semantics.


I will implement these changes as a separate patch.

Comments?


regards
ronnie sahlberg



> I can also imagine that we will tighten up the check_refname_format
> checks in the future; for example, I think it would be a good idea to
> prohibit reference names that start with '-' because it is almost
> impossible to work with them (their names look like command-line
> options).  If we ever make a change like that, we will need some amount
> of tolerance in git versions around the transition.
>
> So...I like the idea of enforcing refname checks at the lowest level
> possible, but I think that the change you propose is too abrupt.  I
> think it needs either more careful analysis showing that it won't hurt
> anybody, or some kind of tooling or non-strict mode that people can use
> to fix their repositories.
>
> Michael
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 389a55f..bccf8c3 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2088,6 +2088,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>       int missing = 0;
>>       int attempts_remaining = 3;
>>
>> +     if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>> +             errno = EINVAL;
>> +             return NULL;
>> +     }
>> +
>>       lock = xcalloc(1, sizeof(struct ref_lock));
>>       lock->lock_fd = -1;
>>
>> @@ -2179,8 +2184,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>>                                        const unsigned char *old_sha1,
>>                                        int flags, int *type_p)
>>  {
>> -     if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
>> -             return NULL;
>>       return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
>>  }
>>
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
