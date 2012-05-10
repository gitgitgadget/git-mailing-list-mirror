From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] notes: preserve object type given by "add -C"
Date: Thu, 10 May 2012 21:04:58 +0700
Message-ID: <1336658701-9004-2-git-send-email-pclouds@gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSU3a-0000AG-HH
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641Ab2EJOI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:08:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46078 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759597Ab2EJOIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:08:53 -0400
Received: by dady13 with SMTP id y13so1758176dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8pIZm+S1haFYwnF/J63xKcT92Hyx43Q65PwoEIeXHNU=;
        b=vo/emaBTzsZUdiH4dWZ2wvKVU48NjZuCvmHkk2vqhxYUZFqQj6vVMgvReBoxRBUEaA
         V+qVIz5ZV/PUZWxqs+pW0nHT5/KZ1kg9Lw80Gjq7JPwpdnWpkXx2jUsq6STBofSr2a0U
         DdLmPKSL26i0Fqsn7OfqFVEL+fVeGGizGXVYTe+cAztnBOINtT99ZiiEhKV4T5tWHy+y
         nsDH/0pJdKmNbyinzpZ4u3DM+kSdBPCe9+DJNxO1cYRsAVcSo3tHMOFV1ZLx6Qw/8kLR
         eu0XR6aIrYjDXJi3GMs/nNgob0+ZXV28bwI4eJT2eqhZlGOWMA1pqvx72CMF2dutnsN+
         XB/g==
Received: by 10.68.221.105 with SMTP id qd9mr20682791pbc.1.1336658932848;
        Thu, 10 May 2012 07:08:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id ov3sm9632380pbb.35.2012.05.10.07.08.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:08:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:05:11 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197566>


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
1.7.8.36.g69ee2
