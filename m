From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] read_tree_recursive(): Fix leaks
Date: Wed, 27 Apr 2005 01:00:01 +0200
Message-ID: <20050426230001.GB28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYxN-0006Yx-Rd
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDZXAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDZXAP
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:00:15 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:34532 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261834AbVDZXAC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:00:02 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id EF19C6E2B9D; Wed, 27 Apr 2005 00:59:06 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id B79FE6E2B9B; Wed, 27 Apr 2005 00:59:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3F88D61FDE; Wed, 27 Apr 2005 01:00:01 +0200 (CEST)
To: pasky@ucw.cz
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fix two potential leaks.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 74f5ad9d566408b4d352570ccde67ece0f2650a7
tree 7a6c485bceed70459c1855ab3c4d8ddfdeeb65d1
parent a738ed98e4557877f8bcd3b992aa55579b22b9d1
author Jonas Fonseca <fonseca@diku.dk> 1114555146 +0200
committer Jonas Fonseca <fonseca@diku.dk> 1114555146 +0200

 tree.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Index: tree.c
===================================================================
--- 2447d3a399200c8f736344822969f88f675612dd/tree.c  (mode:100644 sha1:15a16d560619aee80e41bf816dd8474a3253b1a5)
+++ 7a6c485bceed70459c1855ab3c4d8ddfdeeb65d1/tree.c  (mode:100644 sha1:7c55bb9bfa1565dc9df5cab31207a02004d7fe10)
@@ -39,14 +39,17 @@
 		if (S_ISDIR(mode)) {
 			int retval;
 			int pathlen = strlen(path);
-			char *newbase = xmalloc(baselen + 1 + pathlen);
+			char *newbase;
 			void *eltbuf;
 			char elttype[20];
 			unsigned long eltsize;
 
 			eltbuf = read_sha1_file(sha1, elttype, &eltsize);
-			if (!eltbuf || strcmp(elttype, "tree"))
+			if (!eltbuf || strcmp(elttype, "tree")) {
+				if (eltbuf) free(eltbuf);
 				return -1;
+			}
+			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, path, pathlen);
 			newbase[baselen + pathlen] = '/';


-- 
Jonas Fonseca
