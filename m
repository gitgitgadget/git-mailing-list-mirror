From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 25/44] receive-pack.c: use a reference transaction for
 updating the refs
Date: Tue, 20 May 2014 13:37:47 -0700
Message-ID: <CAL=YDWnaAJ+Ck9Mt462T2zp9KOFaDAGeXKFFH2qJmjb1gj8SbQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-26-git-send-email-sahlberg@google.com>
	<20140520194246.GR12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmqnI-0005Cg-HC
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 22:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbaETUht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 16:37:49 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:38684 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbaETUhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 16:37:48 -0400
Received: by mail-ve0-f176.google.com with SMTP id jz11so1322462veb.35
        for <git@vger.kernel.org>; Tue, 20 May 2014 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RafB14Ghlp6897RmVT51c1z2hD+ICyU3ueserq9IBkE=;
        b=LwY31qvDGPTRRUQvPcvK+IZgxNRE19x4RuQHVQICqiHOkeaPVc5lBkOR8pjwHYT76j
         goBUh6xO5TgjHcywZRe9rIgepyLhydoE96jC/1PCCJai+d/bFlkkOgbCxC3KmZfUMGLP
         a4oZhTF8N7ekzlla1+7jqzc9i6ZO9FN4E/IDz9uz4k/a7DkLUv70HfoQF+kpp82wx/+V
         j1u9l+KWEc1G7WsIO78NHeDUH/7tYXitRtpmedF2A/LEwPAt+xo4Ec1J1qTOX6MWIOwW
         dpDST8rtOI0R7b6H2Sm6cdQ1VYwiw9oMjdkB+Lh6Y7T2J/pdfOGRrU1QF1pPnOdm9oW9
         OhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RafB14Ghlp6897RmVT51c1z2hD+ICyU3ueserq9IBkE=;
        b=jE0kUOJVmRAKHjoGbRE0wRYT+VOyUAkl/w/xqq1efK1wm9u6RiCuM/ajIRq+fnO0VV
         rdlFRLPDdLAFANJXmOT/0zYYr5bz4onyWu3KT8NT9HR2CVDlt4qwogUEvyg9CfuGCDWW
         mZuq0S59GI2bdS8u9hg8cbe9ZZ9o6AEPz8vOAYvK7T3KEyFV9GqZzMwW6M3wDeiQjmUZ
         X2osf9gW1yXwlDHQR8mT6jzNrjf6kddD94ntcP7uKa6c4HfBQryJAZJmmB26ZCSOvyI9
         9oL6sGCF1MQTSzkZQx7GHMxTs3V93aRZSNQ9VfpitGUle6FAZHQy9YbxD7gmeJoUBFuo
         RDUA==
X-Gm-Message-State: ALoCoQm6Gr5lzCI9fO3dhPPxJ4cw/sSfr9sq2mtUqA+6kj9EPmba/9UFyLgA7x0J6GoJzCnLVXeL
X-Received: by 10.52.175.69 with SMTP id by5mr4963784vdc.16.1400618267363;
 Tue, 20 May 2014 13:37:47 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 20 May 2014 13:37:47 -0700 (PDT)
In-Reply-To: <20140520194246.GR12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249739>

On Tue, May 20, 2014 at 12:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Wrap all the ref updates inside a transaction to make the update atomic.
>
> Interesting.
>
> [...]
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>>  static int sent_capabilities;
>>  static int shallow_update;
>>  static const char *alt_shallow_file;
>> +static struct strbuf err = STRBUF_INIT;
>
> I think it would be cleaner for err to be local.  It isn't used for
> communication between functions.

Done.

>
> [...]
>> @@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>                   update_shallow_ref(cmd, si))
>>                       return "shallow error";
>>
>> -             lock = lock_any_ref_for_update(namespaced_name, old_sha1,
>> -                                            0, NULL);
>> -             if (!lock) {
>> -                     rp_error("failed to lock %s", name);
>> -                     return "failed to lock";
>> -             }
>> -             if (write_ref_sha1(lock, new_sha1, "push")) {
>> -                     return "failed to write"; /* error() already called */
>> -             }
>> +             if (ref_transaction_update(transaction, namespaced_name,
>> +                                        new_sha1, old_sha1, 0, 1, &err))
>> +                     return "failed to update";
>
> The original used rp_error to send an error message immediately via
> sideband.  This drops that --- intended?

Oops. I misread it as a normal error()

>
> The old error string shown on the push status line was was "failed to
> lock" or "failed to write" which makes it clear that the cause is
> contention or database problems or filesystem problems, respectively.
> After this change it would say "failed to update" which is about as
> clear as "failed".

I changed it to return xstrdup(err.buf) which should be as detailed as
we can get.

>
> Would it be safe to send err.buf as-is over the wire, or does it
> contain information or formatting that wouldn't be suitable for the
> client?  (I haven't thought this through completely yet.)  Is there
> some easy way to distinguish between failure to lock and failure to
> write?  Or is there some one-size-fits-all error for this case?

I think err.buf is what we want.

>
> When the transaction fails, we need to make sure that all ref updates
> emit 'ng' and not 'ok' in receive-pack.c::report (see the example at
> the end of Documentation/technical/pack-protocol.txt for what this
> means).  What error string should they use?  Is there some way to make
> it clear to the user which ref was the culprit?
>
> What should happen when checks outside the ref transaction system
> cause a ref update to fail?  I'm thinking of
>
>  * per-ref 'update' hook (see githooks(5))
>  * fast-forward check
>  * ref creation/deletion checks
>  * attempt to push to the currently checked out branch
>
> I think the natural thing to do would be to put each ref update in its
> own transaction to start so the semantics do not change right away.
> If there are obvious answers to all these questions, then a separate
> patch could combine all these into a single transaction; or if there
> are no obvious answers, we could make the single-transaction-per-push
> semantics optional (using a configuration variable or protocol
> capability or something) to make it possible to experiment.

I changed it to use one transaction per ref for now.

Please see the update ref-transactions branch.

Thanks!
