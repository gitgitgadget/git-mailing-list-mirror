From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Only re-encode certain parts in commit object, not the whole
Date: Tue, 21 Feb 2012 21:24:52 +0700
Message-ID: <1329834292-2511-4-git-send-email-pclouds@gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:26:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqfU-0004ky-Qf
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab2BUO0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:26:07 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64503 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab2BUO0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:26:05 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so6934617dae.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:26:05 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.241.39 as permitted sender) client-ip=10.68.241.39;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.241.39 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.241.39])
        by 10.68.241.39 with SMTP id wf7mr75338318pbc.128.1329834365402 (num_hops = 1);
        Tue, 21 Feb 2012 06:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hSfuEUU571mH/bmmbtLu6rUS45rRCkWmzeo6mn6/ipc=;
        b=w8Ba4ri9JeXW/6oD1AdqsLdA4CvdXozqg4rxl+n9K74+Drh6H/wahWjrNE0XKadXN3
         WA7IqBUYbVpLpeZg1Mc+G8YfXspdjmUM9vYNL28/N8aUZw+VII+7crAMfOAZLRZH3dP9
         dzw2LJTrocN8A2pdxM92yU4uc/YpupF1yQis8=
Received: by 10.68.241.39 with SMTP id wf7mr62198372pbc.128.1329834365367;
        Tue, 21 Feb 2012 06:26:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id p8sm16185543pbs.51.2012.02.21.06.26.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 06:26:04 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Feb 2012 21:25:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191160>

Commit object has its own format, which happens to be in ascii, but
not really subject to re-encoding.

There are only four areas that may be re-encoded: author line,
committer line, mergetag lines and commit body.  Encoding of tags
embedded in mergetag lines is not decided by commit encoding, so leave
it out and consider it binary.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pretty.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 5c433a2..6ccc091 100644
--- a/pretty.c
+++ b/pretty.c
@@ -489,6 +489,62 @@ static char *replace_encoding_header(char *buf, co=
nst char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
=20
+/*
+ * Re-encode author, committer and commit body only, leaving the rest
+ * in ascii (or whatever the encoding it is in mergetag lines)
+ * regardless output encoding. We assume the commit is good, so no
+ * validation.
+ */
+static char *reencode_commit(const char *buffer,
+			     const char *out_enc, const char *in_enc)
+{
+	struct strbuf out =3D STRBUF_INIT;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *reencoded, *s, *e;
+
+	strbuf_addstr(&buf, buffer);
+
+	s =3D strstr(buf.buf, "\nauthor ");
+	assert(s !=3D NULL);
+	s +=3D 8;			/* "\nauthor " */
+	strbuf_add(&out, buf.buf, s - buf.buf);
+	e =3D strchr(s, '\n');
+	*e =3D '\0';
+	reencoded =3D reencode_string(s, out_enc, in_enc);
+	if (reencoded && strchr(reencoded, '\n'))
+		die("your chosen encoding produces \\n out of nowhere?");
+	strbuf_addstr(&out, reencoded ? reencoded : s);
+	free(reencoded);
+
+	strbuf_addstr(&out, "\ncommitter ");
+	assert(!strncmp(e + 1, "committer ", 10));
+	s =3D e + 11;		/* "\ncommitter " */
+	e =3D strchr(s, '\n');
+	*e =3D '\0';
+	reencoded =3D reencode_string(s, out_enc, in_enc);
+	if (reencoded && strchr(reencoded, '\n'))
+		die("your chosen encoding produces \\n out of nowhere?");
+	strbuf_addstr(&out, reencoded ? reencoded : s);
+	free(reencoded);
+	*e =3D '\n';
+
+	s =3D e;
+	e =3D strstr(s, "\n\n");
+	if (e) {
+		e +=3D 2;		/* "\n\n" */
+		strbuf_add(&out, s, e - s);
+
+		s =3D e;
+		reencoded =3D reencode_string(s, out_enc, in_enc);
+		strbuf_addstr(&out, reencoded ? reencoded : s);
+		free(reencoded);
+	} else
+		strbuf_addstr(&out, s);
+
+	strbuf_release(&buf);
+	return strbuf_detach(&out, NULL);
+}
+
 char *logmsg_reencode(const struct commit *commit,
 		      const char *output_encoding)
 {
@@ -514,7 +570,7 @@ char *logmsg_reencode(const struct commit *commit,
 		else
 			return NULL; /* nothing to do */
 	else
-		out =3D reencode_string(commit->buffer,
+		out =3D reencode_commit(commit->buffer,
 				      output_encoding, use_encoding);
 	if (out)
 		out =3D replace_encoding_header(out, output_encoding);
--=20
1.7.8.36.g69ee2
