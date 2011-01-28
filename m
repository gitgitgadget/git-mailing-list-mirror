From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Fri, 28 Jan 2011 11:20:01 -0500
Message-ID: <4D42ECB1.9080300@xiplink.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 17:19:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pir2i-0006WI-KS
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 17:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab1A1QTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 11:19:19 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:35941 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab1A1QTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 11:19:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp38.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 52011348407;
	Fri, 28 Jan 2011 11:19:18 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp38.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E07A33480DA;
	Fri, 28 Jan 2011 11:19:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165624>

On 11-01-27 06:22 PM, Thomas Hauk wrote:
> On Jan 27, 2011, at 12:53 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>> You'll be much better off if you have project-specific repositories.
>=20
> But how often do you have a project that has no external or internal
> dependencies on any other packages or libraries? Any project I've eve=
r
> done, big or small, has relied on some existing codebase. Imagine a
> project that uses liba and libb, which both reference libc. To use Gi=
t,
> I'd have to have copies of libc existing in three repositories, and c=
opies
> of liba and lib in two repositories each. What a nightmare... and tha=
t's
> only a trivial hypothetical example.

Let me try to give you a more positive response...  :)

Where I work, our products rely on a vast amount of code from different
sources, not just various internal and external libraries but also the =
entire
=46reeBSD tree as well as assorted forks of different Linux kernel vers=
ions
(because different customers have their own tweaked kernels that we nee=
d to
work with).

We use git in a variety of ways to manage all this.  We rely a lot on g=
it's
submodule feature, but not exclusively.

=46or most external code, including the Linux kernel forks, we usually =
set up
an internal git mirror of whatever public repository the code has.  So =
each
external code base has its own git repository, and we attach those
repositories to our main repo using submodules.

This works fairly well, especially because we don't update the external
sources very often.  Working with submodules takes a bit of getting use=
d to,
but it works nicely when the different pieces are reasonably independen=
t, and
this is usually the case for external libraries.

=46or our internal libraries, we just keep them all in the main reposit=
ory.
Our internal code does have some inter-dependencies, so it's convenient=
 to
track them all together.  Note that this doesn't prevent internal libra=
ries
from evolving independently -- even though a branch applies to the whol=
e
repo, the branch's _topic_ can just be about one specific library.  Any=
one
who needs to use the library's updated code can merge that branch into =
their
own, or base their work on that branch.  Eventually the library's branc=
h gets
merged back into the mainline branch and everyone gets to use the updat=
ed code.

In addition to all that, we have a different way of working with the Fr=
eeBSD
code base.  This was put together a few years ago, and I would do it
differently now, but I'll describe it to give you an idea of what else =
is
possible with git.

The FreeBSD code tree lives in a subdirectory of our main repo.  It's n=
ot a
submodule or anything fancy, it's just the code.  We've modified the Fr=
eeBSD
code quite a bit, but we also keep it up to date with changes the FreeB=
SD
guys make.  We put all of their changes in a separate branch in our mai=
n
repo, and a script keeps that branch up to date.  When we're ready, we =
merge
the FreeBSD changes into our mainline branch.

Keeping that FreeBSD branch up to date is a bit involved.  The branch
actually reflects a single branch in the FreeBSD public subversion
repository.  We use "git svn" to maintain a git mirror of that subversi=
on
branch, and what our script does is compare the latest FreeBSD subversi=
on
revision number in our main repo to the one in the mirror ("git svn" re=
cords
the subversion revision numbers in the git commits it creates).  When t=
he
script finds that the main repo is out of date, it extracts the patches=
 for
each individual subversion commit and applies them as git commits in ou=
r main
repo's FreeBSD branch.  (Any git veterans who've read this far are prob=
ably
cringing right now...)

Anyway, my point is that git provides a lot of flexibility to let you w=
ork
with your code base in many different ways, but none of them are how
subversion or perforce work.  Coming from those tools, you have to shif=
t your
mindset a bit to make the best use of git.  That can be frustrating, an=
d I
won't say that git's model is The One True Way, but I've found that wha=
t feel
like limitations from the perspective of other tools usually turn out t=
o be
relatively inconsequential.

		M.
