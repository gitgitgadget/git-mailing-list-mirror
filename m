From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v10 25/44] receive-pack.c: use a reference transaction for
 updating the refs
Date: Fri, 23 May 2014 09:14:25 -0700
Message-ID: <CAL=YDWkDSF1WWhZAt-nW8RUAjm+iBmg+=p8hq6GJAzF-3-WxGg@mail.gmail.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
	<1400261852-31303-26-git-send-email-sahlberg@google.com>
	<537781CA.1010208@alum.mit.edu>
	<CAL=YDWmLgW0b28q5Yqw7R4nobKF5=pcbSpnazC8+EA=QKhkpow@mail.gmail.com>
	<537F51F9.5070600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 23 18:14:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wns75-0004f0-P5
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 18:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbaEWQO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 12:14:28 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:39479 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaEWQO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 12:14:27 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so6465003veb.6
        for <git@vger.kernel.org>; Fri, 23 May 2014 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HWS6Vw1VzozF3syRjgZUVrKlDU1l9JuTO0biFh1Emo0=;
        b=ir02fi31uu7hXLBvZ7zzfCN0vSnFrX7hS99HoFi8JUhWSWgQmUKQlRQJZu7GAvW725
         teuezwEyg1iNgZtr8WrYbKU4tdji24uX5oZTb1RDSR27S+U/Y1HjTXXRZ1iUanTv/kAD
         Miug65I2JjBPHJSg8MyPOn5k0tDcuxKqqHk1d9QNAH6JzjmBir/dqqaAMmwWu7AyQ/vW
         wQbFUmFjcL+Lkingjpr+OqITaMl+cMzvS6YVP+6vA+JElFIj/xzgbIzkvovwXrbIOvEB
         4rj7K8YJtcIFyix+kh8qB2HjR8Mpv+s6ozHIQcXSCEa1vDmWXbNLcvpCG+hClG5+JbgA
         XmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HWS6Vw1VzozF3syRjgZUVrKlDU1l9JuTO0biFh1Emo0=;
        b=EAadbPvqAenjld+vl8s/pieyGbKLDWu3As0ooiXKUeeN5VfnAVnOtizjVN4EPb5KQn
         2Qu8wL6eJ5JT2tEeK92SxfZtiT2lGWNFkXJsacNfWtt/+g6j8JRSblGTY25dFC1vSbB6
         bpwjyeFeAtfsg/q9Yqv0XJ9Bn+9WyrAvp60RdBoZTWVabazHvPzQkpJG5DKOWmhoz7+b
         Z1RY9lsJp1059t/18uGumCtY7nwXp4fpyV3qbGw58eNtHlLsRIs+wRxqUTLrjRRkvPxh
         taQDUHY4EIpwkBxFpJh5EfXTzjootUICfX6KhdNnsnyLQ6yMhaE8jdNPr3VsAyNfOfTs
         wA2g==
X-Gm-Message-State: ALoCoQlczzC7aphzRuOSZ/BcdjWtdRgdCr/vsCOA71NRhpnPwVbvYiClTNvJyjz37n5ANOr+VTTc
X-Received: by 10.58.56.71 with SMTP id y7mr5092747vep.24.1400861666057; Fri,
 23 May 2014 09:14:26 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 23 May 2014 09:14:25 -0700 (PDT)
In-Reply-To: <537F51F9.5070600@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249993>

