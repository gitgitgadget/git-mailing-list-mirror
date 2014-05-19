From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 09/31] refs.c: allow multiple reflog updates during a
 single transaction
Date: Mon, 19 May 2014 16:06:54 -0700
Message-ID: <CAL=YDWn5GXR8ADt8a0dJBS-t62xrkuMz_0h=HTqLkpCawoV=xw@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-10-git-send-email-sahlberg@google.com>
	<xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 01:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWe3-0007QQ-Pz
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaESXG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:06:56 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:63224 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaESXGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:06:55 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so7342879veb.30
        for <git@vger.kernel.org>; Mon, 19 May 2014 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nQnwRBPCCB3KY389HUB/GTTBJ3auWOha4I07gI5e0rc=;
        b=a0fYOF00S/XO6oWdi1J0T3PXWurKraTvrDFotqApxZPiGK/V8FI8MqJOsBRKWHBcah
         +Ka5Bcq5pLhLza++7XICgSis0LyQIgmiMwB/SWOdzPvv+vibA5y50dF8CCTvGfx1yzG4
         WjPD5C/P6bHcADBeUV5Xt1DGnEH7rtzDaAHNis+muMu9U2A7jrMozGQXMWtIO8vUk7+V
         DpMNBWnDPVC6x7snteQPaweXVbzwP0W1Iubz+v9Na4kiVzYWb4wCF/0a0f5lFTdcgEss
         z++wrbu181HlPh9RJHywnBfUnpk0p13XTR4/GTEyAkIxB8qq1iAlV08EBlDOFDZ60wuU
         kaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nQnwRBPCCB3KY389HUB/GTTBJ3auWOha4I07gI5e0rc=;
        b=cORyrZ+ZXf1rYDpqXfwpe7sAyRjNI9v0EDZnBCYfrj0T3aeDXuLBd2IHZcBxZBgrpn
         gYTyZio/Oj09UdvYxwjA1lf79zv0OPVSD5EeTWVp08qKti7B+0WrCOni3kmjyRvmbd3V
         BIM++qU9aUQTpQnvtFEy9ZpkAr5ml1qrKZwFY6sW1RNP4ZY1VxvqE1xG4XzRkEmGuIKb
         Uw9GX8wB1kKCXvrBLevbC19jJfZiPto31/RkJPlGrrR9ZZlsuEqH20rgUDyfalGpC045
         3/KPpgJknFPaZQjDJ0dNQOia0Gmg9DNOmOGSiamPqPI5sDq8xkRvVte89hVuYzjbqdBV
         1UkA==
X-Gm-Message-State: ALoCoQnEqyWvOJsuH5NVMKDSzvUfTpAFUnHOaPjypfej1T1oezNn7z7IzclE5kjaTLU5NCpS7OVz
X-Received: by 10.220.195.196 with SMTP id ed4mr614671vcb.42.1400540814469;
 Mon, 19 May 2014 16:06:54 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 16:06:54 -0700 (PDT)
In-Reply-To: <xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249634>

On Fri, May 16, 2014 at 2:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> Allow to make multiple reflog updates to the same ref during a transaction.
>> This means we only need to lock the reflog once, during the first update that
>> touches the reflog, and that all further updates can just write the reflog
>> entry since the reflog is already locked.
>>
>> This allows us to write code such as:
>>
>> t = transaction_begin()
>> transaction_reflog_update(t, "foo", REFLOG_TRUNCATE, NULL);
>> loop-over-somehting...
>>    transaction_reflog_update(t, "foo", 0, <message>);
>> transaction_commit(t)
>
> OK, so you are now doing not just "refs" but also "reflogs", you
> felt that "ref_transaction()" does not cover the latter.  Is that
> the reason for the rename in the earlier step?
>
> I am sort-of on the fence.
>
> Calling the begin "ref_transaction_begin" and then calling the new
> function "ref_transaction_log_update" would still allow us to
> differentiate transactions on refs and reflogs, while allowing other
> kinds of transactions that are not related to refs at all to employ
> a mechanism that is different from the one that is used to implement
> the transactions on refs and reflogs you are building here.
>
> But I think I am OK with the generic "transaction-begin" now.
> Having one mechanism for refs and reflogs, and then having another
> completely different mechanism for other things, will not let us
> coordinate between the two easily, so "allow transactions that are
> not related to refs at all to be built on a different mechanism" may
> not be a worthwhile goal to pursue in the first place.  Please
> consider the question on the naming in the earlier one dropped.
>
>>
>> where we first truncate the reflog and then build the new content one line at a
>> time.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 49 insertions(+), 9 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index a3f60ad..e7ede03 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -37,6 +37,10 @@ static inline int bad_ref_char(int ch)
>>   *  need to lock the loose ref during the transaction.
>>   */
>>  #define REF_ISPACKONLY       0x0200
>> +/** Only the first reflog update needs to lock the reflog file. Further updates
>> + *  just use the lock taken by the first update.
>> + */
>
> Style.

Done.

>
>> @@ -3349,8 +3355,23 @@ int transaction_update_reflog(struct ref_transaction *transaction,
>>                             int flags)
>>  {
>>       struct ref_update *update;
>> +     int i;
>>
>>       update = add_update(transaction, refname, UPDATE_LOG);
>> +     update->flags = flags;
>> +     for (i = 0; i < transaction->nr - 1; i++) {
>> +             if (transaction->updates[i]->update_type != UPDATE_LOG)
>> +                     continue;
>> +             if (!strcmp(transaction->updates[i]->refname,
>> +                         update->refname)) {
>> +                     update->flags |= UPDATE_REFLOG_NOLOCK;
>> +                     update->orig_update = transaction->updates[i];
>> +                     break;
>> +             }
>> +     }
>> +     if (!(update->flags & UPDATE_REFLOG_NOLOCK))
>> +       update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
>
> So with two calls to transaction-update-reflog, we make two calls to
> add-update, and each holds a separate lock?  If we write two entries
> to record two updates of the same ref, would we still want to do so?

If we call transaction_update_reflog twice we will call add_update
twice since we are doing two updates.
But if the two calls are for the same ref then we only lock the reflog
for the first update and then in the second update we re-use the lock
structure from the first.

Later updates to reflog.c will show how to loop over the old reflog,
using the existing iterator, and then create a new expired reflog one
entry at a time.


>
>> +     /* Rollback any reflog files that are still open */
>> +     for (i = 0; i < n; i++) {
>> +             struct ref_update *update = updates[i];
>> +
>> +             if (update->update_type != UPDATE_LOG)
>> +                     continue;
>> +             if (update->flags & UPDATE_REFLOG_NOLOCK)
>> +                     continue;
>> +             if (update->reflog_fd == -1)
>> +                     continue;
>> +             rollback_lock_file(update->reflog_lock);
>> +     }
>>       transaction->status = ret ? REF_TRANSACTION_ERROR
>>         : REF_TRANSACTION_CLOSED;
