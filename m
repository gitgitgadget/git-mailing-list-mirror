From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH] abspath: increase array size of cwd variable to PATH_MAX
Date: Mon, 19 Sep 2011 17:51:12 +0800
Message-ID: <1316425872-30457-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 11:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5aVX-0007AE-Oa
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 11:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1ISJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 05:51:19 -0400
Received: from mail.windriver.com ([147.11.1.11]:32852 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab1ISJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 05:51:18 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p8J9pDQT029874
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 19 Sep 2011 02:51:14 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Mon, 19 Sep 2011 02:51:13 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181674>

From: Hui Wang <Hui.Wang@windriver.com>

If the name length of working dir exceeds 1024 characters, neither git
clone nor git init can succeed under the working dir.
E.G. %>for ((i=1;i<300;i++));do mkdir 1234567890;cd 1234567890;done
     %>git clone ~/git
     fatal: Could not get current working directory: Numerical result
     out of range

This is because both git clone and git init will call
abspath.c:real_path(), in the real_path(), it will call getcwd()
to get and save current working dir, here we passed a 1024 char size
array to the parameter, if the name length of current working dir
exceeds 1024, this function will fail.

The purpose of calling getcwd() is to save current working dir, then
before the real_path() return, restore to the saved dir. We should use
PATH_MAX instead of 1024 for the array size.

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 abspath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/abspath.c b/abspath.c
index f04ac18..2ce1db9 100644
--- a/abspath.c
+++ b/abspath.c
@@ -24,7 +24,7 @@ int is_directory(const char *path)
 const char *real_path(const char *path)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
-	char cwd[1024] = "";
+	char cwd[PATH_MAX] = "";
 	int buf_index = 1;
 
 	int depth = MAXDEPTH;
-- 
1.6.3.1
