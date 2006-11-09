X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Nicer error messages in case saving an object to db goes wrong
Date: Thu, 09 Nov 2006 13:52:05 +0100
Message-ID: <20061109125205.25131.50211.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 9 Nov 2006 12:52:19 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31197>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi9O7-0004BI-Fl for gcvg-git@gmane.org; Thu, 09 Nov
 2006 13:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965970AbWKIMwI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 07:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965969AbWKIMwH
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 07:52:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34714 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965970AbWKIMwG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 07:52:06 -0500
Received: (qmail 25141 invoked from network); 9 Nov 2006 13:52:05 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 9 Nov 2006 13:52:05 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Currently the error e.g. when pushing to a read-only repository is quite
confusing, this attempts to clean it up, unifies error reporting between
various object writers and uses error() on couple more places.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 sha1_file.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6ea59b5..09456d2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1455,8 +1455,7 @@ int move_temp_to_file(const char *tmpfil
 	unlink(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			fprintf(stderr, "unable to write sha1 filename %s: %s\n", filename, strerror(ret));
-			return -1;
+			return error("unable to write sha1 filename %s: %s\n", filename, strerror(ret));
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -1566,16 +1565,17 @@ int write_sha1_file(void *buf, unsigned
 	}
 
 	if (errno != ENOENT) {
-		fprintf(stderr, "sha1 file %s: %s\n", filename, strerror(errno));
-		return -1;
+		return error("sha1 file %s: %s\n", filename, strerror(errno));
 	}
 
 	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
 
 	fd = mkstemp(tmpfile);
 	if (fd < 0) {
-		fprintf(stderr, "unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
-		return -1;
+		if (errno == EPERM)
+			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
+		else
+			return error("unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
 	}
 
 	/* Set it up */
@@ -1690,9 +1690,12 @@ int write_sha1_from_fd(const unsigned ch
 	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
 
 	local = mkstemp(tmpfile);
-	if (local < 0)
-		return error("Couldn't open %s for %s",
-			     tmpfile, sha1_to_hex(sha1));
+	if (local < 0) {
+		if (errno == EPERM)
+			return error("insufficient permission for adding an object to repository database %s\n", get_object_directory());
+		else
+			return error("unable to create temporary sha1 filename %s: %s\n", tmpfile, strerror(errno));
+	}
 
 	memset(&stream, 0, sizeof(stream));
