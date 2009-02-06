From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Article about "git bisect run" on LWN
Date: Fri, 6 Feb 2009 06:23:15 +0100
Message-ID: <200902060623.16046.chriscool@tuxfamily.org>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Feb 06 06:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJFL-0008Cu-H0
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZBFFXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 00:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbZBFFXt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:23:49 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:50464 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbZBFFXs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 00:23:48 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id A811F4B005A;
	Fri,  6 Feb 2009 06:23:37 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 182654B0095;
	Fri,  6 Feb 2009 06:23:34 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090205141336.GA28443@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108657>

Le jeudi 5 f=E9vrier 2009, Ingo Molnar a =E9crit :
> * Christian Couder <chriscool@tuxfamily.org> wrote:
> > Hi,
> >
> > For information, an article from me, 'Fully automated bisecting wit=
h
> > "git bisect run"' has been published in today's edition of LWN on t=
he
> > development page:
> >
> > http://lwn.net/Articles/317154/
>
> Nice article!
>
> In terms of possible future enhancements of git bisect, here's a coup=
le
> of random ideas that would help my auto-bisection efforts:
>
>  - Feature: support "Bisection Redundancy"
>
>    This feature helps developers realize if a bug is sporadic. This
> happens quite often in the kernel space: a bug looks deterministic, b=
ut
> down the line it becomes sporadic. Sometimes a boot crash only occurs
> with a 75% probability - and if one is unlucky it can cause a _lot_ o=
f
> wasted bisection time. The wrong commit gets blamed and the wrong set=
 of
> developers start scratching their heads. It's a reoccuring theme on l=
kml.
>
>    What git could do here is to allow testers to inject a bit of extr=
a
>    "redundancy" automatically, and use the redundant test-points to
> detect conflicts in good/bad constraints.
>
>    It would work like this:
>
>       git bisect start --redundancy=3D33%
>
>    It would mean that for every third bisection points, Git would
>    _not_ chose the ideal (estimated) 'middle point' from the set of
> "unknown quality" changes that are still outstanding - but would
> intentionally "weer outside" and select one commit from the _known_ s=
et
> of commits.
>
>    If such a redundant re-test of the known-good or known-bad set yie=
lds
> a nonsensical result then Git aborts the bisection with a "logic
> inconsistency detected" kind of message - and people could at this po=
int
> realize the non-determinism of the test.
>
>    ( Git can do this when a "redundant" test point is marked as 'bad'=
 -
>      despite an earlier bisection already categorizing that test poin=
t as
>      'good' - or if it's the other way around. Git will only continue
> with the bisection if the test point has the expected quality. )
>
>    This essentially means an automated re-test - but it's much better
> than just a repeated bisection - i've often met non-deterministic bug=
s
> that yield the _exact same_ nonsensical commit even on repeat bisecti=
ons.
> That happens when a timing bug depends on the exact kernel layout, or=
 a
> miscompilation or linker bug depends on the exact kernel layout, etc.
>
>    It's also faster than a re-done bisection: 33% more testpoints is
> better than twice as many test-points. Also, auto-bisection can deal =
with
> redundancy just fine - it does not really matter whether i have to wa=
it
> 20 or 30 minutes for a test result since there's no manual interventi=
on
> needed - but it _very_ much matters whether i can trust the validity =
of
> the bisection result.

I see. With the current code it seems difficult to have a "weer outside=
"=20
algorithm, but if the "git bisect skip" code is ported (from shell=20
in "git-bisect.sh") to C in "builtin-rev-list.c", that might be doable.=
 And=20
anyway moving the bisect skip code to C is needed for other improvement=
s.

> - Feature: better "git bisect next" support.

You probably mean "git bisect skip" here.

>   Sometimes a commit wont build. In that case we have "git bisect nex=
t",
> but last i checked that only jumps a single commit - and build breaka=
ges=20
> often have a large scope - full trees that got merged upstream, etc. =
Most
> of the time those build breakages are uninteresting and the build-bro=
ken
> window does not contain the bad commit.
>
>   So it would be nice to have a "git bisect next --left=3D20%" type o=
f
>   feature. This would jump 20% commits to the "left" from the bisecti=
on
>   point, towards the 'known bad' set of commits, but still within the
>   bisection window.
>
>   Similarly, "git bisect next --right=3D20%" would jump towards the
> known-good edge of the bisection window (but still within the bisecti=
on
> window).

