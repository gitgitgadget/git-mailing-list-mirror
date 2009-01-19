From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Mon, 19 Jan 2009 03:03:11 +0100
Message-ID: <20090119020311.GA8753@neumann>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
	<alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
	<4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
	<7vr63386rc.fsf@gitster.siamese.dyndns.org>
	<7vhc3wuwxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 03:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjVP-0005UK-Go
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbZASCDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 21:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756376AbZASCDX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:03:23 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:63729 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371AbZASCDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:03:22 -0500
Received: from [127.0.1.1] (p5B1346DD.dip0.t-ipconnect.de [91.19.70.221])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1LOjTp1d9a-000328; Mon, 19 Jan 2009 03:03:10 +0100
Content-Disposition: inline
In-Reply-To: <7vhc3wuwxb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/aiaZN0FGOwIW3P9uasuzfSVSn0GfIkbN4K6P
 wUfhBs385sUTOdpApRInCdu0OXWiruBzweaCA1NDz8xUNonJk1
 a3baHFik0LgZaJFhcaBjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106302>

On Sun, Jan 18, 2009 at 01:27:44PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I think (1) the solution (almost) makes sense, (2) the patch needs =
to be
> > explained a lot better as you mentioned in your two messages, and (=
3) if
> > it does not affect any other case than when you are in a subdirecto=
ry of
> > the .git/ directory, then you are doing something funny anyway and
> > performance issue Dscho mentions, if any, is not a concern.
> >
> > My "(almost)" in (1) above is because the patch uses this new behav=
iour
> > even when you are inside the .git/ directory itself (or at the root=
 of a
> > bare repository), which is a very common case that we do not have t=
o nor
> > want to change the behaviour.  It also invalidates the precondition=
 of (3)
> > above.
>=20
> And this is a trivial follow-up on top of Szeder's patch.

Thanks.  In the meantime I was working on a patch that sets relative
path in this case, too.  I got it almost working: all tests passed
except '.git/objects/: is-bare-repository' in 't1500-rev-parse'.  I
couldn't figure it out why this test failed, however.

In case somebody might be interested for such an uncommon case, the
patch is below.


Best,
G=E1bor


 setup.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 6b277b6..b4d37d7 100644
--- a/setup.c
+++ b/setup.c
@@ -375,7 +375,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
-	int len, offset, ceil_offset;
+	int len, offset, ceil_offset, cdup_count =3D 0;
=20
 	/*
 	 * Let's assume that we are in a git repository.
@@ -453,10 +453,22 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
 		if (is_git_directory(".")) {
+			char gd_rel_path[PATH_MAX];
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			if (cdup_count) {
+				char *p =3D gd_rel_path;
+				while (cdup_count-- > 1) {
+					*p++ =3D '.'; *p++ =3D '.'; *p++ =3D '/';
+				}
+				*p++ =3D '.'; *p++ =3D '.';
+				*p =3D '\0';
+			} else {
+				gd_rel_path[0] =3D '.';
+				gd_rel_path[1] =3D '\0';
+			}
+			setenv(GIT_DIR_ENVIRONMENT, gd_rel_path, 1);
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
@@ -472,6 +484,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		}
 		if (chdir(".."))
 			die("Cannot change to %s/..: %s", cwd, strerror(errno));
+		cdup_count++;
 	}
=20
 	inside_git_dir =3D 0;
