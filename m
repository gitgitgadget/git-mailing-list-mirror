From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git export to svn
Date: Sun, 26 Oct 2008 10:15:54 +0100
Message-ID: <20081026091554.GC3612@atjola.homenet>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com> <1224960205.2874.11.camel@localhost.localdomain> <77DFC428-35AE-4F66-9D9F-3D4E0005727D@gmail.com> <1224965564.2874.49.camel@localhost.localdomain> <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
To: Warren Harris <warrensomebody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 10:17:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku1kK-0001WJ-Jr
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 10:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbYJZJQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 05:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbYJZJQA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 05:16:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:55515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752586AbYJZJP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 05:15:59 -0400
Received: (qmail invoked by alias); 26 Oct 2008 09:15:56 -0000
Received: from i577B8FBC.versanet.de (EHLO atjola.local) [87.123.143.188]
  by mail.gmx.net (mp003) with SMTP; 26 Oct 2008 10:15:56 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1899AI9m6Y9ZPqyy5b1wIOJfBWrAdNu30DuCedef1
	EWqmXqrjHv7Kxr
Content-Disposition: inline
In-Reply-To: <2F1954CC-E013-4861-87F8-F89CF37CE53C@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99154>

On 2008.10.25 13:29:50 -0700, Warren Harris wrote:
> I tried a fetch, but still no luck:
>
> $ git svn fetch
> W: Ignoring error from SVN, path probably does not exist: (175002): R=
A =20
> layer request failed: REPORT of '/svn/!svn/bc/100': Could not read ch=
unk=20
> size: Secure connection truncated (https://svn)
> W: Do not be alarmed at the above message git-svn is just searching =20
> aggressively for old history.
> This may take a while on large repositories
> r58084 =3D c01dadf89b552077da132273485e7569d8694518 (trunk)
> 	A	...
> r58088 =3D 7916f3a02ad6c759985bd9fb886423c373a72125 (trunk)
>
> $ git svn rebase
> Unable to determine upstream SVN information from working tree histor=
y

Means that your current branch is not based on what git-svn has fetched=
,
which is expected when you use "svn init" + "svn fetch" after you
already started working.

What's the actual relationship between your local history and the
history you fetched from svn?

If your local stuff started from revision X, which you manually importe=
d
from svn, you can just rebase it:

git rebase --onto <svn-revision-X> <your-revision-X>


If you have a bunch of merges in your local history, you might want to
merge your stuff into the svn-based branch instead. When you dcommit,
the svn repo will only see one big "do it all" commit though.

=46or that, you would create a graft, so that your first "real" local
commit gets the svn revision X commit as its parent. That is, from:

S---S---SX---S---S---S (svn)

LX--------L---L---L---L (local)

You want to go to:

S---S---SX---S---S---S (svn)
         \
LX        L---L---L---L (local)


Where 'S' means that the commit came from SVN, and L means that it is a
"local" commit. SX and LX are the commits that have the same tree
attached (same directories/files), but have a different hash due to how
they were created. The graft overrides the parent-child relation for th=
e
first "L" commit, so that it actually appears as being branched off of =
SX.

And then, you'd merge local into svn, so you get:

S---S---SX---S---S---S--M (svn)
         \             /
LX        L---L---L---L (local)



If possible, go with the rebase though. That at least gives a somewhat
reasonable history in the svn repo as well. Also note that when you go
with the merge way, make sure that the svn branch is totally uptodate
before you merge and that the merge commit is the only one to be
dcommitted. Otherwise, funny stuff might happen, and rebase might kick
in anyway, I don't exactly remember what git-svn does, but it wasn't
pleasant :-)

Bj=F6rn
