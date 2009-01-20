From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 23:30:30 -0500
Message-ID: <20090120043030.GD30714@sigill.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 05:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP8Hf-0001BC-E0
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 05:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407AbZATEai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 23:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZATEah
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 23:30:37 -0500
Received: from peff.net ([208.65.91.99]:42519 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980AbZATEag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 23:30:36 -0500
Received: (qmail 31409 invoked by uid 107); 20 Jan 2009 04:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 19 Jan 2009 23:30:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jan 2009 23:30:30 -0500
Content-Disposition: inline
In-Reply-To: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106436>

On Mon, Jan 19, 2009 at 01:13:30AM -0800, Junio C Hamano wrote:

> * jk/color-parse (Sat Jan 17 10:38:46 2009 -0500) 2 commits
>  + expand --pretty=3Dformat color options
>  + color: make it easier for non-config to parse color specs

I posted a revised version of 1/2 based on Ren=C3=A9's work, but it loo=
ks
like you have the original. So here it is on top of what's in next.

-- >8 --
=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

optimize color_parse_mem

Commit 5ef8d77a implemented color_parse_mem, a function for
parsing colors from a non-NUL-terminated string, by simply
allocating a new NUL-terminated string and calling
color_parse. This had a small but measurable speed impact on
a user format that used the advanced color parsing. E.g.,

  # uses quick parsing
  $ time ./git log --pretty=3Dtformat:'%Credfoo%Creset' >/dev/null
  real    0m0.673s
  user    0m0.652s
  sys     0m0.016s

  # uses color_parse_mem
  $ time ./git log --pretty=3Dtformat:'%C(red)foo%C(reset)' >/dev/null
  real    0m0.692s
  user    0m0.660s
  sys     0m0.032s

This patch implements color_parse_mem as the primary
function, with color_parse as a wrapper for strings. This
gives comparable timings to the first case above.

Original patch by Ren=C3=A9. Commit message and debugging by Jeff
King.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c |   38 +++++++++++++++++++++-----------------
 1 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/color.c b/color.c
index 54a3da1..915d7a9 100644
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
-	die("bad color value '%s' for variable '%s'", value, var);
+	die("bad color value '%.*s' for variable '%s'", value_len, value, var=
);
 }
=20
 int git_config_colorbool(const char *var, const char *value, int stdou=
t_is_tty)
@@ -191,10 +202,3 @@ int color_fprintf_ln(FILE *fp, const char *color, =
const char *fmt, ...)
 	va_end(args);
 	return r;
 }
-
-void color_parse_mem(const char *value, int len, const char *var, char=
 *dst)
-{
-	char *tmp =3D xmemdupz(value, len);
-	color_parse(tmp, var, dst);
-	free(tmp);
-}
--=20
1.6.1.335.g0366b.dirty
