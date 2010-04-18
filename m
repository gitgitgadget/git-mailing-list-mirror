From: Peter Collingbourne <peter@pcc.me.uk>
Subject: Re: Storing commits in trees
Date: Sun, 18 Apr 2010 18:48:54 +0100
Message-ID: <20100418174854.GA10132@pcc.me.uk>
References: <1271363532.18164.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Bernhard R . Link" <brlink@debian.org>
To: Joachim Breitner <mail@joachim-breitner.de>
X-From: git-owner@vger.kernel.org Sun Apr 18 19:49:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3YcO-0007bj-V5
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 19:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752Ab0DRRs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 13:48:56 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:36743 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab0DRRsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 13:48:55 -0400
Received: from peter by master.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O3Yc2-00034M-GB; Sun, 18 Apr 2010 18:48:54 +0100
Content-Disposition: inline
In-Reply-To: <1271363532.18164.47.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145222>

On Thu, Apr 15, 2010 at 10:32:12PM +0200, Joachim Breitner wrote:
> [Please CC me on reply, as I=E2=80=99m not subscribed. Thanks!]
>=20
> Hi,
>=20
> for a variation of the workflow implemented by git-dpm[1], a tool to
> manage the development of Debian packages in git, I wanted to refer t=
o a
> specific commit P from a regular commit D on my master branch, withou=
t P
> being a parent of D, as I don=E2=80=99t want it to show up in the his=
tory.
>=20
> I found out that I can store commit objects in a tree object, using g=
it=20
> $ git update-index --add --cacheinfo 160000 0ac1855f1681c05d195f219c3=
003a05dc8d3ac20 stored-commits/some-commit
> and refer to it via HEAD:stored-commits/some-commit. I was happy, unt=
il
> I noticed that git prune will happily delete the stored commit as soo=
n
> as it is not referred somewhere else, and git push/pull won=E2=80=99t=
 transfer
> the stored commit along the tree it is contained in.
>=20
> I then found out that storing commit objects in the tree is implement=
ed
> for git-submodules, where you in fact do not want to store the commit=
 in
> the main repo.
>=20
> Now I=E2=80=99m wondering if it would be feasible to offer this featu=
re: A
> proper =E2=80=9Ccommit=E2=80=9D object within a tree that is walked b=
y fsck_walk_tree
> and the other tree walkers?
>=20
> Or is there yet another way of telling git that commit D =E2=80=9Cdep=
ends on=E2=80=9D
> commit P?

Hi Joachim,

I encountered this problem while developing silt [1], another workflow
tool for Debian packaging, which uses a similar technique to refer to
commits from a tree (in this case, from the packaging tree to patch
commits derived from upstream).

I solved the problem by automatically creating a ref for each such
reference.  The name of the ref contains a reference to the earliest
unique commit on the branch ("earliest" is determined using the
commit date), to avoid cluttering the ref namespace every time the
ref changes.

Not only does one need to remember to push the patch refs along with
the main branch ref, the code that determines the earliest unique
commit is error prone and I agree that what would be beneficial would
be a "hard link" to a commit.

In terms of implementation, perhaps we can store a value in the lower
order bits of the mode which indicates whether this is a hard link?
This would ensure compatibility with older versions of git (S_ISGITLINK
would still hold for hard links).

[1] http://git.debian.org/?p=3Dusers/pcc-guest/silt.git;a=3Dsummary

Thanks,
--=20
Peter
