From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Wed, 12 Nov 2008 15:15:47 +0100
Message-ID: <200811121515.48277.chriscool@tuxfamily.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <7v8wrpyhhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 15:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0GUh-00036z-0L
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 15:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYKLONj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Nov 2008 09:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbYKLONj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 09:13:39 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60463 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYKLONi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 09:13:38 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8D18717B5A8;
	Wed, 12 Nov 2008 15:13:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 25A9A17B575;
	Wed, 12 Nov 2008 15:13:35 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wrpyhhs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100750>

Le mercredi 12 novembre 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This subcommand should be used when you have a branch or a part of =
a
> > branch that isn't easily bisectable because of a bug that has been
> > fixed latter.
>
> While I acknowledge your effort to make bisect easier to use, I do
> not think this is going in the right direction, from the point of vie=
w of
> the workflow.
>
> I do agree that the issue it tries to solve is a problem in real life=
=2E
> When you want to hunt for a bug, it is certainly possible that your t=
ests
> fail for a bug that is unrelated to what you are hunting for for a ra=
nge
> of commits.  Borrowing from your picture:
>
>     ...--O--A--X1--X2--...--Xn--B--...
>
> non of the commit marked as Xi may not be testable.
>
> But at that point, will you really spend time to rebuild history betw=
een
> A and B by fixing an unrelated bug that hinders your bisect, so that =
you
> can have a parallel history that is bisectable?  I doubt anybody woul=
d.

I think kernel developers and perhaps others do that somehow. I mean, t=
here=20
is the following text in the git-bisect(1) documentation:

"
You may often find that during bisect you want to have near-constant tw=
eaks=20
(e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or "revisio=
n=20
that does not have this commit needs this patch applied to work around=20
other problem this bisection is not interested in") applied to the revi=
sion=20
being tested.

To cope with such a situation, after the inner git-bisect finds the nex=
t=20
revision to test, with the "run" script, you can apply that tweak befor=
e=20
compiling, run the real test, and after the test decides if the revisio=
n=20
(possibly with the needed tweaks) passed the test, rewind the tree to t=
he=20
pristine state. Finally the "run" script can exit with the status of th=
e=20
real test to let the "git bisect run" command loop to determine the=20
outcome.
"

So we suggest that people patch at bisect time in case of problems. But=
 I=20
think creating a parallel branch should be better in the long run, beca=
use=20
you can easily keep the work you did to make things easier to bisect an=
d=20
you can easily share it with other people working with you. Also using =
"git=20
rebase -i" to create the fixed branch might be easier and more reliable=
=20
than trying to patch at each step.

Of course it also depends on how often people use "git bisect", but it =
seems=20
that there are people out there bisecting very frequently and that thes=
e=20
people care very much about bisectability of the tree.

> Even if we assume that somebody wants to adopt the workflow to first =
fix
> an unrelated bug (that may be totally uninteresting for the purpose o=
f
> solving the original issue he set out to figure out) to rewrite the
> history, what he first needs to do is to find out what part of the
> history to rewrite.

Not necessarily. People may decide to adopt a workflow that consists in=
=20
creating a fixed branch as soon as they know about a fix that may preve=
nt=20
their code from being tested. This way they know that they will be able=
 to=20
bisect at each commit of their full history.

> IOW, he needs to know A and B (and in general, the=20
> history is not even linear).  Maybe he guesses what A and B is.  But =
for
> one thing, after making the guess, he would certainly test A and B to=
 see
> if the original issue exists at these commits.  The sequence of commi=
ts
> Xi become irrelevant if A turns out to be bad or B turns out to be go=
od.

Yes that's possible. But in some cases people might find it simpler (fo=
r=20
example because it might take a long time or a lot of manpower to fully=
=20
test one commit) to just create a fixed branch as soon as they find=20
something that prevents testing which might happen during a bisection o=
r=20
not.

> And if A is good and B is bad, then the _original bug_ is in the very
> sequence of Xi you are going to rewrite.  By the time you made a
> rewritten history with sequence of commits Yi to be grafted like this=
:
>
>
>          C--Y1--Y2--...--Yn
>        /
>  ...--O--A--X1--X2--...--Xn--B--...
>
> to make it bisectable, it is very likely that you would have already =
seen
> the original bug.

I am not sure I understand/agree with that, because I think it may be q=
uite=20
easy to make such a fixed branch, especially if the commit message of B=
 is=20
a good one like "fix build problem on platform 'foo' introduced by A".

> In such a case where you need to figure out what an unrelated bug is,=
 and
> which commit A and B are involved while bisecting, I think you are mu=
ch
> better off using bisect skip, as Johannes mentioned earlier.

Even if there was a bisect skip command that could skip a range of comm=
it,=20
you might find in the end that the original bug you are looking for was=
=20
introduced in a range you skipped.

> On the other hand, if you already have a well-known bug that was
> introduced at A whose fix at B is also very well-known, you would not
> even need a separate "bisect replace" command nor replace_parents()
> machinery only for the purpose of bisection, would you?  In such a ca=
se I
> think you can just use a usual graft.

I don't know very much usual grafts but I think that the problem is tha=
t=20
usual grafts rewrite history for (nearly) all the commands.

It seems to me that with usual grafts for this purpose, people may for=20
example have problems refering to some commits, because it might happen=
=20
that the sha1 of a commit might be in a branch that has been grafted ou=
t=20
the current branch for easier bisecting.

=46or example in my patch series, the 2 last patches add a --no-replace=
 option=20
to "git bisect", so that it's easy not to use "bisect-replace" branches=
 if=20
one does not want too. And I fear that if graft use is generalized, it =
may=20
be necessary to add such options to many other commands (instead of jus=
t=20
one). And even then, people may want to use some of the grafts but not=20
others (for example grafts to see some very old commits imported after =
the=20
initial repo was created but not grafts to fix history) for some purpos=
es=20
and a different set (for example all the grafts) for other purposes (li=
ke=20
bisecting).

> I have a separate idea make 'grafts' easier on object transfer, that =
is
> somewhat related to this one, by the way.  Instead of making the graf=
ts
> completely a local matter as we do now, we can reserve refs/replace/
> namespace, and record a new commit object to replace an existing comm=
it
> whose object name is $sha1 as refs/replace/$sha1.  We make almost all=
 the
> commands except object enumeration (fsck, receive-pack, send-pack, pr=
une,
> etc.  Roughly speaking, anything that involves "rev-list --objects")
> honor this commit replacement, so that any time you ask for commit $s=
ha1,
> the object layer gives you the replacement commit object back.  In th=
is
> way, you can clone or fetch from such a repository (along with refs i=
n
> refs/replace/ hierarchy) and fsck/prune won't lose the original paren=
ts
> (because it does not see replacements).  Things like paranoid update =
hook
> needs to become very careful about refs/replace/ for security reasons=
,
> but I think this would make the grafts much easier to use.

I agree that it would make grafts much easier to use (and would be very=
=20
security sensitive).

But except for grafts used to connect to old histories, do you know man=
y=20
special commands other than "git bisect" that may use the refs/replace/=
=20
namespace?

I mean, it may be a good idea to use a special namespace with sha1 name=
d=20
refs like "refs/xxx/$sha1" instead of branches named=20
like "bisect-replace-SHA1", but I think that it would be better if graf=
ts=20
used to fix history for bisecting purpose would be separated from other=
=20
kind of grafts, for example perhaps in "refs/replace/bisect/$sha1".

Regards,
Christian.
