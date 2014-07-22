From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 12/12] refs.c: fix handling of badly named refs
Date: Tue, 22 Jul 2014 14:30:36 -0700
Message-ID: <CAL=YDWnTNKGW3AAr7twZ44KUb1Pxu0kms5Lt_3-4LBYGQw2+PQ@mail.gmail.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-13-git-send-email-sahlberg@google.com>
	<xmqqlhrlf7oe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hdx-0007LN-EB
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbaGVVah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:30:37 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:59119 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbaGVVah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:30:37 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so544318vcb.7
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+J/MKxr0fYxHmN3PBQ2uc1QsGcVddNT1fI5hkyZHm9Q=;
        b=emhdb4qixvz3vVPBwnCTC4lxh0K3iA7tGoFUOHudfBn6S+FZ0WT9FxDB3sGjq53+Ud
         k9f3PDSi2Z+YpsppNdqLRHCZurl2Q9fxPQaUe85bMa9o8/UlQ5m39qFF+VZ0XsEXOyEi
         WoUXDvKMSXfLztKzxhqmML4502/jd/9PQyKyJBmm5olxlwHX9cCd8FA6aEmHaC3dYoPV
         TApF1QjhxBNggeIHokTCvnmfBrRgTjZ5Kri3W1on+PWoQ0itR45jqelg/D5lou5ifMPr
         5vHbG+s+jH4X9mKpjvEasykuHfX/HntqV03/NKBuDWREFuq6L16R8q26zg5uSlo5+5lu
         Nt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+J/MKxr0fYxHmN3PBQ2uc1QsGcVddNT1fI5hkyZHm9Q=;
        b=K2aefU5UO9JgqapNydjsPEtw/BrMRXNHK1PAtpwd00seymu+YRvxjom4QavZmGqND1
         16b0fPsAEA4Onj1hlfjhQmjgTzTacl7VejjNXNo5xpwrdz0SVSUoSpWn3Ohv/BmJ3Gf/
         koIlXujuhzQ2Bq5E3W8XTjaHyVr5B6uzZVEjkDACkhgLb3xl9AsZrGnAzZq7fgn0G5tX
         seC1O7j7PfAz63MgFvcr8DAh2OM9PN7Zk8QAP9xQ9Kbj+gL84xBGYXHtGg3RMvglmQfn
         QQhmSnK+rDeoMYOABxNl4oG0DEqMwD6Qn3i6tHT5rqcgap1ZhNU3KLh/a/uuMJ5DmMEg
         sSPw==
X-Gm-Message-State: ALoCoQk90vKfEkiY/KDu7EkyEbDZsV81UlK0xu+S0pgm40f3vhfm4aCupVSk3SOviRFdG93tohA+
X-Received: by 10.220.196.207 with SMTP id eh15mr17186325vcb.78.1406064636345;
 Tue, 22 Jul 2014 14:30:36 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 22 Jul 2014 14:30:36 -0700 (PDT)
In-Reply-To: <xmqqlhrlf7oe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254042>

On Tue, Jul 22, 2014 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> We currently do not handle badly named refs well :
>> $ cp .git/refs/heads/master .git/refs/heads/master.....@\*@\\.
>> $ git branch
>>    fatal: Reference has invalid format: 'refs/heads/master.....@*@\.'
>> $ git branch -D master.....@\*@\\.
>>   error: branch 'master.....@*@\.' not found.
>>
>> But we can not really recover from a badly named ref with less than
>> manually deleting the .git/refs/heads/<refname> file.
>>
>> Change resolve_ref_unsafe to take a flags field instead of a 'reading'
>> boolean and update all callers that used a non-zero value for reading
>> to pass the flag RESOLVE_REF_READING instead.
>> Add another flag RESOLVE_REF_ALLOW_BAD_NAME that will make
>> resolve_ref_unsafe skip checking the refname for sanity and use this
>> from branch.c so that we will be able to call resolve_ref_unsafe on such
>> refs when trying to delete it.
>
> Makes sense.
>
>> Add checks for refname sanity when updating (not deleting) a ref in
>> ref_transaction_update and in ref_transaction_create to make the transaction
>> fail if an attempt is made to create/update a badly named ref.
>> Since all ref changes will later go through the transaction layer this means
>> we no longer need to check for and fail for bad refnames in
>> lock_ref_sha1_basic.
>>
>> Change lock_ref_sha1_basic to not fail for bad refnames. Just check the
>> refname, and print an error, and remember that the refname is bad so that
>> we can skip calling verify_lock().
>
> This is somewhat puzzling, though.
>
>> @@ -2180,6 +2196,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>>               else
>>                       unable_to_lock_index_die(ref_file, errno);
>>       }
>> +     if (bad_refname)
>> +             return lock;
>
> Hmph.  If the only offence was that the ref was named badly due to
> historically loose code, does the caller not still benefit from the
> verify-lock check to make sure that other people did not muck with
> the ref while we were planning to update it?
>

I don't think we need to do that.
That would imply that we would need to be able to also allow reading
the content of a badly named ref.
Currently a badly named ref can not be accessed by any function except
 git branch -D <badlynamedref> which contains the special flag that
allows locking it eventhough the ref has an illegal name.

So no one else should be able to read or modify the ref at all.

I think it is sufficient for this case to just have the semantics
"just delete it, I don't care what it used to point to." for this
special case  git branch -D <badrefname>
so therefore since it is not the content of the ref but the name of
the ref itself we have a problem with I don't think we need to read
the old value or verify it.
