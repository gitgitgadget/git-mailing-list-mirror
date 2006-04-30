From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-push: resurrect parsing of Push: lines
Date: Sun, 30 Apr 2006 14:05:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604301405150.2026@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 30 14:06:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaAh5-0000I7-Hk
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 14:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWD3MF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 08:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWD3MF5
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 08:05:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15003 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750795AbWD3MF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 08:05:57 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id BF041C74
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 14:05:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B33F0C6B
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 14:05:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id A007AB65
	for <git@vger.kernel.org>; Sun, 30 Apr 2006 14:05:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19334>


The C'ification of push left these behind.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-push.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index a0c1caa..4e659f0 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -68,6 +68,10 @@ static void set_refspecs(const char **re
 	expand_refspecs();
 }
 
+#define MAX_REFSPECS 10
+static int current_refspec = 0;
+static char *refspecs_[MAX_REFSPECS];
+
 static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 {
 	int n = 0;
@@ -76,11 +80,17 @@ static int get_remotes_uri(const char *r
 	if (!f)
 		return -1;
 	while (fgets(buffer, BUF_SIZE, f)) {
+		int is_refspec;
 		char *s, *p;
 
-		if (strncmp("URL: ", buffer, 5))
+		if (!strncmp("URL: ", buffer, 5)) {
+			is_refspec = 0;
+			s = buffer + 5;
+		} else if (!strncmp("Push: ", buffer, 6)) {
+			is_refspec = 1;
+			s = buffer + 6;
+		} else
 			continue;
-		s = buffer + 5;
 
 		/* Remove whitespace at the head.. */
 		while (isspace(*s))
@@ -93,9 +103,10 @@ static int get_remotes_uri(const char *r
 		while (isspace(p[-1]))
 			*--p = 0;
 
-		uri[n++] = strdup(s);
-		if (n == MAX_URI)
-			break;
+		if (!is_refspec && n < MAX_URI)
+			uri[n++] = strdup(s);
+		else if (is_refspec && current_refspec < MAX_REFSPECS)
+			refspecs_[current_refspec++] = strdup(s);
 	}
 	fclose(f);
 	if (!n)
@@ -140,6 +151,8 @@ static int get_uri(const char *repo, con
 	int n;
 
 	if (*repo != '/') {
+		current_refspec = 0;
+
 		n = get_remotes_uri(repo, uri);
 		if (n > 0)
 			return n;
@@ -165,6 +178,9 @@ static int do_push(const char *repo)
 	if (n <= 0)
 		die("bad repository '%s'", repo);
 
+	if (refspec_nr == 0)
+		set_refspecs((const char**)refspecs_, current_refspec);
+
 	argv = xmalloc((refspec_nr + 10) * sizeof(char *));
 	argv[0] = "dummy-send-pack";
 	argc = 1;
