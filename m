From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] Do attempt pretty print in ASCII-incompatible encodings
Date: Tue, 21 Feb 2012 21:24:50 +0700
Message-ID: <1329834292-2511-2-git-send-email-pclouds@gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 15:26:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzqfD-0004bM-Ro
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 15:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab2BUOZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 09:25:51 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60286 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab2BUOZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 09:25:50 -0500
Received: by pbcun15 with SMTP id un15so7431291pbc.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 06:25:49 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.219.232 as permitted sender) client-ip=10.68.219.232;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.219.232 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.219.232])
        by 10.68.219.232 with SMTP id pr8mr75711326pbc.12.1329834349742 (num_hops = 1);
        Tue, 21 Feb 2012 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DcdFmuhGw3eRXsdwmzow78Cq1U8seN3KAu8kVorKCQw=;
        b=fVJi+1CpvinHKPBy8GhYxriUVED69AYL48FVyfj61OKc7butBOi5HDTOcfZG2urJAG
         WmHTGT/BN+uAcJrDMnybjkhj61tMATvaicJ53q4B1pnf5itviE42ao0fsy3oGPPgGefB
         hL0cr0T38oQ8C+7FNqyzxy3Xn4ZNqQbOU2LbE=
Received: by 10.68.219.232 with SMTP id pr8mr62425284pbc.12.1329834349709;
        Tue, 21 Feb 2012 06:25:49 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.53.120])
        by mx.google.com with ESMTPS id p2sm27751911pbb.14.2012.02.21.06.25.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 06:25:48 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Feb 2012 21:25:01 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191158>

We rely on ASCII everywhere. We print "\n" directly without conversion
for example. The end result would be a mix of some encoding and ASCII
if they are incompatible. Do not do that.

In theory we could convert everything to utf-8 as intermediate medium,
process process process, then convert final output to the desired
encoding. But that's a lot of work (unless we have a pager-like
converter) with little real use. Users can just pipe everything to
iconv instead.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 It seems half of the encodings "iconv -l" list does not pass
 ascii_superset_encoding() test. I just assume they are either exotic
 or duplicate names.

 pretty.c |    7 +++++++
 utf8.c   |   15 +++++++++++++++
 utf8.h   |    1 +
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8688b8f..5c433a2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -493,12 +493,19 @@ char *logmsg_reencode(const struct commit *commit=
,
 		      const char *output_encoding)
 {
 	static const char *utf8 =3D "UTF-8";
+	static const char *last_output_encoding =3D NULL;
 	const char *use_encoding;
 	char *encoding;
 	char *out;
=20
 	if (!*output_encoding)
 		return NULL;
+	if (last_output_encoding !=3D output_encoding) {
+		if (!ascii_superset_encoding(output_encoding))
+			die("encoding %s is not a superset of ASCII.",
+			    output_encoding);
+		last_output_encoding =3D output_encoding;
+	}
 	encoding =3D get_header(commit, "encoding");
 	use_encoding =3D encoding ? encoding : utf8;
 	if (!strcmp(use_encoding, output_encoding))
diff --git a/utf8.c b/utf8.c
index 8acbc66..def93ee 100644
--- a/utf8.c
+++ b/utf8.c
@@ -482,3 +482,18 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	return out;
 }
 #endif
+
+int ascii_superset_encoding(const char *encoding)
+{
+	const char *sample =3D " !\"#$%&'()*+,-./0123456789:;<=3D>?@"
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`"
+		"abcdefghijklmnopqrstuvwxyz{|}~\n";
+	char *output;
+	int ret;
+	if (!encoding)
+		return 1;
+	output =3D reencode_string(sample, encoding, "US-ASCII");
+	ret =3D !output || !strcmp(sample, output);
+	free(output);
+	return ret;
+}
diff --git a/utf8.h b/utf8.h
index 81f2c82..75bc128 100644
--- a/utf8.h
+++ b/utf8.h
@@ -12,6 +12,7 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
 int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int=
 len,
 			     int indent, int indent2, int width);
+int ascii_superset_encoding(const char *encoding);
=20
 #ifndef NO_ICONV
 char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding);
--=20
1.7.8.36.g69ee2
