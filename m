From: "Harald Heigl" <Harald@heigl-online.at>
Subject: What to do if the path of my git submodules change upstream
Date: Sat, 26 Nov 2011 17:45:35 +0100
Message-ID: <002d01ccac5a$d2286ac0$76794040$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 26 17:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RULNp-0005mq-0c
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 17:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab1KZQpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 11:45:40 -0500
Received: from xserv02.internex.at ([85.124.51.102]:49350 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753090Ab1KZQpj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 11:45:39 -0500
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 22310 invoked from network); 26 Nov 2011 16:45:35 -0000
Received: by simscan 1.4.0 ppid: 22279, pid: 22306, t: 0.1392s
         scanners: clamav: 0.97/m:54/d:13991
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 26 Nov 2011 16:45:35 -0000
References: 
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AcykbVOUYs4xONHxR4alkgelAa20AAH4YP1w
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185954>


> Hi everyone!
>=20
> First setup of my git was a server (with ssh) and some clients.
>=20
> Today I changed to gitolite because I wanted a more sophisticated way=
 of
> managing my repos. So far so good=85
> So the old path =93ssh://[ip]/[fullpath].git=94 would change to a new=
 path
> =93git@[servername]:[gitreponame]=94.
> This is no problem for =93normal=94 repos, I change the remote origin=
 and
> continue using push and pull.
>=20
> I have some submodules:
> I changed the .gitmodules to reflect my changes, did a git submodule =
sync.
> This works flawlessly too!
>=20
> But what if someone wants to checkout an older version of the project=
?
(for
> comparison, or because he/she wanted to try something out)
> He would get an old .gitmodules with old paths.
> After a git submodule sync he would get errors, because old paths won=
=92t
> work anymore, because I changed some paths on the server
>=20
> It is only one project I have this problem and therein I changed the
> .gitmodules only 3 times. Is it possible to rewrite .gitmodules on th=
ese
> specific =A0commits on the server (perhaps with git-filter-branch)?
> Or is there another easy solution? Has someone ever had this problem?
>=20
> Hope you can help,
> Kind regards,
> Harald Heigl


Hi everyone!
I try to answer myself, I found a possibility to change the file
".gitmodules" in my git history:

---------------
Method 1 with some git plumbing:

cd [gitrepo]
cd ..
[prepare my "new" .gitmodules-File here]
cd [gitrepo]
git hash-object -w ../.gitmodules
git filter-branch --index-filter 'git rm --cached --ignore-unmatch
=2Egitmodules;git update-index --add --cacheinfo 100644 \
    3e0f4ab4126e01d55fda040234e3593aea1bff79 .gitmodules'
022d9c5fecb4d6c268365dfe186aa65389bcd492^..
Push this new branch to a remote repo and clone from there again (so I'=
ll
have a sober dir, without the old branches)

More or less this adds a new object to git (with SHA1 3e0f4ab in my cas=
e)
and then rewrites every index to remove my old .gitmodules and add the =
newly
entered .gitmodules.

The only "problem" is that this will rewrite all Commits and therefore =
also
the SHA1 which won't match the one on the server.=20
As my understanding in git is now: After a change of the (already pushe=
d)
commits I'll have to delete the remote repo, push my changed repo upstr=
eam
and then everyone in the team will have to clone this new repo. Good th=
at
this project affects only a small group in my company.=20

------------
Method 2 with git rebase -i:
git rebase -i 022d9c5fecb4d6c268365dfe186aa65389bcd492^

This will rebase anything and I can rewrite my file on the specific com=
mits.
But this will change my whole history (and SHAs too). If there are some
merges in these commit the rebase would flatten anything. This wouldn't
disturb that way, but leads to conflicts I have to resolve on the rebas=
e
side for every commit that conflicts.
 ------------

I'll think over it, if I use Method 1 or don't change anything. Perhaps=
 the
latter would be the best :-)

Hope this helps others,
Kind regards
