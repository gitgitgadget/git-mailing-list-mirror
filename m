From: Jonas Fonseca <fonseca@diku.dk>
Subject: [REGRESSION] Interrupted clone/fetch leaves .lock files around
Date: Tue, 6 Jun 2006 20:51:48 +0200
Message-ID: <20060606185148.GA15521@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 06 20:52:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fngew-0000b1-Bt
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 20:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWFFSvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFFSvx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 14:51:53 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:34539 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750952AbWFFSvx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 14:51:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7D8C2770075
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 20:51:51 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27059-17 for <git@vger.kernel.org>; Tue,  6 Jun 2006 20:51:48 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id BCCC7770072
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 20:51:48 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 621096DF835
	for <git@vger.kernel.org>; Tue,  6 Jun 2006 20:48:29 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A4E6A62611; Tue,  6 Jun 2006 20:51:48 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21395>

Hi,

It used to be possible to continue an interrupted clone when using
cg-clone, by cding into the partial repo and run cg-fetch. However, it
seems that the recent changes in the ref locking code ends up leaving
.lock files around when interrupted.

$ cg clone http://elinks.cz/elinks.git
defaulting to local storage area
Fetching head...
Fetching objects...
...
Getting pack c0e265dab40fa34912c3ee6e02ba29686ab84a7b
 which contains 16f85ec5043966c69e2142198c52e12494dcfc76
progress: 22 objects, 939754 bytes, now fetching c0e265dab40f... (657678 bytes)
cg-clone: interrupted
$ cd elinks
$ cg fetch
Recovering from a previously interrupted initial clone...
Fetching head...
Fetching objects...
error: Couldn't open lock file .git/refs/heads/origin.lock: File exists
error: Can't lock ref heads/origin
progress: 0 objects, 0 bytes
cg-fetch: objects fetch failed

Below is my feeble attempt at a (tested) fix.

diff --git a/fetch.c b/fetch.c
index e040ef9..861dc60 100644
--- a/fetch.c
+++ b/fetch.c
@@ -1,3 +1,5 @@
+#include <signal.h>
+
 #include "fetch.h"
 
 #include "cache.h"
@@ -214,9 +216,19 @@ static int mark_complete(const char *pat
 	return 0;
 }
 
+static struct ref_lock *lock = NULL;
+
+static void remove_lockfile_on_signal(int signo)
+{
+	if (lock)
+		unlock_ref(lock);
+	lock = NULL;
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
+}
+
 int pull(char *target)
 {
-	struct ref_lock *lock = NULL;
 	unsigned char sha1[20];
 	char *msg;
 	int ret;
@@ -229,6 +241,7 @@ int pull(char *target)
 			error("Can't lock ref %s", write_ref);
 			return -1;
 		}
+		signal(SIGINT, remove_lockfile_on_signal);
 	}
 
 	if (!get_recover)
@@ -236,22 +249,11 @@ int pull(char *target)
 
 	if (interpret_target(target, sha1)) {
 		error("Could not interpret %s as something to pull", target);
-		if (lock)
-			unlock_ref(lock);
-		return -1;
-	}
-	if (process(lookup_unknown_object(sha1))) {
-		if (lock)
-			unlock_ref(lock);
-		return -1;
-	}
-	if (loop()) {
-		if (lock)
-			unlock_ref(lock);
-		return -1;
-	}
 
-	if (write_ref) {
+	} else if (process(lookup_unknown_object(sha1)) || loop()) {
+		; /* unlock */
+
+	} else if (write_ref) {
 		if (write_ref_log_details) {
 			msg = xmalloc(strlen(write_ref_log_details) + 12);
 			sprintf(msg, "fetch from %s", write_ref_log_details);
@@ -261,6 +263,10 @@ int pull(char *target)
 		if (msg)
 			free(msg);
 		return ret;
+	} else {
+		return 0;
 	}
-	return 0;
+
+	remove_lockfile_on_signal(0);
+	return -1;
 }

-- 
Jonas Fonseca
