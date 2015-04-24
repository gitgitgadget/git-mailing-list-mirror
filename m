From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Thu, 23 Apr 2015 17:21:49 -0700
Message-ID: <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
	<xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 02:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlRNV-0007LV-RI
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 02:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934204AbbDXAVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 20:21:53 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33334 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbbDXAVv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 20:21:51 -0400
Received: by iecrt8 with SMTP id rt8so73182584iec.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OCJE02lW3EhpnnAsboFk9j+VHOaYR8NC3o7PJqt3Jek=;
        b=S7edFurQbT/ZptXF8QzgYyDc+8WEKzuVrr9Nb8E14ifmMjdW4S2YPtDT4hODEj6PQt
         FpBV4lkwTwbrsk4ajRsny1YQhTGJHnl37Q7kItpAFMbH68FPCyzEh4N+5/lHR2dzqNrd
         7NtVQNhpuO5WNRDx5t+9lE/wvs6k+8YrjrmNqfSZbSaL099oIXrPcInifZMxfSuXdXaD
         PH/6V4R5ABDE7y/B006SdeFX9X4lmKvjV0yUqSR6HAIrOVQIOTfNz30mAzEUaH+6Kqn5
         S8bK+wKshU8Q0Ajf27xuZ4iveVNTlI0Pmq0B2bAfiLGX8OjRw7Oh58cn0uAVfHAbBuQn
         zMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OCJE02lW3EhpnnAsboFk9j+VHOaYR8NC3o7PJqt3Jek=;
        b=JjR2+69M8BLJbgW96KgerGDKEyu011EevHuzk4jSwSv17O+DtAiD3LL2mmNhVskhsG
         GaMRI21eNunwc/jUhKqgOH3dakrTcTXYbEk9/fTnL2QQOWdzGpfKeP775El/FGV0abvv
         tSNK21kjB/gojslrBAN3HvmwiSK+hPGQz7Yxms9p3twtacwGiiMpRj+Ouhb0I96CCa85
         1J9A+tVnVPcag4+QTKjKiuKrWkV312YyyghOUdbG2VngegSGsga0i4r+TKdNcW1ut4A2
         LY/raTrgTnNMZSpcj94a14JiyZ+N8qlSKM+KYzOXK4Fc7LPNsyxe5zTQC6Z7YWVpYH79
         WifQ==
X-Gm-Message-State: ALoCoQl95moDC3BhSFa++KwseOcZjCpApWZDTaRoZrbCtNlFMnkDvz4vv8T322BcjcqfVGJ9MAKW
X-Received: by 10.107.13.11 with SMTP id 11mr7657724ion.70.1429834909989; Thu,
 23 Apr 2015 17:21:49 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Thu, 23 Apr 2015 17:21:49 -0700 (PDT)
In-Reply-To: <xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267714>

On Thu, Apr 23, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/refs.c b/refs.c
>> index 4f495bd..7ce7b97 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3041,6 +3041,13 @@ static int write_ref_sha1(struct ref_lock *lock,
>>               errno = EINVAL;
>>               return -1;
>>       }
>> +     if (lock->lk->fd == -1 && reopen_lock_file(lock->lk) == -1) {
>
> Granted, we explicitly assign -1 to lk->fd when we know it is
> closed, and the return value from reopen_lock_file() can come only
> from the return value from open(2), which is defined to return -1
> (i.e. not just any negative value) upon failure, but still, isn't it
> customary to check with "< 0" rather than "== -1" for errors?

< 0 would be better here indeed.

>
>> +             int save_errno = errno;
>> +             error("Couldn't reopen %s", lock->lk->filename.buf);
>
> No need to change this line, but I noticed that we might want to do
> something about the first one of the following two:

I personally like to have each error(...) to have a unique string, such
that when you run into trouble (most likely reported by a user),
you can easily pinpoint where the exact error is.
Maybe we could think about overriding error to actually report
"version, filename, linenumber, actual error message"

>
>     $ git grep -e '[    ]error(_*"[A-Z]' | wc -l
>     146
>     $ git grep -e '[    ]error(_*"[a-z]' | wc -l
>     390
>
>> +             unlock_ref(lock);
>> +             errno = save_errno;
>> +             return -1;
>> +     }
>
> Is this the only place in the entire codebase where a lockfile,
> which may have been closed to save number of open file descriptors,
> needs to be reopened?  If I understand correctly, lockfile API is
> not for sole use of refs (don't the index and the pack codepaths use
> it, too?), so it may give us a better abstraction to have a helper
> function in lockfile.[ch] that takes a lock object, i.e.
>
>         int make_lock_fd_valid(struct lock_file *lk)
>         {
>                 if (lk->fd < 0 && reopen_lock_file(lk) < 0) {
>                         ... error ...
>                         return -1;
>                 }
>                 return 0;
>         }
>
> and to call it at this point, i.e.
>
>         if (make_lock_fd_valid(lock->lk) < 0)
>                 return -1;
>
> perhaps?

This is what I was originally looking for, thanks for the design guidance!

>
>> @@ -3733,6 +3741,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>               return 0;
>>       }
>>
>> +     /*
>> +      * We need to open many files in a large transaction, so come up with
>> +      * a reasonable maximum. We still keep some spares for stdin/out and
>> +      * other open files. Experiments determined we need more fds when
>> +      * running inside our test suite than directly in the shell. It's
>> +      * unclear where these fds come from. 25 should be a reasonable large
>> +      * number though.
>> +      */
>
>> +     remaining_fds = get_max_fd_limit();
>> +     if (remaining_fds > 25)
>> +             remaining_fds -= 25;
>> +     else
>> +             remaining_fds = 0;
>
> Is the value of pack_open_fds visible from here? I am wondering if
> we might want "scratch fds Git can use for its own use" accounting
> so that the two subsystems can collectively say "it is still safe
> to use one more fd and leave 25 for other people". With the code
> structure proposed here, the pack reader can grab all but 25 fds,
> which would leave the rest of Git including this code only 25,
> and the value in remaining_fds would become totally meaningless.
>
> It certainly can wait to worry about that and we do not have to do
> anything about it in this patch, but it may still be a good idea to
> leave "NEEDSWORK:" comment here (and point at open_packed_git_1() in
> sha1_file.c in the comment).
>
> I do not think the other side needs to know about the fd consumption
> in this function, as what is opened in here will be closed before
> this function returns.
>
>> @@ -3762,6 +3784,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>                                   update->refname);
>>                       goto cleanup;
>>               }
>> +             if (!(flags & REF_HAVE_NEW) ||
>> +                 is_null_sha1(update->new_sha1) ||
>> +                 remaining_fds == 0)
>> +                     close_lock_file(update->lock->lk);
>> +             else
>> +                     remaining_fds--;
>>       }
