From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 20:11:07 +0100
Message-ID: <20091208191107.GA4103@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <20091208160822.GA1299@atjola.homenet>
 <20091208161406.GB32045@redhat.com>
 <20091208163737.GA2005@atjola.homenet>
 <20091208164449.GA32204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:11:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI5T1-0006g8-PK
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 20:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965794AbZLHTLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 14:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965791AbZLHTLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 14:11:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:33123 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965790AbZLHTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 14:11:08 -0500
Received: (qmail invoked by alias); 08 Dec 2009 19:11:11 -0000
Received: from i59F55883.versanet.de (EHLO atjola.homenet) [89.245.88.131]
  by mail.gmx.net (mp056) with SMTP; 08 Dec 2009 20:11:11 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/JQd4VOrLJPW7EuFtp2b3fgAysemUsk1pXgyyIGW
	SNwmkIT6qgsqWV
Content-Disposition: inline
In-Reply-To: <20091208164449.GA32204@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134903>

On 2009.12.08 18:44:49 +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2009 at 05:37:37PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2009.12.08 18:14:07 +0200, Michael S. Tsirkin wrote:
> > > On Tue, Dec 08, 2009 at 05:08:22PM +0100, Bj=F6rn Steinbrink wrot=
e:
> > > > On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> > > > > Add --revisions flag to rebase, so that it can be used
> > > > > to apply an arbitrary range of commits on top
> > > > > of a current branch.
> > > > >=20
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >=20
> > > > > I've been wishing for this functionality for a while now,
> > > > > so here goes. This isn't yet properly documented and I didn't
> > > > > write a test, but the patch seems to work fine for me.
> > > > > Any early flames/feedback?
> > > >=20
> > > > This pretty much reverses what rebase normally does. Instead of=
 "rebase
> > > > this onto that" it's "'rebase' that onto this". And instead of =
updating
> > > > the branch head that got rebased, the, uhm, "upstream" gets upd=
ated.
> > >=20
> > > The last sentence is wrong I think - it is still the branch head =
that
> > > is updated.
> >=20
> > But you don't rebase the branch head. Before the rebase, the branch=
 head
> > doesn't reference the commits that get rebased. For example:
> >=20
> > git checkout bar
> > git rebase --revisions foo bar
> >=20
> > You "rebase" the commits in foo's history, but you update bar.
>=20
> Yes, that's the who point of the patch.

Yes, and it's "backwards" compared to the existing "rebase" modes, but
more like "cherry-pick".

> The above applies a single commit, foo, on top of current branch bar.

Hm, no. I expected it to turn all commits reachable from foo into
patches and applying them to bar. But actually, that should hit the
special <since> mode of format-patch. So
git rebase --revisions foo bar
is (with your patch) actually the same as
git rebase foo bar

So actually the example should have been:
git rebase --root --revisions foo bar

Both invocations probably mess up the diff-stat as that becomes:
git diff --stat --summary foo
So it creates a diffstat of the diff from the working tree to "foo",
which can't be right.

>=20
> > WRT the result, the above command should be equivalent to:
> > git checkout bar
> > git reset --hard foo
> > git rebase --root --onto ORIG_HEAD;
> >=20
> > And here, the commits currently reachable through "bar" are rebased=
, and
> > "bar" also gets updated.
>=20
> So this=20
> 1. won't be very useful, as you show it is easy
>    to achieve with existing commands.

One can "almost" achieve it.
git rebase --revision A..B foo

is about the same as:
git checkout foo
git reset --hard B
git rebase --onto ORIG_HEAD A

But:
a) The "reset --hard" obviously lacks the safety checks for clean
index/working tree.
b) "git rebase --abort" won't take you back to your initial state, but
to B.
c) It's not really obvious that you can do it and how to do it.

Another possibility would be:

git checkout B^0 # detach HEAD at B
git rebase foo # rebase onto foo
git checkout foo=20
git merge HEAD@{1} # Fast-forwards foo to the rebased stuff

That fixes a), avoid b) [because you don't mess up any branch head
early] but is still subject to c).

And for both methods, the ORIG_HEAD and HEAD@{1} arguments are somewhat
"unstable", e.g. checking out the wrong branch head first, and only the=
n
the correct one, you'd have to use HEAD@{2} instead of HEAD@{1} (becaus=
e
the reflog for HEAD got a new entry).

So you can already do what you want to do, but wrapping it in a single
porcelain might still be useful because it's obviously a  lot easier an=
d
safer that way. That said, I wonder what kind of workflow you're using
though, and why you require that feature. I've never needed something
like that.

> 2. interprets "foo" as branch name as opposed to
>    revision range.

Well, a single committish is a "range" as far as the range-based
commands are concerned, e.g. "git log master" treats "master" to mean
all commits reachable it. If "rebase --revisions master" would do the
same, that's at least consistent (and for single commit picks, there's
already cherry-pick). The problem with your patch is that it passes the
revision argument to format-patch as is, and:
git format-patch foo
is the same as
git format-patch foo..HEAD


> OTOH, rebase --revisions as I implemented is a "smarter cherry-pick"
> which can't easily be achieved with existing commands, especially if
> you add "-i".

And that "is a 'smarter cherry-pick'" is why I think that rebase is
actually the wrong command to get that feature. While rebase internally
does just mass-cherry-picking, it does that with commits in the current
branch onto a specified branch. The --revisions flag makes it do things
the other way around.

Bj=F6rn
