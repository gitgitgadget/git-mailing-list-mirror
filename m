From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 09/15] refs.c: only write reflog update if msg is non-NULL
Date: Tue, 28 Oct 2014 12:17:23 -0700
Message-ID: <CAL=YDWkZE0KXrM+SqL1gZoQR_u7kcvWjQfton7AoavfptqcM4w@mail.gmail.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-10-git-send-email-sahlberg@google.com>
	<xmqq8uk6skky.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:24:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjCNn-00039f-AO
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 20:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbaJ1TYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 15:24:39 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:62679 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaJ1TYi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 15:24:38 -0400
Received: by mail-qc0-f179.google.com with SMTP id o8so1136669qcw.24
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qKgF994XZOfy8IDgQvraFofzU7eqpslP7vlgxe9aifg=;
        b=J5FpEMSxJVHDgle5Q9aVbped+xhdEXAjPzURVuV7MmXnNDxqnK/iWcCwGeK+r55pPl
         0JueGB9pm+glIFKUQ6OsSq0a8H9TVMYzOi3QM3Wnn8FKDu2DbJdZNCDhXdWFRA2Pg273
         Z/3YW6d/NqqVt+OnfrVuZqJb7o5tcyIpopO9ZHaZ0QJoNTJNKfnzoScXfBEIdKeNpjjI
         wu3xKL871JxzzCgfbsV+KPf4rcSPOrqMVMtDP4F32aolRMf7BkOTVW8a9OjADHN/s9xE
         XtSwFc+YxMOUpsGvJoviyidKb/fQEAX1/WOVs8jdqt+DV9mbOk1YIVtBRG6zYGPIU74L
         IMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qKgF994XZOfy8IDgQvraFofzU7eqpslP7vlgxe9aifg=;
        b=LHAyae26CncWl2RmRYsMRMnxyyD/9UJWiqt5QFTkmylrB6M9EFgwQv8NVG99jHhEBB
         3lXJZBcdt1XfXh63K7/CattWyQgzjE6R5xV1HPVC4JSpGFkz0o2beB6M67YRJ7Cf8weo
         Am/IO/7ZoNkIGxUR0DlW+WXLzWMxTBrFzXkx2Y9OMbCZSE/DGEdgQu0tFSWIS2EGNmJl
         bU4Lljq3sgrKtuI99OiZ1MhV9CVM9ambQNokSW+usMgpabFJ/sfaR+m3NZDOLELpPu6N
         DQn4TTGyrwu+Pe0XeMlZ1fIhZkoklzTl/l5QHu+Wy+O8aDhQiED23XExmYgxsBR6NqCb
         5hYA==
X-Gm-Message-State: ALoCoQlwb4YHv2RGrlnXPHiKpdx/DsVfBu12/OmD6ozUepGf89VhNL2tIsKCxRrD1b+CWQTSOAkq
X-Received: by 10.140.19.205 with SMTP id 71mr7799299qgh.98.1414523843719;
 Tue, 28 Oct 2014 12:17:23 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Tue, 28 Oct 2014 12:17:23 -0700 (PDT)
In-Reply-To: <xmqq8uk6skky.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 11:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> commit 020ed65a12838bdead64bc3c5de249d3c8f5cfd8 upstream.
>>
>> When performing a reflog transaction update, only write to the reflog iff
>> msg is non-NULL. This can then be combined with REFLOG_TRUNCATE to perform
>> an update that only truncates but does not write.
>
> Does any existing caller call this codepath with update->msg == NULL?
>
> Will "please truncate" stay to be the only plausible special cause
> to call into this codepath without having any meaningful message?
>
> I am trying to make sure that this patch is not painting us into a
> corner where we will find out another reason for doing something
> esoteric in this codepath but need to find a way other than setting
> msg to NULL for the caller to trigger that new codepath.  Put it in
> another way, please convince me that a new boolean field in update,
> e.g. update->truncate_reflog, is way overkill for this.

This change only affects whether or not a reflog entry will be emitted
by the update.
msg==NULL means we will not create a new entry. This is orthogonal to
whether we truncate the log or not.

In order to truncate the reflog we do have a boolean in update->flags
& REFLOG_TRUNCATE
which determines whether the update will truncate the log or not.

I see these two actions a) write a log entry and b) truncate the log
as orthogonal and thus think we should have separate knobs for them.


Currently, modulo bugs, the only caller that will use msg==NULL is
when we do reflog truncations. Thus that codepath BOTH sets msg==NULL
(to not write a new log entry) and also sets
update->flags&REFLOG_TRUNCATE (to truncate the log).


Having separate knobs for the two actions allow us the current behaviour with:
  msg==NULL update->flags&REFLOG_TRUNCATE

but it will also allow a caller to do things like
   msg="truncated by foo because ..." update->flags&REFLOG_TRUNCATE

If there is some future usecase where we want to truncate the log and
then also generate a new initial log entry for the new log.


I will work on the commit message to make the distinction between
msg==NULL and update->flags&REFLOG_TRUNCATE more clear.


thanks
ronnie sahlberg


>
>>
>> Change-Id: I44c89caa7e7c4960777b79cfb5d339a5aa3ddf7a
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  refs.c | 5 +++--
>>  refs.h | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index d54c3b9..f14b76e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3895,8 +3895,9 @@ int transaction_commit(struct transaction *transaction,
>>                               update->reflog_fd = -1;
>>                               continue;
>>                       }
>> -             if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
>> -                                  update->new_sha1,
>> +             if (update->msg &&
>> +                 log_ref_write_fd(update->reflog_fd,
>> +                                  update->old_sha1, update->new_sha1,
>>                                    update->committer, update->msg)) {
>>                       error("Could write to reflog: %s. %s",
>>                             update->refname, strerror(errno));
>> diff --git a/refs.h b/refs.h
>> index 5075073..bf96b36 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -337,6 +337,7 @@ int transaction_delete_ref(struct transaction *transaction,
>>  /*
>>   * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>>   * this update will first truncate the reflog before writing the entry.
>> + * If msg is NULL no update will be written to the log.
>>   */
>>  int transaction_update_reflog(struct transaction *transaction,
>>                             const char *refname,
