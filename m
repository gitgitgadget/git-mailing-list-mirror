From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leaks in read-tree.c
Date: Thu, 14 Apr 2005 13:54:22 +0200
Message-ID: <20050414115422.GA14065@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414113527.GA13790@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 13:52:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2sw-0003ua-2v
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDNLy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVDNLy7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:54:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31462 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261482AbVDNLy3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 07:54:29 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 1CBF8320112;
	Thu, 14 Apr 2005 13:53:50 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 146E21FC2; Thu, 14 Apr 2005 13:54:25 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414113527.GA13790@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch fixes one common, and 4 rare memory leaks in read-tree.c.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- read-tree.c.orig
+++ read-tree.c
@@ -23,23 +23,27 @@ static int read_one_entry(unsigned char 
 
 static int read_tree(unsigned char *sha1, const char *base, int baselen)
 {
-	void *buffer;
+	void *buffer0, *buffer;
 	unsigned long size;
 	char type[20];
 
-	buffer = read_sha1_file(sha1, type, &size);
+	buffer0 = buffer = read_sha1_file(sha1, type, &size);
 	if (!buffer)
 		return -1;
-	if (strcmp(type, "tree"))
+	if (strcmp(type, "tree")) {
+		free(buffer);
 		return -1;
+	}
 	while (size) {
 		int len = strlen(buffer)+1;
 		unsigned char *sha1 = buffer + len;
 		char *path = strchr(buffer, ' ')+1;
 		unsigned int mode;
 
-		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
+		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1) {
+			free(buffer0);
 			return -1;
+		}
 
 		buffer = sha1 + 20;
 		size -= len + 20;
@@ -53,13 +57,19 @@ static int read_tree(unsigned char *sha1
 			newbase[baselen + pathlen] = '/';
 			retval = read_tree(sha1, newbase, baselen + pathlen + 1);
 			free(newbase);
-			if (retval)
+			if (retval) {
+				free(buffer0);
 				return -1;
+			}
 			continue;
 		}
-		if (read_one_entry(sha1, base, baselen, path, mode) < 0)
+		if (read_one_entry(sha1, base, baselen, path, mode) < 0) {
+			free(buffer0);
 			return -1;
+		}
 	}
+	free(buffer0);
+
 	return 0;
 }
 
