From: "Todd T. Fries" <todd@fries.net>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 07:19:19 -0500
Organization: Free Daemon Consulting
Message-ID: <200710190719.21660.todd@fries.net>
References: <20071018203106.GA13518@fries.net> <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org> <20071019060624.GK14735@spearce.org>
Reply-To: todd@fries.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JDKGHqItiQbgHoN"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 14:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiqql-0001WK-Bn
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058AbXJSMU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 08:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXJSMU6
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 08:20:58 -0400
Received: from pf.FreeDaemonHosting.com ([66.210.104.252]:41230 "EHLO
	FreeDaemonHosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753298AbXJSMU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 08:20:57 -0400
Received: from blue.fries.net (blue.hse.fries.net [IPv6:2001:240:58a::1c])
	by FreeDaemonHosting.com (8.13.8/8.13.8) with ESMTP id l9JCKaw7027565;
	Fri, 19 Oct 2007 07:20:37 -0500 (CDT)
Received: from blue.fries.net (localhost.fries.net [IPv6:::1])
	by blue.fries.net (8.14.1/8.13.6) with ESMTP id l9JCKHZ0023138;
	Fri, 19 Oct 2007 07:20:17 -0500 (CDT)
Received: (from todd@localhost)
	by blue.fries.net (8.14.1/8.13.6/Submit) id l9JCJMnZ026614;
	Fri, 19 Oct 2007 07:19:22 -0500 (CDT)
X-Authentication-Warning: blue.fries.net: todd set sender to todd@fries.net using -f
User-Agent: KMail/1.9.7
In-Reply-To: <20071019060624.GK14735@spearce.org>
X-FDH-MailScanner-Information: http://FreeDaemonHosting.com/MailScanner.html
X-FDH-MailScanner: clean
X-FDH-MailScanner-From: todd@fries.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61695>

--Boundary-00=_JDKGHqItiQbgHoN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Shawn,

If DT_UNKNOWN exists, then we have to do a stat() of some form to
find out the right type.

This is difficult to fix properly to avoid the extra stat() since
inside the switch logic we do the recursion, but we might have
avoided it earlier because of the exclusion.

I'll send a separate diff for an updated link() vs rename() diff.

I've attached an updated diff that should address concerns of everyone
who gave me feedback on my dir.c changes.

Better?

Thanks,

On Friday 19 October 2007 01:06:24 Shawn O. Pearce wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Thu, 18 Oct 2007, Todd T. Fries wrote:
> > > 2) git presumes that DTYPE(de) != DT_DIR .. means the dirent is not a
> > > dir this is not true for afs
> >
> > That's a major bug, and has nothing to do with AFS. Oops.
> >
> > If you look just a bit lower, you'll see that just a few lines down, git
> > handles DT_UNKNOWN correctly, and just does a lstat() on it as required.
> > I guess that logic should be moved up, or alternatively the exclude logic
> > should be moved down.
> >
> > Your patch looks ok, but at the same time, I don't think it's really the
> > right thing to do, since it now does that lstat() twice.
>
> What about this instead?  It avoids the double lstat() of Todd's
> original patch but seems like it would fix the issue here.  Or did
> I misunderstand the problem?
[..]
> diff --git a/dir.c b/dir.c
> index eb6c3ab..d2597ff 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -487,9 +487,10 @@ static int read_directory_recursive(struct dir_struct
> *dir, const char *path, co && in_pathspec(fullname, baselen + len,
> simplify))
>  				dir_add_ignored(dir, fullname, baselen + len);
>  			if (exclude != dir->show_ignored) {
> -				if (!dir->show_ignored || DTYPE(de) != DT_DIR) {
> +				if (!dir->show_ignored)
> +					continue;
> +				else if (DTYPE(de) != DT_DIR && DTYPE(de) != DT_UNKNOWN)
>  					continue;
> -				}
>  			}
>
>  			switch (DTYPE(de)) {
> --
> 1.5.3.4.1249.g895be



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






--Boundary-00=_JDKGHqItiQbgHoN
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-If-readdir-returns-a-DTYPE-of-DT_UNKNOWN-this-w.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-If-readdir-returns-a-DTYPE-of-DT_UNKNOWN-this-w.patch"

=46rom f7bca472645db70b52824e1be827ba99195198d2 Mon Sep 17 00:00:00 2001
=46rom: Todd T. Fries <todd@fries.net>
Date: Fri, 19 Oct 2007 06:26:49 -0500
Subject: [PATCH] If readdir() returns a DTYPE() of DT_UNKNOWN, this warrant=
s further
investigation, i.e. a stat() or lstat().  We have been presuming
anything not DT_DIR is not a dir, which is not the case for
all filesystems (e.g. afs).

Do the lstat() once, and use the results twice.

Signed-off-by: Todd T. Fries <todd@fries.net>
=2D--
 dir.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index eb6c3ab..0ed4739 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -468,6 +468,7 @@ static int read_directory_recursive(struct dir_struct *=
dir, const char *path, co
 		while ((de =3D readdir(fdir)) !=3D NULL) {
 			int len;
 			int exclude;
+			struct stat st;
=20
 			if ((de->d_name[0] =3D=3D '.') &&
 			    (de->d_name[1] =3D=3D 0 ||
@@ -486,19 +487,24 @@ static int read_directory_recursive(struct dir_struct=
 *dir, const char *path, co
 			if (exclude && dir->collect_ignored
 			    && in_pathspec(fullname, baselen + len, simplify))
 				dir_add_ignored(dir, fullname, baselen + len);
+			if (DTYPE(de) =3D=3D DT_UNKNOWN) {
+				if (lstat(fullname, &st))
+					continue;
+			}
 			if (exclude !=3D dir->show_ignored) {
=2D				if (!dir->show_ignored || DTYPE(de) !=3D DT_DIR) {
+				if (!dir->show_ignored))
 					continue;
=2D				}
+				if (DTYPE(de) =3D=3D DT_UNKNOWN && !S_ISDIR(st.st_mode))
+					continue;
+				else
+					if (DTYPE(de) !=3D DT_DIR)
+						continue;
 			}
=20
 			switch (DTYPE(de)) {
=2D			struct stat st;
 			default:
 				continue;
 			case DT_UNKNOWN:
=2D				if (lstat(fullname, &st))
=2D					continue;
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode))
 					break;
 				if (!S_ISDIR(st.st_mode))
=2D-=20
1.5.2.5


--Boundary-00=_JDKGHqItiQbgHoN--
