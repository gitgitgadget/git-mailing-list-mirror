From: Jeff King <peff@peff.net>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 16:08:52 -0500
Message-ID: <20110301210852.GB21429@sigill.intra.peff.net>
References: <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net>
 <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net>
 <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <vpqmxlea7w1.fsf@bauges.imag.fr>
 <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Chad Joan <chadjoan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:08:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWoL-0001H3-JK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 22:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab1CAVIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 16:08:44 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757226Ab1CAVIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 16:08:43 -0500
Received: (qmail 10467 invoked by uid 111); 1 Mar 2011 21:08:42 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 21:08:42 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 16:08:52 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=UX7VNH+biFgn0FQawP-ttCjW2D7SMf2n6XB6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168260>

On Tue, Mar 01, 2011 at 03:46:46PM -0500, Chad Joan wrote:

> >> I'll do that, but it will probably take a long long time for me to=
 see
> >> the patch. =C2=A0I'm hoping there's some cheap hack I can use to w=
ork
> >> around it in the meantime.
> >
> > I'd say grep for "rmdir" is Git's source code, and replace the call=
s
> > with a wrapper that does roughly
> >
> > rmdir_wrapper(dir) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0rmdir(dir);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat(dir, &buf))
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chmod(dir, b=
uf.st_mode | 0777);
> > }
> >
> OK, I'll try that when I get a chance.

I think this is the cheap hack that you want:

diff --git a/dir.c b/dir.c
index 168dad6..fb6d306 100644
--- a/dir.c
+++ b/dir.c
@@ -1236,6 +1236,29 @@ void setup_standard_excludes(struct dir_struct *=
dir)
 		add_excludes_from_file(dir, excludes_file);
 }
=20
+static int rmdir_on_broken_cifs(const char *path)
+{
+	struct stat sb;
+	if (stat(path, &sb) < 0) {
+		/* Oh well, hopefully if we can't stat it
+		 * it is already gone or we don't have
+		 * permissions to screw it up anyway. */
+		return rmdir(path);
+	}
+	if (rmdir(path) =3D=3D 0) {
+		/* it worked, nothing to restore */
+		return 0;
+	}
+	/* maybe remove this conditional if you can trigger
+	 * the problem with other types of errors */
+	if (errno !=3D ENOTEMPTY)
+		return -1;
+	if (chmod(path, sb.st_mode) < 0)
+		warning("we probably just screwed up the permissions of %s",
+			path);
+	return -1;
+}
+
 int remove_path(const char *name)
 {
 	char *slash;
@@ -1249,7 +1272,7 @@ int remove_path(const char *name)
 		slash =3D dirs + (slash - name);
 		do {
 			*slash =3D '\0';
-		} while (rmdir(dirs) =3D=3D 0 && (slash =3D strrchr(dirs, '/')));
+		} while (rmdir_on_broken_cifs(dirs) =3D=3D 0 && (slash =3D strrchr(d=
irs, '/')));
 		free(dirs);
 	}
 	return 0;

Totally untested, of course. But hey, it compiles, so it must be good.

-Peff
