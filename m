From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 03/15] tar-tree: remove dependency on sq_quote_print()
Date: Sun,  9 Jun 2013 23:24:22 +0530
Message-ID: <1370800474-8940-4-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrw-000725-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab3FIR4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:56:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63136 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3FIR4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:56:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1440980pbb.5
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eiGuAKA7fmRJf9BPSy7eNrmdhN5olubiJD7yiuYbPAc=;
        b=L4/oJ44UqDyT5cE79VDy0G6cYqiwrPtYTjdEYuJnLDDNWlaFXrm2fQefWrV5xuKz8L
         FFYERILIxtE+EYI3Naiy0hfiGM8ZRTteKVHNPsM8HTLUXVugJm6DOBSS8gNQb0dMCxkg
         /SG7+UbAo1Ttr1myo7DCWKAJHU8kOZn3rqBC253addducDLLXo2yt4WTEwSYLKDJ8fKd
         0kPcIiPIJ57aBc20ZQpzFR3YJUD9u8VS3L1DuNbPakPBAiF/TFetC+/+zChMEzk9vvad
         XCFhIQniv9lEh7tMcgZlvL7TxJEEMl32/QKbAywUG42NRACuzYeqPZ08D5WmfEdnKBfv
         wOXQ==
X-Received: by 10.66.255.72 with SMTP id ao8mr10911729pad.3.1370800602923;
        Sun, 09 Jun 2013 10:56:42 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.56.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:56:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227072>

Currently, there is exactly one caller of sq_quote_print(), namely
cmd_tar_tree().  In the interest of removing sq_quote_print() and
simplification, replace it with an equivalent call to sq_quote_argv().
No functional changes intended.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/tar-tree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/tar-tree.c b/builtin/tar-tree.c
index 3f1e701..ba3ffe6 100644
--- a/builtin/tar-tree.c
+++ b/builtin/tar-tree.c
@@ -26,8 +26,8 @@ int cmd_tar_tree(int argc, const char **argv, const c=
har *prefix)
 	 * $0 tree-ish basedir =3D=3D>
 	 * 	git archive --format-tar --prefix=3Dbasedir tree-ish
 	 */
-	int i;
 	const char **nargv =3D xcalloc(sizeof(*nargv), argc + 3);
+	struct strbuf sb =3D STRBUF_INIT;
 	char *basedir_arg;
 	int nargc =3D 0;
=20
@@ -65,11 +65,10 @@ int cmd_tar_tree(int argc, const char **argv, const=
 char *prefix)
 	fprintf(stderr,
 		"*** \"git tar-tree\" is now deprecated.\n"
 		"*** Running \"git archive\" instead.\n***");
-	for (i =3D 0; i < nargc; i++) {
-		fputc(' ', stderr);
-		sq_quote_print(stderr, nargv[i]);
-	}
-	fputc('\n', stderr);
+	sq_quote_argv(&sb, nargv, 0);
+	strbuf_addch(&sb, '\n');
+	fputs(sb.buf, stderr);
+	strbuf_release(&sb);
 	return cmd_archive(nargc, nargv, prefix);
 }
=20
--=20
1.8.3.247.g485169c
