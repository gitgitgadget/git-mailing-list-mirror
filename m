From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 11/42] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 09:45:01 -0700
Message-ID: <CAL=YDWk8uZzJyex0YoBx81KhJZjS99qW1nV2AOe=rZhgoYRAcg@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-12-git-send-email-sahlberg@google.com>
	<20140515002738.GH9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:45:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkymO-0002vc-CK
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbaEOQpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:45:04 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:36776 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaEOQpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:45:03 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so1610288veb.38
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8JDI/leuxvyGqOxK/Do0+XLsWeac176hnhr9IShLT+s=;
        b=iUp/Sfm1cmwMUUPcLZB++5EbvyAnKaT00Y+TOzUKwgvFtkDJM0Z0LfOS7IvCbmEC+f
         XoAmhnuSiWHNlRwDEDoah8UgcGfOmBx8Nhlkq6D9OTbOOF0ZwnOPPh6z1y6pUDcN8NNq
         JrsodSfIfwnSFh3bpXCKY3f+uCeh/CHt8PIogrpmiFtsYaQRyBkf98WXSoQIix0B0xNV
         6khXEK8IyWv+7ugWnCvazelBs9QgaEsMbGuqPGEKUj8kJXJsFVp7n4LXWMrIwaTZ7IOB
         TeBeOvLlVFV6liMBoCGoSUs04PRO3//FbZEhDZB6x+CQZNFCtenoY0wQO28Ik8JBQhXK
         gmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8JDI/leuxvyGqOxK/Do0+XLsWeac176hnhr9IShLT+s=;
        b=XdJdFjaBRAwUQ57pJvEAI+2YB2vUcVtZE0iplIu3Nvb7eHgFCSvv55mFNQrkChbAeF
         lid15g9OcockBoVEqNQB0Gx1O2HY0oqvn+hyXvYz8X6kDtFrzmC7zMBzmRO1aS9g2Ush
         sb46U3izk+JPz5hv+Vd6FOgnMlmcsycNh8zG50uL4N6e/abd9BY07WD05m/uSoi+C26C
         wNYAgHGdNfjL6tiOeETKjDw5ckSYw/7tCx2hAH18p43V9XkNiZozAiltGMroZJtjVdoD
         rbF055yFU4ouLN5DHKRhKRvroyrTk58OSTDNU5wYoeZecgiAiBojGmdsZAiFZ/JvCeH9
         KKEA==
X-Gm-Message-State: ALoCoQlTbVIomn8s29LXm8TtWbSzJEYCHMCl+Jhe5c7UNsb+U+HJMuzX1wL00vt7ZMJTBl/SFa3T
X-Received: by 10.221.26.10 with SMTP id rk10mr9477413vcb.0.1400172301673;
 Thu, 15 May 2014 09:45:01 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:45:01 -0700 (PDT)
In-Reply-To: <20140515002738.GH9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249112>

On Wed, May 14, 2014 at 5:27 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       if (annotate)
>>               create_tag(object, tag, &buf, &opt, prev, object);
>>
>> -     lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
>> -     if (!lock)
>> -             die(_("%s: cannot lock the ref"), ref.buf);
>> -     if (write_ref_sha1(lock, object, NULL) < 0)
>> -             die(_("%s: cannot update the ref"), ref.buf);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref.buf, object, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
>
> Makes sense for the _update and _commit case.  (BTW, why is have_old
> a separate boolean instead of a bit in flags?)
>
> For the _begin() case, can ref_transaction_begin() ever fail?  xcalloc
> die()s on allocation failure.  So I think it's fine to assume
> transaction is non-null (i.e., drop the !transaction condition), or if
> you want to be defensive, then label it as a bug --- e.g.:
>
>         if (!transaction)
>                 die("BUG: ref_transaction_begin() returned NULL?");
>
> Otherwise if ref_transaction_begin regresses in the future and this
> case is tripped then the message would be
>
>         fatal: refs/tags/v1.0: cannot update the ref:
>
> which is not as obvious an indicator that the user should contact
> the mailing list.

For the current refs implementation, _begin can never return NULL
since the only failure mode would be OOM in which case we die().
And then for that case we could remove the !transaction check since transaction
can never be NULL here.

(I am not a big fan of die() in general)

However, if we implement a different datastore for refs in the future
it is likely that
the ref_transaction_begin equivalent for that backend could well start returning
failures for a lot other reasons than just OOM.

I could imagine that tdb_transaction_start() could fail for a
corrupted database.
An SQL based backend could fail due to the client library failing to
open a socket to the db,
etc.


But you bring a good point about the error message.

Instead of the suggestions above, would you accept an alternative
approach where I would
add an err argument to ref_transaction_begin() instead?

For a hypothetical mysql backend, this could then do something like :

>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref.buf, object, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);

Which could then result in output like

fatal: refs/heads/master: cannot update the ref: failed to connect to
mysql database ...



So I suggest that instead of doing these changes I will add an err
argument to ref_transaction_begin.
Does that sound ok with you?


>
> Thanks,
> Jonathan
