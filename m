From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/8] fast-import: cache oe in file_change_m
Date: Mon, 19 Sep 2011 07:27:30 +0600
Message-ID: <1316395657-6991-2-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYD-0007cL-Gp
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1ISBVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34490 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1ISBVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:20 -0400
Received: by wwf22 with SMTP id 22so7286815wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JptPKUVSFnkpBdN+7BEKRTtDcrDQxovQJhhj8a0VcrA=;
        b=C3T82yHkSYuhr7EaYAyJgmd9LmNXGHvtQSP/IJIwWJ+kD6jVNObUdGdJKwGM6pwCoG
         Kc82WmwA+2BPjXzEmC5GQFixKj5Wthbi5LHY86Hu6+iPZI1NQihP8uyiORmMFKmbdsK4
         pt5gHnwuwczHLUPJYYPjwJYeTeUI8TcTLCuSQ=
Received: by 10.227.8.196 with SMTP id i4mr2117289wbi.41.1316395279312;
        Sun, 18 Sep 2011 18:21:19 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181658>

file_change_m checks object type for objects specified by sha1. It does
so via sha1_object_info but doesn't cache this information in struct
object_entry.

Make this call to sha1_object_info cached in struct object_entry.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 742e7da..42f9b17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2297,15 +2297,21 @@ static void file_change_m(struct branch *b)
 	} else {
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
-		enum object_type type = oe ? oe->type :
-					sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("%s not found: %s",
-					S_ISDIR(mode) ?  "Tree" : "Blob",
-					command_buf.buf);
-		if (type != expected)
+		if (!oe)
+			oe = insert_object(sha1);
+		if (!oe->idx.offset) {
+			enum object_type type = sha1_object_info(oe->idx.sha1, NULL);
+			if (type < 0)
+				die("%s not found: %s",
+						S_ISDIR(mode) ?  "Tree" : "Blob",
+						command_buf.buf);
+			oe->type = type;
+			oe->pack_id = MAX_PACK_ID;
+			oe->idx.offset = 1; /* nonzero */
+		}
+		if (oe->type != expected)
 			die("Not a %s (actually a %s): %s",
-				typename(expected), typename(type),
+				typename(expected), typename(oe->type),
 				command_buf.buf);
 	}
 
-- 
1.7.3.4
