From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/15] tar-tree: remove dependency on sq_quote_print()
Date: Tue,  9 Jul 2013 16:02:14 +0530
Message-ID: <1373365946-9230-4-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVHX-0006sg-UL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3GIKgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:22 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37535 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3GIKgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:19 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so5101673pdc.19
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DPqwaEk2evy9tVftvDHFrpHcXL6tnMxMoFkaU+8yErs=;
        b=QNzPDVo+7tlm+bufwOb3Ubr+4qX31WX2HqCfpLmnqsDPKC3M7pqTT2cgEV+xaEQXIs
         6PbP5x6xilUIuOUCbGgIwTNNOlQnOxdq9c0Y3W4VQhl6eCiXT8lPsTuDl+FnuB5AzSAC
         A1BLm9TDDcx4Dgwg95VOYZjh0a+CAGzUThNTs7J/ytjxJJs3idlZ2KjC5l8GmTLkMAiV
         KV3Kwyul79L9IxW/cdk4MD40WFcbUX80wuBOWVa3NVfVpV+pm20Tg4JrJuO9GOSGcDWt
         AM6rzTxcakm0O3kxuiptZLuP0bbL/TvucJo8GhYOrgdvbBdDHax8FgMBNyofTk7ZNPwO
         zgvA==
X-Received: by 10.68.228.39 with SMTP id sf7mr25814900pbc.34.1373366179096;
        Tue, 09 Jul 2013 03:36:19 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229932>

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
1.8.3.2.736.g869de25
