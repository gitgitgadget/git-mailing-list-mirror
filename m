From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG(s)?] dangling symref breaks filter-branch
Date: Sat, 18 Jul 2009 07:28:31 +0200
Message-ID: <20090718052831.GA11825@atjola.homenet>
References: <20090718021144.162050@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Jaeger <pflanze@gmx.ch>
X-From: git-owner@vger.kernel.org Sat Jul 18 07:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS2TU-0003e8-HK
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 07:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbZGRF2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 01:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZGRF2f
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 01:28:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:43781 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751282AbZGRF2f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 01:28:35 -0400
Received: (qmail invoked by alias); 18 Jul 2009 05:28:32 -0000
Received: from i59F56D72.versanet.de (EHLO atjola.local) [89.245.109.114]
  by mail.gmx.net (mp063) with SMTP; 18 Jul 2009 07:28:32 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18FKhxvX0MFZniKZDJPIMkPnakZZIUkz2bdeO0wbS
	046tIhmOafPLuH
Content-Disposition: inline
In-Reply-To: <20090718021144.162050@gmx.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123508>

On 2009.07.18 04:11:44 +0200, Christian Jaeger wrote:
> Hello
>=20
> $ git branch -a
>   master
> * stablepatches
>   work
>   remotes/origin/origin/master
>   remotes/origin/stablepatches
>   remotes/origin/work
>=20
> $ git filter-branch --env-filter '..somecode..'
> fatal: missing object 0000000000000000000000000000000000000000 for re=
fs/remotes/origin/HEAD

This comes from the for-each-ref call that checks whether the backup
namespace is empty. This is probably be fixed like this:


diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 37e044d..7809db4 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -227,7 +227,7 @@ GIT_WORK_TREE=3D.
 export GIT_DIR GIT_WORK_TREE
=20
 # Make sure refs/original is empty
-git for-each-ref > "$tempdir"/backup-refs || exit
+git for-each-ref $orig_namespace > "$tempdir"/backup-refs || exit
 while read sha1 type name
 do
 	case "$force,$name" in

But I'm not sure if this is wanted, and this also breaks test
t7003-filter-branch.sh, because test 6 relies on the fact that all refs
are listed. While this looks like a wrong assumption in the test to me,
I have no idea how to fix the test. :-(

> Same thing happened with whatever additional argument (rev-list) I
> would give to git filter-branch.
>=20
> When I cloned this repo and run the filter-branch in the clone, it
> worked.
>=20
> git fsck --all on the faulty repo reported nothing but a couple
> dangling objects.
>=20
> I used git version 1.6.3.3 and then 1.6.4.rc1 (same problem). Further
> digging has revealed:
>=20
> $ cat .git/refs/remotes/origin/HEAD
> ref: refs/remotes/origin/master
> $ cat .git/refs/remotes/origin/master
> cat: .git/refs/remotes/origin/master: No such file or directory

The second "cat" doesn't tell much, the ref might be stored in
=2Egit/packed-refs. (Though it didn't exist at all in this case, as can=
 be
seen from the "git branch -a" output above).

> $ git rev-parse refs/remotes/origin/HEAD
> said "dangling symref refs/remotes/origin/HEAD."
>=20
> $ rm .git/refs/remotes/origin/HEAD
> has made filter-branch work again.
>=20
>=20
> So, issue one I'm wondering about: how comes I had this dangling
> symbolic ref? If it makes git tools break, shouldn't those refs be
> updated in a safe way (so that interruption can't leave those behind)=
,
> or maybe should the tools be fixed for not handling them correctly.

The symref was most likely created by "git clone". It references the
remote tracking branch for the remote's branch that was referenced by
the remote's HEAD at the time of the clone. Its purpose is to serve as =
a
shortcut for the remote's "primary" branch. Instead of origin/HEAD, you
can just write "origin", so you can do "git log origin.." instead of,
for example, "git log origin/master..".

As we reconstructed on IRC, you cloned the repo while it still had a
branch head called "master", and that was the primary branch. So
origin/HEAD was created as a symref to origin/master. In the meantime,
the "origin" repo got changed and the "master" branch head was deleted.
A call to "git remote prune" then killed "origin/master" locally and th=
e
symref got broken.

Regarding your "rm .git/refs/remotes/origin/HEAD" fix, this can nowaday=
s
be done using "git remote set-head". That command can create, updated o=
r
delete the <remote>/HEAD symrefs, without requiring the user to use
plumbing (git symbolic-ref) or knowing about how and where the refs are
stored within .git.

HTH
Bj=F6rn
