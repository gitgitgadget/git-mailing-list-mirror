From: Alexandre Oliva <lxoliva@fsfla.org>
Subject: Re: rebase parents, or tracking upstream but removing non-distributable bits
Date: Wed, 05 Jan 2011 09:44:15 -0200
Organization: Free thinker, not speaking for FSF Latin America
Message-ID: <orwrmj378w.fsf@livre.localdomain>
References: <ord3ojb0yy.fsf@livre.localdomain>
	<20101230205847.GA29012@burratino> <or4o9uc2ny.fsf@livre.localdomain>
	<m37heqdfck.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 05 12:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaRnV-0004ld-4Z
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 12:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab1AELow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 06:44:52 -0500
Received: from fsfla.org ([217.69.89.164]:33508 "EHLO fsfla.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569Ab1AELov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 06:44:51 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (unknown [201.82.179.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fsfla.org (Postfix) with ESMTPSA id CEC14436006;
	Wed,  5 Jan 2011 11:44:46 +0000 (UTC)
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p05BiVuG031152;
	Wed, 5 Jan 2011 09:44:32 -0200
Received: from livre.localdomain (aoliva@localhost [127.0.0.1])
	by livre.localdomain (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p05BiUg9029808;
	Wed, 5 Jan 2011 09:44:30 -0200
Received: (from aoliva@localhost)
	by livre.localdomain (8.14.3/8.14.3/Submit) id p05BiLJb029805;
	Wed, 5 Jan 2011 09:44:21 -0200
X-Authentication-Warning: livre.localdomain: aoliva set sender to lxoliva@fsfla.org using -f
Mail-Followup-To: Alexandre Oliva <lxoliva@fsfla.org>, git@vger.kernel.org
In-Reply-To: <m37heqdfck.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Thu, 30 Dec 2010 15:14:07 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164560>

On Dec 30, 2010, Jakub Narebski <jnareb@gmail.com> wrote:

> They are not sent by default, but they (refs/replace/*) can be send a=
s
> any other ref.

Oh, doh, I was modeling them after grafts, but indeed the replace refs,
unlike grafts, can be sent out.  Which doesn't really help, since they'=
d
be sent out in addition to the objectionable stuff.

Unless the idea is to replace the other way round, i.e., instead of
cleaned-up commit replacing contaminated commit, mark the contaminated
commit as replacing the cleaned-up one.  I haven't explored this
possibility, for it dids't seem to make much sense at first.

> * you replace merge-turned-ordinary commit with a proper merge
>   commit

Aah...  and this would presumably enable further merges onto my local
tree, but I'd public commits that lost history and relationship with
their upstream commits.

I'm aiming at something better than this, something more like the resul=
t
of filter-branch, but with improvements for git pull/merge that (i) use
some ref/original mapping (that provides nearly equivalent info to that
of the weak parent idea I proposed before) to tell where we are, what w=
e
have and what needs rewriting, and (ii) perform rewriting of each
brought in commit, keeping local history isomorphic to that of upstream=
,
and updating the remapping.  Ideally, (iii) have means for merge to use
the remapping backwards, so that one could merge from the cleaned-up
branch to the contaminated branch, or even to publish the remapping as
equivalences rather than unidirectional mappings.  Perhaps storing them
as trees (or some other format) rather than as long lists of refs would
make them more efficient to deal with, especially after packing.

More details about what we're after in the thread containing:
http://www.mail-archive.com/gnu-linux-libre@nongnu.org/msg00903.html


As for the rewriting itself (which I regard as a solved problem, it's
compatibility between rewritten branches that I'm trying to adress), I'=
m
thinking of making manual changes to the trees whose commits introduced
undesirable content, taking note of the contaminated and clean objects,
and then writing a script to remap with git filter-branch the contents
of the index for each commit, replacing contaminated with clean file, o=
r
removing fully-contaminated file.

> Though I think that better solution would be feature-branch based
> workflow.

We are not in a position to influence how upstream does their
development, and I suppose this would be the case in many (but not all)
of the situations I described as motivators.


On Dec 30, 2010, Yann Dirson <ydirson@free.fr> wrote:

>> I'm under the impression that this could not just work, but also mak=
e
>> rebasing in general (especially the hard case) far less problematic,=
 for
>> git would be able to relate a rebased commit with an original commit=
=2E

> I suppose that by "hard case" you mean forking off a branch that gets
> rebased later ?

I meant the case described as =E2=80=9Chard case=E2=80=9D in the git-re=
base man page:

http://www.kernel.org/pub/software/scm/git/docs/git-rebase.html

Hard case: The changes are not the same.

    This happens if the subsystem rebase had conflicts, or used
    --interactive to omit, edit, squash, or fixup commits; or if the
    upstream used one of commit --amend, reset, or filter-branch.

> This problem suggests a more generic one: how to "merge back" most
> changes from a branch while still not merging some specific changes ?

Thanks for the suggestion.  That made me think that, more than a
parent/child relationship, the original and rewritten commits should be
perceived as siblings as far as merges are concerned, when a
correspondence/equivalence table is given.  Hopefully this wouldn't be
too much of a change to merge and rebase.


Am I making sense?  Does this seem generally useful, say, for someone
trying to do participate in the development of unencumbered portions of
a (patent|copyright|contractually|restriction)-encumbered project?

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
