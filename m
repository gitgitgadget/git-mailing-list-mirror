From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v4 00/12] unify appending of sob
Date: Tue, 12 Feb 2013 02:17:27 -0800
Message-ID: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 11:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5CwQ-0001Xx-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 11:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab3BLKR6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 05:17:58 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42912 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab3BLKR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 05:17:57 -0500
Received: by mail-pa0-f50.google.com with SMTP id fa11so9291pad.9
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 02:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=V3N6WtP+qlEB+rKJn0YH2DvDgFbJnp/OVqLLX6pqSOw=;
        b=UMSx6hmpCiToGasohHMzwR0Ib1xfjUsMhHgzasH8Xo2zVZV8ZuD3WeMfY3QbkJUueE
         oW+xDH29nEpsQZxc9dmwoaMNuIR6WJ45kn0PgWo8G1eS1P2eLH9MtYG+VRhY0hZ4isKA
         ZA1BoBWgoeKTszy/aPQU6SQeH73dNvsmBqDm2WIIMFOv8iCZ/WK574SogC4cYkpAq8AO
         iWpB+uzpKwguU6Rxp/Q/6z9SUXRXI8ibGO2MUe8LEtT+LRBaqixzLTjVnXfOTqi6QKAh
         YNLkxbj/HPIbWmQ5PPv43A8U3ShFbPViFipaqAZ/1BxOyn4gHfzmPScbKTjq+ZHJSlTD
         YX2Q==
X-Received: by 10.66.80.65 with SMTP id p1mr50655136pax.20.1360664277090;
        Tue, 12 Feb 2013 02:17:57 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id l5sm73839001pax.10.2013.02.12.02.17.54
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 02:17:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216129>

Round 4.

Interdiff against round 3 follows the diff stat.

-Brandon

Brandon Casey (9):
  commit, cherry-pick -s: remove broken support for multiline rfc2822
    fields
  t/test-lib-functions.sh: allow to specify the tag name to test_commit
  t/t3511: add some tests of 'cherry-pick -s' functionality
  sequencer.c: recognize "(cherry picked from ..." as part of s-o-b
    footer
  sequencer.c: require a conforming footer to be preceded by a blank
    line
  sequencer.c: always separate "(cherry picked from" from commit body
  sequencer.c: teach append_signoff how to detect duplicate s-o-b
  sequencer.c: teach append_signoff to avoid adding a duplicate newline
  Unify appending signoff in format-patch, commit and sequencer

Jonathan Nieder (1):
  sequencer.c: rework search for start of footer to improve clarity

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  t4014: more tests about appending s-o-b lines
  format-patch: update append_signoff prototype

 builtin/commit.c         |   2 +-
 builtin/log.c            |  13 +--
 log-tree.c               |  92 ++---------------
 revision.h               |   2 +-
 sequencer.c              | 168 +++++++++++++++++++++---------
 sequencer.h              |   4 +-
 t/t3511-cherry-pick-x.sh | 219 +++++++++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh  | 262 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/test-lib-functions.sh  |   8 +-
 9 files changed, 614 insertions(+), 156 deletions(-)
 create mode 100755 t/t3511-cherry-pick-x.sh

--=20
1.8.1.3.579.gd9af3b6

diff --git a/sequencer.c b/sequencer.c
index 404b786..3c63e3a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,13 +27,12 @@ static int is_rfc2822_line(const char *buf, int len=
)
 	for (i =3D 0; i < len; i++) {
 		int ch =3D buf[i];
 		if (ch =3D=3D ':')
+			return 1;
+		if (!isalnum(ch) && ch !=3D '-')
 			break;
-		if (isalnum(ch) || (ch =3D=3D '-'))
-			continue;
-		return 0;
 	}
=20
-	return 1;
+	return 0;
 }
=20
 static int is_cherry_picked_from_line(const char *buf, int len)
@@ -41,9 +40,8 @@ static int is_cherry_picked_from_line(const char *buf=
, int len)
 	/*
 	 * We only care that it looks roughly like (cherry picked from ...)
 	 */
-	return !prefixcmp(buf, cherry_picked_prefix) &&
-		(buf[len - 1] =3D=3D ')' ||
-		 (buf[len - 1] =3D=3D '\n' && buf[len - 2] =3D=3D ')'));
+	return len > strlen(cherry_picked_prefix) + 1 &&
+		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] =3D=3D ')';
 }
