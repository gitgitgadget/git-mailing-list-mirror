From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/43] index-pack: trust the prefix returned by setup_git_directory_gently()
Date: Mon,  5 Apr 2010 20:41:05 +0200
Message-ID: <1270492888-26589-21-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH3-0000ps-Tq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab0DESmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:49 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab0DESmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:38 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ISz5+sbecM9erOcvt7ShSTxcFcUYQhei85n6iqCJb1c=;
        b=xQj4FTgdu0rzUWRuwY2uiBLBZ6igpm+t8YUnIB5FXJW0kGI2U25mHqMLwcN0P+chmK
         GJY4scbpfOJUIjKVdykMhJuttSH4LnaS630kcOtDBVZ/wIZnoot2oRZU0vJzX4NZRxce
         x/jXcugxxKmvTDa5kAuAIrHlXKlpmFygZtHEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=goJEoY4wOiPHDhjb+3n5id2SPiQPVd0dgCPQ1ZAl7eLU5tcmllCl1DrKOLuKFoYPmO
         6BSlCU+1SxcHRkvbuj4h13I3KBqLXtC2FM5XTlBxijyFt9mQH1Xp4AreJg5JvLLr+Hva
         uRqui2O7wSzxsMpRdN0nNJ+JV0/Lcyyx/HqHA=
Received: by 10.223.143.67 with SMTP id t3mr5911827fau.16.1270492957870;
        Mon, 05 Apr 2010 11:42:37 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 15sm8131323fxm.7.2010.04.05.11.42.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:37 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:35 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144035>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.0.rc1.541.g2da82.dirty
