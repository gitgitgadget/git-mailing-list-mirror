From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/5] fast-export: do not refer to non-existing marks
Date: Sun, 24 Jul 2011 16:21:19 +0200
Message-ID: <1311517282-24831-3-git-send-email-srabbelier@gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZn-0006Dd-ME
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab1GXOWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56531 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab1GXOWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so2291817wyg.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wMSwHSh3YvYR3gPQt+zcvl2e9akuGCFsg8ANRO9/wKw=;
        b=jveyy+JNhwPZ9GofGnwq8seIqQC1ew4e+nEL48nc9hTEsplDB8Mwa5/y7pK/YTU7V3
         M2JzwHZdLlHUXP4dXGVPf+cOHP2CCVdRUG1BnHquMcHTmgYHGXibaNOREx3Oan3sS+Bz
         jWPki3O8uG3qYGKNUGmIlROpXMF0X2qDcvUys=
Received: by 10.227.9.80 with SMTP id k16mr3065238wbk.20.1311517341153;
        Sun, 24 Jul 2011 07:22:21 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
In-Reply-To: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177754>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

When calling `git fast-export a..a b` when a and b refer to the same
commit, nothing would be exported, and an incorrect reset line would
be printed for b ('from :0').

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  We encountered this one while staring at the code and trying to
  figure out if our existing solution was sufficient.

 builtin/fast-export.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index becef85..92743c8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -512,9 +512,20 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	}
 }
 
+static void handle_reset(const char *name, struct object *object)
+{
+	int mark = get_object_mark(object);
+
+	if (mark)
+		printf("reset %s\nfrom :%d\n\n", name,
+		       get_object_mark(object));
+	else
+		printf("reset %s\nfrom %s\n\n", name,
+		       sha1_to_hex(object->sha1));
+}
+
 static void handle_tags_and_duplicates(struct string_list *extra_refs)
 {
-	struct commit *commit;
 	int i;
 
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
@@ -526,9 +537,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+			handle_reset(name, object);
 			show_progress();
 			break;
 		}
-- 
1.7.6.385.g91185.dirty
