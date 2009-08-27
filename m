From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 11:35:31 +0200
Message-ID: <200908271135.31794.johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-9-git-send-email-johan@herland.net>
 <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 11:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgbOV-0006nz-0E
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 11:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbZH0Jfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 05:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZH0Jfe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 05:35:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52099 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752128AbZH0Jfd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 05:35:33 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100HG23Z9WAA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 11:35:33 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP100BIH3Z8Q520@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 11:35:33 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.91828
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127149>

On Thursday 27 August 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > The semantics used when parsing notes trees (with regards to fanout
> > subtrees) follow Dscho's proposal fairly closely:
> > - No concatenation/merging of notes is performed. If there are several
> > notes objects referencing a given commit, only one of those objects are
> > used. - If a notes object for a given commit is present in the "root"
> > notes tree, no subtrees are consulted; the object in the root tree is
> > used directly. - If there are more than one subtree that prefix-matches
> > the given commit, only the subtree with the longest matching prefix is
> > consulted. This means that if the given commit is e.g. "deadbeef", and
> > the notes tree have subtrees "de" and "dead", then the following paths
> > in the notes tree are searched: "deadbeef", "dead/beef". Note that
> > "de/adbeef" is NOT searched. - Fanout directories (subtrees) must
> > references a whole number of bytes from the SHA1 sum they subdivide.
> > E.g. subtrees "dead" and "de" are acceptable; "d" and "dea" are not.
> > - Multiple levels of fanout are allowed. All the above rules apply
> >   recursively. E.g. "de/adbeef" is preferred over "de/adbe/ef", etc.
>
> If I am reading this correctly, the earlier parts of the series were
> aiming to let multiple people to add notes to the same commit more or
> less uncordinated while still allowing to merge them sensibly, but now
> such a workflow becomes impossible with this change.
>
> The above claims notes trees with different levels of fan-out are
> allowed, but what it really means is that merging notes trees with
> different levels of fan-out will produce a useless result that records
> notes for the same commit in different blobs all over the notes tree, and
> asking the notes mechanism to give the notes for one commit will give
> only one piece that originates in the tree whose creator happened to have
> used the longest prefix while ignoring all others.  It may _allow_ such a
> layout, but how would such semantics be useful in the first place?
>
> I suspect that I am missing something but my gut feeling is that this
> change turns an interesting hack (even though it might be expensive) into
> a hack that is not useful at all in the real world, without some order,
> discipline, or guideline is applied.

As you may remember, the major, remaining problem with the jh/notes patch 
series was that as the number of notes in a repo grew, the runtime cost of 
displaying (even a single one of) them became prohibitive. This was the 
major reason why Dscho and me did NOT want you to merge this series earlier.
The solution to this performance problem (which has been discussed since 
almost a year ago), is to use some fanout scheme in the notes tree, so that 
we can load individual notes without necessarily parsing the entire notes 
tree. This patch implements the _reading_ of a notes trees with fanout.

However, as you correctly identify, allowing fanout makes it possible to add 
multiple notes for the same commit in the same notes tree.

Therefore, we must now create the order/discipline/guideline you request by 
taking away this extra freedom.

This will take the form of enforcing a chosen fanout scheme when _writing_ 
notes. This code (yet to be written) will include:

- refactoring the notes tree when the number of notes call for a different 
fanout scheme (e.g. create a 2/38 fanout scheme when the number of notes in 
a (sub)tree exceed some threshold).

- adding and editing notes while following the current fanout scheme.

- adding a custom merge strategy for note trees, which reads notes trees 


Currently I have a two different ideas on a suitable fanout scheme:

1. Define a threshold where the number of notes in a (sub)tree becomes large 
enough warrant a fanout. For now, let's assume that threshold is 1024. Start 
with en empty notes tree with no fanout. When we reach 1024 notes, split the 
notes tree into 256 subdirs (2/38 fanout). As each of the subdirs reach 1024 
notes, split those subdirs further (2/2/36 fanout), and so on. In practice 
(since SHA1 gives us a uniform distribution), notes trees with up to:
- < 1024 notes will have no fanout
- < ~256K notes will have 2/38 fanout
- < ~64M notes will have 2/2/36 fanout
- < ~16G notes will have 2/2/2/34 fanout

2. Simply decide on a constant 2/2/36 fanout. For the case with < 256K 
notes, this is somewhat wasteful, but not prohibitively expensive. For the 
case with > 64M notes, performance will start to degrade. The big advantage 
with this approach is that when this is hardcoded into the notes code, we 
have regained the property that notes for a given commit have exactly _one_ 
unique position in the notes tree across all installations (enabling us to 
fall back on the regular merge strategy).

> What's the recommended way to work with this system from the end user's
> point of view in a distirbuted environment?

The end user should not know or care about what fanout scheme is used. 
Everything should be handled seamlessly by the code.

> Somebody up in the project is supposed to decide what fan-out is to be
> used for the whole project and everybody should follow that structure?

Nope, the code should decide which fanout scheme to use.

> If a participant in the project forgets that rule (or makes a mistake), a
> notes tree that mistakenly merges his notes tree becomes practically
> useless?

No. Again this should be invisible to the user.

> If so, perhaps we would need a mechanism to avoid such a mistake from
> happening?

The notes code should prevent notes that violate the fanout scheme from 
being created.

The fanout scheme is not something the user should have to worry about at 
all.


I totally understand that you don't want to merge the notes feature before 
the "writing" side is taken care of. As such, this iteration is simply yet 
another iteration towards that final goal.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
