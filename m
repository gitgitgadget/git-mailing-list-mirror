From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/31] refs.c: allow multiple reflog updates during a
 single transaction
Date: Fri, 16 May 2014 18:01:01 -0400
Message-ID: <CAPig+cSXt3FDS1XtHBq2y5NLQxKrVM4sp=YbRa2skJX=RrOyTw@mail.gmail.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-10-git-send-email-sahlberg@google.com>
	<xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 00:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQBg-0004mj-VZ
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbaEPWBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:01:04 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:64125 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbaEPWBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:01:02 -0400
Received: by mail-yh0-f46.google.com with SMTP id 29so4938057yhl.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p2qeoWaSf7Zh39e8i+15msxCy1qFFxr5h7CQ6B6/qLM=;
        b=T93qrPvvEH7ULlaX/CRBOZSfxL70+O4/pVcu6M/pjfELDkk2hTPNgvs8+KqbdNimwH
         RZZpjJK/5GW06+3Pgz2ggu96gcQJKeW0vDGKtsm4tDF9qYqHhtis2FC8kz/w4ijInzAN
         E56Cyu9h7VdQfCLHqsh0qNI/3qDWFV/5Z1bm2DthdryEV8OkPq1GlPahxc9Wmr3UvU1D
         siFgbKr2AwZ0AZ8UXWN7qap1UnDPZlY3pshVBTe/WVnuq5iICDjIIRz36L1IDzHefp5B
         o3autS6UmTtyu4e/7zx5cNkZa2C51NeUVi12IMnaAhRUMEd0ssibG+Ci+Ub75bOT5+bD
         ++fA==
X-Received: by 10.236.30.105 with SMTP id j69mr6529585yha.19.1400277661983;
 Fri, 16 May 2014 15:01:01 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Fri, 16 May 2014 15:01:01 -0700 (PDT)
In-Reply-To: <xmqqppjd8l13.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 5oj7U3ENJ_pDcqP7-cjkfDEw6EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249422>

On Fri, May 16, 2014 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
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

Also, indent with tabs rather than spaces (the line following the 'if').

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

Indent with tabs.
