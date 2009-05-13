From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 19:07:49 +0200
Message-ID: <20090513170749.GA26288@blimp.localdomain>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com> <200905121900.00625.Hugo.Mildenberger@namir.de> <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com> <20090512172452.GA32594@blimp.localdomain> <7vws8l7w0d.fsf@alter.siamese.dyndns.org> <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com> <alpine.LNX.2.00.0905131109240.2147@iabervon.org> <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 19:08:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4HwB-00024W-KZ
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758531AbZEMRIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757627AbZEMRH7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:07:59 -0400
Received: from mout1.freenet.de ([195.4.92.91]:54067 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbZEMRH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 13:07:58 -0400
Received: from [195.4.92.13] (helo=3.mx.freenet.de)
	by mout1.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M4Hvu-0004xy-NF; Wed, 13 May 2009 19:07:54 +0200
Received: from x4098.x.pppool.de ([89.59.64.152]:43181 helo=tigra.home)
	by 3.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M4Hvu-0007bh-8v; Wed, 13 May 2009 19:07:54 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C3285277D8;
	Wed, 13 May 2009 19:07:49 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 60B3936D28; Wed, 13 May 2009 19:07:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0905130909x2ad67407p53ad6f79966c1ea3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119067>

Strip trailing spaces off guessed target directory, and replace every
'control' character in the new directory name with ASCII space (\x20).

The user still can have any name by specifying it explicitely after url=
=2E

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Wed, May 13, 2009 18:09:42 +0200:
> 2009/5/13 Daniel Barkalow <barkalow@iabervon.org>:
> > On Wed, 13 May 2009, Alex Riesen wrote:
> >> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
> >>
> >> > If it is just informational use only, then it might make more se=
nse to
> >> > drop this ugly "quoted \n" silently. =A0I dunno.
> >>
> >> That'd mean to loose the information completely. Which is just as =
bad
> >> as putting the LF in the url in the first place.
> >
> > Looking back at the original message, it looks like the user includ=
ed a
> > newline in an argument to clone, and the fetch must have stripped i=
t out
> > (or ignored it in some other fashion), because data was retrieved f=
rom a
> > repository that doesn't have a newline in its name.
>=20
> _That_ looks like a bug to me. We should have asked exactly the name
> we were given, or notify the user about what we have used for the url
> if we have ignored user's input and decided to use something else.
> Patches follow.
>=20

Now I just have to figure out why the fetch works. Something seem to
strip spaces off urls...

 builtin-clone.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 880373f..bdbe931 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -104,11 +104,12 @@ static char *get_repo_path(const char *repo, int =
*is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_ba=
re)
 {
 	const char *end =3D repo + strlen(repo), *start;
+	char *dir;
=20
 	/*
-	 * Strip trailing slashes and /.git
+	 * Strip trailing spaces, slashes and /.git
 	 */
-	while (repo < end && is_dir_sep(end[-1]))
+	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
 		end--;
 	if (end - repo > 5 && is_dir_sep(end[-5]) &&
 	    !strncmp(end - 4, ".git", 4)) {
@@ -140,10 +141,21 @@ static char *guess_dir_name(const char *repo, int=
 is_bundle, int is_bare)
 	if (is_bare) {
 		struct strbuf result =3D STRBUF_INIT;
 		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
-		return strbuf_detach(&result, 0);
-	}
-
-	return xstrndup(start, end - start);
+		dir =3D strbuf_detach(&result, 0);
+	} else
+		dir =3D xstrndup(start, end - start);
+	/* replace all 'control' characters with ascii space */
+	for (start =3D dir; *start; ++start)
+		if (*(const unsigned char *)start < 32u)
+			dir[start - dir] =3D '\x20';
+	/* remove trailing spaces */
+	if (dir < start)
+		for (end =3D start; dir < --end; )
+			if (!isspace(*end))
+				break;
+			else
+				dir[end - dir] =3D '\0';
+	return dir;
 }
=20
 static void strip_trailing_slashes(char *dir)
--=20
1.6.3.28.ga852b
