From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/23] status: enable untracked cache
Date: Mon,  8 Dec 2014 21:05:02 +0700
Message-ID: <1418047507-22892-20-git-send-email-pclouds@gmail.com>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 14:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxynX-00057X-P2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbaLHN4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2014 08:56:20 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:44354 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbaLHN4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:56:18 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so5280882pac.11
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4OeUfT+q0pMfVdaZx+z4MeRLEJ/SD0yZhgqD3FmkdpY=;
        b=Ch39nrT+HZQCIgpOsDfmMjryaF9qqMl5httrNkBa4379bhjZ1Ch7M729YIcinaPSgc
         pXtPsRBkv9f0N7sda3B2iZQIfec46CvcnyEtRXYOJKVz5MNNCTJvZrDXD/O9VeLk7SaR
         f+d8m8XmcFGT0/aKaPzjtM/bC2+9MakitsEPhAJJAfpofl4igj7hlvE+GuWfC8QclA6d
         coqimpCJRlC+AQLtUcjuRQMDXKR3IGwIGuzah7PT8L7rwe1LXKeVwGSaCnsmu3fxv8c0
         jlElxw9fJCxNuhyLZ1ya+umdtpI3CN0UdvNLqw3i/o++P/hqaMvAETKMh7S6RqYTgQJO
         Rl7g==
X-Received: by 10.66.236.36 with SMTP id ur4mr53053990pac.107.1418046977657;
        Mon, 08 Dec 2014 05:56:17 -0800 (PST)
Received: from lanh ([115.73.205.130])
        by mx.google.com with ESMTPSA id hc10sm36370214pbd.78.2014.12.08.05.56.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 05:56:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 08 Dec 2014 21:06:53 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1418047507-22892-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261036>

update_index_if_able() is moved down so that the updated untracked
cache could be written out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.2.0.60.gb7b3c64
