From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: Disappearing change on pull rebase
Date: Thu, 10 Nov 2011 17:23:36 +0300
Message-ID: <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pitucha, Stanislaw Izaak" <stanislaw.pitucha@hp.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 14:24:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROUc6-00059n-8g
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 14:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab1KJNYM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 08:24:12 -0500
Received: from mail1.intellij.net ([46.137.178.215]:45049 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1KJNYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 08:24:12 -0500
Received: (qmail 16304 invoked by uid 89); 10 Nov 2011 13:24:10 -0000
Received: by simscan 1.1.0 ppid: 16162, pid: 16273, t: 0.2245s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 10 Nov 2011 13:24:09 -0000
In-Reply-To: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185227>

10.11.2011, =D7 16:15, Pitucha, Stanislaw Izaak:

> Hi all,
> I've got an issue with some operations. It seems like git eats one of=
 my commits (it's still in reflog, but in normal tree, it's unavailable=
).
>=20
> What I did is:
>=20
> checkout -b feature/....
> (edit files and commit)
> checkout master
> merge --no-ff --no-commit feature/...
> (edit some files, change versions, changelog)
> commit
>=20
> Now I've got the change committed in the branch and some more changes=
 on the merge commit.
> So before pushing to the main repo, I'd like to check if any other ch=
anges are there:
>=20
> pull --rebase
>=20
> Now my merge commit disappears completely along with the changes with=
out any warning. I get the branch commits duplicated on top of master a=
nd the branch stays as it was.
> That looks like a data loss bug to me since I can only recover a comm=
itted change from reflog and there are no warnings before that change g=
oes away (using 1.7.4.1). Actually no changes were done in upstream in =
the meantime, so the rebase was not even needed.
>=20

That is definitely not a bug.=20
"git pull --rebase" is (almost?) equal to "git fetch ; git rebase origi=
n/master"
When you perform a rebase, at first your HEAD is rolled back to the com=
mit before your changes, then it is fast-forwared to the remote HEAD (i=
n your case, no fast-forward was made, because there were no remote cha=
nges); then your commits are applied one by one.

Of couse, when your commits are applied, they are applied like patches.=
 That mean, that they are different from the original commits (at least=
, by the commit time). That causes the duplication.

And the merge commit "dissapeared", because it contained no changes, so=
 the patch was empty, and there was nothing to reapply.
If the merge commit contained some changes, and it really was not appli=
ed during rebase, it is a bug, but more details will be needed, I think=
=2E

If you want to preserve your branch history, you should do "pull" witho=
ut "rebase".

Kirill.
