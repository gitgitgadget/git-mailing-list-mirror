From: Kent Fredric <kentfredric@gmail.com>
Subject: IRC discussion re: submodules & missing refs/heads/master
Date: Thu, 19 Apr 2012 07:56:11 +1200
Message-ID: <CAATnKFDM5a9diHPg5QtS-jqEC1oYWL3a1dYnpwFLZK1UktgJAA@mail.gmail.com>
References: <CAATnKFCAAwJYTx42iX5ZQ5-HrygFwUCWnKDNj0GDydwPYs-Nvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 21:56:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKazB-0004Bc-8e
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab2DRT4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 15:56:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45124 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2DRT4M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 15:56:12 -0400
Received: by iagz16 with SMTP id z16so10853527iag.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=FuNRlUkD+pGT4KMX6mPbRugt4LZVEWlevU9RzIicoqQ=;
        b=lFU/zgsk+FsMwraX4kJoNktGvCtT86FXfai5dDHqcyqBt6t2Rd94IylUnBwvcH8ngf
         kYpL+nAvxQPlu6OqDMikbCjWYbD/4T3lJFIGIbF86ogUmGeX9GBDoukeVszCJ6g48MWh
         vObqT2n0ug5FBkDKc05/Ha1C6aiR+22cOdYegwQcLNQhteeQDevXuWulxkxLHU1Wnmbj
         GrWjFyJ6dlHD00mk+nwpKVJa6r5yztxxTk3NgnlL5vWrZamb+VfqZxnXuZJZOE9djoJV
         5O0ZHs4d3LsP6PHtj/HSCvEetiynoiFefNQxGwWFpiCCgshwZS29EITDYqV9tKq6FI4M
         ySoA==
Received: by 10.50.153.201 with SMTP id vi9mr14509609igb.46.1334778971409;
 Wed, 18 Apr 2012 12:56:11 -0700 (PDT)
Received: by 10.42.138.74 with HTTP; Wed, 18 Apr 2012 12:56:11 -0700 (PDT)
In-Reply-To: <CAATnKFCAAwJYTx42iX5ZQ5-HrygFwUCWnKDNj0GDydwPYs-Nvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195891>

Relevant transcript from IRC with jrnieder

---
06:47:09 < kent\n> I have a fun problem, somethings gone wrong with a
submodule somehow, now "git status" and friends just go "Fatal: Oops!"
06:47:39 < kent\n> Ok, no !, but thats basically what I get :/
06:48:29 < cbreak> kent\n: GIT_TRACE=3D1 git status ?
06:48:47 < FauxFaux> strace $(git --exec-dir)/git-status
06:50:01 < kent\n> cbreak: trace: built-in: git 'status'=C2=A0 , fatal:=
 Oops
06:50:26 < kent\n> FauxFaux: doesn't work, status is a builtin, not a
command.
06:50:45 < jrnieder> kent\n: do you mean literally "fatal: Oops"?
06:50:50 < kent\n> yes. Literally.
06:50:54 < FauxFaux> kent\n: ...that's what the purpose of the $() bit =
is.
06:51:16 < kent\n> FauxFaux: git --exec-dir dies anyway because it does=
n't
know what I'm asking it to do
06:51:17 < jrnieder> kent\n: I don't see that error message anywhere in=
 the
source code
06:51:21 < jrnieder> what version of git are you using?
06:51:24 < FauxFaux> kent\n: Uh, --exec-path
06:51:47 < FauxFaux> Also --version, yeah.
06:51:58 < jrnieder> ah, you didn't mean literally "fatal: Oops"
06:52:02 < jrnieder> you meant "fatal: oops"
06:52:11 < FauxFaux> Yay paraphrasing.
06:52:23 < kent\n> no, it has an upper-case O for me.
06:53:02 < jrnieder> kent\n: ok, git version then?
06:53:22 < kent\n> 1.7.8.5
06:54:04 < kent\n> strace seems to tell me the problem is its looking f=
or
the ref "head" on the submodule, but for some reason, the path when sta=
t()
'd returns not found
06:54:06 < jrnieder> kent\n: thanks
06:55:04 < jrnieder> this code changed a bit in v1.7.9-rc1~10^2~7 (Pass=
 a
(ref_cache *) to the resolve_gitlink_*() helper functions, 2011-12-12)
06:55:13 < kent\n> for some reason, my 'refs/heads' directory for my
submodule is empty :/
07:03:14=C2=A0 * kent\n looks around in his .git/refs dir and finds a b=
unch of
empty directories not seeming to correspond to anything


