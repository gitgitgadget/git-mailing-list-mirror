From: John Twilley <mathuin@gmail.com>
Subject: Re: BUG: "--work-tree blah" does not imply "--git-dir blah/.git" or
 fix misleading error message
Date: Wed, 30 Nov 2011 11:13:20 -0800
Message-ID: <CAEUMa-fhqS-dJUePznZrEsKVSMDiAs=-JX93XTXZEm71Oix-1Q@mail.gmail.com>
References: <CAEUMa-cA8qPjJuPBREE1RqhgwmcZG7x1MjBYkxa3i+ZSAnMPOA@mail.gmail.com>
	<20111130182230.GC12096@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 20:13:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVpav-00044O-4b
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 20:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab1K3TNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 14:13:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63941 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab1K3TNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2011 14:13:21 -0500
Received: by ywa9 with SMTP id 9so955406ywa.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=RxN/4IvANkrA6WjaW8Z7mEzO4cNCto1do4EMbnW48QQ=;
        b=Cdw+u54A/dUTcxrKNDRoJhddbJiem51CpLwQDL4ChfsjwP/RvKG+HSu4LDMm0Cq8I2
         fZ2k5GHf1mFp7oihEGI4jOM//vzF2P8Ccu3xTjFR3fa34rwgBbYwYS9pTaHIizeLf6B5
         4Uk42+XNrY44GvxhobxwFW2q1iCOi8QG73x2k=
Received: by 10.50.40.198 with SMTP id z6mr3268988igk.39.1322680400392; Wed,
 30 Nov 2011 11:13:20 -0800 (PST)
Received: by 10.231.42.21 with HTTP; Wed, 30 Nov 2011 11:13:20 -0800 (PST)
In-Reply-To: <20111130182230.GC12096@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186136>

On Wed, Nov 30, 2011 at 10:22, Carlos Mart=EDn Nieto <cmn@elego.de> wro=
te:
> On Wed, Nov 30, 2011 at 09:43:08AM -0800, John Twilley wrote:
>> Today someone asked me if there was a way to run git against a
>> directory other than the current directory. =A0I looked at the outpu=
t of
>> --help and ran this:
>>
>> $ git --work-tree blah status
>>
>> I got the following output:
>>
>> fatal: Not a git repository (or any parent up to mount parent /home)
>> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not=
 set).
>>
>> I mistakenly thought the error message meant that blah was not a git
>> repository. =A0What it meant was that there was no .git in the curre=
nt
>> directory or any parent directory up to /home.
>
> Yes, git looks at the current directory and .git/ to see if there's a
> git repository there. This is what happens unless you tell git to loo=
k
> for it somewhere else.

This makes perfect sense, because nearly every time I run git
commands, I am somewhere within the working tree.  The point of my
post was that I was using --work-tree to tell git to look for the git
repository somewhere else (the root of the specified working tree)
which is not what git expected.

>> This command worked as expected:
>>
>> $ git --work-tree blah --git-dir blah/.git status
>>
>> The documentation is somewhat fuzzy about what constitutes a git
>> repository. =A0The gittutorial describes the git repository as .git =
when
>> talking about "git init" while the Git User's Manual describes the g=
it
>> repository as the working tree and the special top-level directory
>> named .git when talking about "git clone".
>
> A git repository is what's under .git/ (or in foo.git/ for bare
> repos). Non-bare repositories have a working tree associated with
> them, which by default lives just above the repository, because it'd
> be silly to have it somewhere else by default. Often you can think of
> both as the repository, as they're both. When you tell git to look fo=
r
> the worktree somewhere else, you're only overriding that particular
> variable, as git expects to be run from the repository (or just above=
,
> in the worktree).

And it's exactly this issue -- that sometimes the repository is just
the git directory, and sometimes the repository is the working tree
which contains the git directory at its root -- that caused the
confusion and unexpected behavior.  If I were to use a bare repository
directly (something I've never done), I guess I might use --git-dir
since the repository may not be named .git but instead something like
proj.git.  When I accessed a repository from outside its working tree,
I expected --work-tree to cover the whole shebang.  Obviously this
discussion is exposing my relatively limited experience with git, but
these assumptions do not seem unreasonable on their face.

>> It's clear (to me at least) that --work-tree should be used to
>> identify the root of the working tree when not inside the working
>> tree. =A0I expected that the git directory would be automatically se=
t to
>> .git in the root of the working tree, as that would match the
>> documentation. =A0Instead, the current directory and its parents wer=
e
>> checked -- which could provide dangerously misleading information to
>> the user.
>
> What part of the documentation exactly? --work-tree tells git to look
> for the working tree somewhere else. This option exists in order to
> support a multiple-workdir workflow.

What you mention above was what I was thinking about when I mentioned
the possibility of this being a critical and significant feature.  If
it is important to support a workflow with one git directory and
multiple working trees, and that case is more common/important than
the one I experienced, then changing the behavior of --git-dir is
obviously not the right thing to do.

>> I think that one of two things should be done: =A0either the --git-d=
ir
>> default should be changed when the --work-tree option is set, or the
>> error message cited above should be changed to explicitly identify t=
he
>> directory being tested as a potential git repository. =A0I personall=
y
>
> Git does tell you explicitly, but only when you specify a gitdir (via
> GIT_DIR or --git-dir), otherwise it looks at the current directory.

This is misleading if you don't know that the specification of a
working tree does not also implicitly specify a git directory.
Whether that lack of knowledge is the user's problem or the
software/documentation's problem is a separate question.

>> believe the first option is superior because it fulfills the
>> expectations of average users (folks who read git's documentation
>> instead of its source code) while permitting flexibility to those wh=
o
>
> It's not likely that it will get changed because that would break
> backwards-compatability in a very big way. If your concern is for
> "average user", she shouldn't be using that option, but changing to
> that directory instead. If you want your working tree to be ./foo/ an=
d
> your gitdir to be ./foo/.git, why don't you just cd to ./foo/?

=46rom that perspective, why have --work-tree at all?  Without that
option, either the git directory is in the root of your current
working tree, or it's not -- in which case --git-dir is all you need.
If you're going to keep the option, it's helpful to provide the
diagnostic output.  My suggestion would be more compelling if I could
provide a valid use case, but all I can come up with off the top of my
head are scripts and something like "(cd $worktree && git status)"
would probably work fine.

>> wish to refer to the current directory or some other directory for
>> their --git-dir value. =A0If the current behavior is somehow not a b=
ug
>> but instead a critical and significant feature which if changed woul=
d
>> cause more harm than good, please consider the second option.
>
> You get two different messages depending on how git is looking for th=
e
> repository. The message you mentioned gets printed when git tries to
> find it automatically. A "fatal: Not a git repository: '/tmp'" gets
> printed if you've told git to look for it in a specific place. The
> information is already there, though I guess you do have to know abou=
t
> the difference. Adding the current directory to the "default" message
> probably wouldn't hurt, as it's unlikely that a script is parsing
> that, and might be useful.

=46ewer scripts would be broken if the additional output is only
displayed when --work-tree is used, but that might be too special-case
for this situation.

> =A0 cmn

Jack.
--
mathuin at gmail dot com
