From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/22] resolve_ref(): emit warnings for improperly-formatted references
Date: Thu, 15 Sep 2011 23:10:40 +0200
Message-ID: <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JLD-0001GW-7c
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935034Ab1IOVTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:20 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40242 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934943Ab1IOVTT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:19:19 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J93-00019o-Cx; Thu, 15 Sep 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181517>

While resolving references, if a reference is found that is in an
unrecognized format, emit a warning (and then fail, as before).
Wouldn't *you* want to know?

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index ee3e0cc..2387f4e 100644
--- a/refs.c
+++ b/refs.c
@@ -500,6 +500,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	ssize_t len;
 	char buffer[256];
 	static char ref_buffer[256];
+	char path[PATH_MAX];
 
 	if (flag)
 		*flag = 0;
@@ -508,7 +509,6 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		return NULL;
 
 	for (;;) {
-		char path[PATH_MAX];
 		struct stat st;
 		char *buf;
 		int fd;
@@ -593,8 +593,10 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		if (flag)
 			*flag |= REF_ISSYMREF;
 	}
-	if (get_sha1_hex(buffer, sha1))
+	if (get_sha1_hex(buffer, sha1)) {
+		warning("reference in %s is formatted incorrectly", path);
 		return NULL;
+	}
 	return ref;
 }
 
-- 
1.7.6.8.gd2879
