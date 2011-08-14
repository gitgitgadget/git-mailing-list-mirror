From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/7] sequencer: Expose API to cherry-picking machinery
Date: Sun, 14 Aug 2011 19:27:18 +0530
Message-ID: <CALkWK0=zqyvL8zo9wvBGUXyf3RWSZB7dY=WaC9TN6YXnThag0Q@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-7-git-send-email-artagnon@gmail.com> <20110814131303.GF18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 15:58:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsbCd-000883-Dg
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 15:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab1HNN5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 09:57:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64986 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab1HNN5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 09:57:39 -0400
Received: by wwf5 with SMTP id 5so4147657wwf.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fnHQU1Zf5eB/qsX7ImjrmdzNPceEHDYrGDY8tkthSO4=;
        b=UXEDmpPwQxJgeGdQLc0S/sFuZVs1+li3s7ehkRk4WfFeHsO/8e4HcjXe9z3xGYS2zm
         68hOO0C3s9eTXc0Z+tTCKqDSL6uVIUnF+SMS7CgHVdvQO/0dq1fPDDdRWcFdEeZsdB7c
         yBcN0iVIC7cg27nPfoQqjf72708Ntmrd2sblY=
Received: by 10.216.160.9 with SMTP id t9mr1234624wek.108.1313330258125; Sun,
 14 Aug 2011 06:57:38 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 06:57:18 -0700 (PDT)
In-Reply-To: <20110814131303.GF18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179325>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Move code from builtin/revert.c to sequencer.c and expose a public A=
PI
>> without making any functional changes. =C2=A0Although it is useful o=
nly to
>> existing callers of cherry-pick and revert now, this patch lays the
>> foundation for future expansion.
>
> :) =C2=A0It sounds like you are running a business.

*laughs* Now that you mention it, it certainly does :)

>> +++ b/sequencer.c
>> @@ -1,13 +1,656 @@
>> [...]
>> +#define COMMIT_MESSAGE_INIT =C2=A0{ NULL, NULL, NULL, NULL, NULL };

I'll get rid of this.

>> +static const char *action_keyword(const struct replay_opts *opts)
>> [...]
>
> Another (non-functional) change. =C2=A0Probably (?) this renaming has=
 a
> good reason to be part of this patch, but it should definitely be
> mentioned in the commit message.

Yes, I want the rename to be part of this patch (see Daniel's comment
and my agreement).  Will clarify in the commit message.

> git_path() calls vsnprintf which clobbers errno, so depending on the
> platform this can print messages like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: Could not open '.git/CHERRY_PICK_HE=
AD' for writing: Success
>
> The natural fix would be to add a local for it (as a separate patch).
> Sorry I missed this when the code first arrived.

Ugh, yet another "bugfix patch" to queue near the beginning of the
series.  Thanks for catching this.

>> +static struct tree *empty_tree(void)
>> [...]
>
> This tree is leaked (for example if you cherry-pick a sequence of
> root commits).

This is not something I introduced -- it can wait until later, no?

>> +static int fast_forward_to(const unsigned char *to, const unsigned =
char *from)
>> [...]
>
> The exit code here violates the usual "exit with status 128 for
> errors other than conflicts" rule. =C2=A0Perhaps it should be changed=
 to
> "return -1" in a separate patch (to accompany the patch that returns
> error() instead of die()-ing so often to allow callers to give
> additional context to errors from this machinery).

Great catch!  Will fix.

>> --- a/sequencer.h
>> +++ b/sequencer.h
> [...]
>> +void sequencer_parse_args(int argc, const char **argv, struct repla=
y_opts *opts);
>
> I thought sequencer_parse_args() wasn't being exposed.

Rebase fail, sorry.  There is no sequencer_parse_args().

> Except where noted above, I hope this is just simple code movement,
> but I haven't checked. =C2=A0If I could be sure, it would be easier t=
o
> review.

It is a simple code movement.  Is there something I can do to help?

-- Ram
