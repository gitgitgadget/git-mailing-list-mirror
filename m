From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/12] utf8: keep NULs in reencode_string()
Date: Sat, 16 Mar 2013 09:24:38 +0700
Message-ID: <1363400683-14813-8-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:32:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgvP-0001W0-8X
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab3CPCcT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:32:19 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:32910 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab3CPCcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:32:18 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so4523360pbc.21
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=mdDr0GCCQPH2cvOxxBP7FweN/EPvK8VXYZCzXXXGJuc=;
        b=ZMeWcJb+iBRCfJAybr3kJlzVZ1A9MyBee434cCZCZlwe0KsyErHwrvRRtxW8rqrSG2
         LK36Jfg8YFTGzy9fQHOix48JYypX8gtvNayRRo9QJWqXwGLAPDlZnd/AEjML4Mb+0kes
         Iqr74MMyaLfW8pMpx4jFhU6FdyJEpsj9O8NYdl82XQgKmu3YKAVwbrLOmpAavH1Fi4AH
         PQwKJcAQ9Fxflr+iK+5uz0JdFRfIawBvFDhpRY3coHnlpHWtdzxZ49CSqTdJB1+0+oEb
         cXiAZc/Xn9lBtjbIr17I76VgrC3MTwhnZIAH5g7aogzGUKaA9Ai4rGMMfeScGacMvHWf
         RlUg==
X-Received: by 10.68.218.72 with SMTP id pe8mr20972247pbc.112.1363400734676;
        Fri, 15 Mar 2013 19:25:34 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id mz8sm11516870pbc.9.2013.03.15.19.25.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:28 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218284>

reencode_string() will be used in the next patch for re-encoding
pretty output, which can contain NULs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fast-export.c    |  3 ++-
 builtin/mailinfo.c       |  3 ++-
 compat/precompose_utf8.c |  2 +-
 notes.c                  |  4 +++-
 pretty.c                 |  3 ++-
 sequencer.c              |  5 +++--
 utf8.c                   | 10 +++++++---
 utf8.h                   | 10 +++++++---
 8 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 77dffd1..7ba9f3b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -316,7 +316,8 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev)
=20
 	mark_next_object(&commit->object);
 	if (!is_encoding_utf8(encoding))
-		reencoded =3D reencode_string(message, "UTF-8", encoding);
+		reencoded =3D reencode_string(message, strlen(message),
+					    "UTF-8", encoding, NULL);
 	if (!commit->parents)
 		printf("reset %s\n", (const char*)commit->util);
 	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 24a772d..129e7dc 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -486,7 +486,8 @@ static void convert_to_utf8(struct strbuf *line, co=
nst char *charset)
=20
 	if (same_encoding(metainfo_charset, charset))
 		return;
-	out =3D reencode_string(line->buf, metainfo_charset, charset);
+	out =3D reencode_string(line->buf, line->len,
+			      metainfo_charset, charset, NULL);
 	if (!out)
 		die("cannot convert from %s to %s",
 		    charset, metainfo_charset);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8cf5955..d9203d0 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -78,7 +78,7 @@ void precompose_argv(int argc, const char **argv)
 		size_t namelen;
 		oldarg =3D argv[i];
 		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
-			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose);
+			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose, NU=
LL);
 			if (newarg)
 				argv[i] =3D newarg;
 		}
diff --git a/notes.c b/notes.c
index f63fd57..4ae3b25 100644
--- a/notes.c
+++ b/notes.c
@@ -1222,7 +1222,9 @@ static void format_note(struct notes_tree *t, con=
st unsigned char *object_sha1,
=20
 	if (output_encoding && *output_encoding &&
 	    !is_encoding_utf8(output_encoding)) {
-		char *reencoded =3D reencode_string(msg, output_encoding, utf8);
+		char *reencoded =3D reencode_string(msg, strlen(msg),
+						  output_encoding, utf8,
+						  NULL);
 		if (reencoded) {
 			free(msg);
 			msg =3D reencoded;
diff --git a/pretty.c b/pretty.c
index e2241e5..092dd1d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -643,7 +643,8 @@ char *logmsg_reencode(const struct commit *commit,
 		 * this point, we are done with msg. If we allocated a fresh
 		 * copy, we can free it.
 		 */
-		out =3D reencode_string(msg, output_encoding, use_encoding);
+		out =3D reencode_string(msg, strlen(msg),
+				      output_encoding, use_encoding, NULL);
 		if (out && msg !=3D commit->buffer)
 			free(msg);
 	}
diff --git a/sequencer.c b/sequencer.c
index aef5e8a..bf15531 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -61,8 +61,9 @@ static int get_message(struct commit *commit, struct =
commit_message *out)
 	out->reencoded_message =3D NULL;
 	out->message =3D commit->buffer;
 	if (same_encoding(encoding, git_commit_encoding))
-		out->reencoded_message =3D reencode_string(commit->buffer,
-					git_commit_encoding, encoding);
+		out->reencoded_message =3D
+			reencode_string(commit->buffer, strlen(commit->buffer),
+					git_commit_encoding, encoding, NULL);
 	if (out->reencoded_message)
 		out->message =3D out->reencoded_message;
=20
diff --git a/utf8.c b/utf8.c
index 38322a1..9d98043 100644
--- a/utf8.c
+++ b/utf8.c
@@ -468,7 +468,7 @@ int utf8_fprintf(FILE *stream, const char *format, =
=2E..)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv,=
 int *outsz_p)
 {
 	size_t outsz, outalloc;
 	char *out, *outpos;
@@ -502,13 +502,17 @@ char *reencode_string_iconv(const char *in, size_=
t insz, iconv_t conv)
 		}
 		else {
 			*outpos =3D '\0';
+			if (outsz_p)
+				*outsz_p =3D outpos - out;
 			break;
 		}
 	}
 	return out;
 }
=20
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding)
+char *reencode_string(const char *in, int insz,
+		      const char *out_encoding, const char *in_encoding,
+		      int *outsz)
 {
 	iconv_t conv;
 	char *out;
@@ -518,7 +522,7 @@ char *reencode_string(const char *in, const char *o=
ut_encoding, const char *in_e
 	conv =3D iconv_open(out_encoding, in_encoding);
 	if (conv =3D=3D (iconv_t) -1)
 		return NULL;
-	out =3D reencode_string_iconv(in, strlen(in), conv);
+	out =3D reencode_string_iconv(in, insz, conv, outsz);
 	iconv_close(conv);
 	return out;
 }
diff --git a/utf8.h b/utf8.h
index a556932..99db3e0 100644
--- a/utf8.h
+++ b/utf8.h
@@ -17,10 +17,14 @@ void strbuf_add_wrapped_bytes(struct strbuf *buf, c=
onst char *data, int len,
 			     int indent, int indent2, int width);
=20
 #ifndef NO_ICONV
-char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)=
;
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding);
+char *reencode_string_iconv(const char *in, size_t insz,
+			    iconv_t conv, int *outsz);
+char *reencode_string(const char *in, int insz,
+		      const char *out_encoding,
+		      const char *in_encoding,
+		      int *outsz);
 #else
-#define reencode_string(a,b,c) NULL
+#define reencode_string(a,b,c,d) NULL
 #endif
=20
 #endif
--=20
1.8.2.83.gc99314b
