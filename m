From: "Todd T. Fries" <todd@fries.net>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 07:42:07 -0500
Organization: Free Daemon Consulting
Message-ID: <200710190742.08174.todd@fries.net>
References: <20071018203106.GA13518@fries.net> <20071019054814.GJ14735@spearce.org>
Reply-To: todd@fries.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gYKGHUHg1S99Yp3"
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 14:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IirBn-0005yJ-6D
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342AbXJSMmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXJSMmm
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:42:42 -0400
Received: from pf.FreeDaemonHosting.com ([66.210.104.252]:20110 "EHLO
	FreeDaemonHosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751958AbXJSMml (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:42:41 -0400
Received: from blue.fries.net (blue.hse.fries.net [IPv6:2001:240:58a::1c])
	by FreeDaemonHosting.com (8.13.8/8.13.8) with ESMTP id l9JCgMDC021513;
	Fri, 19 Oct 2007 07:42:23 -0500 (CDT)
Received: from blue.fries.net (localhost.fries.net [IPv6:::1])
	by blue.fries.net (8.14.1/8.13.6) with ESMTP id l9JCgDvF001005;
	Fri, 19 Oct 2007 07:42:13 -0500 (CDT)
Received: (from todd@localhost)
	by blue.fries.net (8.14.1/8.13.6/Submit) id l9JCg8Ea032650;
	Fri, 19 Oct 2007 07:42:08 -0500 (CDT)
X-Authentication-Warning: blue.fries.net: todd set sender to todd@fries.net using -f
User-Agent: KMail/1.9.7
In-Reply-To: <20071019054814.GJ14735@spearce.org>
X-FDH-MailScanner-Information: http://FreeDaemonHosting.com/MailScanner.html
X-FDH-MailScanner: clean
X-FDH-MailScanner-From: todd@fries.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61697>

--Boundary-00=_gYKGHUHg1S99Yp3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You're the second one to point out that I should check the errno of link() on
afs.

It should not matter, but I'm using arla's afs client on OpenBSD; the errno
is 17 (EEXIST), the very errno that bypasses the coda hack's rename():

  8484 git-index-pack CALL  mkdir(0xcfbdc750,0x1ff)
  8484 git-index-pack NAMI  ".git/objects/pack"
  8484 git-index-pack RET   mkdir -1 errno 17 File exists
  8484 git-index-pack CALL  link(0x829e7040,0xcfbdc750)
  8484 git-index-pack NAMI  ".git/objects/tmp_pack_BU8484"
  8484 git-index-pack 
NAMI  ".git/objects/pack/pack-db66c6d25d6e0044093252434b4aa2a7d67e386a.pack"
  8484 git-index-pack RET   link -1 errno 17 File exists

.. and does not go on to do a rename(), which based on the code makes sense.

I can assure you that the 2nd argument to link does not exist ;-)

So, I've made the following change and it seems to fix the problem, much
cleaner IMHO, and get the following change in behavior:

  5933 git-index-pack CALL  mkdir(0xcfbc0070,0x1ff)
  5933 git-index-pack NAMI  ".git/objects/pack"
  5933 git-index-pack RET   mkdir -1 errno 17 File exists
  5933 git-index-pack CALL  link(0x860c0040,0xcfbc0070)
  5933 git-index-pack NAMI  ".git/objects/tmp_pack_EV5933"
  5933 git-index-pack 
NAMI  ".git/objects/pack/pack-db66c6d25d6e0044093252434b4aa2a7d67e386a.pack"
  5933 git-index-pack RET   link -1 errno 17 File exists
[..]
  5933 git-index-pack CALL  rename(0x860c0040,0xcfbc0070)
  5933 git-index-pack NAMI  ".git/objects/tmp_pack_EV5933"
  5933 git-index-pack 
NAMI  ".git/objects/pack/pack-db66c6d25d6e0044093252434b4aa2a7d67e386a.pack"
  5933 git-index-pack RET   rename 0

The only downside is that either on coda or if the file already exists, it
will try a spurrous rename(), in which case it will fail with EEXIST again,
so I hope this is not a big negative.

If this is ok, an appropriate commit message might be something like:

    AFS inconveniently returns EEXIST from link() to say it
    doesn't like cross directory link()'s.  Do a little
    extra work to fix this by ignoring EEXIST and trying
    a rename() anyway.


Thanks,

On Friday 19 October 2007 00:48:14 Shawn O. Pearce wrote:
> There's two different issues here so I'm going to split the thread
> into two to simplify the discussion.  Well, for me anyway.  ;-)
>
> "Todd T. Fries" <todd@fries.net> wrote:
> > 1) git presumes that link() works fine across subdirs; in afs land,
> >    hardlinks do not succeed ever
>
> ...
>
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 83a06a7..1b93322 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -1961,7 +1961,7 @@ static int link_temp_to_file(const char *tmpfile,
> > const char *filename) int ret;
> >  	char *dir;
> >
> > -	if (!link(tmpfile, filename))
> > +	if (!rename(tmpfile, filename))
> >  		return 0;
> >
> >  	/*
> > @@ -1980,7 +1980,7 @@ static int link_temp_to_file(const char *tmpfile,
> > const char *filename) return -2;
> >  		}
> >  		*dir = '/';
> > -		if (!link(tmpfile, filename))
> > +		if (!rename(tmpfile, filename))
> >  			return 0;
> >  		ret = errno;
> >  	}
>
> These cases should already be handled lower, see l.1997-2012 of
> sha1_file.c:
>
>     /*
>      * Coda hack - coda doesn't like cross-directory links,
>      * so we fall back to a rename, which will mean that it
>      * won't be able to check collisions, but that's not a
>      * big deal.
>      *
>      * The same holds for FAT formatted media.
>      *
>      * When this succeeds, we just return 0. We have nothing
>      * left to unlink.
>      */
>     if (ret && ret != EEXIST) {
>         if (!rename(tmpfile, filename))
>
> > Brandon Casey <casey@nrlssc.navy.mil> wrote:
> >
> > On Thu, 18 Oct 2007, Todd T. Fries wrote:
> > > link() returns -1 errno 17 File exists on afs.
> > >
> > > To further muddy the waters, linking within the same dir is ok,
> > > linking outside the same dir is not:
> > >
> > > todd@ispdesk/p6 ~/tmp=A661$ mkdir dir
> > > todd@ispdesk/p6 ~/tmp=A662$ touch a
> > > todd@ispdesk/p6 ~/tmp=A663$ ln a b
> > > todd@ispdesk/p6 ~/tmp=A664$ ls -l a b
> > > -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> > > -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> > > todd@ispdesk/p6 ~/tmp=A665$ ls -li a b
> > > 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 a
> > > 2068032 -rw-r--r--  2 4  wheel  0 Oct 18 17:09 b
> > > todd@ispdesk/p6 ~/tmp=A666$ ln a dir/b
> > > ln: dir/b: File exists
> > > todd@ispdesk/p6 ~/tmp=A667$ echo $?
> >
> > That error is just bogus on afs. If it returned a sane
> > error, things would just work.
> >
> > But, looks like afs only supports linking within the same
> > directory: http://www.angelfire.com/hi/plutonic/afs-faq.html
>
> So according to that error message from "ln" we really should have
> fallen into that Coda hack I just mentioned.  Did we instead get
> a different errno here and not use that hack?
>
>
> We probably could just use rename as you do above but then we would
> want to remove the unlink(tmpfile) call on l.2013 in sha1_file.c.
> Otherwise we're always incurring a syscall for no reason.  I'm not
> against a change here, I just want to make sure we make the right
> change for AFS.  :-)



