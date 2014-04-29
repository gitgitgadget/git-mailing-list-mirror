From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] replace.c: use the ref transaction functions for updates
Date: Tue, 29 Apr 2014 14:29:10 -0400
Message-ID: <CAPig+cQ5br8icrUPwP7=zuQnXD4-tNU5rjZ8AWhCWGwT5KegfA@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-13-git-send-email-sahlberg@google.com>
	<CAPig+cSWMK_kyVvaD8QCfZmPu4JVT+nOJZJLteHhDao0umHLbA@mail.gmail.com>
	<CAL=YDWn9TJsygZdgY2gXVBScFjO3zbrbJ5XORc2ZLaY-M8PmSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:29:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfCmK-0003Gd-CS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbaD2S3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 14:29:12 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:50481 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbaD2S3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 14:29:11 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so536617ykp.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ColfbJcKAvD8SCEPCfqwOtA9CYT/Oqbe/iD+wIbvzv4=;
        b=E9ybz+3meItrMp7a0hSN8DCGVZGTto0VJmE9JgW1c+bwG+HZPevHki5qn62lrB1bWi
         E3uYhLhLt++8h/ShmYy7yPmx8QeBj+U3AO8qwzFhU+P4UWbDxQRxagZ/Y4Z//tc9wQDT
         wfGl7Y9p2UHvdRtdC19dBW1+1FAVHBz93mpmC6gV99a9Ss+QGsVm3Xbgyn56YLN2V05D
         8yJ9XsN+3NufAKWAecIrWopb7bNL1fO25mLY1sOWgm0gtEuat0SkZR8iZ+PNFFX02jwg
         /FTNFDdaMrfQ5nmzK7R7Z04ur51YV4KwfssE7T/U91Nccv7d3K/cldPq+NO0bfTlY/Ax
         kmcg==
X-Received: by 10.236.194.169 with SMTP id m29mr5186454yhn.121.1398796150855;
 Tue, 29 Apr 2014 11:29:10 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Tue, 29 Apr 2014 11:29:10 -0700 (PDT)
In-Reply-To: <CAL=YDWn9TJsygZdgY2gXVBScFjO3zbrbJ5XORc2ZLaY-M8PmSw@mail.gmail.com>
X-Google-Sender-Auth: APvvXGRb7KjEp_aYMmKXokW9VGo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247600>

On Tue, Apr 29, 2014 at 12:18 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Mon, Apr 28, 2014 at 5:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>>> Update replace.c to use ref transactions for updates.
>>>
>>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>>> ---
>>>  builtin/replace.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/builtin/replace.c b/builtin/replace.c
>>> index b62420a..b037b29 100644
>>> --- a/builtin/replace.c
>>> +++ b/builtin/replace.c
>>> @@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>>         unsigned char object[20], prev[20], repl[20];
>>>         enum object_type obj_type, repl_type;
>>>         char ref[PATH_MAX];
>>> -       struct ref_lock *lock;
>>> +       struct ref_transaction *transaction;
>>> +       struct strbuf err = STRBUF_INIT;
>>>
>>>         if (get_sha1(object_ref, object))
>>>                 die("Failed to resolve '%s' as a valid ref.", object_ref);
>>> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>>         else if (!force)
>>>                 die("replace ref '%s' already exists", ref);
>>>
>>> -       lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>>> -       if (!lock)
>>> -               die("%s: cannot lock the ref", ref);
>>> -       if (write_ref_sha1(lock, repl, NULL) < 0)
>>> -               die("%s: cannot update the ref", ref);
>>> +       transaction = ref_transaction_begin();
>>> +       if (!transaction ||
>>> +           ref_transaction_update(transaction, ref, repl, prev,
>>> +                                  0, !is_null_sha1(prev)) ||
>>> +           ref_transaction_commit(transaction, NULL, &err))
>>> +               die(_("%s: failed to replace ref: %s"), ref, err.buf);
>>
>> Even though 'err' will be empty after this conditional, would
>> strbuf_release(&err) here be warranted to future-proof it? Today's
>> implementation of strbuf will not have allocated any memory, but
>> perhaps a future change might pre-allocate (unlikely though that is),
>> which would leak here.
>
> I have no strong feelings either way.
> A previous patch got a comment to remove a strbuf_release() because we
> knew in that
> code path that the string would be empty and thus the call was superfluous.

Indeed, I realized later that the reason I gave for possibly adding
the strbuf_release() was effectively bogus. Code throughout the
project ignores strbuff_release() when it is obvious that the strbuf
hasn't been used. Such code looks like this:

func() {
    struct strbuf foo = STRBUF_INIT;
    ...code not touching 'foo'...
    if (...)
        return;
    ...code touching 'foo'...
    strbuf_release(&foo);
}

At the point of early return, it's obvious at a glance that no content
has been added to 'foo'.

It was only a little while ago that I came to understand why the code
in this patch bothered me:

func() {
    struct strbuf foo = STRBUF_INIT;
    if (bar(&foo))
        die(...);
    ...return or fall off end without releasing 'foo'...
}

The problem is that it's not so easy to see that it's safe to "leak"
the strbuf without detouring through the documentation of bar() and
possibly its implementation as well, before finally resuming the
reading of func(). That extra cost of having to study bar() will
likely be paid by most readers of func() who are concerned about the
missing strbuf_release(). The cognitive burden is greater.

> So one for and one against so far.
> I will leave as is until there is more consensus.

Fair enough. The fact that the variable is named 'err' in this case
might be enough to allow one to infer, without detouring through
bar(), that the missing strbuf_release() is intentional.