=20
 /*
@@ -55,25 +53,29 @@ static int is_cherry_picked_from_line(const char *b=
uf, int len)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob=
,
 	int ignore_footer)
 {
-	int last_char_was_nl, this_char_is_nl;
+	char prev;
 	int i, k;
 	int len =3D sb->len - ignore_footer;
 	const char *buf =3D sb->buf;
 	int found_sob =3D 0;
=20
-	/* find start of last paragraph */
-	last_char_was_nl =3D 0;
+	/* footer must end with newline */
+	if (!len || buf[len - 1] !=3D '\n')
+		return 0;
+
+	prev =3D '\0';
 	for (i =3D len - 1; i > 0; i--) {
-		this_char_is_nl =3D (buf[i] =3D=3D '\n');
-		if (last_char_was_nl && this_char_is_nl)
+		char ch =3D buf[i];
+		if (prev =3D=3D '\n' && ch =3D=3D '\n') /* paragraph break */
 			break;
-		last_char_was_nl =3D this_char_is_nl;
+		prev =3D ch;
 	}
=20
 	/* require at least one blank line */
-	if (!last_char_was_nl || buf[i] !=3D '\n')
+	if (prev !=3D '\n' || buf[i] !=3D '\n')
 		return 0;
=20
+	/* advance to start of last paragraph */
 	while (i < len - 1 && buf[i] =3D=3D '\n')
 		i++;
=20
@@ -84,13 +86,13 @@ static int has_conforming_footer(struct strbuf *sb,=
 struct strbuf *sob,
 			; /* do nothing */
 		k++;
=20
-		found_rfc2822 =3D is_rfc2822_line(buf + i, k - i);
+		found_rfc2822 =3D is_rfc2822_line(buf + i, k - i - 1);
 		if (found_rfc2822 && sob &&
-			!strncmp(buf + i, sob->buf, sob->len))
+		    !strncmp(buf + i, sob->buf, sob->len))
 			found_sob =3D k;
=20
 		if (!(found_rfc2822 ||
-			is_cherry_picked_from_line(buf + i, k - i)))
+		      is_cherry_picked_from_line(buf + i, k - i - 1)))
 			return 0;
 	}
 	if (found_sob =3D=3D i)
@@ -1108,26 +1110,36 @@ void append_signoff(struct strbuf *msgbuf, int =
ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob =3D flag & APPEND_SIGNOFF_DEDUP;
 	struct strbuf sob =3D STRBUF_INIT;
-	int has_footer =3D 0;
-	int i;
+	const char *append_newlines =3D NULL;
+	int has_footer;
=20
 	strbuf_addstr(&sob, sign_off_header);
 	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 				getenv("GIT_COMMITTER_EMAIL")));
 	strbuf_addch(&sob, '\n');
-	for (i =3D msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - =
1] !=3D '\n'; i--)
-		; /* do nothing */
=20
-	if (msgbuf->buf[i] !=3D '\n') {
-		if (i)
-			has_footer =3D has_conforming_footer(msgbuf, &sob,
-					ignore_footer);
-
-		if (!has_footer)
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-					"\n", 1);
+	/*
+	 * If the whole message buffer is equal to the sob, pretend that we
+	 * found a conforming footer with a matching sob
+	 */
+	if (msgbuf->len - ignore_footer =3D=3D sob.len &&
+	    !strncmp(msgbuf->buf, sob.buf, sob.len))
+		has_footer =3D 3;
+	else
+		has_footer =3D has_conforming_footer(msgbuf, &sob, ignore_footer);
+
+	if (!has_footer) {
+		size_t len =3D msgbuf->len - ignore_footer;
+		if (len && msgbuf->buf[len - 1] !=3D '\n')
+			append_newlines =3D "\n\n";
+		else if (len > 1 && msgbuf->buf[len - 2] !=3D '\n')
+			append_newlines =3D "\n";
 	}
=20
+	if (append_newlines)
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+			append_newlines, strlen(append_newlines));
+
 	if (has_footer !=3D 3 && (!no_dup_sob || has_footer !=3D 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
 				sob.buf, sob.len);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d0ec097..97fde9e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1023,11 +1023,10 @@ test_expect_success 'cover letter using branch =
description (6)' '
=20
 append_signoff()
 {
-	C=3D`git commit-tree HEAD^^{tree} -p HEAD` &&
-	git format-patch --stdout --signoff ${C}^..${C} |
-		tee append_signoff.patch |
-		sed -n "1,/^---$/p" |
-		grep -n -E "^Subject|Sign|^$"
+	C=3D$(git commit-tree HEAD^^{tree} -p HEAD) &&
+	git format-patch --stdout --signoff $C^..$C >append_signoff.patch &&
+	sed -n -e "1,/^---$/p" append_signoff.patch |
+		egrep -n "^Subject|Sign|^$"
 }
=20
 test_expect_success 'signoff: commit with no body' '
