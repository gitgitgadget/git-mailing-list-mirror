From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Tue, 16 Sep 2008 15:50:22 +0200
Message-ID: <20080916135022.GA19466@atjola.homenet>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com> <20080916052425.GA14644@spearce.org> <7v3ak08v5l.fsf@gitster.siamese.dyndns.org> <20080916080908.GA14272@atjola.homenet> <48CFB44F.8060609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfaxs-0002t2-Es
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYIPNu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 09:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYIPNu2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:50:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:32952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751428AbYIPNu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 09:50:27 -0400
Received: (qmail invoked by alias); 16 Sep 2008 13:50:24 -0000
Received: from i577B8C4C.versanet.de (EHLO atjola.local) [87.123.140.76]
  by mail.gmx.net (mp035) with SMTP; 16 Sep 2008 15:50:24 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19T5QdM/+VTURWnq78iT8o5TMijLDZ5+A9TwFLh83
	4sgzb0nyDYW3o9
Content-Disposition: inline
In-Reply-To: <48CFB44F.8060609@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96005>

On 2008.09.16 15:27:43 +0200, Michael J Gruber wrote:
> Bj=F6rn Steinbrink venit, vidit, dixit 16.09.2008 10:09:
> > On 2008.09.15 23:25:10 -0700, Junio C Hamano wrote:
> >> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >>
> >>> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >>>> Here is my attempt at a "let's publish a shallow repository for =
branch
> >>>> of moodle". Let me show you what I did...
> >>> ...
> >>>>  # 1.7 was a significant release, anything earlier than that
> >>>>  # is just not interesting -- even for pickaxe/annotate purposes
> >>>>  # so add a graft point right at the branching point.
> >>> ...
> >>>> Is this kind of workflow (or a variation of it) supported? For t=
his to
> >>>> work, we should communicate the grafts in some push operations a=
nd
> >>>> read them in clone ops - and perhaps in fetch too.
> >>> ...
> >>> I think that in this case the best thing to do is give users
> >>> a shell script that does roughly:
> >>>
> >>> 	git init
> >>> 	echo $BASE >.git/info/grafts
> >>> 	git remote add -f origin $url
> >>> 	git checkout -b master origin/master
> >>>
> >>> Sign the script, and let users verify it before executing.  You m=
ay
> >>> also want a script to drag in the history behind by removing the
> >>> graft and fetching $BASE^, but that is hard because your reposito=
ry
> >>> already "has" that.
> >> Why not just filter-branch _once at the origin_ and publish the re=
sult?
> >=20
> > I think the idea was to have a shallow clone starting at a certain
> > point, as opposed to the --depth option, where you cannot specify a
> > starting point, but only the depth of the clone.
>=20
> That's what Junio suggests:
>=20
> chop the history by introducing an appropriate graft
> make it "permanent" by filter-branching (and remove from info/grafts)=
=2E
>=20
> Now you have a disconnect dag. clone/push/whatever works on the
> "components" given by connected branches.
>=20
> Note that in this approach all history after the "chopping point" wil=
l
> be rewritten, i.e. get new sha1's.

But shallow clones using --depth don't get alterted hashed. They have
"graft-like" entries in .git/shallow (or whatever it is called) instead=
=2E

Assuming that using a shallow clone is worth the hassle (ie. you have t=
o
fetch significantly less data than with a full clone), I can imagine
some use-cases for that, for example bisecting a bug of which you know
that it was introduced after the last release. Just shallow clone the
repo from that version's tag onwards and bisect locally, while still
being able to use the original hash to report the broken version. Or
genrally anything for which you need a recent part of the history and
which requires you to talk about certain commits. The hashes are useful
for that, and filter-branch'ing breaks that.

Maybe instead of providing "pre-shallowed" repos to clone from, that
should have been an RFE to support shallow clones starting at a given
commit in the DAG? I have no idea whether that's feasible though.

Bj=F6rn
