From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 00/10] unify appending of sob
Date: Mon, 21 Jan 2013 00:40:17 -0800
Message-ID: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCw7-0002ne-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab3AUIki convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 03:40:38 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35199 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3AUIkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:40:37 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so3288970pac.1
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=BlAJuvJcuak7r03Mzu9qg6uuvba05XujXyKlPaNLVM4=;
        b=iWUFvyPSsaKFhFbFOgzELD5dLKZqb6SC8bSevWjrEw0cTsI6iAkohV9S0jv5FaMuoQ
         7cBaokqRzuXld7j8XicXL0TrTuzjEO2kruni7uQWWTv0L+fWLrj5Ni/X/BtQETRr3L+q
         LfKJQ0yZvCAgFQebxdSa9K/ZtwkKX73zs2wSrD0PPG+3nP5TflRK/AyzyTmg+PGqzJ2B
         ksLYvvrTkH5o+w8N2GqTOqDVQXdhYxdqRUL94cBSM68zfSMuO8RyVa39L3WsD5ZBq1/r
         xEuVFAslThFExfe8Kzv3aik281x3lroUooNemf83b01/MrKLIjBd/bHIj0aoPfcMQKIT
         jOqg==
X-Received: by 10.66.84.10 with SMTP id u10mr45673896pay.24.1358757636791;
        Mon, 21 Jan 2013 00:40:36 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:40:35 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214094>

Here's version 2 of the unify-appending-of-sob series.  Hopefully this
addresses the comments made on the first series:

   http://thread.gmane.org/gmane.comp.version-control.git/210390

The main difference is that the detection of the "(cherry picked from .=
=2E.)"
line has been relaxed, and the modifications to log-tree.c have been dr=
opped.

Here's the inter-diff of this series against the original series, both =
built
on top of 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (the actual series i=
n the
following emails is of course built on top of master).

diff --git a/revision.h b/revision.h
index 435a60b..d20defa 100644
--- a/revision.h
+++ b/revision.h
@@ -137,7 +137,7 @@ struct rev_info {
 	int		numbered_files;
 	char		*message_id;
 	struct string_list *ref_message_ids;
-	int              add_signoff;
+	int		add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
diff --git a/sequencer.c b/sequencer.c
index eb93dd6..54b3cb9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -36,13 +36,18 @@ static int is_rfc2822_line(const char *buf, int len=
)
 	return 1;
 }
=20
-static int is_cherry_pick_from_line(const char *buf, int len)
+static int is_cherry_picked_from_line(const char *buf, int len)
 {
-	return (strlen(cherry_picked_prefix) + 41) <=3D len &&
-		!prefixcmp(buf, cherry_picked_prefix);
+	/*
+	 * We only care that it looks roughly like (cherry picked from ...)
+	 */
+	return !prefixcmp(buf, cherry_picked_prefix) &&
+		(buf[len - 1] =3D=3D ')' ||
+		 (buf[len - 1] =3D=3D '\n' && buf[len - 2] =3D=3D ')'));
 }
=20
-/* Returns 0 for non-conforming footer
+/*
+ * Returns 0 for non-conforming footer
  * Returns 1 for conforming footer
  * Returns 2 when sob exists within conforming footer
  * Returns 3 when sob exists within conforming footer as last entry
@@ -51,7 +56,7 @@ static int has_conforming_footer(struct strbuf *sb, s=
truct strbuf *sob,
 	int ignore_footer)
 {
 	int hit =3D 0;
-	int i, k =3D 0;
+	int i, k;
 	int len =3D sb->len - ignore_footer;
 	const char *buf =3D sb->buf;
 	int found_sob =3D 0;
@@ -76,12 +81,13 @@ static int has_conforming_footer(struct strbuf *sb,=
 struct strbuf *sob,
 			; /* do nothing */
 		k++;
=20
-		found_rfc2822 =3D is_rfc2822_line(buf+i, k-i);
+		found_rfc2822 =3D is_rfc2822_line(buf + i, k - i);
 		if (found_rfc2822 && sob &&
-			!strncasecmp(buf+i, sob->buf, sob->len))
+			!strncmp(buf + i, sob->buf, sob->len))
 			found_sob =3D k;
=20
-		if (!(found_rfc2822 || is_cherry_pick_from_line(buf+i, k-i)))
+		if (!(found_rfc2822 ||
+			is_cherry_picked_from_line(buf + i, k - i)))
 			return 0;
 	}
 	if (found_sob =3D=3D i)
@@ -1103,11 +1109,20 @@ void append_signoff(struct strbuf *msgbuf, int =
ignore_footer, int no_dup_sob)
 	strbuf_addch(&sob, '\n');
 	for (i =3D msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - =
1] !=3D '\n'; i--)
 		; /* do nothing */
-	if (msgbuf->buf[i] !=3D '\n' && (!i || !(has_footer =3D
-		has_conforming_footer(msgbuf, &sob, ignore_footer))))
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
+
+	if (msgbuf->buf[i] !=3D '\n') {
+		if (i)
+			has_footer =3D has_conforming_footer(msgbuf, &sob,
+					ignore_footer);
+
+		if (!has_footer)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+					"\n", 1);
+	}
+
 	if (has_footer !=3D 3 && (!no_dup_sob || has_footer !=3D 2))
 		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
 				sob.buf, sob.len);
+
 	strbuf_release(&sob);
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c53dc4b..6d00e43 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1211,16 +1211,17 @@ subject
=20
 body
=20
+Reviewed-id: Noone
 Tested-by: my@house
 Change-id: Ideadbeef
 Signed-off-by: C O Mitter <committer@example.com>
-BUG: 1234
+Bug: 1234
 EOF
 	cat >expected <<\EOF &&
 4:Subject: [PATCH] subject
 8:
 10:
-13:Signed-off-by: C O Mitter <committer@example.com>
+14:Signed-off-by: C O Mitter <committer@example.com>
 EOF
 	test_cmp expected actual
 '

Brandon Casey (8):
  sequencer.c: remove broken support for rfc2822 continuation in footer
  t/test-lib-functions.sh: allow to specify the tag name to test_commit
  t/t3511: add some tests of 'cherry-pick -s' functionality
  sequencer.c: recognize "(cherry picked from ..." as part of s-o-b
    footer
  sequencer.c: always separate "(cherry picked from" from commit body
  sequencer.c: teach append_signoff how to detect duplicate s-o-b
  sequencer.c: teach append_signoff to avoid adding a duplicate newline
  Unify appending signoff in format-patch, commit and sequencer

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  t4014: more tests about appending s-o-b lines
  format-patch: update append_signoff prototype

 builtin/commit.c         |   2 +-
 builtin/log.c            |  13 +--
 log-tree.c               |  92 ++---------------
 revision.h               |   2 +-
 sequencer.c              | 146 +++++++++++++++++---------
 sequencer.h              |   2 +-
 t/t3511-cherry-pick-x.sh | 219 +++++++++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh  | 263 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/test-lib-functions.sh  |   9 +-
 9 files changed, 595 insertions(+), 153 deletions(-)
 create mode 100755 t/t3511-cherry-pick-x.sh

--=20
1.8.1.1.252.gdb33759
