From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 27/44] walker.c: use ref transaction for ref updates
Date: Wed, 21 May 2014 10:06:43 -0700
Message-ID: <CAL=YDW=DxtPBH=zBaNNzazz=vhVnWAKpOVXucK4Ezm=O_1VOFQ@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-28-git-send-email-sahlberg@google.com>
	<20140521004632.GX12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:06:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9yc-0001Os-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbaEURGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:06:46 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:43106 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbaEURGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:06:45 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so2848441veb.5
        for <git@vger.kernel.org>; Wed, 21 May 2014 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dOvGEaUYEUDwDNbIaRQbI3Y1YMeNN+59ARXJBDpvdek=;
        b=ez5vVdKDot8ERhDN5kSbuIVCvPWrpY0XnRs31g5jhyiALl/n+HLEmnklJmceOHT72A
         ozrE0gwWK+8MX6aMkxJ7juwwMWU5pk+Ifo4IGgSlDaJhTzdBzPnlCxJ7Mm33uyPyTNgE
         c3fAItvBu6UboffaQ9hK8tZq+HfCHoCXLdqgU5/z+Hik57yciHXElBMpWNPbn99qXU1r
         GprnAccJxqKJwcrKJlfH6qBFjxlvA7b7Ts3M4JAhwEltV+rdd+HfDG6KM6RdXljZb3VO
         +HXBhwf5mrQs6TS5z9lGyXfX0zLQOo0ELGOGJlBZUPuShFV/v9oxKBJqlutcoRo9Geag
         hfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dOvGEaUYEUDwDNbIaRQbI3Y1YMeNN+59ARXJBDpvdek=;
        b=jVf66Jv6U/ZMoF24i+RJYV3iz8rrp+A0uG+VLSa4H6X8Jil702VHmd7idIC6hUKJcY
         9Hs0Py/wZBCWv33B1dtJaWhUHTtBzbbp1IqVUnERKVobzssvOdWZ9X0Zznnh36OZJhoB
         CHLAUaDCsroOl+ewXGtrAP45msMa/W9WkGeYdpOi52QV0pOmn/tFnwwClkadZzkUKq1d
         aJDx6E4FuNSVhDzkjjl32T3cRlV9TE4NkV1ipleQrJ6FYK+DkeDbEOtsn6ENSa/CA4s/
         Ky+KLeCFz3k8jKBgLh9zVBWbebusvf+GyNf/UXfXQZJqUEfvT2uezZ0yOHbkkEi4yHyg
         pt+Q==
X-Gm-Message-State: ALoCoQnS2LD9h1BlwTJ0VaWoWkKXdvzInZWaqWlJBwv/EmwvHrBj7jwy8DueEnB7+idlpm7sL4tn
X-Received: by 10.52.189.36 with SMTP id gf4mr3644500vdc.1.1400692003970; Wed,
 21 May 2014 10:06:43 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 21 May 2014 10:06:43 -0700 (PDT)
In-Reply-To: <20140521004632.GX12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249813>

On Tue, May 20, 2014 at 5:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> This changes the locking slightly for walker_fetch. Previously the code would
>> lock all refs before writing them but now we do not lock the refs until the
>> commit stage. There is thus a very short window where changes could be done
>> locally during the fetch which would be overwritten when the fetch completes
>> and commits its transaction. But this window should be reasonably short.
>> Even if this race does trigger, since both the old code and the new code
>> just overwrites the refs to the new values without checking or comparing
>> them with the previous value, this is not too dissimilar to a similar scenario
>> where you first do a ref change locally and then later do a fetch that
>> overwrites the local change. With this in mind I do not see the change in
>> locking semantics to be critical.
>
> Sounds scary.  The usual approach is
>
>         old_sha1 = ...
>         ... various checks ...
>
>         transaction = transaction_begin(&err)
>         transaction_update(transaction, refname, new_sha1, old_sha1, ...);
>         transaction_commit(transaction, &err);
>
> which is not racy because _update checks against old_sha1.
>
> If I understand correctly, you are saying 'have_old' is false here so
> we don't have the usual protection.  If the "... various checks ..."
> section shown above is empty, that should be fine and there is no
> actual change in semantics.  If the "... various checks ..." section
> shown above is nonempty then it could be a problem.

Yeah, we don't have the old sha1 so this function is already imo a bit dodgy.
The transaction system in this series can not really handle this with
the exact same semantics as the old code
but we do gain the ability to do things such as

transaction_begin
... lock all refs...
...do other stuff.
transaction_update for all refs
transaction_commit

in the next patch series when the transactions start supporting
multiple updates for the same ref.
However that support comes reasonably late in the next series and I
would want to avoid growing this series much more.


