From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH 1/3] diff-no-index.c read_directory() use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 17:16:20 +0200
Message-ID: <1395242180-4559-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 16:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQIEH-0006MD-HD
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965375AbaCSPQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:16:26 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60999 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965061AbaCSPQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:16:24 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so6720998eek.36
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Jy5nBNyfN03YH+OVasMkS3fJmxglmA9i4i8MaM0DpzM=;
        b=zlMU5j5bBT7MX8s8uY9RPYk+0hymHi5amxoi70gCCX0qLxanFhV4hF8AG50M55V7W4
         LVtqoh+kpqHV5mg2etcVPk8ViW2eApVoxiHo01Z9tgJ6TWZn+tPBH9RdV7s30lZbGr1o
         Ob07/z3yotg/tUxKycEID8sLc8XpYOsoGGi66bIJquJG/vDfPzKSqq7okuEgITBVXMGm
         Jcws+ke2MQOpk4LQwyeCyAkAE9L3/XDBIBb7wrT83Oaag5M2jPTC11GSOO4ofPs2D+Ie
         znj2TJ1gj1XD0eSmbsJRLFKqidFOfpBGEL0b4H2A+8Ws4wIystw59hs07e70d3QQGTtY
         nO7w==
X-Received: by 10.15.32.206 with SMTP id a54mr36007240eev.51.1395242183784;
        Wed, 19 Mar 2014 08:16:23 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPSA id x45sm42976809eeu.23.2014.03.19.08.16.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 08:16:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244451>

Implement read_directory() to use is_dot_or_dotdot() function from dir.h
instead of strcmp().

Rename read_directory() in read_directory_path() to avoid conflicting with
read_directory() from dir.h.

Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>


---
 I plan on applying to GSoc 2014.

 diff-no-index.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..2d1165f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,8 +15,9 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "dir.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_path(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -25,7 +26,7 @@ static int read_directory(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (!is_dot_or_dotdot(e->d_name))
 			string_list_insert(list, e->d_name);
 
 	closedir(dir);
@@ -107,9 +108,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_path(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_path(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.7.9.5
