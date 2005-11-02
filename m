From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix segfaults caused by invalid tags
Date: Wed, 02 Nov 2005 21:07:52 +0100
Message-ID: <20051102200751.26904.5780.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 02 21:09:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXOtq-0006XY-SS
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 21:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVKBUH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 15:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVKBUH4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 15:07:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64919 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965211AbVKBUHz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 15:07:55 -0500
Received: (qmail 26924 invoked from network); 2 Nov 2005 21:07:52 +0100
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 2 Nov 2005 21:07:52 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11034>

On many places, we didn't bother checking deref_tag() return value against
NULL, causing GIT segfaulting e.g. on some old Cogito checkouts containing
residual tags from GIT.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 fetch-pack.c  |    2 +-
 server-info.c |    5 +++--
 upload-pack.c |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3df9911..1fae211 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -40,7 +40,7 @@ static int rev_list_insert_ref(const cha
 {
 	struct object *o = deref_tag(parse_object(sha1));
 
-	if (o->type == commit_type)
+	if (o && o->type == commit_type)
 		rev_list_push((struct commit *)o, SEEN);
 
 	return 0;
diff --git a/server-info.c b/server-info.c
index ba53591..8e13c94 100644
--- a/server-info.c
+++ b/server-info.c
@@ -14,8 +14,9 @@ static int add_info_ref(const char *path
 	fprintf(info_ref_fp, "%s	%s\n", sha1_to_hex(sha1), path);
 	if (o->type == tag_type) {
 		o = deref_tag(o);
-		fprintf(info_ref_fp, "%s	%s^{}\n",
-			sha1_to_hex(o->sha1), path);
+		if (o)
+			fprintf(info_ref_fp, "%s	%s^{}\n",
+				sha1_to_hex(o->sha1), path);
 	}
 	return 0;
 }
diff --git a/upload-pack.c b/upload-pack.c
index c5eff21..f0b8e63 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -227,7 +227,8 @@ static int send_ref(const char *refname,
 	}
 	if (o->type == tag_type) {
 		o = deref_tag(o);
-		packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
+		if (o)
+			packet_write(1, "%s %s^{}\n", sha1_to_hex(o->sha1), refname);
 	}
 	return 0;
 }
