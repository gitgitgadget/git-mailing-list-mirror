From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 16/17] revert: Introduce --reset to remove sequencer state
Date: Sun, 17 Jul 2011 22:40:51 +0530
Message-ID: <CALkWK0mfNNfpyyMDFgVD_gnEC7OxHuPAPc+27-PepYNKPOR8-w@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-17-git-send-email-artagnon@gmail.com> <20110712203011.GF14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 19:11:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiUs9-0003K5-UR
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 19:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab1GQRLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 13:11:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59512 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1GQRLM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 13:11:12 -0400
Received: by wwe5 with SMTP id 5so2561371wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uXEALEiuhYuJixmrvko74MOLKTFFsJZXzNZ8D8cEUPY=;
        b=RcWe8x/ICRK7yFKdWO/b4Hie5y7pjfHqbrO3TpXF0aSOVakON+VLLFyTNf5cToqbEg
         jr6wUAuMz3LMrRXaz2sjZrPTNvSYdQjpGCp4IblrqQ2G0s3qR4qY17ZoR8Ah7IAc9nra
         afYMqcya1VP8Tq+aSz80XTTq49YA/xq9Ea9Fs=
Received: by 10.216.9.134 with SMTP id 6mr2299661wet.111.1310922671098; Sun,
 17 Jul 2011 10:11:11 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 10:10:51 -0700 (PDT)
In-Reply-To: <20110712203011.GF14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177307>

Hi,

On Wed, Jul 13, 2011 at 2:00 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Ramkumar Ramachandra wrote:
>> Protect the sequencer state from accidentally being stomped by a new
>> cherry-pick or revert invocation by ensuring that an existing one
>> isn't in progress.
>
> I first read this as "an existing sequencer state isn't in progress".
> But anyway, if I understand correctly the goal isn't to protect the
> sequencer state from corruption but to protect the user from forgetti=
ng
> about a pending cherry-pick.
>
>> While this patch would normally be expected to
>> break many tests, the earlier patches "reset: Make hard reset remove
>> the sequencer state" and "revert: Remove sequencer state when no
>> commits are pending" make sure that they don't.
>
> Why would I expect a nice change to break tests?
>
> I suppose you mean: "A naive version of this would break the followin=
g
> established way of working:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick X; # has conflicts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard; # no, no!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick Y
>
> Or even:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick X; # has conflicts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# ... resolve ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick Y
>
> But a previous patch takes care of that by making "git reset --hard"
> cancel the pending cherry-pick and by making "git commit" clean up
> after a pending cherry-pick when making the commit that would finish
> it."
>
> The above text quoted with ">" describes the main impact of the
> change. =C2=A0The subject line, on the other hand, describes a less
> important part:
>
>> [Subject: revert: Introduce --reset to remove sequencer state]
>
> Is that fixable? =C2=A0Maybe this could be split into two patches (si=
nce it
> does two different things), or maybe the subject line could be tweake=
d
> to describe both.

New commit message.

revert: Don't clobber sequencer state; introduce --reset

Protect the user from forgetting about a pending operation by
immediately erroring out when an existing cherry-pick or revert
operation is in progress.  A naive version of this would break the
following established ways of working:

$ git cherry-pick foo
=2E.. conflict ...
$ git reset --hard  # I actually meant "moo" when I said "foo"
$ git cherry-pick moo

$ git cherry-pick foo
=2E.. conflict ...
# resolve the conflict
$ git commit # commit the resolution
$ git cherry-pick moo # New operation

But the previous patches "reset: Make hard reset remove the sequencer
state" and "revert: Remove sequencer state when no commits are
pending" make sure that this does not happen.

To explicitly remove the sequencer state for a fresh cherry-pick or
revert invocation, introduce a new subcommand called '--reset' which
really removes the sequencer state on the very first invocation.

>> Ensure that the "rebase -i" script which invokes cherry-pick or reve=
rt
>> doesn't change its behavior by using '--reset' to to clear the state
>> after every failed pick.
>
> This should be avoidable by noticing that commands like "rebase -i"
> use GIT_CHERRY_PICK_HELP to clobber our nice instructions about how t=
o
> resume a cherry-pick anyway and therefore are unlikely to need
> cherry-pick --continue/--abort facilities, no?

Right.  Removed hunk and corresponding segment in commit message.

Thanks.

-- Ram
