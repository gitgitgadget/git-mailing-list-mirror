From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 18/44] branch.c: use ref transaction for all ref updates
Date: Mon, 19 May 2014 10:22:11 -0700
Message-ID: <CAL=YDWkSmRbgjEqS2EytQOcUqs4KKCEv7gOCmTxepPBd5dOfAQ@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-19-git-send-email-sahlberg@google.com>
	<53776512.7080504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 19:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRGT-000304-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbaESRWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:22:14 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:38555 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbaESRWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:22:12 -0400
Received: by mail-vc0-f176.google.com with SMTP id lg15so9868538vcb.35
        for <git@vger.kernel.org>; Mon, 19 May 2014 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8FTxd9WfSWNiYzg00DfUB9LiYXM96ubfrdltgptikiQ=;
        b=dx3Fz0OzNonb2ukqzLMJFdvb2U8eibVDml0GyHKJh2PIN1wKvLXRt7R6rFupUHagkU
         QOgBSYqH5NrkxxzJExQ4A0w+yMOdpN7CEsM1ppIV4hOmzMe4Oeitk0ujO4zlf7/Z3gny
         tbJ4oJIry978FOGCpXPbjUYteOOUdSJlEmjwsaweM9zI+RHj+2EOsBwaKOHlOLyI/Xjz
         V4kNYI2dqYLTcfPk0zkAXWYyWobERODiRGYg+qpz8uaPxOyS+cNAmvJYNStDtM6fIoUb
         Q4GbwYPdUWYuqB5PL53UnJhDZ+U5mtGFidzQt1xfbgugsTjqFHE2YGB5JcDvnCWYxavo
         nUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8FTxd9WfSWNiYzg00DfUB9LiYXM96ubfrdltgptikiQ=;
        b=TSe+lmyrZVge5CVjuw7PKEAOIFMzTCnZSzSJMnqvYDObYu7jVZ+1LvJX1ANDi7kRMj
         mbT+oICrjO3h0sDC/4WDPlmd7nP6jGWtDz9VY4Yom0pi/QjldPxvmF7fGAXWhqL/m881
         Si5v7fnpAQtwevXJytjQCEKCjQLxeNfnp3onNsQFIqCatxo4xDhB22V7KRcrTrJP8B5U
         sY+wDqOtIQGILjv6NTuzXEAGTpBQTMtwlKwYiFS8aqA8p33loGoLgwPDaMw0GIjyJYc+
         4qOzsShxkrYPo90iqbUclq1izSUg0M1kS2+mB4undAqWUgKYl0T/g5uJluKyeE/2kotJ
         aW5g==
X-Gm-Message-State: ALoCoQkI+I/GmMLKXWV4RKnokmZ/VkOAjfarTjBrjpI8ysGKFLn5NcUtoqtmhCfe+QW/dZhQ3/Q8
X-Received: by 10.58.56.71 with SMTP id y7mr16734084vep.24.1400520131745; Mon,
 19 May 2014 10:22:11 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 10:22:11 -0700 (PDT)
In-Reply-To: <53776512.7080504@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249605>

On Sat, May 17, 2014 at 6:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> Change create_branch to use a ref transaction when creating the new branch.
>> ref_transaction_create will check that the ref does not already exist and fail
>> otherwise meaning that we no longer need to keep a lock on the ref during the
>> setup_tracking. This simplifies the code since we can now do the transaction
>> in one single step.
>>
>> If the forcing flag is false then use ref_transaction_create since this will
>> fail if the ref already exist. Otherwise use ref_transaction_update.
>
> s/exist/exists/
>
> And the references to ref_transaction_create() in the commit message are
> obsolete.
>

Thanks. Fixed typo and deleted obsolete text.

>>
>> This also fixes a race condition in the old code where two concurrent
>> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
>> did not protect against the ref already existing. I.e. one thread could end up
>> overwriting a branch even if the forcing flag is false.
>>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  branch.c | 29 +++++++++++++++--------------
>>  1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 660097b..8bf7588 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>>                  int force, int reflog, int clobber_head,
>>                  int quiet, enum branch_track track)
>>  {
>> -     struct ref_lock *lock = NULL;
>>       struct commit *commit;
>>       unsigned char sha1[20];
>>       char *real_ref, msg[PATH_MAX + 20];
>> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>>               die(_("Not a valid branch point: '%s'."), start_name);
>>       hashcpy(sha1, commit->object.sha1);
>>
>> -     if (!dont_change_ref) {
>> -             lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
>> -             if (!lock)
>> -                     die_errno(_("Failed to lock ref for update"));
>> -     }
>> -
>> -     if (reflog)
>> -             log_all_ref_updates = 1;
>> -
>>       if (forcing)
>>               snprintf(msg, sizeof msg, "branch: Reset to %s",
>>                        start_name);
>> @@ -301,13 +291,24 @@ void create_branch(const char *head,
>>               snprintf(msg, sizeof msg, "branch: Created from %s",
>>                        start_name);
>>
>> +     if (reflog)
>> +             log_all_ref_updates = 1;
>> +
>> +     if (!dont_change_ref) {
>> +             struct ref_transaction *transaction;
>> +             struct strbuf err = STRBUF_INIT;
>> +
>> +             transaction = ref_transaction_begin();
>> +             if (!transaction ||
>> +                 ref_transaction_update(transaction, ref.buf, sha1,
>> +                                        null_sha1, 0, !forcing, &err) ||
>> +                 ref_transaction_commit(transaction, msg, &err))
>> +                     die("%s", err.buf);
>> +     }
>> +
>>       if (real_ref && track)
>>               setup_tracking(ref.buf + 11, real_ref, track, quiet);
>>
>> -     if (!dont_change_ref)
>> -             if (write_ref_sha1(lock, sha1, msg) < 0)
>> -                     die_errno(_("Failed to write ref"));
>> -
>>       strbuf_release(&ref);
>>       free(real_ref);
>>  }
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