-- 
Todd Fries .. todd@fries.net

 _____________________________________________
|                                             \  1.636.410.0632 (voice)
| Free Daemon Consulting                      \  1.405.227.9094 (voice)
| http://FreeDaemonConsulting.com             \  1.866.792.3418 (FAX)
| "..in support of free software solutions."  \          250797 (FWD)
|                                             \
 \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                                 
              37E7 D3EB 74D0 8D66 A68D  B866 0326 204E 3F42 004A
                        http://todd.fries.net/pgp.txt



--Boundary-00=_gYKGHUHg1S99Yp3
Content-Type: text/x-diff;
  charset="utf-8";
  name="0002-AFS-inconveniently-returns-EEXIST-from-link-to-say.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-AFS-inconveniently-returns-EEXIST-from-link-to-say.patch"

=46rom e3fe1eae139dccb9738cf0c8f6818136be96657b Mon Sep 17 00:00:00 2001
=46rom: Todd T. Fries <todd@fries.net>
Date: Fri, 19 Oct 2007 07:38:16 -0500
Subject: [PATCH] AFS inconveniently returns EEXIST from link() to say it
doesn't like cross directory link()'s.  Do a little
extra work to fix this by ignoring EEXIST and trying
a rename() anyway.

Signed-off-by: Todd T. Fries <todd@fries.net>
=2D--
 sha1_file.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 83a06a7..9c7d74e 100644
=2D-- a/sha1_file.c
+++ b/sha1_file.c
@@ -2004,8 +2004,13 @@ int move_temp_to_file(const char *tmpfile, const cha=
r *filename)
 	 *
 	 * When this succeeds, we just return 0. We have nothing
 	 * left to unlink.
+	 *
+	 * AFS hack - afs is similar to coda, but inconveniently
+	 * set errno to EEXIST, so call rename() if the link()
+	 * above fails unconditionally.  Small bit of extra work
+	 * so afs functions properly.
 	 */
=2D	if (ret && ret !=3D EEXIST) {
+	if (ret) {
 		if (!rename(tmpfile, filename))
 			return 0;
 		ret =3D errno;
=2D-=20
1.5.2.5


--Boundary-00=_gYKGHUHg1S99Yp3--
