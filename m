From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/8] fast-import: cache oe in parse_new_tag
Date: Mon, 19 Sep 2011 07:27:31 +0600
Message-ID: <1316395657-6991-3-git-send-email-divanorama@gmail.com>
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
	id 1R5SYE-0007cL-2G
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab1ISBV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34490 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1ISBVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 22so7286815wwf.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XUSRhcMEhEk4WNZe2ip235hMH1H7ukql3tEZbXPkOTc=;
        b=KT0DPpIIayg1x3dGqhhei+XCcUw84aUQcsGhBsHZfeP1fqXnSPosYBBF4b/tn7e13l
         Llcj/+5MtErN0Kuk+UW/I7V9itKmdLU21GJ8sC+dOLhFnbNdW4TGsGPdA6LY2KECBlJJ
         EJQnrAww/zRfbLpDkBZhKn8xKcoPINpTOID5M=
Received: by 10.216.12.83 with SMTP id 61mr2054478wey.1.1316395281487;
        Sun, 18 Sep 2011 18:21:21 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181657>

parse_new_tag uses sha1_object_info to find out the type of an object
given by a sha1 expression. But doesn't cache it in struct object_entry.

Make this call to sha1_object_info cached in struct object_entry.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 42f9b17..2b049f7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2732,11 +2732,14 @@ static void parse_new_tag(void)
 		type = oe->type;
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!get_sha1(from, sha1)) {
-		struct object_entry *oe = find_object(sha1);
-		if (!oe) {
+		struct object_entry *oe = insert_object(sha1);
+		if (!oe->idx.offset) {
 			type = sha1_object_info(sha1, NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
+			oe->type = type;
+			oe->pack_id = MAX_PACK_ID;
+			oe->idx.offset = 1; /* nonzero */
 		} else
 			type = oe->type;
 	} else
-- 
1.7.3.4