On Fri, May 23, 2014 at 6:49 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/19/2014 09:02 PM, Ronnie Sahlberg wrote:
>> On Sat, May 17, 2014 at 8:35 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
>>>> Wrap all the ref updates inside a transaction to make the update atomic.
>>>>
>>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>>> ---
>>>>  builtin/receive-pack.c | 20 ++++++++++----------
>>>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>>>> index c323081..5534138 100644
>>>> --- a/builtin/receive-pack.c
>>>> +++ b/builtin/receive-pack.c
>>>> @@ -46,6 +46,8 @@ static void *head_name_to_free;
>>>>  static int sent_capabilities;
>>>>  static int shallow_update;
>>>>  static const char *alt_shallow_file;
>>>> +static struct strbuf err = STRBUF_INIT;
>>>> +static struct ref_transaction *transaction;
>>>>
>>>>  static enum deny_action parse_deny_action(const char *var, const char *value)
>>>>  {
>>>> @@ -475,7 +477,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>>>       const char *namespaced_name;
>>>>       unsigned char *old_sha1 = cmd->old_sha1;
>>>>       unsigned char *new_sha1 = cmd->new_sha1;
>>>> -     struct ref_lock *lock;
>>>>
>>>>       /* only refs/... are allowed */
>>>>       if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
>>>> @@ -580,15 +581,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>>>>                   update_shallow_ref(cmd, si))
>>>>                       return "shallow error";
>>>>
>>>> -             lock = lock_any_ref_for_update(namespaced_name, old_sha1,
>>>> -                                            0, NULL);
>>>> -             if (!lock) {
>>>> -                     rp_error("failed to lock %s", name);
>>>> -                     return "failed to lock";
>>>> -             }
>>>> -             if (write_ref_sha1(lock, new_sha1, "push")) {
>>>> -                     return "failed to write"; /* error() already called */
>>>> -             }
>>>> +             if (ref_transaction_update(transaction, namespaced_name,
>>>> +                                        new_sha1, old_sha1, 0, 1, &err))
>>>> +                     return "failed to update";
>>>>               return NULL; /* good */
>>>>       }
>>>>  }
>>>> @@ -812,6 +807,7 @@ static void execute_commands(struct command *commands,
>>>>       head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
>>>>
>>>>       checked_connectivity = 1;
>>>> +     transaction = ref_transaction_begin();
>>>>       for (cmd = commands; cmd; cmd = cmd->next) {
>>>>               if (cmd->error_string)
>>>>                       continue;
>>>> @@ -827,6 +823,10 @@ static void execute_commands(struct command *commands,
>>>>                       checked_connectivity = 0;
>>>>               }
>>>>       }
>>>> +     if (ref_transaction_commit(transaction, "push", &err))
>>>> +             error("%s", err.buf);
>>>> +     ref_transaction_free(transaction);
>>>> +     strbuf_release(&err);
>>>>
>>>>       if (shallow_update && !checked_connectivity)
>>>>               error("BUG: run 'git fsck' for safety.\n"
>>>>
>>>
>>> This patch is strange, because even if one ref_transaction_update() call
>>> fails, subsequent updates are nevertheless also attempted, and the
>>> ref_transaction_commit() is also attempted.  Is this an officially
>>> sanctioned use of the ref_transactions API?  Should it be?
>>
>> I think it should be supported. Because otherwise, unless you have the
>> entire transaction localized in a single block you would end up having
>> to check and recheck the return value everywhere.
>>
>> It makes the API much easier to use if you can continue calling
>> transaction functions even after the transaction has failed. If the
>> transaction has already failed then _update/_create/_delete will do
>> nothing except return an error.
>
> I agree that it is convenient to be able to keep calling functions
> blindly without worrying that an earlier function call already failed.
> As you point out below, this allows a style of use of the API where you
> choose *not* to check intermediate results at all, and only check
> whether the final commit succeeds.
>
> Meanwhile, remember the awkwardness in your patch that made fetch use a
> transaction to update the references.  In that case, the switch to using
> a transaction had the big disadvantage that the user would only get an
> error message for the first failing reference update.
>
> When I combine these two lines of thought, it suggests to me that we
> could do a better job of supporting *both* use cases.  What if the
> transaction object contained not an err strbuf but a string_list?  If an
> error occurs while building up the transaction, a message would be added
> to the string list and the function would return an error status.  The
> caller can monitor errors while it is building up the transaction and
> abort immediately if it wants, or it can ignore the return values and
> let the error messages accumulate in the string list.  When the caller
> attempts the commit, it would notice that the transaction failed, and at
> that time the caller could emit *all* of the accumulated error messages
> by reading them out of the string list; e.g.,
>
>     Error fetching from $REMOTE:   <- this is generated by caller
>         $ERR[0]    <- these come from the error string list,
>         $ERR[1]       printed with indentation by caller
>         $ERR[2]
>         $ERR[3]
>
> This style would have another advantage: we might have some back ends
> for which transactions have a high overhead.  Such a back end would
> probably choose not to do any checks while the transaction is being
> built up, e.g., to avoid a round-trip to a database.  When commit() is
> called, it would learn about all of the errors at once.  (1) It would
> need a way to return all of the errors to the caller.  (2) It would be
> nice for the caller to be able to treat such a back end the same as it
> treats a back end that is able to report errors immediately.  It seems
> to me that having a way to report multiple errors at the same time would
> solve both problems nicely.

Inretesting.
That would mean changing all functions to take a string_list provided
by the caller instead of a strbuf.
And then have _update/_create/_delete do actual work instead of
bailing out after the first error.

Users that want to check for error and log after each call to
_update/_create/_delete could do so and
just use the last entry added to the string list or otherwise they
could just wait until _commit time and if it fails log
all the strings.


>
>> If _commit is called on a failed transaction then the commit will fail
>> with an error and do nothing.
>>
>> I think it is convenient, and it allows things like :
>>
>> struct ref_transaction *transaction;
>> void foo()
>> {
>>    ...
>>    ref_transaction_update(transaction, ... , &err);
>>    ...
>> }
>>
>>
>> transaction = ref_transaction_begin(&err);
>> ... doing stuff and call things that eventually ends up calling foo,
>> possible multiple times ...
>> ret = ref_transaction_commit(transaction, &err);
>>
>>
>> In foo() we ignore checking the return value so we will not see/care
>> if it failed. IF it fails however it will mark the transaction as
>> failed and update &err. (Note that this can not yet happen since
>> _update can not really fail, ever, but the next series will introduce
>> _update failures when we move locking there.)
>>
>> Instead we can depend on that IF _update failed, then the call to
>> _commit will fail too and &err is already updated so we can defer any
>> checking for errors until _commit time.
>>
>> This will make the API much more convenient for use cases where you
>> begin/commit the transaction in one function but the calls to
>> _update/_delete/_create are somewhere else, possible many function
>> calls away.
>> It does not mean that a caller must ignore the return value from
>> ref_transaction_update, just that the caller can do so and defer
>> checking for errors until later when it would be more convenient.
>>
>>
>> Please see current:
>> https://github.com/rsahlberg/git/tree/ref-transactions
>> and patch:
>> refs.c: add transaction.status and track OPEN/CLOSED/ERROR
>>
>>
>>   It might be
>>> a way to give feedback to the user on multiple attempted reference
>>> updates at once (i.e., address my comment about the last patch).
>>>
>>> If this is sanctioned, then it might be appropriate for the transaction
>>> to keep track of the fact that one or more reference updates failed, and
>>> when *_commit() is called to fail the whole transaction.
>>
>> Yes. I updated refs.h to indicate that you can continue using
>> _update/_create/_delete even if a previous call has failed but that
>> these calls will now just return an error.
>>
>> This does mean that on the first update that fails for a ref we fail
>> the transaction and abort any further _update calls to fail
>> immediately so if there would be additional refs that would fail we
>> would not log this. I think this is what we want to do since once we
>> have had a ref update fail it would be really hard to determine if the
>> next failure was just a side effect of the first failure or not.
>
> It could be that errors cascade, for example if I update reference R to
> value A, then (maybe a few steps later) verify that R has value A.  If
> the update fails, then the verify will also fail.  But it would be silly
> for our code to generate such a sequence of operations.  And if that
> sequence of operations came from the user (e.g., from "git update-ref
> --stdin"), it would be pretty churlish of the user to complain that we
> report two errors.  So I don't think your "side effect" worry is a
> problem in practice.

If we accept that users could do bad things causing cascading errors
to be logged
and that the user is to blame for the cascading errors in the logged
output, then I
am fine with doing these changes you suggest.

I will try this change today and see what it looks like.
