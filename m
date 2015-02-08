From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/24] status: enable untracked cache
Date: Sun,  8 Feb 2015 15:55:42 +0700
Message-ID: <1423385748-19825-19-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNgQ-0003Ii-6K
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbbBHI5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:57:34 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37926 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452AbbBHI5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:57:33 -0500
Received: by pdbft15 with SMTP id ft15so24344805pdb.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HfbPHDBDCOrU0oHLr0EfbrmEe4HMziYQE5/dFST4EUE=;
        b=e+iENVxFxl21c8v4iFGy+FDfp9SwkbCih0RoWJetkDv8le2WQCI9+pVpaOs7ExTvDM
         XwgYSXGnuEMVk7NLcCgDmo7xMy2tGoEWhN/HYVtc09zoO+bFpogzfi5f9MWMvWpmAtN8
         PwI/Xxbu/nXQWPV/kNPeAW18RA4QbJTOqr/zj7KvmgICLkG16DPa/7iAf6kFq7RA1ibQ
         b/XQ1Yovp2AtfqUBkLLZO1Amv/bucX+VNmhcy9Kjrzqymb0aJZCDLWzuNtqtuEZRsDQV
         t6Bg8hSot1fL/nSurt+5M/32SRMGr9ZqSqbpJrZcrkuS1vF4zlgswMygh9N2uMIECxZ8
         P1ug==
X-Received: by 10.66.250.137 with SMTP id zc9mr5423886pac.55.1423385853030;
        Sun, 08 Feb 2015 00:57:33 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id bx10sm13038844pab.25.2015.02.08.00.57.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:57:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:57:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263480>

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
2.3.0.rc1.137.g477eb31
