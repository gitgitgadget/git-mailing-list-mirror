From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 10/15] refs.c: allow multiple reflog updates during a
 single transaction
Date: Tue, 28 Oct 2014 12:59:32 -0700
Message-ID: <CAL=YDWkjBf_Ch=ww6oQDp=KLnDLSe=LkjLLrDJ6Rv-k2zM7gmA@mail.gmail.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
	<1413919462-3458-11-git-send-email-sahlberg@google.com>
	<xmqq4muusjkc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjCva-0001Mw-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 20:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbaJ1T7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 15:59:34 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:59578 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaJ1T7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 15:59:33 -0400
Received: by mail-qc0-f181.google.com with SMTP id w7so1233448qcr.12
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BG3ATLT/yv6utWuwOTv0wr9eAjmFCxBnmQ3Q2Dr+s50=;
        b=igGeXiU0TQ9at2/8Zrib/aYpFzGJfImUBUUgwEG78pgNHdp0dBu7C243kLD9EBOn8W
         EqjkUTwjH3kRLEAoxvI5BHprWnaO/rb4UZnNgue7DvNqFOg8CbSoARyTMx6JeS37oueg
         rFJAAERgJUxioHMyuFwkHf5/DKN5Kp0KrLidZVBz+gqJTG3XRdJuVMDsA2XcTYybA8dC
         F/oixEqt1C4hDxDAsMajA4JcX0270gqQ/j2u71D4GfBrqfJT2C8w5qD2gOty7jq9mDwD
         2AQ2DghevILqoXctk6EGzxlnIKZ6g+GcVs/GRuPvuVOd0b9T7csMpswXz0E/YGaG+adT
         djSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BG3ATLT/yv6utWuwOTv0wr9eAjmFCxBnmQ3Q2Dr+s50=;
        b=Hse3uh/F+yJY1z5W/o7F5V/wx7Md3ghca1WyfTHSX4t9TwW4DBIr/d+r4cv8xpDxNh
         vEXgGXlBG5f5UMUQxuAHZfKGEX+vSBS0uq/RSNyWbNiDx8qnkOq+JO7cJPelk7Zvzolz
         P0nx12l7A2hHF9x0OI76FeUN6xXgwGl9LoujgXt1q5D3+aYBGJsMoBM1ZZCP6mR6thQZ
         0IAb4pVudA8tM5/wBpwDabZ3+wofRdWeMJ9OPQRJUFZ22Y3Hn3y+bcTyHiAYXFPpOCkK
         whaYxNv1wqUKXRoO7wzBqPtiz91hoWeHQ/uzXgs84T/CDvYhTwtzThkAVswRN3OKt2wZ
         FPHg==
X-Gm-Message-State: ALoCoQlsojWnCbovkfRlajoeBGYCx5+DHKUcFjeHW9L8cjstDN4IXUJtKvRrV2LzA06w35HiBVzW
X-Received: by 10.224.90.3 with SMTP id g3mr8461965qam.90.1414526373030; Tue,
 28 Oct 2014 12:59:33 -0700 (PDT)
Received: by 10.229.225.202 with HTTP; Tue, 28 Oct 2014 12:59:32 -0700 (PDT)
In-Reply-To: <xmqq4muusjkc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 23, 2014 at 11:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> @@ -3531,7 +3537,7 @@ struct ref_update {
>>       enum transaction_update_type update_type;
>>       unsigned char new_sha1[20];
>>       unsigned char old_sha1[20];
>> -     int flags; /* REF_NODEREF? */
>> +     int flags; /* REF_NODEREF? or private flags */
>
> Not a very informative comment, I'd have to say.  How are users of
> this API expected to avoid stepping on each others' and API
> implementation's toes?

That is an old and bitrotted comment.
I changed it to point to the canonical definition of these flags instead :
  int flags;  /* The flags to transaction_update_ref[log] are defined
                  * in refs.h
                  */
>
>> @@ -3539,8 +3545,9 @@ struct ref_update {
>>
>>       /* used by reflog updates */
>>       int reflog_fd;
>> -     struct lock_file reflog_lock;
>> +     struct lock_file *reflog_lock;
>
> What is this change about?
>

We have one update entry for each line we want to write to the reflog.
So for the first update to a reflog we allocate a lock_file structure.
For any subsequent reflog entry to the same ref we just let the
pointer point to the previous structure we already allocated.

I.e. a way to have only one lock_file structure and share it across
multiple struct ref_update structures.

> Does the lifetime rule for "struct lock_file" described in
> Documentation/technical/api-lockfile.txt, namely, "once you call
> hold_lock_file_* family on it, you cannot free it yourself", have
> any implication on this?

Nope.

>
>> +     if (!(update->flags & UPDATE_REFLOG_NOLOCK))
>> +             update->reflog_lock = xcalloc(1, sizeof(struct lock_file));
>> +
>
> Hmph, does this mean that the caller needs to keep track of the refs
> it ever touched inside a single transaction, call this without nolock
> on the first invocation on a particular ref and with nolock on the
> subsequent invocation?

Nope. This is not visible to the caller and is managed transparently
inside the transaction code.

>
> Or is the "caller" just implementation detail of the API and higher level
> callers do not have to care?

The latter,    the higher level do not have to care.


regards
ronnie sahlberg
