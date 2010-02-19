From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
Subject: [PATCH] mailinfo: don't trim whitespace in the commit message
Date: Fri, 19 Feb 2010 12:54:02 +0100
Message-ID: <4B7E7BDA.4040701@gmail.com>
References: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:04:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiRax-0006Jr-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 13:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab0BSME0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 07:04:26 -0500
Received: from atum.ita.chalmers.se ([129.16.4.148]:47836 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0BSMEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 07:04:24 -0500
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2010 07:04:24 EST
Received: from [192.168.1.2] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by mail.chalmers.se (Postfix) with ESMTP id 84DC4844A;
	Fri, 19 Feb 2010 12:53:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20100211)
In-Reply-To: <alpine.LFD.2.00.1002180936240.4141@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140444>

Previously any whitespace in the beginning of the first line
of the commit message was trimmed, destroying any paragraph
indentation. Move the whitespace trimming to check_header()
instead, and preserve all commit message lines as-is in
handle_commit_msg().

Signed-off-by: Lukas Sandstr=F6m <luksan@gmail.com>
---

On 2010-02-18 19:05, Linus Torvalds wrote:
> 'git mailinfo' removes the whitespace from the beginning of the email
> body, but it does it incorrectly.
>
> In particular, some people use indented paragraphs, like this:
>
> 	  Four-score and Four score and seven years ago our fathers
>    brought forth, upon this continent, a new nation, conceived in Lib=
erty,
>    and dedicated to the proposition that all men are created equal.
>
> 	Now we are engaged in a great civil war, testing whether that
>    nation, or any nation so conceived, and so dedicated, can long end=
ure.
>    We are met here on a great battlefield of that war. We have come t=
o
>    dedicate a portion of it as a final resting place for those who he=
re
>    gave their lives that that nation might live. It is altogether fit=
ting
>    and proper that we should do this.
>
>    ...
>
> and mailinfo will not just remove empty lines from the beginning of t=
he
> email body, it will also remove the _first_ indentation (but not any
> others). Which makes the whole thing come out wrong.
>
> I bisected it, and this bug was introduced almost two years ago. In c=
ommit
> 3b6121f69b2 ("git-mailinfo: use strbuf's instead of fixed buffers"), =
to be
> exact. I'm pretty sure the bug is that handle_commit_msg() was change=
d to
> use 'strbuf_ltrim()' for the 'still_looking' case.
>
> Before commit 3b6121f69b2, it would create a new variable that had th=
e
> trimmed results ("char *cp =3D line;"), after that commit it would ju=
st trim
> the line itself. Which is correct for the case of it being a header, =
but
> if it's the first non-header line, it's wrong.
>

This patch should fix it. Note that there was a test-case explicitly
checking for this "trim first line" behaviour.

/Lukas

 builtin-mailinfo.c |   41 ++++++++++++++++++++++-------------------
 t/t5100/msg0015    |    2 +-
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index a50ac22..954dc11 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -283,11 +283,15 @@ static inline int cmp_header(const struct strbuf =
*line, const char *hdr)
 			line->buf[len] =3D=3D ':' && isspace(line->buf[len + 1]);
 }

-static int check_header(const struct strbuf *line,
+static int check_header(const struct strbuf *line_in,
 				struct strbuf *hdr_data[], int overwrite)
 {
 	int i, ret =3D 0, len;
-	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf sb =3D STRBUF_INIT, sb2 =3D STRBUF_INIT, *line =3D &sb2=
;
+
+	strbuf_addbuf(line, line_in);
+	strbuf_ltrim(line);
+
 	/* search for the interesting parts */
 	for (i =3D 0; header[i]; i++) {
 		int len =3D strlen(header[i]);
@@ -339,6 +343,7 @@ static int check_header(const struct strbuf *line,

 check_header_out:
 	strbuf_release(&sb);
+	strbuf_release(&sb2);
 	return ret;
 }

@@ -773,27 +778,25 @@ static int is_scissors_line(const struct strbuf *=
line)

 static int handle_commit_msg(struct strbuf *line)
 {
-	static int still_looking =3D 1;
+	static int first_msg_line_found =3D 0;
+	size_t cnt;

 	if (!cmitmsg)
-		return 0;
-
-	if (still_looking) {
-		strbuf_ltrim(line);
-		if (!line->len)
+		return 0; /* FIXME: shouldn't this be: return 1? */
+
+	if (!first_msg_line_found) {
+		if (use_inbody_headers)
+			if (check_header(line, s_hdr_data, 0))
+				return 0;
+		/* Check if the first line is all whitespace */
+		for (cnt =3D 0; isspace(line->buf[cnt]); cnt++)
+			; /* nothing */
+		if (line->len =3D=3D cnt)
+			/* Ignore the first line if it's only whitespace */
 			return 0;
+		first_msg_line_found =3D 1;
 	}

-	if (use_inbody_headers && still_looking) {
-		still_looking =3D check_header(line, s_hdr_data, 0);
-		if (still_looking)
-			return 0;
-	} else
-		/* Only trim the first (blank) line of the commit message
-		 * when ignoring in-body headers.
-		 */
-		still_looking =3D 0;
-
 	/* normalize the log message to UTF-8. */
 	if (metainfo_charset)
 		convert_to_utf8(line, charset.buf);
@@ -804,7 +807,7 @@ static int handle_commit_msg(struct strbuf *line)
 			die_errno("Could not rewind output message file");
 		if (ftruncate(fileno(cmitmsg), 0))
 			die_errno("Could not truncate output message file at scissors");
-		still_looking =3D 1;
+		first_msg_line_found =3D 0;

 		/*
 		 * We may have already read "secondary headers"; purge
diff --git a/t/t5100/msg0015 b/t/t5100/msg0015
index 9577238..4abb3d5 100644
--- a/t/t5100/msg0015
+++ b/t/t5100/msg0015
@@ -1,2 +1,2 @@
-- a list
+  - a list
   - of stuff
--=20
1.6.6.1
