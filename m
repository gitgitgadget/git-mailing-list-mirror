From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/3] fast-import: fix corner case for checkpoint
Date: Mon, 19 Sep 2011 01:01:47 +0600
Message-ID: <1316372508-7173-3-git-send-email-divanorama@gmail.com>
References: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:55:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MX0-0006KC-Lg
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab1IRSzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 14:55:46 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:58336 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756528Ab1IRSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 14:55:39 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8212282wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=n0jsEufnKA8xLXtpkbK802ySmyNih15pVGXvkM9jw8g=;
        b=Zi/qleQzitt/4DnIW4/LidO0SG2kVzJgi4MqhvBToK/b+n/mEFH4uLlkF8bENTLSQi
         wEyG4LRTyJ/O9PcJXI31Nv2cB9blVCUV8NIZtZV918+UA1MbjgAgjgjOr9QofNupgKaj
         L31b18P8O0+gmneiNZ/6BR+3KYuSqDN4S7g84=
Received: by 10.227.2.81 with SMTP id 17mr2087389wbi.15.1316372138866;
        Sun, 18 Sep 2011 11:55:38 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id h20sm16877374wbo.22.2011.09.18.11.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:55:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316372508-7173-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181625>

checkpoint command makes fast-import finish current pack and write out
branches/tags and marks. In case no new objects are added in current
pack fast-import falls back to no-op. While it is possible that refs
or marks need to be updated (to point to old objects).

Make fast-import always dump them on checkpoint. But as before do not
cycle_packfile if there are no objects to write.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 907cb05..014a807 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3025,12 +3025,11 @@ static void parse_ls(struct branch *b)
 static void checkpoint(void)
 {
 	checkpoint_requested = 0;
-	if (object_count) {
+	if (object_count)
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
-	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
-- 
1.7.3.4
