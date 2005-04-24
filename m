From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Cleanup sha1_file_directory initialization
Date: Sun, 24 Apr 2005 15:07:30 +0200
Message-ID: <20050424130730.GA10649@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:03:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPglL-00086A-2p
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 15:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVDXNHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 09:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVDXNHs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 09:07:48 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:11214 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262328AbVDXNHg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 09:07:36 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 665326E2862; Sun, 24 Apr 2005 15:06:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BD41E6E1879; Sun, 24 Apr 2005 15:06:39 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 129CB61FDD; Sun, 24 Apr 2005 15:07:31 +0200 (CEST)
To: torvalds@osdl.org
Mail-Followup-To: torvalds@osdl.org, git@vger.kernel.org
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

Use get_object_directory() when initializing sha1_file_directory
and make sha1_file_name() work on the global.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
Actually the initiailzation in ls-tree.c can be removed because call to
list() will end up in sha1_file_name() which will do it.

commit 6a06750a72231eaf285f9fbd2bcb88a39b699679
tree bec1c4178131a67de1fa639a274b13adec21c1e5
parent 32141512fff2d42c0233c07610db866926c89a75
author Jonas Fonseca <jonas@cvalda.(none)> 1114346881 +0200
committer Jonas Fonseca <jonas@cvalda.(none)> 1114346881 +0200

Index: ls-tree.c
===================================================================
--- 31e9af73983d640090508b06784ef7db4816c957/ls-tree.c  (mode:100644 sha1:bd99f9ac7b2d6dc23c1ec7d8f03877c20afec63f)
+++ bec1c4178131a67de1fa639a274b13adec21c1e5/ls-tree.c  (mode:100644 sha1:b630f69d8430f18f52799cf32787059b4427f3e8)
@@ -104,9 +104,8 @@ int main(int argc, char **argv)
 		usage(ls_tree_usage);
 	if (get_sha1_hex(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+
+	sha1_file_directory = get_object_directory();
 	if (list(sha1) < 0)
 		die("list failed");
 	return 0;
Index: read-cache.c
===================================================================
--- 31e9af73983d640090508b06784ef7db4816c957/read-cache.c  (mode:100644 sha1:f67aceb6b12f6d9cadf6a80bb1d33cf1bcd7f619)
+++ bec1c4178131a67de1fa639a274b13adec21c1e5/read-cache.c  (mode:100644 sha1:deb60df8cbb4f9ec8367f4ff96c62e383b5699e8)
@@ -183,9 +183,7 @@ int read_cache(void)
 	if (active_cache)
 		return error("more than one cachefile");
 	errno = ENOENT;
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
-	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+	sha1_file_directory = get_object_directory();
 	if (access(sha1_file_directory, X_OK) < 0)
 		return error("no access to SHA1 file directory");
 	fd = open(get_index_file(), O_RDONLY);
Index: sha1_file.c
===================================================================
--- 31e9af73983d640090508b06784ef7db4816c957/sha1_file.c  (mode:100644 sha1:97a515a073fec5870dfaaa279868ce9330853d3d)
+++ bec1c4178131a67de1fa639a274b13adec21c1e5/sha1_file.c  (mode:100644 sha1:94ab1119383a00a821254c3454fe349845027346)
@@ -71,8 +71,11 @@ char *sha1_file_name(const unsigned char
 	static char *name, *base;
 
 	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
-		int len = strlen(sha1_file_directory);
+		int len;
+
+		if (!sha1_file_directory)
+			sha1_file_directory = get_object_directory();
+		len = strlen(sha1_file_directory);
 		base = malloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);

-- 
Jonas Fonseca
