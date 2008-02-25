From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 10/10] receive-pack: use strict mode for unpacking objects
Date: Mon, 25 Feb 2008 22:55:00 +0100
Message-ID: <12039765002986-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12039765002329-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765004039-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003484-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002219-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002397-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765001192-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765002534-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765003644-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12039765001906-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTlKn-0007Dt-91
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 22:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757880AbYBYVzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 16:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758821AbYBYVzh
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 16:55:37 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55615 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621AbYBYVzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 16:55:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 76BED680B59A;
	Mon, 25 Feb 2008 22:55:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fu7RfzZnmyy8; Mon, 25 Feb 2008 22:55:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 927436CF0063; Mon, 25 Feb 2008 22:55:00 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12039765001906-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75079>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Documentation/config.txt |    6 ++++++
 receive-pack.c           |   36 +++++++++++++++++++++++-------------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb6dae0..f319e27 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -922,6 +922,12 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+receive.fsckObjects::
+	If it is set to true, git-receive-pack will check all received 
+	objects. It will abort in the case of a malformed object or a 
+	broken link. The result of an abort are only dangling objects.
+	The default value is true.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
diff --git a/receive-pack.c b/receive-pack.c
index 3267495..f5440ff 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -10,6 +10,7 @@
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
 static int deny_non_fast_forwards = 0;
+static int receive_fsck_objects = 1;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
@@ -35,6 +36,11 @@ static int receive_pack_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.fsckobjects") == 0) {
+		receive_fsck_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value);
 }
 
@@ -367,11 +373,13 @@ static const char *unpack(void)
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
 
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code;
-		const char *unpacker[3];
-		unpacker[0] = "unpack-objects";
-		unpacker[1] = hdr_arg;
-		unpacker[2] = NULL;
+		int code, i = 0;
+		const char *unpacker[4];
+		unpacker[i++] = "unpack-objects";
+		if (receive_fsck_objects)
+			unpacker[i++] = "--strict";
+		unpacker[i++] = hdr_arg;
+		unpacker[i++] = NULL;
 		code = run_command_v_opt(unpacker, RUN_GIT_CMD);
 		switch (code) {
 		case 0:
@@ -392,8 +400,8 @@ static const char *unpack(void)
 			return "unpacker exited with error code";
 		}
 	} else {
-		const char *keeper[6];
-		int s, status;
+		const char *keeper[7];
+		int s, status, i = 0;
 		char keep_arg[256];
 		struct child_process ip;
 
@@ -401,12 +409,14 @@ static const char *unpack(void)
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
 
-		keeper[0] = "index-pack";
-		keeper[1] = "--stdin";
-		keeper[2] = "--fix-thin";
-		keeper[3] = hdr_arg;
-		keeper[4] = keep_arg;
-		keeper[5] = NULL;
+		keeper[i++] = "index-pack";
+		keeper[i++] = "--stdin";
+		if (receive_fsck_objects)
+			keeper[i++] = "--strict";
+		keeper[i++] = "--fix-thin";
+		keeper[i++] = hdr_arg;
+		keeper[i++] = keep_arg;
+		keeper[i++] = NULL;
 		memset(&ip, 0, sizeof(ip));
 		ip.argv = keeper;
 		ip.out = -1;
-- 
1.5.4.3.g3c5f
