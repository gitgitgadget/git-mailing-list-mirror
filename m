From: "Julian Phillips" <jp3@quantumfyre.co.uk>
Subject: [PATCH] Allow fetch--tool to read from stdin
Date: Tue, 13 Feb 2007 01:21:39 +0000
Message-ID: <11713297013179-git-send-email-julian@quantumfyre.co.uk>
References: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 02:28:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmTB-0006ZR-QL
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965458AbXBMB2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965462AbXBMB2Z
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:28:25 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:37417 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965458AbXBMB2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:28:24 -0500
Received: (qmail 25772 invoked by uid 103); 13 Feb 2007 01:21:41 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <jp3@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.88.7/2553. spamassassin: 3.1.3. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024449 secs); 13 Feb 2007 01:21:41 -0000
Received: from unknown (HELO beast) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 13 Feb 2007 01:21:41 +0000
Received: by beast (sSMTP sendmail emulation); Tue, 13 Feb 2007 01:21:41 +0000
X-Mailer: git-send-email 1.4.4.4
In-Reply-To: <11713297014015-git-send-email-julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39477>

If the reflist is "-" then read the reflist data from stdin instead,
this will allow the passing of more than 128K of reflist data - which
won't fit in the environment passed by execve.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin-fetch--tool.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3090ffe..619ceb0 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -2,6 +2,20 @@
 #include "refs.h"
 #include "commit.h"
 
+static char *get_stdin(void)
+{
+#define CHUNK_SIZE (1048576)
+	char *data = xmalloc(CHUNK_SIZE);
+	int offset = 0, read = 0;
+	read = xread(0, data, CHUNK_SIZE);
+	while (read == CHUNK_SIZE) {
+		offset += CHUNK_SIZE;
+		data = xrealloc(data, offset + CHUNK_SIZE);
+		read = xread(0, data + offset, CHUNK_SIZE);
+	}
+	return data;
+}
+
 static void show_new(char *type, unsigned char *sha1_new)
 {
 	fprintf(stderr, "  %s: %s\n", type,
@@ -463,12 +477,18 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 	if (!strcmp("parse-reflist", argv[1])) {
 		if (argc != 3)
 			return error("parse-reflist takes 1 arg");
-		return parse_reflist(argv[2]);
+		const char *reflist = argv[2];
+		if (!strcmp(reflist, "-"))
+			reflist = get_stdin();
+		return parse_reflist(reflist);
 	}
 	if (!strcmp("expand-refs-wildcard", argv[1])) {
 		if (argc < 4)
 			return error("expand-refs-wildcard takes at least 2 args");
-		return expand_refs_wildcard(argv[2], argc - 3, argv + 3);
+		const char *reflist = argv[2];
+		if (!strcmp(reflist, "-"))
+			reflist = get_stdin();
+		return expand_refs_wildcard(reflist, argc - 3, argv + 3);
 	}
 
 	return error("Unknown subcommand: %s", argv[1]);
-- 
1.4.4.4
