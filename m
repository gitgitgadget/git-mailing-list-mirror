From: =?ISO-8859-1?Q?Philip_J=E4genstedt?= <philip@foolip.org>
Subject: Re: Working with remotes with (too) many branches
Date: Tue, 21 Feb 2012 23:36:25 +0100
Message-ID: <CAKHWUkY_bEtKoPOiWFz6i2bp-tbekapROOaCYR0k5Ymh0HYMdA@mail.gmail.com>
References: <CAKHWUka763XRWyMz2Xq1qQ2rfKqSYdTX0xtdVFm8zWJ_+6tGqA@mail.gmail.com>
 <7v7gzipkt8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzyKK-0003so-7T
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab2BUWgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 17:36:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45770 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab2BUWgq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 17:36:46 -0500
Received: by vbjk17 with SMTP id k17so4513705vbj.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 14:36:46 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.52.24.70 as permitted sender) client-ip=10.52.24.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.52.24.70 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.52.24.70])
        by 10.52.24.70 with SMTP id s6mr13057746vdf.47.1329863806080 (num_hops = 1);
        Tue, 21 Feb 2012 14:36:46 -0800 (PST)
Received: by 10.52.24.70 with SMTP id s6mr10617316vdf.47.1329863805966; Tue,
 21 Feb 2012 14:36:45 -0800 (PST)
Received: by 10.52.178.193 with HTTP; Tue, 21 Feb 2012 14:36:25 -0800 (PST)
In-Reply-To: <7v7gzipkt8.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQnmtBb8CLFjLz1IFE3w+gKgeVaufFoYPXZhwVHpWxleHC/cr5FoBB9fhqkShn5+D41BSR/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191193>

On Sun, Feb 19, 2012 at 22:36, Junio C Hamano <gitster@pobox.com> wrote=
:
> Philip J=E4genstedt <philip@foolip.org> writes:
>
>> 1. If I make a typo with remote set-branches, fetch will fail with
>> "fatal: Couldn't find remote ref refs/heads/typotopic" and not fetch
>> anything at all.
>
> At that point you can notice the earlier typo and remove or fix the f=
etch
> refspec you have.
>
> Alternatively, set-branches could run ls-remote against the remote an=
d
> notice that there is no such branch over there. However, even if you =
got
> the branch name right when you did "set-branches", you would still se=
e the
> same "Couldn't find" when the branch gets removed over there, so you =
would
> need a way to remove or fix the fetch refspec you have *anyway*.
>
> So, assuming that there is no easy way to remove one branch from the =
set
> of branches tracked from a given remote, it is much more important to=
 add
> such a way. =A0Checking against a typo when "set-branches" is run is =
"nicer
> to have" but lack of it is not a show-stopper.
>
> Wouldn't "git config --unset remote.origin.fetch '/typotopic'" be
> sufficient in the meantime even if a user fears "vi .git/config"?

Yeah, one can recover if one knows what config "set-branches" maps to,
but I'd like this to be less error-prone so that I can recommend it to
others suffering from branch explosion. Tab completion and
"set-branches --remove" is probably a good start.

>> 2. If I forget that I've previously worked with footopic and
>> set-branches --add it again, I'll get a duplicate line in my config.
>
> I do not know the duplicate hurts anything, but I agree that it would=
 be
> more aescetically pleasing if "--add" noticed what you already had an=
d
> avoided duplicates.

Right, it's not worthwhile by itself, but something to consider if
implementing --delete.

>> 3. When I don't care about footopic anymore, there's no clear way to
>> stop fetching it and remove refs/remotes/main/footopic.
>
> Isn't the lack of "set-branches --delete" the same as #1 above?

Kind of, several of these points can be solved by the same fixes.

> The
> latter would be "branch -r -d main/footopic" but I could imagine
> "set-branches --delete" would do that for you once implemented.

Letting "set-branches --delete" manage this per-branch would be nice, I=
 agree.

Would it be wrong, though, if "fetch --prune" and "remote prune"
simply pruned all refs under refs/remotes/main/ that were not fetched?
It seems to me that if one starts out with all branches and then
"set-branches main footopic", one really does want all other refs to
go away on the next fetch.

>> 4. If set-branches --delete existed one could end up with no fetch
>> lines in the remote config, at which point fetch falls back to
>> fetching HEAD, instead of the expected nothing.
>
> Don't do that, then ;-)
>
> I could imagine a new preference "fetch.$remote.default=3Dnothing" th=
at
> causes "git fetch" to fail with "You have fetch.$remote.default=3Dnot=
hing
> set, so I am not fetching anything from there without any configured
> refspec". =A0The default would be fetch.$remote.default=3DHEAD, I wou=
ld guess.
>
> The preference can be set automatically when you use "set-branches"
> without "--add" for a given remote, as use of "set-branches" is a cle=
ar
> indication that you want to deviate from the built-in default behavio=
ur
> when interacting with that remote.

That sounds like a good idea. To make sure that I understand the
notation, the actual config would look something like this:

[remote "origin"]
	url =3D git://github.com/gitster/git.git
	# no fetch, it was removed

[fetch "origin"]
	default =3D nothing

This looks a bit odd to me, shouldn't the new setting file under
[remote "origin"]?

>> I'd appreciate feedback on these issues so that I don't waste time
>> trying to patch the wrong problems. Suggestions for an alternative
>> work flow is of course also most welcome!
>
> Admittedly I wouldn't use "set-branches" myself (it is far easier to =
tweak
> with "vi .git/config", and I wasn't involved in), but looking at the =
whole
> history of the feature with "git log --grep=3Dset-branch builtin/remo=
te.c",
> I have a feeling that not many people used, cut by its still-unrounde=
d
> edges, and polished the subcommand by rounding them out yet, and it h=
as a
> large room for improvement.

That was my impression as well.

> It would have saved you time to wait for a round-trip if you did the =
above
> "git log" yourself to find out from whom this subcommand came from, a=
nd
> looked at list archive to see if the original author is still active =
here
> (in this case he is), and Cc'ed him before posting the message I am
> responding to.

Thanks for the tip. (I did look at the original commit and search the
archives, but found no answers.)

--=20
Philip J=E4genstedt
