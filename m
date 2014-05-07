From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/20] status: support untracked cache
Date: Wed,  7 May 2014 21:51:57 +0700
Message-ID: <1399474320-6840-18-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3EA-0006QZ-4e
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877AbaEGOxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:53:36 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49432 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932863AbaEGOxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:53:35 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so1311725pad.4
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0j9SzLRrvAfR62o8gvutcgRVNH5j8J8AE4QqVzaEYY=;
        b=Iw3+KfoQFxk5itmSrQmkiPwJTBU7f4ImCHEJZyHgCedw64x14j3pzivXESjiXRf2hn
         ioOWTUyTWYRQM38WeM7Bz+4ZpgvABlksjyvA1lNhmSdgVBCgOL9KHho+NrYVPb9cyou6
         P2Tz098lC46t8vUQP7lmptHFAdk5qyqjFpUBD9Ipxo2y+dmVmy98TdwmsYPxw/0hqyK7
         xs4OvV5ueD86QM0Vd0fxSeIxYOhrGnanFpmdcmc039bLwOS2yA3hg4bzZmvJtEAzrfM5
         vgezaD4sinx2KxkMeJvOGGfa3tpzzvn5GUME+R7dJR5xicBeCcllXUIrgIx2c6jqHuQV
         NO5w==
X-Received: by 10.66.140.104 with SMTP id rf8mr19890473pab.107.1399474414660;
        Wed, 07 May 2014 07:53:34 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id ff4sm114752628pad.24.2014.05.07.07.53.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:53:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:53:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248324>

---
 builtin/commit.c | 8 ++++++++
 wt-status.c      | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..1e45ff0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1327,6 +1327,14 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_status_print(&s);
 		break;
 	}
+
+	if (active_cache_changed) {
+		fd = hold_locked_index(&index_lock, 0);
+		if (0 <= fd &&
+		    (write_cache(fd, active_cache, active_nr) ||
+		     commit_locked_index(&index_lock)))
+			die("Unable to write new index file");
+	}
 	return 0;
 }
 
diff --git a/wt-status.c b/wt-status.c
index ec7344e..0355129 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -578,9 +578,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 	if (s->show_ignored_files)
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
+	dir.untracked = the_index.untracked;
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, &s->pathspec);
+	if (dir.untracked &&
+	    (dir.untracked->dir_opened ||
+	     dir.untracked->gitignore_invalidated ||
+	     dir.untracked->dir_invalidated))
+		active_cache_changed = 1;
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-- 
1.9.1.346.ga2b5940