07:13:52 < kent\n> yay. managed to fix it. blew away module/${modname}/=
refs
, checked out a new branch in the module, deleted master, rechecked out
master, problem solved. ( wtf )
07:15:52=C2=A0 * kent\n has no idea why
=2Egit/modules/${modpathtingythere}/refs/heads/master=C2=A0 vanished.
07:16:02 < jrnieder> kent\n: hmm
07:16:16 < jrnieder> do you have a backup of the problematic state, or =
can
you make it happen again?
07:16:29 < kent\n> I'm going to try, should be as easy as rm
refs/heads/master
07:16:37 < jrnieder> ok
07:17:28 < kent\n> yep, that causes the problem to return.
07:17:34 < jrnieder> excellent
07:17:55 < jrnieder> if you use git 1.7.9 or newer, are the symptoms th=
e
same?
07:18:13 < kent\n> will give it a whirl, fortunately, have 2 boxen with
different gits =3D)
07:19:12 < jrnieder> (another way if you don't want to upgrade your sys=
tem
copy of git is to do: "git clone git://repo.or.cz/git.git; cd git; make=
 -j4"
and then use bin-wrappers/git from the source tree in place)
07:20:42 < jrnieder> kent\n: I have to head out now but anyway, this se=
ems
interesting
07:20:59 < jrnieder> whether 1.7.9 fixes it or not, if you get a chance=
 to
email git@vger.kernel.org about it, that would be useful
07:21:17 < kent\n> kk. will do.
07:21:21 < jrnieder> thanks much

Digging tells me that either Git gc or git prune is stripping the
"master" file, causing the issue:

cd $ROOT/metadata/perl/

md5sum $( find ../../.git/modules/metadata/perl/ -type f ) > /tmp/pregc
git gc
md5sum $( find ../../.git/modules/metadata/perl/ -type f ) > /tmp/postg=
c
git prune
md5sum $( find ../../.git/modules/metadata/perl/ -type f ) > /tmp/postp=
rune

diff3 /tmp/pregc /tmp/postgc /tmp/postprune
=3D=3D=3D=3D1
1:4c
  4800e0911d51d4829e5650c487931108
=2E./../.git/modules/metadata/perl/refs/heads/master
2:3a
3:3a

So it seems 1.7.8.5 is removing that file for some unknown reason.

cd $ROOT/metadata/perl
git status

# On branch master
nothing to commit (working directory clean)

cd $ROOT/

git status

fatal: Oops


Rsyncing that to a box with 1.7.9.4  , and giving it  a little path cle=
anup :

  sed -i 's!/var/paludis/repositories/perl-git/!/tmp/mirrorbox/!' $(
grep 'var/paludis/repositories' -R -l .  )

cd $ROOT

 git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#	modified:   metadata/perl (new commits)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	.mailmap
#	Todo.txt
#	dists.txt
#	filterchange.pl
#	fixme.pl
#	itemise_diff.pl
#	rebase.sh
#	rebase2.sh
#	rebash.sh
#	rebash2.pl
#	rebash2.pl.bak
#	scripts/gen_metadata.pl
#	ts
#	update-index.sh
no changes added to commit (use "git add" and/or "git commit -a")
[master *%] kent@katipo: /tmp/mirrorbox


( ALL GOOD )

cd $ROOT/metadata/perl

git status

git status
# On branch master
nothing to commit (working directory clean)

( ALL GOOD )

=46rankly, thats just .... weird.

--
Kent

perl -e=C2=A0 "print substr( \"edrgmaM=C2=A0 SPA NOcomil.ic\\@tfrken\",=
 \$_ * 3, 3 )
for ( 9,8,0,7,1,6,5,4,3,2 );"

http://kent-fredric.fox.geek.nz
