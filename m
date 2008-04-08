From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Fwd: [Bug 163341] Re: git-svn gets wrong parent revision for
	tags
Date: Tue, 8 Apr 2008 19:15:02 +0200
Message-ID: <20080408171502.GA6163@atjola.homenet>
References: <20071117143713.8355.50653.malonedeb@potassium.ubuntu.com> <20080407195610.13681.39351.malone@potassium.ubuntu.com> <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Leonard <talex5@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjHQH-0002A5-Mv
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 19:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYDHRPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2008 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYDHRPI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 13:15:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:38392 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752527AbYDHRPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 13:15:07 -0400
Received: (qmail invoked by alias); 08 Apr 2008 17:15:03 -0000
Received: from i577BB179.versanet.de (EHLO atjola.local) [87.123.177.121]
  by mail.gmx.net (mp055) with SMTP; 08 Apr 2008 19:15:03 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+d/nZCIuSd7tGcUdGTg6QB9VR77txYT6g70Y6jhH
	opO9+WsLVvwdrM
Content-Disposition: inline
In-Reply-To: <cd53a0140804080848r54bb1e6dq54b5cce62339d6d1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79010>

On 2008.04.08 16:48:03 +0100, Thomas Leonard wrote:
> Hi.
>=20
> The git-svn Ubuntu packager asked me to forward this here.
>=20
> Summary:
>=20
> When converting a subversion repository to GIT using git-svn, the tag=
s
> do not have the right parent. Each tag should be identical to a trunk
> revision (which it was copied from), but because git-svn uses an
> earlier revision as the parent it appears that the same work was
> duplicated on two branches.
>=20
> Example:
>=20
> git-svn clone https://zero-install.svn.sourceforge.net/svnroot/zero-i=
nstall
> -T trunk/0publish -r1890:2072 -b releases/0publish
>=20
> The git branch comes from r1894, yet the svn log shows that in
> includes files from r2070:
>=20
> $ svn log https://zero-install.svn.sourceforge.net/svnroot/zero-insta=
ll
> -r2071 -v
> r2071 | tal197 | 2007-11-10 19:40:45 +0000 (Sat, 10 Nov 2007) | 1 lin=
e
> Changed paths:
>    A /releases/0publish/0publish-0.12 (from /trunk/0publish:1968)
>    R /releases/0publish/0publish-0.12/0publish (from
> /trunk/0publish/0publish:2070)
>    R /releases/0publish/0publish-0.12/0publish.xml (from
> /trunk/0publish/0publish.xml:2070)
>    R /releases/0publish/0publish-0.12/release.py (from
> /trunk/0publish/release.py:2069)

Well, SVN recorded useless, broken metadata.

SVN itself believes that the branch was created from revision 1968. As
that revision didn't introduce any changes to trunk/0publish, there's n=
o
commit for that revision in the git branch, so git-svn took the most
recent one instead (1894).

=46or the other three files, SVN reports that the files were replaced b=
y
versions from another branch. There's no immediate way to tell whether
those replacements make the branch equal to the more recent version of
trunk. So git-svn does it the safe way and reproduces what SVN told it
to reproduce: A commit that creates a branch and changes some files.

I guess sth. like this happened on the svn end:
svn cp trunk/0publish releases/0publish (at rev. 1968)
svn cp trunk/0publish/release.py releases/0publish (at rev. 2069)
=2E..
svn commit (whenever)

So the branch was "incrementally" created locally and SVN decided to
record the "Uh, I copied this from here to there" metacrap^H^H^H^Hdata,
of which git-svn made use. Hooray for rename/copy tracking.

You could maybe ask for an enhancement so that git-svn tries to figure
out if the provided metadata is broken and looks up a matching revision
in such a case. But I guess it's not worth the trouble and could lead t=
o
other breakage along the way...

Bj=F6rn
