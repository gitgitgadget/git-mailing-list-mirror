From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] tar-tree: remove dependency on sq_quote_print()
Date: Tue, 30 Jul 2013 14:01:26 +0530
Message-ID: <1375173087-2164-3-git-send-email-artagnon@gmail.com>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 30 10:35:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V45Oy-0003Ve-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 10:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056Ab3G3IfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 04:35:23 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:34424 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090Ab3G3IfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 04:35:10 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so2382318pbc.23
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+2p5pOPRv63pPRMpaRFcdnYFXjIYk6lMuNDPfRZpeNk=;
        b=PFovpEf4DnXSPCZwHxf4jRELm4Ib6OO2msw6BYlvSqZicmJZK7Dcz+rcIw8ykdnEI4
         Bhee44rEh/O/EDvafc+gqSoSBLoFPr5EZ3qtH4YXCYRHmf0U6MEpe4DngphD6H+oT6Ez
         rM00s4F+ERiCczi9NNvb+XWlGtMgiWBPsMtck5AFVaTtGjdCuVNBKs15oTUTHawvtAWn
         kKeFH//D0BfGtylpv56EU+qMUJnqOACj74PFnQafQEqVRdU6VXJ5KDyPDurI3pogtyUD
         xj7VbW59MiO+X/2wTdz726MpIePelMfCQh17eVPaZ0GtMU/bcEITQw9jqXr4s+tOyB9A
         fItQ==
X-Received: by 10.68.130.234 with SMTP id oh10mr72799294pbb.129.1375173309831;
        Tue, 30 Jul 2013 01:35:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.159.87])
        by mx.google.com with ESMTPSA id qb15sm25641801pab.13.2013.07.30.01.35.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 01:35:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.4.g4634265
In-Reply-To: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231356>

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
1.8.4.rc0.4.g4634265
