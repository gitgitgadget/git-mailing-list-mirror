From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Revert "rehabilitate 'git index-pack' inside the object store"
Date: Fri, 23 Jul 2010 19:04:11 +0700
Message-ID: <1279886651-14590-2-git-send-email-pclouds@gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 14:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcGz8-00065V-Ow
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 14:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588Ab0GWMDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 08:03:53 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53215 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521Ab0GWMDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 08:03:52 -0400
Received: by pxi14 with SMTP id 14so3604912pxi.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EzU8tm9FLF6CWRiB++76pk7k3b60mAQNoGZ2Qxb8Zyg=;
        b=D/QP69ZILuMXTKEDGsxFtjGMtSYSXIQhSmiWZ52pDLew6yQW/H12O3i+oHRgdTEakT
         D/w49mt1ZF4DsSmgc4MpC7vycX7AaxTl4h6iMor1I5oQu6D2fRh+p8Q4Mk/qfOXMtCzH
         kq/xDIQWE8LxoQMNoFdhvbfHXCHtED/w4foik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o9pAp9yo3/QGVIceEZ90HFk8vYHR2ex48p6EqrlzWmUCTDsbuMbrwJaucBq3fd3b4s
         Z3TgLT47XfE3ez6acZNix6nxeNsBqtv93xbfUiQgW+T+/RFX+icUUty02r8BticKg2//
         h7DGRsOiICwa6nyF+SbV2bmyjGZacggp9W5Uo=
Received: by 10.142.132.18 with SMTP id f18mr4028547wfd.263.1279886631455;
        Fri, 23 Jul 2010 05:03:51 -0700 (PDT)
Received: from dektop ([121.91.36.254])
        by mx.google.com with ESMTPS id f2sm181768wfp.23.2010.07.23.05.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 05:03:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Fri, 23 Jul 2010 19:04:20 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151528>

This reverts code change in commit a672ea6ac5a1b876bc7adfe6534b16fa2a32=
c94b.

The cwd behavior now fits index-pack well, i.e. NULL prefix means
no cwd changes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a89ae83..89a1f12 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,29 +880,15 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
+	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
=20
-	/*
-	 * We wish to read the repository's config file if any, and
-	 * for that it is necessary to call setup_git_directory_gently().
-	 * However if the cwd was inside .git/objects/pack/ then we need
-	 * to go back there or all the pack name arguments will be wrong.
-	 * And in that case we cannot rely on any prefix returned by
-	 * setup_git_directory_gently() either.
-	 */
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
1.7.1.rc1.69.g24c2f7
