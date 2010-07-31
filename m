From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/16] fetch-pack: support --subtree
Date: Sat, 31 Jul 2010 23:18:17 +0700
Message-ID: <1280593105-22015-9-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfORu-0002yA-Nw
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0HACip convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:38:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42790 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0HACio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:38:44 -0400
Received: by pwi5 with SMTP id 5so977126pwi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fL/gtJHflSJTCCCsZiV4iFhSt7aH06KlLdDcC7ODGaU=;
        b=o57bWWvXgyeGn//xbbdUhARI01B+sbVfnd4LlhCyu7kj2nIyNHwPTViw/Xr0RZXtag
         lVjOcdjkOHg1FBK8ovQf6yi+s5frsVgPfIP1TR5YppmmPIhrCt55ZmajW4mGEzw9Igi6
         2BM4SHeyPOusO3dH1DaI6Rpy7b8n66oW2FUeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=u7IsPXFA3RhDvI/oeOdou7clmdU9UMr9FDoyv7YqfrbOmRHmNa9A0RZh77X3cKKB2F
         vHoPbY0xYFHPeYvutOpTdPGSisOoN2L8eWviBM1oDXWWnQqQHSlmqxEdAD01sNgyynC1
         wrNfeV5MFD4MUHLvrIx1rNeZLnGTCSOLCkTK4=
Received: by 10.142.180.1 with SMTP id c1mr3584892wff.59.1280630323978;
        Sat, 31 Jul 2010 19:38:43 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id t11sm5243170wfc.16.2010.07.31.19.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:38:43 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:19:37 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152355>

This options requires subtree-aware upload-pack. It simply pass the
subtree from command line (or from $GIT_DIR/config) to upload-pack.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dbd8b7b..7460ecc 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -237,6 +237,8 @@ static int find_common(int fd[2], unsigned char *re=
sult_sha1,
 	for_each_ref(rev_list_insert_ref, NULL);
=20
 	fetching =3D 0;
+	if (core_subtree)
+		packet_buf_write(&req_buf, "subtree %s\n", core_subtree);
 	for ( ; refs ; refs =3D refs->next) {
 		unsigned char *remote =3D refs->old_sha1;
 		const char *remote_hex;
@@ -692,6 +694,8 @@ static struct ref *do_fetch_pack(int fd[2],
=20
 	if (is_repository_shallow() && !server_supports("shallow"))
 		die("Server does not support shallow clients");
+	if (core_subtree && !server_supports("subtree"))
+		die("Server does not support subtree");
 	if (server_supports("multi_ack_detailed")) {
 		if (args.verbose)
 			fprintf(stderr, "Server supports multi_ack_detailed\n");
@@ -860,6 +864,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 				pack_lockfile_ptr =3D &pack_lockfile;
 				continue;
 			}
+			if (!prefixcmp(arg, "--subtree=3D")) {
+				core_subtree =3D arg + 10;
+				continue;
+			}
 			usage(fetch_pack_usage);
 		}
 		dest =3D (char *)arg;
--=20
1.7.1.rc1.69.g24c2f7
