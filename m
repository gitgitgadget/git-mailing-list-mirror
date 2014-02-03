From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 21/26] Support running file watcher with the test suite
Date: Mon,  3 Feb 2014 11:29:09 +0700
Message-ID: <1391401754-15347-22-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBt-0001WX-El
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbaBCEbV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:21 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48354 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbaBCEbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:20 -0500
Received: by mail-pd0-f179.google.com with SMTP id q10so6382643pdj.24
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bqyDEL59PnR8LTbgOVEgBjQdmu93pcP/QcyvXmk51DI=;
        b=gNbMssfqP1eEp1HLpLq0+UeAEIvtj3+GM/Aflw6j+4JBetKD0fxEkP5rInXYodXUJW
         lcfiWu8DnTTNwhtaE6is/4ct4/nnL7xHhQee+3FjptI5bJVfWrNVErEXJZViai7QyGkj
         bvOhJGm+ZjSYEaV2T8WGzUrkzY/C39yLQHtmTvAnwQYOrVwyvHE1NJYINvlDzeT7/PFc
         ZIv/I8I5UiT7Z8fkV2Wx+1hyLbAVr5SrYJ0O9bs5/MQ2yH78vdB12c+d638SzGbHPgrQ
         0pljxv+kUpGRgs8Ig0lTbY2gqrWkd/qTOafPqBYbRRFsJO7dqoHabjv/Iam7S4fUN5ig
         xobQ==
X-Received: by 10.66.136.71 with SMTP id py7mr35439041pab.2.1391401880314;
        Sun, 02 Feb 2014 20:31:20 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id yd4sm51412133pbc.13.2014.02.02.20.31.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:17 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241416>

This is to force running the test suite with file-watcher with

  $ mkdir /tmp/watcher
  $ chmod 700 /tmp/watcher
  $ git-file-watcher /tmp/watcher/

then open another terminal and run

  $ export GIT_TEST_WATCHED=3D2 GIT_TEST_WATCHER=3D2
  $ export GIT_TEST_WATCHER_PATH=3D/tmp/watcher
  $ make test

TIME_WAIT set set to unlimited by GIT_TEST_WATCHER=3D2 so the test suit=
e
could hang up indefinitely due to a file-watcher bug. Luckily
everything passes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 file-watcher-lib.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/file-watcher-lib.c b/file-watcher-lib.c
index b6b0848..93afb52 100644
--- a/file-watcher-lib.c
+++ b/file-watcher-lib.c
@@ -136,6 +136,7 @@ void open_watcher(struct index_state *istate)
 	}
=20
 	if (!read_config) {
+		const char *s;
 		int i;
 		/*
 		 * can't hook into git_default_config because
@@ -149,6 +150,18 @@ void open_watcher(struct index_state *istate)
 		if (i =3D=3D istate->cache_nr)
 			recent_limit =3D 0;
 		read_config =3D 1;
+
+		s =3D getenv("GIT_TEST_WATCHER");
+		if (s) {
+			watch_lowerlimit =3D 1;
+			recent_limit =3D 0;
+			WAIT_TIME =3D -1;
+			if (atoi(s) > 1)
+				istate->update_watches =3D 1;
+			s =3D getenv("GIT_TEST_WATCHER_PATH");
+			if (s)
+				watcher_path =3D xstrdup(s);
+		}
 	}
=20
 	istate->watcher =3D connect_watcher(watcher_path);
--=20
1.8.5.2.240.g8478abd
