From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 5/8] fast-import: tiny optimization in read_marks
Date: Mon, 19 Sep 2011 07:27:34 +0600
Message-ID: <1316395657-6991-6-git-send-email-divanorama@gmail.com>
References: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYX-0007it-0w
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722Ab1ISBVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:44 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:46718 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1ISBV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:28 -0400
Received: by mail-wy0-f170.google.com with SMTP id 8so8452393wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lIRLEPMGz21tXk1MRUb0GfODxT3Wieom6HPzoqNQ48U=;
        b=imEw+e00DyApV2bLv9DAi039rEW6ftEYz7FTCe/auG867KGDLH/2MvK2DSLsD7+vtN
         xs3sWAq4P8oSNdWgp5xoXXGfXiW/cmaofJQoFiNy6T1C4oWhC0XSVg4s20gT6HL7xXtO
         sBobkXJ/GdPG3NGS+E6pZvVbb4Rhz217kQ0+4=
Received: by 10.216.158.3 with SMTP id p3mr2031939wek.1.1316395288242;
        Sun, 18 Sep 2011 18:21:28 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181664>

read_marks calls find_object and then insert_object if nothing is found.

Reduce it to just insert_object and a check if it was found or inserted.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3c2a067..dd3dcd5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1852,11 +1852,9 @@ static void read_marks(void)
 		if (!mark || end == line + 1
 			|| *end != ' ' || get_sha1(end + 1, sha1))
 			die("corrupt mark line: %s", line);
-		e = find_object(sha1);
-		if (!e) {
-			e = insert_object(sha1);
+		e = insert_object(sha1);
+		if (!e->idx.offset)
 			resolve_sha1_object(e);
-		}
 		insert_mark(mark, e);
 	}
 	fclose(f);
-- 
1.7.3.4
