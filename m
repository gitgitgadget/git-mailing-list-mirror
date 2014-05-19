From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 25/44] receive-pack.c: use a reference transaction for
 updating the refs
Date: Mon, 19 May 2014 12:02:56 -0700
Message-ID: <CAL=YDWmLgW0b28q5Yqw7R4nobKF5=pcbSpnazC8+EA=QKhkpow@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-26-git-send-email-sahlberg@google.com>
	<537781CA.1010208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 19 21:03:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmSpz-0004Kz-DT
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 21:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbaESTC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 15:02:59 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:62830 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaESTC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 15:02:58 -0400
Received: by mail-vc0-f172.google.com with SMTP id hr9so10097810vcb.17
        for <git@vger.kernel.org>; Mon, 19 May 2014 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qHmpxThdwVxDkBAKhxH+zsoiLCDGg6HW3jiNRLxJXLk=;
        b=OdI8td9VewKve0O6JWSr9vFY4nTtpjoD4HoKizvw+ND4wtstiaUGHBDS4ssdSKIlxr
         mTiv9Eb2dkPoDGndNwrz+yMV0SwxOrAymDUzaJsbIJpWd550J1g5gt87ooOpsj82l+4Q
         XILAKXArqPAOBfJxC/O0rSf1oM6aucOH/j63yCRCQTgsOV0DuK6Gc3QXSc3cOk+f287K
         jx5uoAM69KEh3sW08fV/eQeWg3sbfNUal9qkZqtLvTcOhAIf7eF+rd2NYmUAn8UDXvld
         c4//toO2RcgQ5s+rAEVNGXFMy+ZMSt6LwKWdqtjkS6clkL3bSor39zZNekBZUEvUFiJW
         aEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qHmpxThdwVxDkBAKhxH+zsoiLCDGg6HW3jiNRLxJXLk=;
        b=Yl6VDrXaAjQOXjuTdwZJjUr33FmbXeZKSy/6xFYMSg+uAgz+q2K2iJ0HAY/+z8qyQy
         5vMljgVotCPpdJv9iGKKEsTmIP6oBsy8lKJYe7jB5ApASXb+ARv3FRyrfY0TPasodDS6
         xaaMMk1Ij2UAbfvLKjOAvQ+FYUz/1iFFm8mG3Hn3T6MsGI4svLIaKdxc6T53dxW4M9ww
         7WwrU71nZYuKN8QWC/b8c1CGWPbtnVUX3X+EfDFLWpiXCi/6sLkozoVBI0vb4lUneMzP
         o73c5H46DBpu6kTM1XDyhu3bGH1sh57sHqOQXV4vXqPUo7uqJzvoRILwMo7xydyjKXz5
         k/AA==
X-Gm-Message-State: ALoCoQnNuiaIchNKWhV1HegJ4O9xwKmiGhVeO5783X7Hi1ViVc+74gabMRnts7UU7zZ1sP/8ZXLc
X-Received: by 10.220.205.3 with SMTP id fo3mr1881566vcb.57.1400526176993;
 Mon, 19 May 2014 12:02:56 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 12:02:56 -0700 (PDT)
In-Reply-To: <537781CA.1010208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249612>

On Sat, May 17, 2014 at 8:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>> Wrap all the ref updates inside a transaction to make the update atomic.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  builtin/receive-pack.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index c323081..5534138 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>>  static int sent_capabilities;
>>  static int shallow_update;
>>  static const char *alt_shallow_file;
>> +static struct strbuf err = STRBUF_INIT;
>> +static struct ref_transaction *transaction;
>>
>>  static enum deny_action parse_deny_action(const char *var, const char *value)
>>  {
>> @@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>       const char *namespaced_name;
>>       unsigned char *old_sha1 = cmd->old_sha1;
>>       unsigned char *new_sha1 = cmd->new_sha1;
>> -     struct ref_lock *lock;
>>
>>       /* only refs/... are allowed */
>>       if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
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
>>               return NULL; /* good */
>>       }
>>  }
>> @@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
>>       head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
>>
>>       checked_connectivity = 1;
>> +     transaction = ref_transaction_begin();
>>       for (cmd = commands; cmd; cmd = cmd->next) {
>>               if (cmd->error_string)
>>                       continue;
>> @@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
>>                       checked_connectivity = 0;
>>               }
>>       }
>> +     if (ref_transaction_commit(transaction, "push", &err))
>> +             error("%s", err.buf);
>> +     ref_transaction_free(transaction);
>> +     strbuf_release(&err);
>>
>>       if (shallow_update && !checked_connectivity)
>>               error("BUG: run 'git fsck' for safety.\n"
>>
>
> This patch is strange, because even if one ref_transaction_update() call
> fails, subsequent updates are nevertheless also attempted, and the
> ref_transaction_commit() is also attempted.  Is this an officially
> sanctioned use of the ref_transactions API?  Should it be?

I think it should be supported. Because otherwise, unless you have the
entire transaction localized in a single block you would end up having
to check and recheck the return value everywhere.

It makes the API much easier to use if you can continue calling
transaction functions even after the transaction has failed. If the
transaction has already failed then _update/_create/_delete will do
nothing except return an error.

If _commit is called on a failed transaction then the commit will fail
with an error
and do nothing.


I think it is convenient, and it allows things like :

struct ref_transaction *transaction;
void foo()
{
   ...
   ref_transaction_update(transaction, ... , &err);
   ...
}


transaction = ref_transaction_begin(&err);
... doing stuff and call things that eventually ends up calling foo,
possible multiple times ...
ret = ref_transaction_commit(transaction, &err);


In foo() we ignore checking the return value so we will not see/care
if it failed. IF it fails however it will mark the transaction as
failed and update &err. (Note that this can not yet happen since
_update can not really fail, ever, but the next series will introduce
_update failures when we move locking there.)

Instead we can depend on that IF _update failed, then the call to
_commit will fail too and &err is already updated so we can defer any
checking for errors until _commit time.

This will make the API much more convenient for use cases where you
begin/commit the transaction in one function but the calls to
_update/_delete/_create are somewhere else, possible many function
calls away.
It does not mean that a caller must ignore the return value from
ref_transaction_update, just that the caller can do so and defer
checking for errors until later when it would be more convenient.


Please see current:
https://github.com/rsahlberg/git/tree/ref-transactions
and patch:
refs.c: add transaction.status and track OPEN/CLOSED/ERROR


  It might be
> a way to give feedback to the user on multiple attempted reference
> updates at once (i.e., address my comment about the last patch).
>
> If this is sanctioned, then it might be appropriate for the transaction
> to keep track of the fact that one or more reference updates failed, and
> when *_commit() is called to fail the whole transaction.

Yes. I updated refs.h to indicate that you can continue using
_update/_create/_delete even if a previous call has failed but that
these calls will now just return an error.

This does mean that on the first update that fails for a ref we fail
the transaction and abort any further _update calls to fail
immediately so if there would be additional refs that would fail we
would not log this. I think this is what we want to do since once we
have had a ref update fail it would be really hard to determine if the
next failure was just a side effect of the first failure or not.


>
> In any case, I think it is important to document, as part of the API
> docs, whether this is sanctioned or not, and if so, what exactly are its
> semantics.
>
> I've run out of time for today so I'm going to have to stop here.  FWIW
> patches 01-23 looked OK aside from the comments that I have made.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
