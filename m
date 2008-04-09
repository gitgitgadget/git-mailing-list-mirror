From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for
	tags
Date: Wed, 9 Apr 2008 13:28:56 +0200
Message-ID: <20080409112856.GB16607@atjola.homenet>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com> <20080407195610.13681.39351.malone@potassium.ubuntu.com> <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com> <20080408171502.GA6163@atjola.homenet> <cd53a0140804081343l4b791dc3x5fa3fb294af71621@mail.gmail.com> <20080409080333.GA13892@atjola.homenet> <cd53a0140804090339h472bc672ucd84b0ff13e2eeee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Leonard <talex5@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 13:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjYUr-0002jl-Ic
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 13:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYDIL3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 07:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYDIL3A
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 07:29:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:38039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752406AbYDIL3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 07:29:00 -0400
Received: (qmail invoked by alias); 09 Apr 2008 11:28:57 -0000
Received: from i577BA362.versanet.de (EHLO atjola.local) [87.123.163.98]
  by mail.gmx.net (mp040) with SMTP; 09 Apr 2008 13:28:57 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX191n+kHbCF123QVBRLaGiKFxHhaADVY+qrezdDysx
	c2J7X93tDg1v/z
Content-Disposition: inline
In-Reply-To: <cd53a0140804090339h472bc672ucd84b0ff13e2eeee@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79104>

On 2008.04.09 11:39:17 +0100, Thomas Leonard wrote:
> On 09/04/2008, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> wrote:
> >  On 2008.04.08 21:43:03 +0100, Thomas Leonard wrote:
> >  > The log shows:
> >  >
> >  > ----------------------------------------------------------------=
--------
> >  > r4 | talex | 2008-04-08 21:35:44 +0100 (Tue, 08 Apr 2008) | 1 li=
ne
> >  > Changed paths:
> >  >    A /release (from /trunk:1)
> >  >    A /release/bar (from /trunk/bar:3)
> >  >    A /release/foo (from /trunk/foo:2)
> >  >
> >  > Release
> >
> > Change the "." to "file:///tmp/test-repo/trunk" in the svn cp comma=
nd
> >  and you get:
> >  Changed paths:
> >    A /release (from /trunk:3)
> >
> >  Seems more useful. No idea why SVN decides to record crap when you=
 use
> >  ".", even when your working copy is clean.
>=20
> That's good advice, but I'm wondering how to convert my existing svn
> repositories to GIT.

I'd probably patch git-svn locally once and revert it after the import,
if your suggested change really makes sense for your repo. Another
option would be to adjust the branches afterwards, but that's probably
awkward in your case. Maybe a patch that allows to toggle the branch
creation logic would be accepted as well, dunno.

> >  > So, I don't think the metadata is broken in this case. Maybe oth=
er
> >  > people don't create branches like this, but it seemed like the o=
bvious
> >  > way to do it at the time. Given this behaviour of svn, perhaps i=
t
> >  > would be better to take the highest version number as the branch
> >  > point?
> >
> > Uhm, and what happens then, when you actually _did_ just copy over =
a
> >  few files, but not all of them? Right, you get a branch to start a=
t a
> >  later revision and see a bunch of reverts. Equally broken.
>=20
> Sure, if you create a situation that GIT can't represent then there's
> nothing much git-svn can do.
>=20
> However, when there are different source revisions:
>=20
> - Taking the highest revision will give correct results in the common
> case, and "equally broken" results in the uncommon case.
>=20
> - Taking any other revision (the current behaviour) is guaranteed to
> give the wrong result. There's no way a branch that was created with =
a
> file from revision 6 can possibly be a branch of revision 5, for
> example.

Sure it can be.

svn co $repo full-repo-here
cd full-repo-here
svn cp trunk branches/b1 (at rev 5)
echo 123 > trunk/foo # (new file)
echo 456 > trunk/bar
# 431 other files changed (exaggeration ;-))
svn commit trunk -m "Committing trunk only, with 433 files changed"
svn cp trunk/foo branches/b1
svn commit branches/b1 -m "Committing b1."

b1 branched at rev 5, but has a single file from rev 6.

Currently, git-svn would create the branch starting at rev5, with
the addition of "foo" on top.

Your suggested change would make it branch at rev6 and revert 432 files=
=2E

The fact that svn just has directory copies as branches makes all kinds
of junk possible ;-)

> Also, the current behaviour can be wildly out (e.g. revision 1894 whe=
n
> it should have been 2070, in the previous real example). The highest
> revision is unlikely to be far off.

How many "interesting" revisions was it off by? 3? As the revision
numbers in svn are shared throughout the whole repo, your example sound=
s
far worse than it really is.

And for locally prepared branches (I've actually heard of people doing
that, like in my example above), it can happen for your way to be way
more off than the current way.

Bj=F6rn
