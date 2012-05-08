From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] notes: do not accept non-blobs as new notes
Date: Tue,  8 May 2012 20:11:32 +0700
Message-ID: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 15:15:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkGB-0007eE-1i
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027Ab2EHNPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:15:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2EHNPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 09:15:15 -0400
Received: by pbbrp8 with SMTP id rp8so8030649pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=klwgy9b1LlSN4MqqVMTrog6uVDjZwYSj0DkpwE5y1ck=;
        b=ijMPS8ZKd4YNbtjpfvhRbeoMFtsI07UdObfneGGZJTVSf328YqywxqiT7vkxTav1IN
         QXfIQ881UJz25+RtTUO7A8EPL3XM2t3h7Ap1nYZFdWvZojaHmX+G08tBg0AJeQH/+j7M
         T3v6lk7eCFw+yAb47mG1N44AjdaYP5aac9DzDS2rAd1Ez3SIATdVDPOqKwg/7zee+7CJ
         bTBpi3cZjcSNghNQQ8vSa/Vz30AB8V2CfmYwu5j1f9p6RQVFM8dpO9vk//QeVDgEqeBr
         WSDmAkwF7sj1hJHK3FaSzS4TxcyEiqm2i/ts7r2FGH8526r1JGUFebJANMAvHqHp/ajj
         S3sg==
Received: by 10.68.217.165 with SMTP id oz5mr7493142pbc.131.1336482914983;
        Tue, 08 May 2012 06:15:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id vl3sm2359444pbc.44.2012.05.08.06.15.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 06:15:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 May 2012 20:11:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197360>

While at it, check if current notes are blobs before using them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c  |    9 ++++++++-
 t/t3301-notes.sh |    4 ++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 3644d14..5f276fc 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -114,6 +114,8 @@ static void write_note_data(int fd, const unsigned =
char *sha1)
 	enum object_type type;
 	char *buf =3D read_sha1_file(sha1, &type, &size);
 	if (buf) {
+		if (type !=3D OBJ_BLOB)
+			die(_("note %s is not a blob"), sha1_to_hex(sha1));
 		if (size)
 			write_or_die(fd, buf, size);
 		free(buf);
@@ -201,8 +203,11 @@ static void create_note(const unsigned char *objec=
t, struct msg_arg *msg,
 		strbuf_grow(&(msg->buf), size + 1);
 		if (msg->buf.len && prev_buf && size)
 			strbuf_insert(&(msg->buf), 0, "\n", 1);
-		if (prev_buf && size)
+		if (prev_buf && size) {
+			if (type !=3D OBJ_BLOB)
+				die(_("note %s is not a blob"), sha1_to_hex(prev));
 			strbuf_insert(&(msg->buf), 0, prev_buf, size);
+		}
 		free(prev_buf);
 	}
=20
@@ -274,6 +279,8 @@ static int parse_reuse_arg(const struct option *opt=
, const char *arg, int unset)
 		free(buf);
 		die(_("Failed to read object '%s'."), arg);;
 	}
+	if (type !=3D OBJ_BLOB)
+		die(_("%s is not a blob, invalid for notes"), sha1_to_hex(object));
 	strbuf_add(&(msg->buf), buf, len);
 	free(buf);
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 16de05a..8c72755 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1222,4 +1222,8 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=3Drefs/notes/bar git notes --ref=3Dbaz get-ref)=
" =3D "refs/notes/baz"
 '
=20
+test_expect_success 'non-blobs cannot be notes' '
+	test_must_fail git notes add -f -C HEAD^{tree}
+'
+
 test_done
--=20
1.7.8.36.g69ee2