In the following thread, H. Peter Anvin suggested an algorithm to deal =
with=20
this kind of problem:

http://thread.gmane.org/gmane.comp.version-control.git/98164/

And I suggested a simpler one, that might be implemented without having=
 to=20
port "git bisect skip" code to C first, but I did not work on it yet.

>   Currently when i hit a build error during auto-bisection, it aborts=
 and
> i have to intervene manually. But with a bigger jump distance i could=
 use
> git-bisect-next reliably in scripts too.
>
>   Likewise, users too hit build breakages often, and find it hard to =
get
> out of the window of breakage. With the high-order tree structure of =
the
> kernel repository that is rather non-intuitive to do as well, and oft=
en
> people make mistakes and test the wrong commit.

I am working slowly on "git replace" these days and, if everything goes=
=20
well, it should make it possible to use "replace" refs when bisecting, =
so=20
that people could bisect on commit trees where many breakages have been=
=20
removed. And as refs can be shared, this means that users and developer=
s=20
should be able to easily share these improved trees.

Another way to work around breakages could be to have a list of commits=
 and=20
ranges of commits that should always be skipped and always pass them=20
to "git bisect skip" before using "git bisect run". Something like that=
=20
perhaps:

$ git bisect start <bad> <good>
$ git bisect skip $(cat always_skipped.txt)
$ git bisect run ./my_test_script.sh

But I agree that it would also be a good thing to have an improved "git=
=20
bisect skip" that could jump out of breakage windows.

> - Feature: detect "redundant" and "inconsistent" test points
>
>   This is a variation of the redunant testing theme, but from a diffe=
rent
>   angle: often newbies when they bisect the kernel weer outside of th=
e
>   bisection window without realizing it. It would be nice if Git prin=
ted
> a friendly notifier that:
>
>      git bisect good 12341234
>      info: bisection point 12341234 was already in the 'good' range

I agree that it would be nice. And it might be easy to implement.

>   Or, if the redunant test point is conflicting, print:
>
>      git bisect good 12341234
>      fatal: bisection point 12341234 was already in the 'bad' range!
>
>   And give an error return as well, so that scripts can abort.
>
>   Currently Git seems to be very forgiving and accepts all bisection
> points that we feed it, without checking them for consistency. (this
> might have changed in current development versions, i dont know.)

I don't think conflicting test points are accepted. An error should be=20
reported (with exit code 1), like this:

$ git bisect start HEAD~5 HEAD
Some good revs are not ancestor of the bad rev.
git bisect cannot work properly in this case.
Maybe you mistake good and bad revs?

> - User friendliness: give an estimation about how many steps are
> remaining
>
>   Right now git prints this when a bisection session begins:
>
>      aldebaran:~/tip> git bisect start
>      aldebaran:~/tip> git bisect bad linus
>      aldebaran:~/tip> git bisect good v2.6.28
>      Bisecting: 5449 revisions left to test after this
>      [e0b685d39a0404e7f87fb7b7808c3b37a115fe11] Updated contact info =
for
> CREDITS file
>
>   It would be nice if Git estimated the expected number of bisection
> points. Something like this would be helpful:
>
>      aldebaran:~/tip> git bisect good v2.6.28
>      Bisecting: 5449 revisions left to test after this
>                 About ~16 test steps left [approximated]
>      [e0b685d39a0404e7f87fb7b7808c3b37a115fe11] Updated contact info =
for
> CREDITS file
>
>   The real number of test points might be higher than this, if the tr=
ee
>   layout is unlucky, or it might be less than this if the user manual=
ly
>   narrows the bisection window to a suspected set of commits - but th=
at's
>   OK - most kernel testers use the default variant and the message is
> clear enough that it's only an estimation.

I will have a look at that. It might be easy to do.

Thanks,
Christian.
