From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] wt-status.c: move cut-line print code out to wt_status_add_cut_line
Date: Sun, 16 Feb 2014 10:37:19 +0700
Message-ID: <1392521840-21628-3-git-send-email-pclouds@gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 04:37:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEsXq-0008OH-HV
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 04:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbaBPDh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Feb 2014 22:37:27 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:45174 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaBPDh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 22:37:26 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so13569831pde.28
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 19:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4iiDbQr33ZVZJrwRayFVRDImgJpOla4UXBN/UEc+T1Y=;
        b=Ka9rqbg3YMSi8Qr/D/+keJmBHFAYATvmWz2jl8041ecAdInZGhysbs3jovvLTQ1qnB
         0Y+zoOoz4ZZhmjE4W+87zoJiTue7U9WXOUElOidlGVa6yEAr+Ja9MV9eV6/alLZfjsYC
         vyEy3xxwebXOAJw1be0W8XyK+oi/JP3v1m99VJt3UfuJ8lH1jPGduWj08JIV6e5TJxpu
         gw5Cx8d6uRhsu+mJGpcc924BNQQWSrP3Sv3AZEqZhxzjXd9EJOI6gclt/fuqgDT5N+m/
         dZhwoU50ckGc9VyerXfCfATmQ9hh7LJlHl+psfFt5MzaomOXBUa8Pwvw2tN5E4YiJPRf
         /oNg==
X-Received: by 10.68.130.169 with SMTP id of9mr18429576pbb.79.1392521845644;
        Sat, 15 Feb 2014 19:37:25 -0800 (PST)
Received: from lanh ([115.73.213.123])
        by mx.google.com with ESMTPSA id qs1sm31971558pbb.18.2014.02.15.19.37.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 19:37:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Feb 2014 10:37:36 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242210>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wt-status.c | 19 ++++++++++++-------
 wt-status.h |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 65e35c3..ed31b6a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -808,6 +808,17 @@ void wt_status_truncate_message_at_cut_line(struct=
 strbuf *buf)
 	strbuf_release(&pattern);
 }
=20
+void wt_status_add_cut_line(FILE *fp)
+{
+	const char *explanation =3D _("Do not touch the line above.\nEverythi=
ng below will be removed.");
+	struct strbuf buf =3D STRBUF_INIT;
+
+	fprintf(fp, "%c %s", comment_line_char, cut_line);
+	strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
+	fputs(buf.buf, fp);
+	strbuf_release(&buf);
+}
+
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
@@ -833,14 +844,8 @@ static void wt_status_print_verbose(struct wt_stat=
us *s)
 	 * diff before committing.
 	 */
 	if (s->fp !=3D stdout) {
-		const char *explanation =3D _("Do not touch the line above.\nEveryth=
ing below will be removed.");
-		struct strbuf buf =3D STRBUF_INIT;
-
 		rev.diffopt.use_color =3D 0;
-		fprintf(s->fp, "%c %s", comment_line_char, cut_line);
-		strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
-		fputs(buf.buf, s->fp);
-		strbuf_release(&buf);
+		wt_status_add_cut_line(s->fp);
 	}
 	run_diff_index(&rev, 1);
 }
diff --git a/wt-status.h b/wt-status.h
index 30a4812..b56ce3f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -92,6 +92,7 @@ struct wt_status_state {
 };
=20
 void wt_status_truncate_message_at_cut_line(struct strbuf *);
+void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
--=20
1.8.5.2.240.g8478abd
