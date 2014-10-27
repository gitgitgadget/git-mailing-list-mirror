From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/19] status: enable untracked cache
Date: Mon, 27 Oct 2014 19:10:43 +0700
Message-ID: <1414411846-4450-17-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:14:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XijBo-0004dP-8m
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbaJ0MOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:14:19 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46465 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbaJ0MMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:12:10 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so3581382pdb.35
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Lv/1Kj0zJj0/MNbVMP2sw1iPvjIM/b0NZ+VZ59iE8iU=;
        b=DMdZUDlDqAn4/TYBHfcoqxSHQ6bBWiu0mCEUh994eHf4Xf5qvFejnjw/dbAIay8gDC
         EHmm4gvcPcbofJ4lCAXdNqs/eR8mld5W6KqTpNko1YGMTDqB62npfyip3evNCdnhIF6U
         lxiBWJwJT/k1rIzlG174F7NBSgxAeJMztUAFJ0HZAZAW/0zJPHE1LaOM4wMG+AnxI6Bq
         /LKuhBX6AQS1jN+aWJXPi4x4xRuvRFoEnMm69KL1xMxIA+NxI2OXBhFs8Yko+UDWBmPP
         scKe5vhO2cpCZ2A73QMW2NsqXUHzTQ6fivNPNOWdkhZHZsnmYqgEx0cwmKTvB+EtJMcw
         GJLQ==
X-Received: by 10.68.233.166 with SMTP id tx6mr23902163pbc.89.1414411929530;
        Mon, 27 Oct 2014 05:12:09 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id l5sm7735645pdj.12.2014.10.27.05.12.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:12:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:12:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

update_index_if_able() is moved down so that the updated untracked
cache could be written out.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c | 5 +++--
 wt-status.c      | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 81dc622..08e2964 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1408,13 +1408,14 @@ int cmd_status(int argc, const char **argv, con=
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
index 1bf5d72..42aeebe 100644
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
2.1.0.rc0.78.gc0d8480
