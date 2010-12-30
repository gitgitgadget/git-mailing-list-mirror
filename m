From: Alexandre Oliva <lxoliva@fsfla.org>
Subject: rebase parents, or tracking upstream but removing non-distributable bits
Date: Thu, 30 Dec 2010 15:54:29 -0200
Organization: Free thinker, not speaking for FSF Latin America
Message-ID: <ord3ojb0yy.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 19:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYMsN-0007MV-OB
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 19:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab0L3SE1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Dec 2010 13:04:27 -0500
Received: from fsfla.org ([217.69.89.164]:56764 "EHLO fsfla.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab0L3SE1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Dec 2010 13:04:27 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Dec 2010 13:04:26 EST
Received: from freie.oliva.athome.lsd.ic.unicamp.br (unknown [201.82.179.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fsfla.org (Postfix) with ESMTPSA id CFA8E67AF19
	for <git@vger.kernel.org>; Thu, 30 Dec 2010 17:54:38 +0000 (UTC)
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id oBUHsZ02019845
	for <git@vger.kernel.org>; Thu, 30 Dec 2010 15:54:35 -0200
Received: from livre.localdomain (aoliva@localhost [127.0.0.1])
	by livre.localdomain (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBUHsUWG020693;
	Thu, 30 Dec 2010 15:54:31 -0200
Received: (from aoliva@localhost)
	by livre.localdomain (8.14.3/8.14.3/Submit) id oBUHsU3t020692;
	Thu, 30 Dec 2010 15:54:30 -0200
X-Authentication-Warning: livre.localdomain: aoliva set sender to lxoliva@fsfla.org using -f
Mail-Followup-To: Alexandre Oliva <lxoliva@fsfla.org>, git@vger.kernel.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164360>

Say the git repository of a project I use (with changes) on another
projet I work on contains portions that I oughtn't distribute.  Say,
portions that are illegal, immoral or too risky in my jurisdiction:
patented stuff that lawyers say I should not distribute in anyway,
unauthorized or otherwise copyright-infringing bits, text or pictures
that are offensive or even illegal to publish, i.e., stuff that I must
not be caught distributing and that, ideally, I could arrange to not
even possess.

If you guessed that my primary reason to want this is the non-Free
Software in the Linux git repository, you got it right :-)  Anyhow,
regardless of your opinion as to my stance in this matter, I hope you'l=
l
agree that the scenarios above are relevant and desirable.  Heck, even =
a
business that decides to remove all traces from a feature that was
planned for a certain release, but that is pushed back to a later
release, could benefit from this.

Note that simply reverting/removing these bits from the head of a branc=
h
wouldn't be enough: since the repository carries the entire history,
pushing the head of the branch to my public repository would amount to
publishing the bits I must not publish.

I need to be able to maintain and publish a modified repository, that
filters out the unwanted portions, but still be able to pull changes
from the upstream repository.  Desirable, but not strictly necessary, i=
s
the possibility of letting upstream pull my improvements, without
bringing in the changes I made to remove the bits I'm not supposed to
distribute.


Given this problem statement, I started looking for solutions that
didn't require modifying git.

I first looked into rewriting history, removing the unwanted bits and
replaying subsequent changes, but quickly discarded it, for it would
make my local repository incompatible with upstream both ways: I
wouldn't be able to pull from it; upstream wouldn't be able to pull to
it; third parties would run into ugly situations trying to carry patche=
s
from either one to the other.

Now, it looks like I might be able to pull from upstream if I maintain
manually a graft file that named each upstream commit as an additional
parent of the corresponding local rebase commit that brought it into my
rewritten tree.  Workable, maybe, but this wouldn't help third parties
that used my public repository.

Besides, I'm concerned that pushing from the local repository (with the
graft file) to the public repository would end up publishing the change=
s
I'm not supposed to distribute, because they'd be taken as parents of
the local commits.


Are there any other ways to support the desired features with git as-is=
?
AFAICT, there isn't, so I've been thinking of how to introduce this.  I
suppose the simplest way to accomplish this is to introduce the notion
of a =E2=80=9Cweak parent=E2=80=9D: one that is taken into account for =
purposes of
checking whether a commit is present in a branch being merged- or
rebased into, but that is not transmitted over pushes, and that is not
retained over purges, and not complained about when missing.

I'm under the impression that this could not just work, but also make
rebasing in general (especially the hard case) far less problematic, fo=
r
git would be able to relate a rebased commit with an original commit.


Now, assuming I'm correct in this assessment, there are two questions
that remain:

- how to represent this?

I thought of changing the commit blob format so as to somehow mark the
weak parents, say, with an additional character on the same line:

parent f00ba5... W

an alternate header:

wparent f00ba5...

or even an additional line:

parent f00ba5...
=2E..
weak f00ba5...

=46or some backward compatibility, it looks like only the last form wou=
ld
as much as stand a chance of being properly parsed, if the weak notes
are added at the end of the blob.

Another possibility is to create another kind of object, that named an
original and rebased commit and that, like a tag object, would be
(optionally?) transmitted when the (rebased) commit it named was
transmitted.  This could be more interesting, in that it might enable
all traces of a rebase to be eventually removed.  A (named?) object tha=
t
names multiple such pairs of commits might make even more sense to this
end.


Am I on the right track?  Any thoughts, preferences, suggestions,
concerns, recommendations, advice, pointers or gotchas to watch out for
before I start implementing any of these possibilities?


I realize that, although this option could make =E2=80=9Cgit pull --reb=
ase=E2=80=9D work
to track upstream in the rebased branch, and would enable me to publish
the repository with the rebased branch without the pieces I shouldn't
distribute, I'm not sure this would enable upstream to easily integrate
my changes.  Or would it?


Thanks in advance,


I'm not subscribed, but I'm going to look for replies in the archives.
That said, I'd appreciate if you'd explicitly copy me in any follow ups=
=2E
(Mail-Followup-To: set accordingly)


Last but not least: Happy GNU Year! :-)

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
