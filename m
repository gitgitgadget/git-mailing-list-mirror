From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 04/31] am: implement patch queue mechanism
Date: Fri, 19 Jun 2015 20:49:29 +0800
Message-ID: <CACRoPnSVWNOPPJAhJS1S-HbHUEVJ1p_jz-dnFmuk8Hh1NaMLwg@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-5-git-send-email-pyokagan@gmail.com>
	<xmqq7fr0eoho.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 14:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5vjn-0002Jb-W6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 14:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbbFSMtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 08:49:32 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33670 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbbFSMta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 08:49:30 -0400
Received: by laka10 with SMTP id a10so73529277lak.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I8AYzWhqDlzz4AZr659Oly2kEZp+y7A9Z+kd4yC8pPY=;
        b=HPnXfd2gTLBuax3mfHeRlXBlW7Hy8JyDq2isARPjnP4Iuvb4s2kHYATtCU+jZJcaWe
         z0mXpVwtvcBYkWV6Nf6v2klFyJqBsca+kwhWD7flj2rzroCgmkt0PO7p34DCXuPAloq5
         7eMZdOmVeQ+li4nH1YpyxtwDXtSB5jpDuJT1F5Qtz5QtXLTOKI/xecWoz7tSxcMmVIkc
         T6b5oiA5bVcEhbeDmg+hVXV0bOXV3ich4qfraGBgPTRau8yYDGIKSZyOYRFr8+2WVRN1
         kmXA3ET8PXxeYKfPw+KDpsCryGN8dyvRszskwqgMN3+HNxUtahQyZ20PIti8fyYRiE7r
         sY+A==
X-Received: by 10.112.199.133 with SMTP id jk5mr18122699lbc.32.1434718169174;
 Fri, 19 Jun 2015 05:49:29 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 19 Jun 2015 05:49:29 -0700 (PDT)
In-Reply-To: <xmqq7fr0eoho.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272133>

On Fri, Jun 19, 2015 at 4:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index dbc8836..af68c51 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -6,6 +6,158 @@
>>  #include "cache.h"
>>  #include "builtin.h"
>>  #include "exec_cmd.h"
>> +#include "parse-options.h"
>> +#include "dir.h"
>> +
>> +struct am_state {
>> +     /* state directory path */
>> +     struct strbuf dir;
>
> Is this a temporary variable you will append "/patch", etc. to form
> a different string to use for fopen() etc., or do you use separate
> strbufs for things like that and this is only used to initialize
> them?
>
>  - If the former then "dir" is a misnomer.
>
>  - If the latter, then it probably does not have to be a strbuf;
>    rather, it should probably be a "const char *".  Unless you pass
>    this directly to functions that take a strbuf, such as
>    remove_dir_recursively(), that is.

It's the latter, and yes it does not need to be an strbuf since it
will not usually change.

However, I don't think it should be a const char*, as it means that
the API user has to keep track of the lifetime of the "dir" string.
Note that we will have to git_pathdup() as git_path() returns a static
buffer:

char *dir = git_pathdup("rebase-apply");
struct am_state state;
am_state_init(&state);
state.dir = dir;
...stuff...
if (foo) {
     ... separate code path ...
     am_state_release(&state);
     free(dir);
     return 0;
}
... separate code path ...
am_state_release(&state);
free(dir);
return 0;

Note the additional memory bookkeeping.

Instead, I would rather the am_state struct take ownership of the
"dir" string and free it in am_state_release(). So dir will be a
char*:

struct am_state state;
am_state_init(&state, git_path("rebase-apply"));
... stuff ...
if (foo) {
     ... separate code path ...
     am_state_release(&state);
     return 0;
}
... separate code path ...
am_state_release(&state);
return 0;

>> +/**
>> + * Release memory allocated by an am_state.
>> + */
>
> Everybody else in this file seems to say "Initializes", "Returns",
> "Reads", etc.  While I personally prefer to use imperative
> (i.e. give command to this function to "release memory allocated"),
> you would want to be consistent throughout the file; "Releases
> memory" would make it so.

OK

>> +/**
>> + * Setup a new am session for applying patches
>> + */
>> +static void am_setup(struct am_state *state)
>> +{
>> +     if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
>> +             die_errno(_("failed to create directory '%s'"), state->dir.buf);
>> +
>> +     write_file(am_path(state, "next"), 1, "%d", state->cur);
>> +
>> +     write_file(am_path(state, "last"), 1, "%d", state->last);
>
> These two lines are closely related pair; drop the blank in between.
>
> I am tno sure if write_file() is an appropriate thing to use,
> though.  What happens when you get interrupted after opening the
> file but before you manage to write and close?  Shouldn't we be
> doing the usual "write to temp, close and then rename to final"
> dance?  This comment applies to all the other use of write_file().

We could, although I don't think it would help us much. The state
directory is made up of many different files, so even if we made
modifications to single files atomic, there's no point if we terminate
unexpectedly in the middle of writing multiple files to the state
directory as the state, as a whole, is corrupted anyway.

So, we must be able to make updates to the entire state directory as a
single transaction, which is a more difficult problem...

Furthermore, while applying patches, we may face abnormal termination
between e.g. the patch application and commit, so I think it is safe
to say that if abnormal termination occurs, we will not be able to
reliably --resume or --skip anyway, and the user should just run
--abort to go back to the last known state.

However, it would be an improvement if we wrote the "next" and "last"
files last, as we use their presence to determine if we have an am
session in progress or not, so if we terminate in am_setup() we will
just have a stray directory. I will make this change in the next
iteration.

Regards,
Paul
