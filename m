From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix memory leaks in read_tree_recursive()
Date: Thu, 5 May 2005 01:19:59 +0200
Message-ID: <20050504231959.GA25475@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTTCT-0005dN-KM
	for gcvg-git@gmane.org; Thu, 05 May 2005 01:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVEDX3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 19:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEDX3E
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 19:29:04 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:62186 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261962AbVEDX2s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 19:28:48 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id ACB376E4280; Thu,  5 May 2005 01:18:54 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5791B6E3361; Thu,  5 May 2005 01:18:54 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5C7F161FDE; Thu,  5 May 2005 01:19:59 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
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

This patch fixes memory leaks in the error path of
read_tree_recursive().

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 571c0f4599fbeefd995bbc24480add1575c36c94/tree.c  (mode:100644 sha1:4a26603f6e32866c0db8a01ac1c228be801f76c6)
+++ uncommitted/tree.c  (mode:100644)
@@ -39,14 +39,18 @@
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
+				if (eltbuf) mem_free(eltbuf);
 				return -1;
+			}
+
+			newbase = xmalloc(baselen + 1 + pathlen);
 			memcpy(newbase, base, baselen);
 			memcpy(newbase + baselen, path, pathlen);
 			newbase[baselen + pathlen] = '/';

-- 
Jonas Fonseca
