From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/12] pretty: save commit encoding from logmsg_reencode if the caller needs it
Date: Sat, 30 Mar 2013 16:35:05 +0700
Message-ID: <1364636112-15065-6-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 10:36:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULsCl-00038P-T4
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 10:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242Ab3C3Jfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 05:35:40 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54136 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3C3Jfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 05:35:38 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so535214pbb.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3mXRqSrwTKHM984hM7RcnxJJZoNGU2YRknLZtpfa2p8=;
        b=zOCmpg7fglJi/nv868sMXaUfy8FweLZo+0MFVFY97ZV+4cXxvXdmumJY3l/JHA9NNH
         6jmxPFKTFTRAba3FjwE/XXtOJFA5x7Eh0rymc/SPqZp10RRQfOIvPAu1ntio77yBk3rq
         e91Q5ZP1RSdxQ3QMKLIyBuQ8d9bSj3+xxh1K5AT2zaGjqGq/V3NCnbUf+bPiDYeo8nID
         hEDjmNPoYZtBEUbwwNCwH5Rq5qRwe5YBpBUB3wJ3XQvSk8eYDYbVbrd4F0gnhBuOIjX8
         T8Lhkd022716faI8KgxSAEIMUD/jJTQYbt7EGmo2hQK6Nn0wfhif8X6pb4yFgSjbl2Ig
         mmjA==
X-Received: by 10.68.195.161 with SMTP id if1mr7746379pbc.207.1364636138365;
        Sat, 30 Mar 2013 02:35:38 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id wm3sm6009128pbc.4.2013.03.30.02.35.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 30 Mar 2013 02:35:37 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Mar 2013 16:35:43 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219574>

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
index 3348aa1..beead44 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -953,7 +953,7 @@ static const char *read_commit_message(const char *=
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
index 4138bb4..085349a 100644
--- a/commit.h
+++ b/commit.h
@@ -100,6 +100,7 @@ struct userformat_want {
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
+			     char **commit_encoding,
 			     const char *output_encoding);
 extern void logmsg_free(char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
diff --git a/pretty.c b/pretty.c
index 79784be..ab5d70f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -584,6 +584,7 @@ static char *replace_encoding_header(char *buf, con=
st char *encoding)
 }
=20
 char *logmsg_reencode(const struct commit *commit,
+		      char **commit_encoding,
 		      const char *output_encoding)
 {
 	static const char *utf8 =3D "UTF-8";
@@ -605,9 +606,15 @@ char *logmsg_reencode(const struct commit *commit,
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
@@ -648,7 +655,8 @@ char *logmsg_reencode(const struct commit *commit,
 	if (out)
 		out =3D replace_encoding_header(out, output_encoding);
=20
-	free(encoding);
+	if (!commit_encoding)
+		free(encoding);
 	/*
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
@@ -1313,7 +1321,7 @@ void format_commit_message(const struct commit *c=
ommit,
 	context.commit =3D commit;
 	context.pretty_ctx =3D pretty_ctx;
 	context.wrap_start =3D sb->len;
-	context.message =3D logmsg_reencode(commit, output_enc);
+	context.message =3D logmsg_reencode(commit, NULL, output_enc);
=20
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
@@ -1476,7 +1484,7 @@ void pretty_print_commit(const struct pretty_prin=
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
index ef60205..c6ff560 100644
--- a/revision.c
+++ b/revision.c
@@ -2290,7 +2290,7 @@ static int commit_match(struct commit *commit, st=
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
1.8.2.83.gc99314b
