From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 22:00:17 +0200
Message-ID: <20091208200017.GA827@redhat.com>
References: <20091208144740.GA30830@redhat.com> <20091208160822.GA1299@atjola.homenet> <20091208161406.GB32045@redhat.com> <20091208163737.GA2005@atjola.homenet> <20091208164449.GA32204@redhat.com> <20091208191107.GA4103@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 08 21:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6Hc-0003JU-6n
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965953AbZLHUD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 15:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965930AbZLHUD2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:03:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32611 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965929AbZLHUD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:03:27 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB8K32Fl027370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Dec 2009 15:03:02 -0500
Received: from redhat.com (vpn1-5-156.ams2.redhat.com [10.36.5.156])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB8K2xAB004299;
	Tue, 8 Dec 2009 15:03:00 -0500
Content-Disposition: inline
In-Reply-To: <20091208191107.GA4103@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134907>

On Tue, Dec 08, 2009 at 08:11:07PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.08 18:44:49 +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 08, 2009 at 05:37:37PM +0100, Bj=F6rn Steinbrink wrote:
> > > On 2009.12.08 18:14:07 +0200, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 08, 2009 at 05:08:22PM +0100, Bj=F6rn Steinbrink wr=
ote:
> > > > > On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> > > > > > Add --revisions flag to rebase, so that it can be used
> > > > > > to apply an arbitrary range of commits on top
> > > > > > of a current branch.
> > > > > >=20
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > ---
> > > > > >=20
> > > > > > I've been wishing for this functionality for a while now,
> > > > > > so here goes. This isn't yet properly documented and I didn=
't
> > > > > > write a test, but the patch seems to work fine for me.
> > > > > > Any early flames/feedback?
> > > > >=20
> > > > > This pretty much reverses what rebase normally does. Instead =
of "rebase
> > > > > this onto that" it's "'rebase' that onto this". And instead o=
f updating
> > > > > the branch head that got rebased, the, uhm, "upstream" gets u=
pdated.
> > > >=20
> > > > The last sentence is wrong I think - it is still the branch hea=
d that
> > > > is updated.
> > >=20
> > > But you don't rebase the branch head. Before the rebase, the bran=
ch head
> > > doesn't reference the commits that get rebased. For example:
> > >=20
> > > git checkout bar
> > > git rebase --revisions foo bar
> > >=20
> > > You "rebase" the commits in foo's history, but you update bar.
> >=20
> > Yes, that's the who point of the patch.
>=20
> Yes, and it's "backwards" compared to the existing "rebase" modes, bu=
t
> more like "cherry-pick".
>=20
> > The above applies a single commit, foo, on top of current branch ba=
r.
>=20
> Hm, no. I expected it to turn all commits reachable from foo into
> patches and applying them to bar. But actually, that should hit the
> special <since> mode of format-patch. So
> git rebase --revisions foo bar
> is (with your patch) actually the same as
> git rebase foo bar
>=20
> So actually the example should have been:
> git rebase --root --revisions foo bar
>=20
> Both invocations probably mess up the diff-stat as that becomes:
> git diff --stat --summary foo
> So it creates a diffstat of the diff from the working tree to "foo",
> which can't be right.
>=20
> >=20
> > > WRT the result, the above command should be equivalent to:
> > > git checkout bar
> > > git reset --hard foo
> > > git rebase --root --onto ORIG_HEAD;
> > >=20
> > > And here, the commits currently reachable through "bar" are rebas=
ed, and
> > > "bar" also gets updated.
> >=20
> > So this=20
> > 1. won't be very useful, as you show it is easy
> >    to achieve with existing commands.
>=20
> One can "almost" achieve it.
> git rebase --revision A..B foo
>=20
> is about the same as:
> git checkout foo
> git reset --hard B
> git rebase --onto ORIG_HEAD A
>=20
> But:
> a) The "reset --hard" obviously lacks the safety checks for clean
> index/working tree.
> b) "git rebase --abort" won't take you back to your initial state, bu=
t
> to B.
> c) It's not really obvious that you can do it and how to do it.
>=20
> Another possibility would be:
>=20
> git checkout B^0 # detach HEAD at B
> git rebase foo # rebase onto foo
> git checkout foo=20
> git merge HEAD@{1} # Fast-forwards foo to the rebased stuff
>=20
> That fixes a), avoid b) [because you don't mess up any branch head
> early] but is still subject to c).
>=20
> And for both methods, the ORIG_HEAD and HEAD@{1} arguments are somewh=
at
> "unstable", e.g. checking out the wrong branch head first, and only t=
hen
> the correct one, you'd have to use HEAD@{2} instead of HEAD@{1} (beca=
use
> the reflog for HEAD got a new entry).
>=20
> So you can already do what you want to do, but wrapping it in a singl=
e
> porcelain might still be useful because it's obviously a  lot easier =
and
> safer that way. That said, I wonder what kind of workflow you're usin=
g
> though, and why you require that feature. I've never needed something
> like that.

I need this often for many reasons:
-	Imagine developing a patchset with a complex bugfix on master branch.
	Then I decide to also apply (backport) this patchset to stable branch.
-	Imagine developing a bugfix/feature patchset on master branch.
	Then I decide the patchset is too large/unsafe and want to
	switch it to staging branch.
-	I have a large queue of patches on staging branch, I decide that
	a range of patches is mature enough for master.

And I often need -i to inspec/edit patches while doing this,
even though I can rebase -i later, but that would mean
figuring which commit to pass to rebase -i.

> > 2. interprets "foo" as branch name as opposed to
> >    revision range.
>=20
> Well, a single committish is a "range" as far as the range-based
> commands are concerned, e.g. "git log master" treats "master" to mean
> all commits reachable it. If "rebase --revisions master" would do the
> same, that's at least consistent (and for single commit picks, there'=
s
> already cherry-pick). The problem with your patch is that it passes t=
he
> revision argument to format-patch as is, and:
> git format-patch foo
> is the same as
> git format-patch foo..HEAD
>=20
>=20
> > OTOH, rebase --revisions as I implemented is a "smarter cherry-pick=
"
> > which can't easily be achieved with existing commands, especially i=
f
> > you add "-i".
>=20
> And that "is a 'smarter cherry-pick'" is why I think that rebase is
> actually the wrong command to get that feature. While rebase internal=
ly
> does just mass-cherry-picking, it does that with commits in the curre=
nt
> branch onto a specified branch. The --revisions flag makes it do thin=
gs
> the other way around.
>=20
> Bj=F6rn

Well, implemenation-wise, teaching cherry-pick about multiple
commits seems very hard to me. We would need to teach it about
all the flags that rebase has to patch queue management.
So I can't implement it. Can you?

--=20
MST
