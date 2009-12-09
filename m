From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 16:02:36 +0200
Message-ID: <20091209140236.GL2977@redhat.com>
References: <20091208144740.GA30830@redhat.com> <20091208160822.GA1299@atjola.homenet> <20091208161406.GB32045@redhat.com> <20091208163737.GA2005@atjola.homenet> <20091208164449.GA32204@redhat.com> <20091208191107.GA4103@atjola.homenet> <20091208200017.GA827@redhat.com> <20091209131945.GB30218@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 09 15:05:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NINAY-0006nG-1U
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 15:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbZLIOFS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 09:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbZLIOFS
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 09:05:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19623 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858AbZLIOFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 09:05:17 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB9E5Lw6007370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 9 Dec 2009 09:05:21 -0500
Received: from redhat.com (vpn2-9-43.ams2.redhat.com [10.36.9.43])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB9E5IKV031807;
	Wed, 9 Dec 2009 09:05:19 -0500
Content-Disposition: inline
In-Reply-To: <20091209131945.GB30218@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134971>

On Wed, Dec 09, 2009 at 02:19:45PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.08 22:00:17 +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 08, 2009 at 08:11:07PM +0100, Bj=F6rn Steinbrink wrote:
> > > So you can already do what you want to do, but wrapping it in a s=
ingle
> > > porcelain might still be useful because it's obviously a  lot eas=
ier and
> > > safer that way. That said, I wonder what kind of workflow you're =
using
> > > though, and why you require that feature. I've never needed somet=
hing
> > > like that.
> >=20
> > I need this often for many reasons:
> > -	Imagine developing a patchset with a complex bugfix on master bra=
nch.
> > 	Then I decide to also apply (backport) this patchset to stable bra=
nch.
>=20
> Hm, I'd also imagine that you want a separate branch then, and not
> directly mess up the stable branch,

Well, directly working with a stable branch is easier, so yes,
I want to mess it up: this is just my local tree, if anything
goes wrong  I just don't push or "reset --hard origin/stable".

> so I'd do:
> git branch foo-stable foo # Create a branch for the backport
> git rebase --onto stable master foo-stable # Backport
>=20
> Now you got your backported version and can merge it to "stable".

The annoying thing is that merge step. I can create a merge
commit if I mistype things, and I do not want any
merge commits, I want to create linear history.

> Common wisdom is do things the other way around though. Create the
> bugfix for the oldest branch that it applies to, then merge it forwar=
d,
> either doing:
>=20
> "bugfix -> stable" and "stable -> master" merges, or
> "bugfix -> stable" and "bugfix -> master" merges.
>=20
> That approach has the advantage that you don't get multiple commits
> doing the same thing, which you get with rebasing/cherry-picking.
>=20
> IIRC the gitworkflows manpage describe that in some more detail.


I know. The advantage of making all changes to master first
is that this way a change gets more review and testing before
being applied to stable. Further, often different people
maintain master and stable branches.

> > -	Imagine developing a bugfix/feature patchset on master branch.
> > 	Then I decide the patchset is too large/unsafe and want to
> > 	switch it to staging branch.
>=20
> Hm, so you have a topic branch "foo" based upon master, but it's too
> experimental so you don't want to merge it to master, but "staging". =
I
> don't see why you even have to rebase it then. "staging" is likely ah=
ead
> of master, so the merge base of "foo" and "master" is also reachable
> through "staging", and simply merging "foo" to "staging" should work
> without any ill-effects.

Yes but I want my development history to be linear,
so that format patch rebase -i etc work well.

> > -	I have a large queue of patches on staging branch, I decide that
> > 	a range of patches is mature enough for master.
>=20
> Basically, same deal as with the first two cases. If the series is
> directly on "staging" (i.e. you didn't create a topic branch), you ca=
n
> create one now:
> git branch foo $last_commit_for_foo
> git rebase --onto master $first_commit_for_foo^ foo
>=20
> And you got your backported topic branch for "foo".
>=20
> Or you already have a topic branch "foo-staging", but it's based upon
> some commit only in "staging" but not in "master", so a plain merge
> would mess things up. Same deal as with backporting from "master" to
> "stable"

Yes, I understand that creating a temporary branch and checking it out
then merging it will make rebase do what I want.
The only disadvantage is that I need to remember where I am in the
process, while an "atomic" command does this for me.

> And in this case it's also true that basing the topic branches on
> "master" instead of "staging" makes things easier. That way, you can
> merge to either "staging" or "master" without any ill-effects.
>=20
> Bj=F6rn

As above, I do not want merges.
