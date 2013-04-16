From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/13] pretty: save commit encoding from logmsg_reencode if the caller needs it
Date: Tue, 16 Apr 2013 18:24:50 +1000
Message-ID: <1366100702-31745-2-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Ct-0004xw-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935636Ab3DPIZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:25:34 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33329 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935614Ab3DPIZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:25:32 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so167357pdj.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gvgaJwNthkuTeYh0TO/6vDxUS3qNsSfLZCgUSoV+KQc=;
        b=CU+k0q/PjE7ZBoWJ1FkYjKKCSeG+Kn072PBr2rkKlvwyD2V3hlrq4MTHl4VFtseBlc
         MfjrSFfEgu7mMYbAhOX91nO4dMCqDvGd+m5V8YMK9kkg0pdIG4kmDnsRLvlBRQLIbdeJ
         4e9xyHGNr81upR7Kg7iY8WgYGOq7waNeD7EE3NsDu68hUjmOXSysNeOLinzmUQGVD5pE
         mnbYbozpmzaAQuQEP7IAEZLgQCrxb/fwrjE3O2LgbS9809UXghs+kz3zQp/OqajE30j5
         Jzfyl1J9DIU1EBlnsz/gARrbkaq8LMK2qWzBePWKHdt1LhU6C4NGH4DrsAwr/Eaq7Pjn
         d48g==
X-Received: by 10.68.129.232 with SMTP id nz8mr1840563pbb.25.1366100731747;
        Tue, 16 Apr 2013 01:25:31 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id li15sm1781798pab.2.2013.04.16.01.25.28
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:25:30 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:25:17 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221380>

The commit encoding is parsed by logmsg_reencode, there's no need for
the caller to re-parse it again. The reencoded message now has the new
encoding, not the original one. The caller would need to read commit
object again before parsing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c  |  2 +-
 builtin/commit.c |  2 +-
 commit.h         |  1 +
 pretty.c         | 16 ++++++++++++----
 revision.c       |  2 +-
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86100e9..104a948 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1425,7 +1425,7 @@ static void get_commit_info(struct commit *commit=
,
 	commit_info_init(ret);
=20
 	encoding =3D get_log_output_encoding();
-	message =3D logmsg_reencode(commit, encoding);
+	message =3D logmsg_reencode(commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
diff --git a/builtin/commit.c b/builtin/commit.c
index 4620437..d2f30d9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -955,7 +955,7 @@ static const char *read_commit_message(const char *=
name)
 	if (!commit)
 		die(_("could not lookup commit %s"), name);
 	out_enc =3D get_commit_output_encoding();
-	return logmsg_reencode(commit, out_enc);
+	return logmsg_reencode(commit, NULL, out_enc);
 }
=20
 static int parse_and_validate_options(int argc, const char *argv[],
diff --git a/commit.h b/commit.h
index 87b4b6c..ad55213 100644
--- a/commit.h
+++ b/commit.h
@@ -101,6 +101,7 @@ struct userformat_want {
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
+			     char **commit_encoding,
 			     const char *output_encoding);
 extern void logmsg_free(char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index d3a82d2..c361b9b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -594,6 +594,7 @@ static char *replace_encoding_header(char *buf, con=
st char *encoding)
 }
=20
 char *logmsg_reencode(const struct commit *commit,
+		      char **commit_encoding,
 		      const char *output_encoding)
 {
 	static const char *utf8 =3D "UTF-8";
@@ -615,9 +616,15 @@ char *logmsg_reencode(const struct commit *commit,
 			    sha1_to_hex(commit->object.sha1), typename(type));
 	}
=20
-	if (!output_encoding || !*output_encoding)
+	if (!output_encoding || !*output_encoding) {
+		if (commit_encoding)
+			*commit_encoding =3D
+				get_header(commit, msg, "encoding");
 		return msg;
+	}
 	encoding =3D get_header(commit, msg, "encoding");
+	if (commit_encoding)
+		*commit_encoding =3D encoding;
 	use_encoding =3D encoding ? encoding : utf8;
 	if (same_encoding(use_encoding, output_encoding)) {
 		/*
@@ -658,7 +665,8 @@ char *logmsg_reencode(const struct commit *commit,
 	if (out)
 		out =3D replace_encoding_header(out, output_encoding);
=20
-	free(encoding);
+	if (!commit_encoding)
+		free(encoding);
 	/*
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
@@ -1288,7 +1296,7 @@ void format_commit_message(const struct commit *c=
ommit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
-	context.message =3D logmsg_reencode(commit, output_enc);
+	context.message =3D logmsg_reencode(commit, NULL, output_enc);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
@@ -1451,7 +1459,7 @@ void pretty_print_commit(const struct pretty_prin=
t_context *pp,
 	}
=20
 	encoding =3D get_log_output_encoding();
-	msg =3D reencoded =3D logmsg_reencode(commit, encoding);
+	msg =3D reencoded =3D logmsg_reencode(commit, NULL, encoding);
=20
 	if (pp->fmt =3D=3D CMIT_FMT_ONELINE || pp->fmt =3D=3D CMIT_FMT_EMAIL)
 		indent =3D 0;
diff --git a/revision.c b/revision.c
index 71e62d8..2e77397 100644
--- a/revision.c
+++ b/revision.c
@@ -2314,7 +2314,7 @@ static int commit_match(struct commit *commit, st=
ruct rev_info *opt)
 	 * in it.
 	 */
 	encoding =3D get_log_output_encoding();
-	message =3D logmsg_reencode(commit, encoding);
+	message =3D logmsg_reencode(commit, NULL, encoding);
=20
 	/* Copy the commit to temporary if we are using "fake" headers */
 	if (buf.len)
--=20
1.8.2.82.gc24b958
