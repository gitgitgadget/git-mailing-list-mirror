From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/24] status: enable untracked cache
Date: Tue, 20 Jan 2015 20:03:27 +0700
Message-ID: <1421759013-8494-19-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:05:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYV7-0003xa-58
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbbATNFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:05:35 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37075 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713AbbATNFe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:05:34 -0500
Received: by mail-pd0-f171.google.com with SMTP id fp1so21491051pdb.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0PZzS+0ot58sZh8tWqd4XgDkyYStqMt9pXnST8Vl8NE=;
        b=KzO30a69F2CcXlqVCVPvcth8YvLdasNuK/nrzEUuTK+Z7LeFmtJvbPyOu0Bz9PAA/K
         O94yAEujTAYZ/Km+cGiqSCTAr4vpLn3d+3XW/IO0Z5NhczTs1amtKdYJcVCs8S0wSWtD
         5wpO+nY9UQK1tFDX+20pmRCOMVyJIWxlVTaIHez3/2sPQAVp3bB4GtFmB3t2vdkofXXY
         wVWSDHQsfvnMdjJOx7gh6u8DWOa1dJ51PgsB2f4kaW2zDjDEkA+QlZMl5FwCerdP37tu
         u+este6+jYv4j12+0gUyIAmkaMEdVcvkiICNRue+SSs+Odw6J1HootaJ6Q0qqStEsAPK
         vFKw==
X-Received: by 10.66.235.200 with SMTP id uo8mr52733109pac.108.1421759133661;
        Tue, 20 Jan 2015 05:05:33 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id f3sm53692pdb.41.2015.01.20.05.05.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:05:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:05:44 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262670>

update_index_if_able() is moved down so that the updated untracked
cache could be written out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 5 +++--
 wt-status.c      | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..bdcfa61 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1372,13 +1372,14 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, &s.pathspec=
, NULL, NULL);
=20
 	fd =3D hold_locked_index(&index_lock, 0);
-	if (0 <=3D fd)
-		update_index_if_able(&the_index, &index_lock);
=20
 	s.is_initial =3D get_sha1(s.reference, sha1) ? 1 : 0;
 	s.ignore_submodule_arg =3D ignore_submodule_arg;
 	wt_status_collect(&s);
=20
+	if (0 <=3D fd)
+		update_index_if_able(&the_index, &index_lock);
+
 	if (s.relative_paths)
 		s.prefix =3D prefix;
=20
diff --git a/wt-status.c b/wt-status.c
index 27da529..8880c3b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -585,6 +585,8 @@ static void wt_status_collect_untracked(struct wt_s=
tatus *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	if (s->show_ignored_files)
 		dir.flags |=3D DIR_SHOW_IGNORED_TOO;
+	else
+		dir.untracked =3D the_index.untracked;
 	setup_standard_excludes(&dir);
=20
 	fill_directory(&dir, &s->pathspec);
--=20
2.2.0.84.ge9c7a8a
