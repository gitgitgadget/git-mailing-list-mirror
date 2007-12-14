From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] Fix random sha1 in error message in http-fetch and http-push
Date: Fri, 14 Dec 2007 22:18:01 +0100
Message-ID: <1197667081-9909-2-git-send-email-mh@glandium.org>
References: <1197667081-9909-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 22:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HvT-00026z-BE
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbXLNVSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756837AbXLNVSI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:18:08 -0500
Received: from smtp19.orange.fr ([80.12.242.18]:36469 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549AbXLNVSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:18:05 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1923.orange.fr (SMTP Server) with ESMTP id 4D2801C00099
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 22:18:02 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-17-136.w82-124.abo.wanadoo.fr [82.124.59.136])
	by mwinf1923.orange.fr (SMTP Server) with ESMTP id 2DA681C00094;
	Fri, 14 Dec 2007 22:18:02 +0100 (CET)
X-ME-UUID: 20071214211802187.2DA681C00094@mwinf1923.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J3Huz-0002aA-IL; Fri, 14 Dec 2007 22:18:01 +0100
X-Mailer: git-send-email 1.5.4.rc0.8.gbf4af-dirty
In-Reply-To: <1197667081-9909-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68348>

When a downloaded ref doesn't contain a sha1, the error message displays
a random sha1 because of uninitialized memory. This happens when cloning
a repository that is already a clone of another one, in which case
refs/remotes/origin/HEAD is a symref.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

Please note that this is already fixed in my strbuf patch for these files,
which had been applied in pu, but it seems to have disappeared from pu's
history. This also means the strbuf patch conflicts with this one. Please
tell me if you want a new strbuf patch made after this one.

 http-push.c   |    5 +++--
 http-walker.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index fc60bfd..7f1d043 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1149,9 +1149,10 @@ int fetch_ref(char *ref, unsigned char *sha1)
 		return error("Unable to start request");
 	}
 
+	if (buffer.posn != 41)
+		return 1;
         hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
-        return 0;
+        return get_sha1_hex(hex, sha1);
 }
 
 static void one_remote_object(const char *hex)
diff --git a/http-walker.c b/http-walker.c
index a3fb596..68b5108 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -986,9 +986,10 @@ static int fetch_ref(struct walker *walker, char *ref, unsigned char *sha1)
 		return error("Unable to start request");
 	}
 
+	if (buffer.posn != 41)
+		return 1;
         hex[40] = '\0';
-        get_sha1_hex(hex, sha1);
-        return 0;
+        return get_sha1_hex(hex, sha1);
 }
 
 static void cleanup(struct walker *walker)
-- 
1.5.4.rc0.8.gbf4af-dirty
