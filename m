From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 6/8] read-cache.c: add INDEX_FILE_DIRECTORY support
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-733079@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:11:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNokR-00063c-9H
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVDSJN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJLY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:11:24 -0400
Received: from spoon.guft.org ([63.224.205.130]:51086 "EHLO mail.guft.org")
	by vger.kernel.org with ESMTP id S261403AbVDSJJx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 05:09:53 -0400
Received: (qmail 23339 invoked by uid 5006); 19 Apr 2005 02:09:51 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch give read-cache the ability for the index directory to be 
overridden by the INDEX_FILE_DIRECTORY environment variable.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
        [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
        [PATCH 5/8] init-db.c: refactor mkdir logic
 read-cache.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


read-cache.c: edaadf3e1c0714735ca8d80301dd644aa0f9cd2a
--- a/read-cache.c
+++ b/read-cache.c
@@ -174,22 +174,33 @@ static int verify_hdr(struct cache_heade
 
 int read_cache(void)
 {
-	int fd, i;
+	int fd, i, len;
 	struct stat st;
 	unsigned long size, offset;
 	void *map;
 	struct cache_header *hdr;
+	char *index_path, *index_file;
 
 	errno = EBUSY;
 	if (active_cache)
 		return error("more than one cachefile");
 	errno = ENOENT;
+
 	sha1_file_directory = getenv(DB_ENVIRONMENT);
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
 	if (access(sha1_file_directory, X_OK) < 0)
 		return error("no access to SHA1 file directory");
-	fd = open(".git/index", O_RDONLY);
+
+	index_path = getenv(INDEX_ENVIRONMENT);
+	if (!index_path)
+		index_path = DEFAULT_INDEX_ENVIRONMENT;
+	len = strlen(index_path);
+	index_file = malloc(len + 7);
+	if (!index_file) error("out of memory");
+	sprintf(index_file, "%s/index", index_path);
+
+	fd = open(index_file, O_RDONLY);
 	if (fd < 0)
 		return (errno == ENOENT) ? 0 : error("open failed");
 
