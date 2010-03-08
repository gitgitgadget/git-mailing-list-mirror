From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] index-pack: trust the prefix returned by setup_git_directory_gently()
Date: Mon,  8 Mar 2010 23:50:32 +0700
Message-ID: <1268067033-25199-2-git-send-email-pclouds@gmail.com>
References: <1268067033-25199-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 17:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NogDd-0006tC-UD
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 17:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab0CHQyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 11:54:09 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45653 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab0CHQyE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 11:54:04 -0500
Received: by mail-ew0-f216.google.com with SMTP id 8so220474ewy.28
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rEyKmlpHu53CaYOgplEucdoBVJmVLMBsOfZ6/DTUzQg=;
        b=of674/ghzga+q/2YLO7uzny0y+oyeN+NdLxHf99yaVYlp8tkN+xNf9rFDnLSp8v1l6
         MYkZDrrAJqe2HSyqzBOjxcyfoErvSbhPI37wK/LstlO1MXUTJ7aEMxIsR7dh7VpGZOJv
         3ET5Y8cz2AXciCTIuS0ykxAP5xNBQSQdO30N8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jFPPxj8F3nFkr8IhRoHQchZne2/HGWd3NVUu2lTxkrg6HDryk1vJ1Zhk0DY31+kqoh
         uRhZKP8YWbWKIGUsNOZ+FNrte4lmCOMkOEtizk+8myVpqQICfQxsqae+DoiTGjegdinS
         /Ez1rkg3ROR2NTmdix341eJEeoCH9lxZFqkIs=
Received: by 10.213.104.19 with SMTP id m19mr3328382ebo.40.1268067243796;
        Mon, 08 Mar 2010 08:54:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 13sm2413439ewy.1.2010.03.08.08.54.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 08:54:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  8 Mar 2010 23:50:43 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268067033-25199-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141772>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b4cf8c5..2a6359d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -879,29 +879,20 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
+	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
=20
 	/*
-	 * We wish to read the repository's config file if any, and
-	 * for that it is necessary to call setup_git_directory_gently().
+	 * We wish to read the repository's config file if any.
 	 * However if the cwd was inside .git/objects/pack/ then we need
 	 * to go back there or all the pack name arguments will be wrong.
-	 * And in that case we cannot rely on any prefix returned by
-	 * setup_git_directory_gently() either.
 	 */
-	{
-		char cwd[PATH_MAX+1];
-		int nongit;
-
-		if (!getcwd(cwd, sizeof(cwd)-1))
-			die("Unable to get current working directory");
-		setup_git_directory_gently(&nongit);
-		git_config(git_index_pack_config, NULL);
-		if (chdir(cwd))
-			die("Cannot come back to cwd");
-	}
+	prefix =3D setup_git_directory_gently(&nongit);
+	git_config(git_index_pack_config, NULL);
+	if (prefix && chdir(prefix))
+		die("Cannot come back to cwd");
=20
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
--=20
1.7.0.1.384.g6abcaa
