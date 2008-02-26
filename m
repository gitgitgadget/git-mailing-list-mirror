From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Build in clone
Date: Tue, 26 Feb 2008 13:19:41 +0100
Message-ID: <200802261319.41862.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LSU.1.00.0802261111460.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Kristian =?utf-8?q?H=C3=B8gsberg?= <krh@redhat.com>,
	Santi =?utf-8?q?B=C3=A9jar?= <sbejar@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 13:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTyo9-0001Jr-3K
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYBZMUl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2008 07:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbYBZMUk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:20:40 -0500
Received: from sam.opera.com ([213.236.208.81]:32968 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbYBZMUj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:20:39 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m1QCJgQt023931
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Feb 2008 12:19:42 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0802261111460.17164@racer.site>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/6000/Tue Feb 26 10:04:46 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75126>

On Tuesday 26 February 2008, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 26 Feb 2008, Johan Herland wrote:
>=20
> > On Monday 25 February 2008, Daniel Barkalow wrote:
> > > This version is still a mess, but it passes all of the tests.
> >=20
> > Not for me:
> > *** t5700-clone-reference.sh ***
> > *   ok 1: preparing first repository
> > *   ok 2: preparing second repository
> > * FAIL 3: cloning with reference (-l -s)
> >         git clone -l -s --reference B A C
>=20
> Which machine?  What is your base (next or master)?  What does the ve=
rbose=20
> output look like?

I'm at work now (with a different machine), and when I try to reproduce
I get either 4 errors (with "make test") or 7 errors (with
"sh ./t5700-clone-reference.sh"). See [1] for verbose output.
This is with next (v1.5.4.3-342-g99e8cb6) + Daniel's patch on a 64-bit
Gentoo Linux on top of Intel Core 2 Duo with 4GB RAM. My home box is
similar (Quad instead of Duo). Without Daniel's patch, the entire test
suite passes.

> > diff --git a/builtin-clone.c b/builtin-clone.c
> > index 5aa75e1..7eed340 100644
> > --- a/builtin-clone.c
> > +++ b/builtin-clone.c
> > @@ -1,7 +1,7 @@
> >  /*
> >   * Builtin "git clone"
> >   *
> > - * Copyright (c) 2007 Kristian H=C3=B8gsberg <krh@redhat.com>
> > + * Copyright (c) 2007 Kristian H=C3=83=C2=B8gsberg <krh@redhat.com=
>
>=20
> This is almost certainly wrong.

Yes. But the intent is valid: His name should be in UTF-8; not i latin-=
1.

> > @@ -79,7 +79,7 @@ static char *get_repo_path(const char *repo)
> > =20
> >  	if (!stat(repo, &buf) && S_ISDIR(buf.st_mode))
> >  		return xstrdup(make_absolute_path(repo));
> > -=09
> > +
>=20
> Trailing whitespace.  Okay.
>=20
> > @@ -347,6 +347,9 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
> >  	char *path, *dir, *head, *ref_temp;
> >  	struct ref *refs, *r, *remote_head, *head_points_at, *remote_mast=
er;
> >  	char branch_top[256], key[256], refname[256], value[256];
> > +	struct strbuf reflog_msg;
> > +
> > +	git_config(git_default_config);
>=20
> Good catch.

Thanks.

> > @@ -495,7 +501,7 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
> >  	if (!remote_head) {
> >  		/* If there isn't one, oh well. */
> >  	} else if (remote_master && !hashcmp(remote_master->old_sha1,
> > -				      remote_head->old_sha1)) {
> > +					     remote_head->old_sha1)) {
>=20
> I am not so sure about this change.  It is unneeded, and distracts fr=
om=20
> the rest.

Yes, if this were meant for inclusion, I'd agree. However, as I origina=
lly
stated above the patch, this was pretty much a verbatim dump of my buff=
ers
with the immediate issues I found. It was meant as (hopefully useful)
feedback to Daniel, and not for any kind of consumption by git proper.

Still, I should probably have taken the extra minute to filter out unne=
eded
whitespace churn.


Have fun! :)

=2E..Johan


[1] Verbose output from t5700-clone-reference.sh:

$ ./t5700-clone-reference.sh --verbose
* expecting success: test_create_repo A && cd A &&
echo first > file1 &&
git add file1 &&
git commit -m initial
Created initial commit 8c40535: initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file1
*   ok 1: preparing first repository

