From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: make it easier for non-config to parse color
	specs
Date: Sun, 18 Jan 2009 13:06:10 -0500
Message-ID: <20090118180610.GB22718@coredump.intra.peff.net>
References: <20090117152108.GA24899@coredump.intra.peff.net> <20090117153229.GA27071@coredump.intra.peff.net> <4973628C.8080501@lsrfire.ath.cx> <20090118172802.GA17434@coredump.intra.peff.net> <49736A9C.1040601@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 19:07:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOc3e-0005cN-LB
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 19:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZARSGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZARSGO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 13:06:14 -0500
Received: from peff.net ([208.65.91.99]:54175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbZARSGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 13:06:13 -0500
Received: (qmail 22389 invoked by uid 107); 18 Jan 2009 18:06:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 13:06:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 13:06:11 -0500
Content-Disposition: inline
In-Reply-To: <49736A9C.1040601@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106255>

On Sun, Jan 18, 2009 at 06:45:00PM +0100, Ren=C3=A9 Scharfe wrote:

> > need a "memcasecmp" here.
>=20
> 	if (!strncasecmp(value, "reset", len)) {

Thanks. I knew there must be some stock function to do this, but for
some reason I just could not think of strncasecmp.

>    die("bad color value '%.*s' for variable '%s', len, value, var);

Except that we've been shortening "len" during the course of the
function, so it is generally 0 at this point.

> >   $ time ./git log --pretty=3Dtformat:'%Credfoo%Creset' >/dev/null
> >   real    0m0.673s
> >   user    0m0.652s
> >   sys     0m0.016s
> >   $ time ./git log --pretty=3Dtformat:'%C(red)foo%C(reset)' >/dev/n=
ull
> >   real    0m0.692s
> >   user    0m0.660s
> >   sys     0m0.032s
> >=20
> > That's about 1 microsecond per commit.
>=20
> Hmm, not too much overhead, agreed, but it would still be nice to avo=
id it.

Here are the numbers with your fixes:

  $ time ./git log --pretty=3Dtformat:'%C(red)foo%C(reset)' >/dev/null
  real    0m0.677s
  user    0m0.668s
  sys     0m0.008s

which puts the difference well into the noise region (I actually did ge=
t
one run with your patch that was just as fast as the original).

Here is an updated version of patch 1/2, squashing in your
color_mem_parse update, your follow-on fix, and a fix for the die().

-- >8 --
color: make it easier for non-config to parse color specs

We have very featureful color-parsing routines which are
used for color.diff.* and other options. Let's make it
easier to use those routines from other parts of the code.

This patch converts color_parse to color_parse_mem, taking a
length-bounded string instead of a NUL-terminated one. We
keep color_parse as a wrapper which takes a normal string.
Thanks to Ren=C3=A9 Scharfe for rewriting the color_parse
implementation.

This also changes the error string for an invalid color not
to mention the word "config", since it is not always
appropriate (and when it is, the context is obvious since
the offending config variable is given).

=46inally, while we are in the area, we clean up the parameter
names in the declaration of color_parse; the var and value
parameters were reversed from the actual implementation.
---
 color.c |   31 +++++++++++++++++++++----------
 color.h |    3 ++-
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/color.c b/color.c
index fc0b72a..915d7a9 100644
--- a/color.c
+++ b/color.c
@@ -41,29 +41,40 @@ static int parse_attr(const char *name, int len)
=20
 void color_parse(const char *value, const char *var, char *dst)
 {
+	color_parse_mem(value, strlen(value), var, dst);
+}
+
+void color_parse_mem(const char *value, int value_len, const char *var=
,
+		char *dst)
+{
 	const char *ptr =3D value;
+	int len =3D value_len;
 	int attr =3D -1;
 	int fg =3D -2;
 	int bg =3D -2;
=20
-	if (!strcasecmp(value, "reset")) {
+	if (!strncasecmp(value, "reset", len)) {
 		strcpy(dst, "\033[m");
 		return;
 	}
=20
 	/* [fg [bg]] [attr] */
-	while (*ptr) {
+	while (len > 0) {
 		const char *word =3D ptr;
-		int val, len =3D 0;
+		int val, wordlen =3D 0;
=20
-		while (word[len] && !isspace(word[len]))
-			len++;
+		while (len > 0 && !isspace(word[wordlen])) {
+			wordlen++;
+			len--;
+		}
=20
-		ptr =3D word + len;
-		while (*ptr && isspace(*ptr))
+		ptr =3D word + wordlen;
+		while (len > 0 && isspace(*ptr)) {
 			ptr++;
+			len--;
+		}
=20
-		val =3D parse_color(word, len);
+		val =3D parse_color(word, wordlen);
 		if (val >=3D -1) {
 			if (fg =3D=3D -2) {
 				fg =3D val;
@@ -75,7 +86,7 @@ void color_parse(const char *value, const char *var, =
char *dst)
 			}
 			goto bad;
 		}
-		val =3D parse_attr(word, len);
+		val =3D parse_attr(word, wordlen);
 		if (val < 0 || attr !=3D -1)
 			goto bad;
 		attr =3D val;
@@ -115,7 +126,7 @@ void color_parse(const char *value, const char *var=
, char *dst)
 	*dst =3D 0;
 	return;
 bad:
-	die("bad config value '%s' for variable '%s'", value, var);
+	die("bad color value '%.*s' for variable '%s'", value_len, value, var=
);
 }
=20
 int git_config_colorbool(const char *var, const char *value, int stdou=
t_is_tty)
diff --git a/color.h b/color.h
index 6cf5c88..7066099 100644
--- a/color.h
+++ b/color.h
@@ -16,7 +16,8 @@ extern int git_use_color_default;
 int git_color_default_config(const char *var, const char *value, void =
*cb);
=20
 int git_config_colorbool(const char *var, const char *value, int stdou=
t_is_tty);
-void color_parse(const char *var, const char *value, char *dst);
+void color_parse(const char *value, const char *var, char *dst);
+void color_parse_mem(const char *value, int len, const char *var, char=
 *dst);
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...=
);
=20
--=20
1.6.1.266.g3b9d0.dirty
