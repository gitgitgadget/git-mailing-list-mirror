From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/5] Make 'ce_compare_link()' use the new
 'strbuf_readlink()'
Date: Wed, 17 Dec 2008 10:43:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain> <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 19:45:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD1OY-0004aX-3G
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 19:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYLQSn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbYLQSn7
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 13:43:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54557 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855AbYLQSn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 13:43:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIhDoa030531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 10:43:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHIhCsK009336;
	Wed, 17 Dec 2008 10:43:13 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103367>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Dec 2008 09:47:27 -0800

This simplifies the code, and also makes ce_compare_link now able to
handle filesystems with odd 'st_size' return values for symlinks.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 read-cache.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c14b562..b1475ff 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -99,27 +99,21 @@ static int ce_compare_data(struct cache_entry *ce, struct stat *st)
 static int ce_compare_link(struct cache_entry *ce, size_t expected_size)
 {
 	int match = -1;
-	char *target;
 	void *buffer;
 	unsigned long size;
 	enum object_type type;
-	int len;
+	struct strbuf sb = STRBUF_INIT;
 
-	target = xmalloc(expected_size);
-	len = readlink(ce->name, target, expected_size);
-	if (len != expected_size) {
-		free(target);
+	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
-	}
+
 	buffer = read_sha1_file(ce->sha1, &type, &size);
-	if (!buffer) {
-		free(target);
-		return -1;
+	if (buffer) {
+		if (size == sb.len)
+			match = memcmp(buffer, sb.buf, size);
+		free(buffer);
 	}
-	if (size == expected_size)
-		match = memcmp(buffer, target, size);
-	free(buffer);
-	free(target);
+	strbuf_release(&sb);
 	return match;
 }
 
-- 
1.6.1.rc3.3.gcc3e3