* expecting success: git clone A B && cd B &&
echo second > file2 &&
git add file2 &&
git commit -m addition &&
git repack -a -d &&
git prune
Initialize B/.git
Initialized empty Git repository in B/.git/
Okay
Get for /home/johanh/git-test/git/t/trash/A/.git
0x714f50
HEAD
refs/heads/master
work tree now /home/johanh/git-test/git/t/trash/B
Created commit 4f5d964: addition
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file2
Counting objects: 6, done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (6/6), done.
Total 6 (delta 0), reused 0 (delta 0)
*   ok 2: preparing second repository

* expecting success: git clone -l -s --reference B A C
Initialize C/.git
Initialized empty Git repository in C/.git/
Okay
Wrote /home/johanh/git-test/git/t/trash/B/.git/objects
 to C/.git/objects/info/alternates
4f5d96490c0371a2814efb3203ed699ef4814fda -> C/.git/refs/reference-tmp/4=
f5d96490c0371a2814efb3203ed699ef4814fda
error: refs/remotes/origin/HEAD does not point to a valid object!
error: Z;n=EF=BF=BD+ does not point to a valid object!
error: Z;n=EF=BF=BD+ does not point to a valid object!
error: =EF=BF=BDp does not point to a valid object!
error: Z;n=EF=BF=BD+ does not point to a valid object!
error: Z;n=EF=BF=BD+ does not point to a valid object!
error: Y;n=EF=BF=BD+ does not point to a valid object!
error: q does not point to a valid object!
=2E/test-lib.sh: line 193: 32376 Segmentation fault      git clone -l -=
s --reference B A C
* FAIL 3: cloning with reference (-l -s)
        git clone -l -s --reference B A C

* expecting success: test `wc -l <C/.git/objects/info/alternates` =3D 2
* FAIL 4: existence of info/alternates
        test `wc -l <C/.git/objects/info/alternates` =3D 2

* expecting success: cd C &&
git pull ../B master
*   ok 5: pulling from reference

* expecting success: cd C &&
echo "0 objects, 0 kilobytes" > expected &&
git count-objects > current &&
diff expected current
*   ok 6: that reference gets used

* expecting success: git clone --reference B file://`pwd`/A D
Initialize D/.git
Initialized empty Git repository in D/.git/
Okay
Wrote /home/johanh/git-test/git/t/trash/B/.git/objects
 to D/.git/objects/info/alternates
4f5d96490c0371a2814efb3203ed699ef4814fda -> D/.git/refs/reference-tmp/4=
f5d96490c0371a2814efb3203ed699ef4814fda
error: refs/remotes/origin/HEAD does not point to a valid object!
=EF=BF=BD+ does not point to a valid object!
=EF=BF=BD+ does not point to a valid object!
error: =EF=BF=BDp does not point to a valid object!
=EF=BF=BD+ does not point to a valid object!
=EF=BF=BD+ does not point to a valid object!
error:  does not point to a valid object!
=2E/test-lib.sh: line 193: 32440 Segmentation fault      git clone --re=
ference B file://`pwd`/A D
* FAIL 7: cloning with reference (no -l -s)
        git clone --reference B file://`pwd`/A D

* expecting success: test `wc -l <D/.git/objects/info/alternates` =3D 1
*   ok 8: existence of info/alternates

* expecting success: cd D && git pull ../B master
*   ok 9: pulling from reference

* expecting success: cd D && echo "0 objects, 0 kilobytes" > expected &=
&
git count-objects > current &&
diff expected current
*   ok 10: that reference gets used

* expecting success: cd A &&
echo third > file3 &&
git add file3 &&
git commit -m update &&
git repack -a -d &&
git prune
Created commit 20c3827: update
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file3
Counting objects: 6, done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (6/6), done.
Total 6 (delta 0), reused 0 (delta 0)
*   ok 11: updating origin

* expecting success: cd C &&
git pull origin
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
* FAIL 12: pulling changes from origin
        cd C &&
        git pull origin

* expecting success: cd C &&
echo "2 objects" > expected &&
git count-objects | cut -d, -f1 > current &&
diff expected current
1c1
< 2 objects
---
> 0 objects
* FAIL 13: that alternate to origin gets used
        cd C &&
        echo "2 objects" > expected &&
        git count-objects | cut -d, -f1 > current &&
        diff expected current

* expecting success: cd D &&
git pull origin
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly
* FAIL 14: pulling changes from origin
        cd D &&
        git pull origin

* expecting success: cd D &&
echo "5 objects" > expected &&
git count-objects | cut -d, -f1 > current &&
diff expected current
1c1
< 5 objects
---
> 0 objects
* FAIL 15: check objects expected to exist locally
        cd D &&
        echo "5 objects" > expected &&
        git count-objects | cut -d, -f1 > current &&
        diff expected current

* failed 7 among 15 test(s)


--=20
Johan Herland, <johan@herland.net>
www.herland.net
