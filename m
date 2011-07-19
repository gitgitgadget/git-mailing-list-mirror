From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/17] revert: Propogate errors upwards from do_pick_commit
Date: Tue, 19 Jul 2011 15:39:29 +0530
Message-ID: <CALkWK0ntcPR5y6m3O6SoTc_8B3xi4dsKFs6zFMJrcwOtRQoQbA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-6-git-send-email-artagnon@gmail.com> <20110712173220.GA14120@elie>
 <CALkWK0=6A=2z5BShsiHeMCS2Movn+L3V4P1WJTTQ-HexTasAhg@mail.gmail.com> <20110717165904.GA27787@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 12:10:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj7FU-0002Re-HA
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 12:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688Ab1GSKJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 06:09:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49123 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab1GSKJu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 06:09:50 -0400
Received: by wyg8 with SMTP id 8so2661142wyg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aAkKAR2T8QnEvqMI0GBXE9kD7Xz9OVJWnUbpDvflTBE=;
        b=FK32YuA1atVwQciFpaVG/ok9SorMIyK7QyCR+r3NUAoGFg4Vnvnf6N266huCYVfJeR
         pPOruH/2rkqx+2xBq1GZ2lTiydn4OwnPOvyCLCNQxkN7IggMdLSrV6tLBsVARxssVc22
         kr0Hew9P2pLghZFEbr6DEdqkAXuPRNyQl+QmM=
Received: by 10.216.70.14 with SMTP id o14mr6942490wed.111.1311070189271; Tue,
 19 Jul 2011 03:09:49 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 03:09:29 -0700 (PDT)
In-Reply-To: <20110717165904.GA27787@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177448>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> revert: Propogate errors upwards from do_pick_commit
>>
>> Currently, revert_or_cherry_pick can fail in two ways. =C2=A0If it
>> encounters a conflict, it returns a positive number indicating the
>> intended exit status for the git wrapper to pass on; for all other
>> errors, it calls die(). =C2=A0The latter behavior is inconsiderate t=
owards
>> callers, as it denies them the opportunity to do some post-processin=
g
>> or cleanup before exiting. =C2=A0For instance, later in the series, =
callers
>> will want to save some data about the current operation before
>> exiting.
>
> Thanks for explaining. =C2=A0Why can't callers use set_die_routine() =
or
> atexit()? =C2=A0Is the last sentence true?

Definitely a misguided commit message.
New commit message.

revert: Propogate errors upwards from do_pick_commit

Currently, revert_or_cherry_pick can fail in two ways.  If it
encounters a conflict, it returns a positive number indicating the
intended exit status for the git wrapper to pass on; for all other
errors, it calls die().  The latter behavior is inconsiderate towards
callers, as it denies them the opportunity to recover from errors and
do other things.

After this patch, revert_or_cherry_pick will still return a positive
return value to indicate an exit status for conflicts as before, while
for some other errors, it will print an error message and return -1
instead of die()-ing.  The cmd_revert and cmd_cherry_pick are adjusted
to handle the fatal errors by die()-ing themselves.

While the full benefits of this patch will only be seen once all the
"die" calls are replaced with calls to "error", its immediate impact
is to change some "fatal:" messages to say "error:" and to add a new
"fatal: cherry-pick failed" message at the end when the operation
fails.

> =C2=A0Since no callers take advantage of the ability to recover from
> =C2=A0errors yet, it is possible and even likely that these functions=
 do
> =C2=A0not completely clean up after themselves on (fatal) error but l=
eave
> =C2=A0some state to be cleared away by exit(). =C2=A0Callers beware!
>
> That last paragraph summarizes my worry. =C2=A0Since this API change =
does
> not seem to be used by the other patches, I would prefer not to
> leave such a trap for unwary new callers, at least until the intended
> legitimate use is a little clearer.

Very legitimate.  Thanks for explaining.  However, I don't think I've
introduced any new traps for callers except for the
write_cache_as_tree() thing which is fixed now -- so, I've omitted
your warning in the commit message because I'm not entirely sure it's
true.  Yes, we don't have callers that take advantage of this yet, but
the idea of the patch is to work in the right direction -- we have to
convert all the "die" calls to "error" calls and make a nice public
API out of it sometime in the future.

Also, should we worry about it so much at this stage? We haven't set
up a public API

>>> write_cache_as_tree() locks the index and does not always commit or
>>> roll it back except on success. =C2=A0Current callers aren't likely=
 to try
>>> to lock the index again (since they just die()), but presumably the
>>> goal of returning error() here is to allow for callers that want to
>>> stay alive and do something more. =C2=A0How should they recover (i.=
e., what
>>> is the intended API)?
>>
>> Hm, there was supposed to be a discard_cache() before this error as =
I
>> recall -- fixed now. =C2=A0Thanks for catching.
>
> discard_index() does not unlock the index.

Ugh, sorry.  I realize now that you were talking about the lockfile,
which will only be cleaned up by exit().  I thought about this for a
while and decided to classify this as an unrecoverable error for the
moment -- we have no way to clean up the lockfile at this stage, so
might as well die() instead of setting a trap for callers.

>>> Similar questions probably apply to calls to other APIs that return=
 -1
>>> to mean "I failed; please print an appropriate message about that a=
nd
>>> exit". =C2=A0I haven't checked carefully, since the answer to this =
example
>>> could help in knowing what to look for in the others.
>>
>> I think the others are fairly clear actually.
>
> Roughly speaking, there are two kinds of functions that return error(=
)
> instead of die()-ing in the git codebase:
>
> =C2=A01. Those that recover from their errors, leaving the process in=
 a
> =C2=A0 =C2=A0sane state that allows the caller (e.g., a long-lived in=
teractive
> =C2=A0 =C2=A0porcelain) to go on to do other things
>
> =C2=A02. Those that do not have enough information to give a useful e=
rror
> =C2=A0 =C2=A0message themselves, so delegate to the caller the respon=
sibility
> =C2=A0 =C2=A0to die() with an error message about where in the progra=
m the
> =C2=A0 =C2=A0failure occured.
>
> The commit message suggests that you are introducing a new category:
>
> =C2=A03. Those that could die() without trouble, _except_ that some c=
allers
> =C2=A0 =C2=A0want to do cleanup of private state on exit and atexit()=
 is not
> =C2=A0 =C2=A0working for them for some reason

Thanks for the excellent categorization -- this change falls mostly in
category (1), and a little bit in (2) too.  When we work towards a
general sequencer, do_pick_commit has no idea about the name of git
wrapper that invoked it ("git cherry-pick" or "git revert" in this
case).  Thinking about these things helped me write a better commit
message.

Thanks.

-- Ram
