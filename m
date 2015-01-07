From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Wed, 7 Jan 2015 01:28:48 +0100
Message-ID: <CALKQrge3yEfmi26HMbckyw_ONRXUWtZGvz=SqqYaL2sqJaHbUg@mail.gmail.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
	<xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
	<A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 01:31:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8eWF-0005WN-6j
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 01:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbbAGA3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 19:29:18 -0500
Received: from mail13.copyleft.no ([91.220.196.227]:38340 "EHLO
	mail13.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbbAGA3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 19:29:16 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail13.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Y8eUr-0006nk-58
	for git@vger.kernel.org; Wed, 07 Jan 2015 01:29:13 +0100
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Y8eUP-0003WE-Nv
	for git@vger.kernel.org; Wed, 07 Jan 2015 01:28:47 +0100
Received: by mail-pa0-f46.google.com with SMTP id lf10so1092084pab.5
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 16:28:49 -0800 (PST)
X-Received: by 10.66.159.42 with SMTP id wz10mr407011pab.8.1420590529016; Tue,
 06 Jan 2015 16:28:49 -0800 (PST)
Received: by 10.70.105.4 with HTTP; Tue, 6 Jan 2015 16:28:48 -0800 (PST)
In-Reply-To: <A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262117>

On Wed, Jan 7, 2015 at 12:29 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Jan 6, 2015, at 10:25, Junio C Hamano wrote:
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>> So despite the name of the test, the actual tree contents do not seem
>>> to be examined.
>>
>> Yes, but the thing is, thanks to refs/notes restriction, there is no
>> need to do such examination [*1*].
>>
>> Note that it is an entirely different matter when you deliberately
>> violate the expectation using plumbing (e.g. update-ref).  Users of
>> plumbing commands are expected to know what they are doing, so the
>> level of safety we need to give them can be much lower than Porcelain
>> commands such as 'git notes'.
>>
>> But when you stick to Porcelain commands, it is very hard to mix
>> refs/notes/* with refs/heads/* and refs/remotes/* by mistake.  You
>> have to really work on it by doing something unusual to have a non
>> commit in refs/heads/*, a commit in refs/notes/*, or a regular
>> non-note commit in refs/notes/*.

Just injecting my own (probably faulty) memory here: I agree with Junio's
analysis (including his footnote *1*). We figured that it was not possible
to outright forbid non-notes in notes trees (a sufficiently determined user
can always use plumbing commands to create arbitrarily non-well-formed
"notes trees"), so instead we implemented the notes plumbing
(notes.{h,c}) to deal with non-notes somewhat sanely instead (ignoring
them in notes queries, and preserving them across notes manipulations).

As a consequence, the safety features were pushed up into the porcelain
layer (builtin/notes.{h,c} and builtin/notes-merge.{h,c}), where they apply
to ref names instead of actual notes tree contents.

> Perhaps that is the crux of the issue.  There is no git notes-plumbing
> command where the git notes command continues to apply restrictions but the
> vaporware notes-plumbing command allows anything just like update-ref does.

Good observation. From my POV, as people start creating tools that use
notes in a more structured manner (than as free-form plain-text appendages
to commit messages), the sharp and pointy bits (and bugs) of the interface
come into view. This applies to the safety features being discussed in this
thread, but also IMHO to the other things being currently discussed/fixed
in the notes code:

 - adding empty notes
 - adding notes to non-commits in fast-import
 - suboptimal fanout when mixing fast-import
   and git-notes manipulations of notes trees

So far I've approached some of these issues by making/suggesting fairly
modest fixes/extensions to the notes porcelain, to make it more friendly
to these users. I haven't considered that we might at some point be
better off splitting out a separate plumbing command for manipulating
notes. However, I'm not sure we're there, yet. The problems raised so
far do not IMHO warrant the creation of a whole new plumbing command.
Instead, we can still keep fixing and improving 'git notes'.

> I think there are two issues here:
>
> 1) There's no simple way to store remote notes refs outside the refs/notes
> namespace in such a way that they can be used with git notes commands.
>
> 2) People who want to experiment with using git notes storage as a basis for
> building some new feature are forced to store their refs under the
> refs/notes namespace even if that does not make sense for the feature when
> what's stored in the notes tree is not intended to provide any content that
> is directly meaningful to the user.

Agreed.

>> That is exactly what I meant by that the existing safety pays price
>> of not being able to store notes outside refs/notes, which may be
>> too high a price to pay.
>>
>>>> Although I am not fundamentally against allowing to store notes
>>>> outside refs/notes/, it is different from "anywhere is fine".
>>>> Can't we do this widening in a less damaging way?
>>>
>>>
>>> Without arbitrarily restricting where notes can be stored it seems to
>>> me the only option would be to have the notes machinery actually
>>> inspect the tree of any existing notes ref it's passed.
>>
>>
>> As I said earlier (assuming you read footnotes before you read a new
>> paragraph), the ship has already sailed.
>
>
> Hmpf.  So the only possible safety check is refname-based.  But, as you say,
> it's no use crying over spilled milk [3].
>
>> Obvious two sensible ways forward are to do a blacklist (i.e. allow
>> anywhere except for known non-notes namespaces like refs/heads/) or
>> do a whitelist (i.e. allow refs/<some-known-space> in addition to
>> refs/notes) of the namespace, and the latter is vastly preferrable
>> than the former, because you can practically *never* crawl back a
>> namespace once you give it to the general public, even if you later
>> find it a grave error to open it too widely and need a more
>> controlled access [*2*].  And the name of the game for a software
>> that can be relied for a long haul is to avoid painting ourselves in
>> a corner that we cannot get out of.
>>
>> If we add refs/remote-notes/* to the whitelist now, and if later it
>> turns out to be not so ideal and we would prefer another layout for
>> remotes, e.g. refs/remotesNew/*/{heads,notes,tags}/, we can add
>> refs/remotesNew/*/notes/ to the whitelist _without_ breaking those
>> who have already started using refs/remote-notes/*.  That is why
>> I said whitelist is preferrable than blacklist.

I agree that a whitelist is preferable to a blacklist.

> A whitelist solves issue (1) but is no help for issue (2) unless some
> additional additional part of the refs namespace were to be also
> whitelisted.  Perhaps something like refs/x-<anything>/... in the same vein
> as the various IETF standards for experimental names.

Alternatively (or additionally), for issue (2), we could add a
--disable-ref-safety option to 'git notes', to explicitly disable the
safety checks for "experimental" use.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
