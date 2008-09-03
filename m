From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 08:26:10 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809030741190.3259@nehalem.linux-foundation.org>
References: <20080903072011.GA14252@atjola.homenet> <7vprnld5ws.fsf@gitster.siamese.dyndns.org> <20080903083739.GA18653@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 17:28:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KauHC-0007c0-VW
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 17:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYICP1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYICP1E
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:27:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52904 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398AbYICP1B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 11:27:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m83FQAHJ018621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Sep 2008 08:26:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m83FQAQi022011;
	Wed, 3 Sep 2008 08:26:10 -0700
In-Reply-To: <20080903083739.GA18653@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94804>



On Wed, 3 Sep 2008, Bj=F6rn Steinbrink wrote:
>=20
> OK, so that basically means "if you cherry-pick, you better make sure
> that you don't have to revert or just get your fine-toothed comb read=
y
> when you merge later", right? Any advice on how to deal with such a
> situation?

Well, it's not actually even really related to cherry-picks in particul=
ar,=20
although yes, cherry-picks and reverts are perhaps the simplest case to=
=20
explain.

At a more fundamental level, it's about git _not_ caring about any=20
individual commit in the history, and only caring about the "big pictur=
e".=20

In this, git is fairly consistent - the same way that git never cares=20
about any individual _file_, but always merges the whole tree, it also=20
never really cares about any individual _commit_, but always the whole=20
history.

So it really doesn't matter if one commit undid another - the only thin=
g=20
that matters as far as git merging is concerned is what the final set o=
f=20
changes were from the common base point.

Now, there's nothing to say that git _couldn't_ try to look at individu=
al=20
commits when deciding how to merge, but I actually think it's=20
fundamentally wrong to do so, for pretty much the same reason I think i=
t's=20
fundamentally wrong to try to encode rename information.

The fact is, should it really matter whether something was "reverted", =
or=20
whether multiple gradual changes made ot go back to what it used to be?=
=20
Git says no, an considers the two to be totally equivalent in the end.=20
exactly the same way that git doesn't matter whether you first created =
a=20
new file and later deleted a similar old file, or whether you renamed i=
t.=20

The only thing that matters is the end result.

So if you have one branch that first does "A", and then does "revert A"=
,=20
as far as git is concerned, that branch didn't do anything at all when =
it=20
comes to data.

So when you merge it with another branch that does "A" too, the end res=
ult=20
is that the merged contents will have A. That's fairly easy to understa=
nd=20
if you just think of git as caring about the whole end result and just=20
doing a three-way merge at the end points (which is what it does), but =
I=20
would also like to explain why I think it's fundamentally the _right_=20
thing to do, not just an "implementation detail because it's simpler".

When one branch does the "revert A" does that really mean that A was ba=
d?=20
No. It could mean that A was "unnecessary" or "not quite ready". The=20
revert, after all, was literally done in the context of _that_ branch, =
and=20
the reasons may well have been totally private to that branch. Git does=
n't=20
know, and git shouldn't care - the only thing that should matter is the=
=20
end result.

To really hammer this point in, let's say that "A" was really doing two=
=20
different things - A1 and A2 - to two different files. And let's furthe=
r=20
say that it had been cherry-picked because the one branch needed just a=
=20
part of it - A1. And then later, in a fit of cleanup madness, that bran=
ch=20
undid A2, because it really didn't need it.

When you merge the two branches, what do you expect? You could argue th=
at=20
you would expect A2 to be undone in the original branch too. It was, af=
ter=20
all, a partial revert. But I think you'll agree that it's not at all=20
"obvious" any more.

In fact, I will argue that it would be horribly _wrong_, because the=20
branch that undid part of A could have done it two different ways:

 - it could do the "cherry-pick A" as one commit and the "undo A2" as=20
   another (as I implied above)

 - but it could equally well have done a "cherry-pick just part of A", =
and=20
   done it as just one commit (perhaps because it noticed that A2 didn'=
t=20
   even _compile_ within the context of that branch, and did an '--amen=
d'=20
   to fix it up rather than create a new commit.

See? Shouldn't both really act the same? Should it really make a=20
difference to what git does if there was a cherry-pick and a partial=20
revert, or a partial cherry-pick? Should _how_ you do something matter=20
more than the end result? HELL NO!

And is the "partial revert" really any different from the "total revert=
"?

Now, if you're a math person, think of the "limit behavior" as A2=20
approaches all of A. The final end result is that you were to revert _a=
ll_=20
of A. Should that limit case be fundamentally different from the case o=
f=20
A2 being just a _part_ of A? What should the logic be? What if all of A=
=20
was reverted except for the whitespace cleanups that it did (almost by=20
mistake?)

So in the end, the answer is that git doesn't care about individual=20
commits, because caring about individual commits is totally crazy. Git=20
_remembers_ them, of course, and it can _show_ you them when you merge,=
=20
but the actual end result depends purely on the *state* of the merge (a=
nd=20
the "big picture" of the history, ie where the branches join etc), not =
of=20
the small details of how you got to that state.

And that is fundamentally the only sane thing to do.

Here's another final thought to leave you with:

 - what if the other branch had decided that instead of reverting it, i=
t=20
   could just do a "git rebase -i" _without_ it, because that other bra=
nch=20
   had never been exposed to anybody else?

See? The "how you got to some state" really must be immaterial in a sta=
ble=20
merge strategy. I realize that I'm at odds with some SCM people on this=
,=20
but I'm ok with that, because I also realize that all those other SCM=20
people are just _stupid_.

			Linus
