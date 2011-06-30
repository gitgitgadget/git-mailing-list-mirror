From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC] status - don't show gitdir
Date: Thu, 30 Jun 2011 13:46:28 +0200
Message-ID: <1309434388-3536-1-git-send-email-iveqy@iveqy.com>
References: <4E0C3C1D.1050406@nextest.com>
Cc: iveqy@iveqy.com, jens.lehmann@web.de, hvoigt@hvoigt.net,
	git@vger.kernel.org, gitster@pobox.com
To: raible@nextest.com
X-From: git-owner@vger.kernel.org Thu Jun 30 13:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcFhS-0005Dr-P6
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 13:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab1F3LqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 07:46:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44897 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab1F3LqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 07:46:20 -0400
Received: by bwd5 with SMTP id 5so1747177bwd.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OitCJoPL3zu6OkM1b/nB2O0gRQMsYQprM7F/i7IWDx0=;
        b=UXPj8VCMYy19I6smQfJvycn68MMYMZ12Dq/gkeKgUhrs8BNIKAiKNl0DedmHynqBat
         fTf5YV1RpYL4E7WGh27eilGmmS3F8gmU+NxgFkSY2XdtigXHHouxoF3NtkaTxwWNJBs7
         togaB6EnAcEfUuT+fcI15hyChzAejgQ4rDLs4=
Received: by 10.204.84.24 with SMTP id h24mr1883479bkl.185.1309434379290;
        Thu, 30 Jun 2011 04:46:19 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id l24sm2018960bkw.15.2011.06.30.04.46.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 04:46:18 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1QcFhf-0000wg-DF; Thu, 30 Jun 2011 13:46:39 +0200
X-Mailer: git-send-email 1.7.6.rc3.dirty
In-Reply-To: <4E0C3C1D.1050406@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176485>

When gitdir is inside the working dir, don't show it as a untracked
directory.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
This patch works but have a few weaknesses. The string manipulations done
is cumbersome and can possible be done nicer (not what I could to with
support of strbuf).

Also, this patch doesn't know why .git isn't showed as untracked. Maybe
this code is at the wrong place.

 dir.c             |   28 ++++++++++++++++++++++++++++
 t/t7508-status.sh |   10 ++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 08281d2..9cabc29 100644
--- a/dir.c
+++ b/dir.c
@@ -1215,6 +1215,13 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
+	const char *work_tree;
+	const char *git_dir;
+	struct strbuf wt_full;
+	struct strbuf gd_base;
+	struct strbuf gd_relpath;
+	struct strbuf gd;
+	int i = 0;
 
 	dir->exclude_per_dir = ".gitignore";
 	path = git_path("info/exclude");
@@ -1222,6 +1229,27 @@ void setup_standard_excludes(struct dir_struct *dir)
 		add_excludes_from_file(dir, path);
 	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
+	work_tree = get_git_work_tree();
+	strbuf_init(&wt_full,0);
+	strbuf_addstr(&wt_full,work_tree);
+	strbuf_addstr(&wt_full,"/.git");
+	git_dir = read_gitfile_gently(wt_full.buf);
+	strbuf_remove(&wt_full,wt_full.len-5,5);
+	if(git_dir) {
+		strbuf_init(&gd,0);
+		strbuf_addstr(&gd,git_dir);
+		if(gd.len > wt_full.len) {
+			strbuf_init(&gd_base,0);
+			strbuf_add(&gd_base,wt_full.buf,wt_full.len);
+			if(!strbuf_cmp(&gd_base,&wt_full)) {
+				strbuf_init(&gd_relpath,0);
+				for(i = gd_base.len + 1; i < gd.len; i++) {
+					strbuf_addch(&gd_relpath,gd.buf[i]);
+				}
+				add_exclude(gd_relpath.buf,"",0,&dir->exclude_list[EXC_FILE]);
+			}
+		}
+	}
 }
 
 int remove_path(const char *name)
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 1fdfbd3..1fed0cf 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1139,4 +1139,14 @@ test_expect_failure '.git/config ignore=all suppresses submodule summary' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'Check if git-dir is ignored when gitfile is used' '
+	git init gitdir-test &&
+	cd gitdir-test &&
+	mv .git real-git-dir &&
+	echo "gitdir: real-git-dir" > .git &&
+	git status -s real-git-dir > actual &&
+	> expect &&
+	test_cmp actual expect
+'
+
 test_done
-- 
1.7.6.rc3.dirty
