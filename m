From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path to
 do sparse clone
Date: Fri, 25 Jul 2008 01:47:03 -0700
Message-ID: <7v7ibauz94.fsf@gitster.siamese.dyndns.org>
References: <20080723145718.GA29134@laptop>
 <20080724171952.GB21043@sigill.intra.peff.net>
 <alpine.DEB.1.00.0807241837441.8986@racer>
 <20080724182813.GA21186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 10:48:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMIyI-0002JX-GM
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 10:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbYGYIrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbYGYIrO
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 04:47:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbYGYIrL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 04:47:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A381F3853A;
	Fri, 25 Jul 2008 04:47:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9E8D138539; Fri, 25 Jul 2008 04:47:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4527E828-5A26-11DD-BCF5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90016>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 24, 2008 at 06:41:03PM +0100, Johannes Schindelin wrote:
>
>> > As a user, I would expect "sparse clone" to also be sparse on the=20
>> > fetching. That is, to not even bother fetching tree objects that w=
e are=20
>> > not going to check out. But that is a whole other can of worms fro=
m=20
>> > local sparseness, so I think it is worth saving for a different se=
ries.
>>=20
>> I think this is not even worth of a series.  Sure, it would have ben=
efits=20
>> for those who want sparse checkouts.  But it comes for a high price =
on=20
>> everyone else:
>
> I agree there are a lot of issues. I am just thinking of the person w=
ho
> said they had a >100G repository. But I am also not volunteering to d=
o
> it, so I will let somebody who really cares about it try to defend th=
e
> idea.

I think sparse fetch is a lot worse than grafts and shallow clones whic=
h
are already bad.  These are all ways to introduce local inconsistency a=
t
the object level and pretend everything is Ok, but the latter two do so
only at commit boundary and it is somewhat more manageable (but we stil=
l
do not handle it very well).  With sparse fetch, you cannot even guaran=
tee
the integrity of individual commits with subtrees here and there missin=
g.

I do think shallow checkout that says "I'll have the whole tree in the
index but the work tree will have only these paths checked out" makes
sense.  You do not need a fully populated work tree to create commits o=
r
merges -- the only absolute minimum you need is a fully populated index=
=2E

In that sense, I think "protect index entries outside of these paths" (=
I
remember that the first round of this series was done around that notio=
n)
is a wrong mentality to handle this.  We should think of this as more l=
ike
"you still populate the index with the whole tree, and you are free to
update them in any way you want, but we do not touch work tree outside
these areas".

This has a few ramifications:

 - If the user can somehow check out a path outside the "sparse" area, =
it
   is perfectly fine for the user to edit and "git add" it.  Such a met=
hod
   to check out a path outside the "sparse" area is a way to widen the
   "sparse" area the user originally set up;

 - When the user runs "merge", and it needs to present the user a worki=
ng
   tree file because of conflicts at the file level, the user has to ag=
ree
   to widen the "sparse" area before being able to do so.  One way to d=
o
   this is to refuse and fail the merge (and then the user needs to do
   that "unspecified way" of widening the "sparse" area first).  Anothe=
r
   way would be to automatically widen the "sparse" area to include suc=
h
   conflicting paths.

 - And you would want to narrow it down after you do such a widening.

=46or many projects that has src/ and doc/ (git.git being one of them),=
 it
is perfectly valid for a code person and a doc person to work in tandem=
=2E
In such a project, after the code person makes changes in her sparsely
checked out repository and making changes only to the src/ area and pus=
hes
the results out, the doc person would run "git pull && git log -p
ORIG_HEAD" and updates the documentation in his sparsely checked out
repository that has only doc/ area.  The two parts are tied together an=
d
they advance more or less in sync.  I think sparse checkout would be a
useful feature to help such a configuration.

Having said that, I however think that this can easily be misused as a =
CVS
style "one CVSROOT houses millions of totally unrelated projects" layou=
t.
In CVS, the layout is perfectly fine because the system does not track
changes at anything higher than the level of individual files, but when
you na=C3=AFvely map the layout to a system with tree-wide atomic commi=
ts, such
as git, it will defeat the whole point of using such a system.  The pac=
e
these millions of unrelated projects advance do not have any relationsh=
ip
with each other, but by tying them together in the same top-level tree,
the layout is introducing an unnecessary ordering between their commits=
=2E