This is the patch in the next series that restore the lock-everything-first.
It relies on that we will do all locking in _update already and not
wait until _commit as well as that it allows multiple updates to the
same ref as long as all updates, except the first, are of the form
have_old==1 and old_sha1==new_sha1-of-previous-update.


diff --git a/walker.c b/walker.c
index 94d4988..dd8c11e 100644
--- a/walker.c
+++ b/walker.c
@@ -255,18 +255,31 @@ int walker_fetch(struct walker *walker, int targets, char
        struct strbuf err = STRBUF_INIT;
        struct ref_transaction *transaction;
        unsigned char *sha1 = xmalloc(targets * 20);
+       unsigned char transaction_sha1[20];
        char *msg;
        int i;

        save_commit_buffer = 0;

        if (write_ref) {
+               memset(transaction_sha1, 0xff, 20);
                transaction = transaction_begin(&err);
                if (!transaction) {
                        error("%s", err.buf);
                        strbuf_release(&err);
                        return -1;
                }
+               /* Lock all refs by updating to a temporary sha1 */
+               for (i = 0; i < targets; i++) {
+                       if (!write_ref[i])
+                               continue;
+                       strbuf_reset(&ref_name);
+                       strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
+                       transaction_update_sha1(transaction, ref_name.buf,
+                                               transaction_sha1, NULL, 0, 0,
+                                               msg ? msg : "fetch (unknown)",
+                                               &err);
+               }
        }
        if (!walker->get_recover)
                for_each_ref(mark_complete, NULL);
@@ -295,7 +308,8 @@ int walker_fetch(struct walker *walker, int targets, char **
                strbuf_reset(&ref_name);
                strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
                if (transaction_update_sha1(transaction, ref_name.buf,
-                                           &sha1[20 * i], NULL, 0, 0,
+                                           &sha1[20 * i], transaction_sha1,
+                                           0, 1,
                                            msg ? msg : "fetch (unknown)",
                                            &err))
                        break;



>
> [...]
>> --- a/walker.c
>> +++ b/walker.c
>> @@ -251,24 +251,18 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
>>  int walker_fetch(struct walker *walker, int targets, char **target,
>>                const char **write_ref, const char *write_ref_log_details)
>>  {
>> -     struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
>> +     char ref_name[PATH_MAX];
>
> We tend to prefer strbuf instead of fixed-size buffers in new code.

Changed.

>
> [...]
>> -     char *msg;
>> +     char *msg = NULL;
>
> Needed?  The existing code seems to set msg = NULL in the
> !write_ref_log_details case already.

Fixed.

Thanks.


>
> [...]
>> @@ -294,19 +288,26 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>>       for (i = 0; i < targets; i++) {
>>               if (!write_ref || !write_ref[i])
>>                       continue;
>> -             ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
>
> Okay, so before this patch we do:
>
>         for each target in write_ref:
>                 lock it (with no particular expectation about where it
>                 points)
>
> Then
>
>         unless http-fetch was passed --recover:
>                 mark the objects pointed to by current refs as COMPLETE
>
> Then we do HTTP GETs to grab the objects we need from a "dumb" HTTP
> server.  The COMPLETE objects tell us about objects we don't have to
> bother trying to get.
>
> When we're done, we come up with a reflog entry and write out refs
> pointing to the requested commits.
>
> This code has two callers:
>
>         git-remote-http (aka remote-curl.c::fetch_dumb)
>         git-http-fetch (aka http-fetch.c)
>
> The codepath in git-remote-http gets wide use, though it's diminishing
> as more people switch to "smart" http.  It doesn't 't use the "write
> out some refs" feature.  It just wants the objects and then takes care
> of writing refs on its own.
>
> Perhaps it's worth avoiding beginning a transaction in the first place
> in the !write_ref case.
>
> The git-http-fetch command is a piece of plumbing that used to be used
> by 'git clone' and 'git fetch' in the olden days when they were shell
> scripts.  I doubt anyone uses it.  As you noticed, it doesn't have any
> way to specify anything about the expected old values of the refs it
> writes to.  So this change doesn't introduce any race there.
>
>> +             sprintf(ref_name, "refs/%s", write_ref[i]);
>> +             if (ref_transaction_update(transaction, ref_name,
>> +                                        &sha1[20 * i], NULL,
>> +                                        0, 0))
>> +                     goto rollback_and_fail;
>> +     }
>
> Looks good.
>
>> +
>> +     if (ref_transaction_commit(transaction, msg ? msg : "fetch (unknown)",
>> +                                &err)) {
>> +             error("%s", err.buf);
>> +             goto rollback_and_fail;
>>       }
>
> Also looks good.
>
> Thanks,
> Jonathan
