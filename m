From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 25/44] receive-pack.c: use a reference transaction for
 updating the refs
Date: Wed, 21 May 2014 11:50:01 -0700
Message-ID: <CAL=YDWnftEnmmKFj=6vyG9bhfEL-dO5gpRPNCD0+X38LKdi7Gg@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-26-git-send-email-sahlberg@google.com>
	<20140520194246.GR12314@google.com>
	<CAL=YDWnaAJ+Ck9Mt462T2zp9KOFaDAGeXKFFH2qJmjb1gj8SbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 20:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBav-0001p0-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752978AbaEUSuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 14:50:03 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:53367 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaEUSuC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 14:50:02 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so3067321veb.10
        for <git@vger.kernel.org>; Wed, 21 May 2014 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N2JKoiROFsg+mYcGSF8sEPi8nRF5KvIBgAxh3BdYAcw=;
        b=MQ2j7w/DqMafyJmf0uT1LriuMRRx8sYkqtpKcLwzKcpV+4XoQZ0dYpUAHPmnd5i1/H
         y/zhy5wb30ULnqSZiXf1UKj5qrikL8vZq/pCEtrpjcaES5XQNXgmb2kConUFIKhUdQR6
         fRDI/b7f5C9ZaWOo0X0zw/uupaLyH/caalktPjVCaWiGd0sbFQhOlrUN9iMVtWrW6xeC
         7mzcXTogueMvUDIB2Z2bEr0DziAFkikRnNjrUITGlVlYkPHlLc0tM435+JgDL+3ckrhy
         ra/C3wnFP4iWak1/IwraMN7EG9HgVJvp8wn4cytoVtsU+PfcnBTrT3u50UmZ+eLcG08D
         +w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N2JKoiROFsg+mYcGSF8sEPi8nRF5KvIBgAxh3BdYAcw=;
        b=mskOpff8he9RpXoVNedSeqznpw2FgmLFmLxN8nhQLwEQXD4Nwh79Q3a+crLXXQwc9N
         fDB/d4r+GYZ+55GGQscCQk9p1HBy5Lds8dUjs5pKJ5GVqhWiEMVNuOny/Y38NKbXEm1C
         BAAaERgkJGRM9wUHjF+hLRMGhoeZpKXc5bcqyM7u+R09VWZ//Z7AeAHNGu4hwUtqmz60
         FAVAJ19azGJUa2M+xgjmd8kUkbGf8K6NeekCe/I++aM1j1iY1EwC1pGeChrISjHmdfVo
         g8X+IcNqo/EqatWHZ7KtI8JQ8CCvyDI3pkX1r40TyRovQlTmBD1q/UCMNSfiaqVX7Dzq
         UaVA==
X-Gm-Message-State: ALoCoQkxiZC96Qf7VT7YvYxQCEg90qV+mQ/VUS/abvm7cqfnWQREXgPneVZPJ6EWgcaOCrIh7Lrw
X-Received: by 10.52.37.48 with SMTP id v16mr9577724vdj.4.1400698201137; Wed,
 21 May 2014 11:50:01 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 21 May 2014 11:50:01 -0700 (PDT)
In-Reply-To: <CAL=YDWnaAJ+Ck9Mt462T2zp9KOFaDAGeXKFFH2qJmjb1gj8SbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249822>

On Tue, May 20, 2014 at 1:37 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Tue, May 20, 2014 at 12:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Ronnie Sahlberg wrote:
>>
>>> Wrap all the ref updates inside a transaction to make the update atomic.
>>
>> Interesting.
>>
>> [...]
>>> --- a/builtin/receive-pack.c
>>> +++ b/builtin/receive-pack.c
>>> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>>>  static int sent_capabilities;
>>>  static int shallow_update;
>>>  static const char *alt_shallow_file;
>>> +static struct strbuf err = STRBUF_INIT;
>>
>> I think it would be cleaner for err to be local.  It isn't used for
>> communication between functions.
>
> Done.
>
>>
>> [...]
>>> @@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>>                   update_shallow_ref(cmd, si))
>>>                       return "shallow error";
>>>
>>> -             lock = lock_any_ref_for_update(namespaced_name, old_sha1,
>>> -                                            0, NULL);
>>> -             if (!lock) {
>>> -                     rp_error("failed to lock %s", name);
>>> -                     return "failed to lock";
>>> -             }
>>> -             if (write_ref_sha1(lock, new_sha1, "push")) {
>>> -                     return "failed to write"; /* error() already called */
>>> -             }
>>> +             if (ref_transaction_update(transaction, namespaced_name,
>>> +                                        new_sha1, old_sha1, 0, 1, &err))
>>> +                     return "failed to update";
>>
>> The original used rp_error to send an error message immediately via
>> sideband.  This drops that --- intended?
>
> Oops. I misread it as a normal error()
>
>>
>> The old error string shown on the push status line was was "failed to
>> lock" or "failed to write" which makes it clear that the cause is
>> contention or database problems or filesystem problems, respectively.
>> After this change it would say "failed to update" which is about as
>> clear as "failed".
>
> I changed it to return xstrdup(err.buf) which should be as detailed as
> we can get.
>
>>
>> Would it be safe to send err.buf as-is over the wire, or does it
>> contain information or formatting that wouldn't be suitable for the
>> client?  (I haven't thought this through completely yet.)  Is there
>> some easy way to distinguish between failure to lock and failure to
>> write?  Or is there some one-size-fits-all error for this case?
>
> I think err.buf is what we want.
>
>>
>> When the transaction fails, we need to make sure that all ref updates
>> emit 'ng' and not 'ok' in receive-pack.c::report (see the example at
>> the end of Documentation/technical/pack-protocol.txt for what this
>> means).  What error string should they use?  Is there some way to make
>> it clear to the user which ref was the culprit?
>>
>> What should happen when checks outside the ref transaction system
>> cause a ref update to fail?  I'm thinking of
>>
>>  * per-ref 'update' hook (see githooks(5))
>>  * fast-forward check
>>  * ref creation/deletion checks
>>  * attempt to push to the currently checked out branch
>>
>> I think the natural thing to do would be to put each ref update in its
>> own transaction to start so the semantics do not change right away.
>> If there are obvious answers to all these questions, then a separate
>> patch could combine all these into a single transaction; or if there
>> are no obvious answers, we could make the single-transaction-per-push
>> semantics optional (using a configuration variable or protocol
>> capability or something) to make it possible to experiment.
>
> I changed it to use one transaction per ref for now.
>
> Please see the update ref-transactions branch.

I have added support for atomic pushes towards the end of the -next series.
https://github.com/rsahlberg/git/tree/ref-transactions-next

It is activated by a new --atomic-push argument to send-pack and is
then negotiated by a new option in the wire protocol.


>
> Thanks!
