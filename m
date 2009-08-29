From: =?UTF-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=20=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] Majorly simplify the definition of scissors line
Date: Sat, 29 Aug 2009 16:17:00 +0900
Message-ID: <20090829161700.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 09:18:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhID4-0000wq-UD
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 09:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbZH2HSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2009 03:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbZH2HSn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 03:18:43 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41333 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbZH2HSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 03:18:42 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 9721811B8AF;
	Sat, 29 Aug 2009 02:18:44 -0500 (CDT)
Received: from 3979.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id MQWK0OK8DH1Y; Sat, 29 Aug 2009 02:18:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GCAYlF+LllGDWRTMZjlYxlK4qGi4fZzHh61qmKAfI36tqN3CDBlVoHJXZLsxXz9wgLnlDIXbV0qf8kF/h1cV49QLttn2Tf/48+oAGN/BKI7Vgh3ZpkhD2090kDoxHYo+ZKYRpB8T1eIYu7eReglHWwfbPiJqL0cF8SW7IaNPvaM=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127374>

The definition of scissors line was "a line that mainly consists of
scissors and perforation". While it is easy to explain to new people,
this does not exactly define where the line between "mainly consists
of" and "contains some amount of" lies.

Make the definition more strict and allow only lines that begin with
a '-- >8 --' (or its left-handed equivalent '-- 8< --'), which is
equally easy to explain to new people. More important, the rule is
much shorter and more precise, so it is easier to remember.

This pattern also is how Nicolas Sebrecht initially thought what the
definition was, without reading what Junio's code really did, so we
have an empirical evidence that this matches at least one newcomer's
intuition.

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 Documentation/git-mailinfo.txt |    4 +-
 builtin-mailinfo.c             |   48 +++-----------------------------=
-------
 t/t5100/msg0014                |    4 +-
 t/t5100/sample.mbox            |    4 +-
 4 files changed, 10 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinf=
o.txt
index 71b93ad..1c2c414 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -56,8 +56,8 @@ conversion, even with this flag.
=20
 --scissors::
 	Remove everything in body before a scissors line.  A line that
-	mainly consists of scissors (either ">8" or "8<") and perforation
-	(dash "-") marks is called a scissors line, and is used to request
+	begins with "-- >8 --" or "-- 8< --" is called a scissors line,
+	and is used to request
 	the reader to cut the message at that line.  If such a line
 	appears in the body of the message before the patch, everything
 	before it (including the scissors line itself) is ignored when
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 508bdf0..1bbad4e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -722,52 +722,12 @@ static inline int patchbreak(const struct strbuf =
*line)
=20
 static int is_scissors_line(const struct strbuf *line)
 {
-	size_t i, len =3D line->len;
-	int scissors =3D 0, gap =3D 0;
-	int first_nonblank =3D -1;
-	int last_nonblank =3D 0, visible, perforation =3D 0, in_perforation =3D=
 0;
 	const char *buf =3D line->buf;
+	size_t len =3D line->len;
=20
-	for (i =3D 0; i < len; i++) {
-		if (isspace(buf[i])) {
-			if (in_perforation) {
-				perforation++;
-				gap++;
-			}
-			continue;
-		}
-		last_nonblank =3D i;
-		if (first_nonblank < 0)
-			first_nonblank =3D i;
-		if (buf[i] =3D=3D '-') {
-			in_perforation =3D 1;
-			perforation++;
-			continue;
-		}
-		if (i + 1 < len &&
-		    (!memcmp(buf + i, ">8", 2) || !memcmp(buf + i, "8<", 2))) {
-			in_perforation =3D 1;
-			perforation +=3D 2;
-			scissors +=3D 2;
-			i++;
-			continue;
-		}
-		in_perforation =3D 0;
-	}
-
-	/*
-	 * The mark must be at least 8 bytes long (e.g. "-- >8 --").
-	 * Even though there can be arbitrary cruft on the same line
-	 * (e.g. "cut here"), in order to avoid misidentification, the
-	 * perforation must occupy more than a third of the visible
-	 * width of the line, and dashes and scissors must occupy more
-	 * than half of the perforation.
-	 */
-
-	visible =3D last_nonblank - first_nonblank + 1;
-	return (scissors && 8 <=3D visible &&
-		visible < perforation * 3 &&
-		gap * 2 < perforation);
+	if (len < 8)
+		return 0;
+	return (!memcmp("-- >8 --", buf, 8) || !memcmp("-- 8< --", buf, 8));
 }
=20
 static int handle_commit_msg(struct strbuf *line)
diff --git a/t/t5100/msg0014 b/t/t5100/msg0014
index 62e5cd2..187ff57 100644
--- a/t/t5100/msg0014
+++ b/t/t5100/msg0014
@@ -6,8 +6,8 @@ Subject: [PATCH] BLAH TWO
=20
 And then we will see the scissors.
=20
- This line is not a scissors mark -- >8 -- but talks about it.
- - - >8 - - please remove everything above this line - - >8 - -
+ This is not a scissors line -- >8 -- but talks about it.
+-- >8 -- please remove everything above this line -- >8 --
=20
 Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- m=
ark
 From: Junio C Hamano <gitster@pobox.com>
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 13fa4ae..563f713 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -576,8 +576,8 @@ Subject: [PATCH] BLAH TWO
=20
 And then we will see the scissors.
=20
- This line is not a scissors mark -- >8 -- but talks about it.
- - - >8 - - please remove everything above this line - - >8 - -
+ This is not a scissors line -- >8 -- but talks about it.
+-- >8 -- please remove everything above this line -- >8 --
=20
 Subject: [PATCH] Teach mailinfo to ignore everything before -- >8 -- m=
ark
 From: Junio C Hamano <gitster@pobox.com>
--=20
1.6.4.1

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
