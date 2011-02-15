From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] git.c: binary-search builtin commands
Date: Tue, 15 Feb 2011 10:09:04 +0700
Message-ID: <1297739344-28961-2-git-send-email-pclouds@gmail.com>
References: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org>
 <1297739344-28961-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 04:06:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpBFZ-0007bG-BB
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 04:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1BODGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 22:06:46 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:63114 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1BODGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 22:06:41 -0500
Received: by pxi15 with SMTP id 15so931681pxi.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 19:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=rvYWns/QZYc6oCc/ZTd3iX/0tKzgDDl9C8PWYH0ONVk=;
        b=doIomyVBWFtaCxWqFLRPwIKGtyjQaBRWZMkls14D+q2HDhEXMoZoGsDskenQ6EXWIG
         4imWg0sCh360ZOFvVftq8bSaK8xSonn9OMB3v9I35bpSSxQIg0oc4RrKXyysl8xKCNlE
         mCzvt0M6gY784yMWZEfXI9qGxAYPDOXGgfU6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qFwhIPTY90fZoXap/kAWA1AIHsPbhGsGqvleajWhqLmYyu3Wrc7q9URIiFOueMlczz
         Nx5rPDomhNz8oPv/WOX4N/unHOv8Sx8AOY+RnWI2eh2/kc0/1XU2k/wcRiNeq42BI5cI
         UIthqTO/RuzilfNvJuTbO8Lie3CiEDlHyPiyY=
Received: by 10.142.135.18 with SMTP id i18mr3725447wfd.374.1297739201421;
        Mon, 14 Feb 2011 19:06:41 -0800 (PST)
Received: from tre ([115.73.232.10])
        by mx.google.com with ESMTPS id x35sm5030107wfd.13.2011.02.14.19.06.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 19:06:40 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Feb 2011 10:09:15 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1297739344-28961-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166807>

An obvious implication of this patch: commands array must be in correct
order.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  2011/2/15 Junio C Hamano <gitster@pobox.com>:
  > I did this myself the other day, as I think it simply is a good pro=
ject
  > hygiene.  If this were 1/2 of a series followed by 2/2 that runs bi=
nary
  > search in the table, that would make it make more sense ;-)
 =20
  I did think the array was binary-searched and nearly claimed "git-sta=
ge
  won't work because it's in wrong order".

  This patch won't give any performance gain, but it would force
  people to keep the array in order :-)

 git.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 57701e3..c36117a 100644
--- a/git.c
+++ b/git.c
@@ -308,6 +308,13 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 	return 0;
 }
=20
+static int cmd_cmp(const void *a, const void *b)
+{
+	const char *key =3D a;
+	const struct cmd_struct *cmd =3D b;
+	return strcmp(key, cmd->cmd);
+}
+
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd =3D argv[0];
@@ -423,6 +430,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
 	};
+	struct cmd_struct *p;
 	int i;
 	static const char ext[] =3D STRIP_EXTENSION;
=20
@@ -441,12 +449,9 @@ static void handle_internal_command(int argc, cons=
t char **argv)
 		argv[0] =3D cmd =3D "help";
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p =3D commands+i;
-		if (strcmp(p->cmd, cmd))
-			continue;
+	p =3D bsearch(cmd, commands, ARRAY_SIZE(commands), sizeof(*commands),=
 cmd_cmp);
+	if (p)
 		exit(run_builtin(p, argc, argv));
-	}
 }
=20
 static void execv_dashed_external(const char **argv)
--=20
1.7.4.74.g639db
