From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/17] revert: Propogate errors upwards from do_pick_commit
Date: Sun, 17 Jul 2011 16:16:08 +0530
Message-ID: <CALkWK0=6A=2z5BShsiHeMCS2Movn+L3V4P1WJTTQ-HexTasAhg@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-6-git-send-email-artagnon@gmail.com> <20110712173220.GA14120@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 12:46:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiOs1-0003Rz-0r
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 12:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562Ab1GQKqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 06:46:30 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1GQKq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 06:46:29 -0400
Received: by wwe5 with SMTP id 5so2411937wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e6lJfpRyXCDtZi35/jotlA8nVM0XlnppsTisriIvo3o=;
        b=nuLx4YaVm/Qw6TUSpDNNkky8RNo/UJ2YdO6AHKKG65Tm4IIAhK7FeFocm23rmdgUYC
         CzUbWSx1u9G3tEXpbFMhPqDGAGEK7jaV+Srzz9MsFxYEqKpmTMwpW8nHuWh9mKz2b++h
         elAVUP8H0i4dTRPgDq0Hx7R5BvXf+6Mu1klyE=
Received: by 10.216.175.206 with SMTP id z56mr330048wel.66.1310899588376; Sun,
 17 Jul 2011 03:46:28 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 03:46:08 -0700 (PDT)
In-Reply-To: <20110712173220.GA14120@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177294>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Currently, the return value from revert_or_cherry_pick is a
>> non-negative number representing the intended exit status from `git
>> revert` or `git cherry-pick`. =C2=A0Change this by replacing some of=
 the
>> calls to "die" with calls to "error", so that it can return negative
>> values too. =C2=A0Postive return values indicate conflicts, while ne=
gative
>> ones indicate other errors. =C2=A0This return status is propogated u=
pdwards
>> from do_pick_commit, to be finally handled in cmd_cherry_pick and
>> cmd_revert.
>
> As mentioned at [1], this accurately describes the effect, but not th=
e
> motivation. =C2=A0(In tricky cases like this, knowing the motivation =
would
> help with review immensely.)

Sorry, I should have done this earlier.  Does this look alright?

revert: Propogate errors upwards from do_pick_commit

Currently, revert_or_cherry_pick can fail in two ways.  If it
encounters a conflict, it returns a positive number indicating the
intended exit status for the git wrapper to pass on; for all other
errors, it calls die().  The latter behavior is inconsiderate towards
callers, as it denies them the opportunity to do some post-processing
or cleanup before exiting.  For instance, later in the series, callers
will want to save some data about the current operation before
exiting.

Change this by replacing some of the calls to "die" with calls to
"error", so that revert_or_cherry_pick can return negative values too.
While postive return values indicate conflicts as before, negative
ones indicate other errors.  This return status is propogated updwards
from do_pick_commit, to be finally handled in cmd_cherry_pick and
cmd_revert.

In the same spirit, also introduce a new function error_dirty_index,
based on die_dirty_index, which prints some hints and returns an error
to its caller do_pick_commit.

While the full benefits of this patch will only be seen once all the
"die" calls are replaced with calls to "error", its immediate impact
is to change some of the "fatal:" messages to "error:" messages and
print a new "fatal: cherry-pick failed" message when the operation
fails.


>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
> [...]
>> @@ -373,12 +368,12 @@ static int do_pick_commit(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* to work on.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_cache_as_=
tree(head, 0, NULL))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die (_("Your index file is unmerged."));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return error(_("Your index file is unmerged."));
>
> write_cache_as_tree() locks the index and does not always commit or
> roll it back except on success. =C2=A0Current callers aren't likely t=
o try
> to lock the index again (since they just die()), but presumably the
> goal of returning error() here is to allow for callers that want to
> stay alive and do something more. =C2=A0How should they recover (i.e.=
, what
> is the intended API)?

Hm, there was supposed to be a discard_cache() before this error as I
recall -- fixed now.  Thanks for catching.

> Similar questions probably apply to calls to other APIs that return -=
1
> to mean "I failed; please print an appropriate message about that and
> exit". =C2=A0I haven't checked carefully, since the answer to this ex=
ample
> could help in knowing what to look for in the others.

I think the others are fairly clear actually.  Let me know if you find
something.

-- Ram
