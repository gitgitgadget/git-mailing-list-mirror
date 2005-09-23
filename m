From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 3/6] git-local-fetch: Fix error checking and leak in setup_indices()
Date: Fri, 23 Sep 2005 16:28:23 +0400 (MSD)
Message-ID: <20050923122823.3D01BE010FC@center4.mivlgu.local>
References: <20050923122754.GB2197@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 14:30:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EImfG-00078j-3b
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 14:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVIWM2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 08:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVIWM2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 08:28:25 -0400
Received: from mivlgu.ru ([81.18.140.87]:14800 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1750932AbVIWM2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 08:28:24 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 3D01BE010FC; Fri, 23 Sep 2005 16:28:23 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050923122754.GB2197@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9186>

setup_indices() did not check the return value of opendir(), and
did not have a corresponding closedir() call.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>


---

 local-fetch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

b2c9aab8c8186900cc4610e144513d45fc5b4865
diff --git a/local-fetch.c b/local-fetch.c
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -38,6 +38,8 @@ static int setup_indices(void)
 	unsigned char sha1[20];
 	sprintf(filename, "%s/objects/pack/", path);
 	dir = opendir(filename);
+	if (!dir)
+		return -1;
 	while ((de = readdir(dir)) != NULL) {
 		int namelen = strlen(de->d_name);
 		if (namelen != 50 || 
@@ -46,6 +48,7 @@ static int setup_indices(void)
 		get_sha1_hex(de->d_name + 5, sha1);
 		setup_index(sha1);
 	}
+	closedir(dir);
 	return 0;
 }
 
