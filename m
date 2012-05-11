From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/4] notes: preserve object type given by "add -C"
Date: Fri, 11 May 2012 08:25:03 +0700
Message-ID: <1336699506-28388-2-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:26:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSech-0001u3-QZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532Ab2EKB0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:26:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2EKB0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 21:26:18 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2400997dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lbn4kaISh1CzrQjnflyl3xNFQswkOlh8vXip6o7AtHg=;
        b=ql67zF7JfaqdIgTkRnT6hFNq/m+4Tjos0DSK7oPqsXjkV9P1P5ZPa+ehdNXeWjDEre
         qxy8e2Z4l/RZaGM1I/A5JkraVObsjAxfezZIqepJzuWrtKxhBs/p4eG8LmlR4GV5bl6C
         mUCAL0Q/L+YFMxIhF7jqvR1X+m2SrxQpoNR4RJg6EAeMS+wpsGNjweVUZ6vUiZWfUkpp
         veUeKR76Qd9jfzCJrINYSwKZpeSu4OVdhEgE5Z0/DhF1iekmwpiTMnwab0tdgcqLrXh0
         bp1/rKqZ9fRghabjY2AEbhDAVS7P+estxXA5uPVs8/g8EvVOhi0OIUlODjy9XVY7abf9
         KAEA==
Received: by 10.68.225.104 with SMTP id rj8mr25657680pbc.135.1336699577761;
        Thu, 10 May 2012 18:26:17 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id oz9sm11100376pbc.68.2012.05.10.18.26.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 18:26:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 11 May 2012 08:25:17 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197650>

_Automatically_ converting a non-blob object to a blob is
wrong. Either this way, or reject non-blob objects upfront.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c  |    8 +++++---
 t/t3301-notes.sh |   10 ++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..9840269 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -98,6 +98,7 @@ struct msg_arg {
 	int given;
 	int use_editor;
 	struct strbuf buf;
+	enum object_type type;
 };
=20
 static int list_each_note(const unsigned char *object_sha1,
@@ -211,7 +212,7 @@ static void create_note(const unsigned char *object=
, struct msg_arg *msg,
 			sha1_to_hex(object));
 		hashclr(result);
 	} else {
-		if (write_sha1_file(msg->buf.buf, msg->buf.len, blob_type, result)) =
{
+		if (write_sha1_file(msg->buf.buf, msg->buf.len, typename(msg->type),=
 result)) {
 			error(_("unable to write note object"));
 			if (path)
 				error(_("The note contents has been left in %s"),
@@ -278,6 +279,7 @@ static int parse_reuse_arg(const struct option *opt=
, const char *arg, int unset)
 	free(buf);
=20
 	msg->given =3D 1;
+	msg->type =3D type;
 	return 0;
 }
=20
@@ -529,7 +531,7 @@ static int add(int argc, const char **argv, const c=
har *prefix)
 	unsigned char object[20], new_note[20];
 	char logmsg[100];
 	const unsigned char *note;
-	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
+	struct msg_arg msg =3D { 0, 0, STRBUF_INIT, OBJ_BLOB };
 	struct option options[] =3D {
 		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
 			"note contents as a string", PARSE_OPT_NONEG,
@@ -686,7 +688,7 @@ static int append_edit(int argc, const char **argv,=
 const char *prefix)
 	const unsigned char *note;
 	char logmsg[100];
 	const char * const *usage;
-	struct msg_arg msg =3D { 0, 0, STRBUF_INIT };
+	struct msg_arg msg =3D { 0, 0, STRBUF_INIT, OBJ_BLOB };
 	struct option options[] =3D {
 		{ OPTION_CALLBACK, 'm', "message", &msg, "msg",
 			"note contents as a string", PARSE_OPT_NONEG,
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 16de05a..d3fd341 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1222,4 +1222,14 @@ test_expect_success 'git notes get-ref (--ref)' =
'
 	test "$(GIT_NOTES_REF=3Drefs/notes/bar git notes --ref=3Dbaz get-ref)=
" =3D "refs/notes/baz"
 '
=20
+test_expect_success 'add -C happily takes object of any kind' '
+	git notes add -f -C HEAD^{tree}
+'
+
+test_expect_success 'non-blobs notes are shown in human-readable form'=
 '
+	git notes show HEAD >actual &&
+	git show `git rev-parse HEAD^{tree}` >expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.3.1.256.g2539c.dirty
