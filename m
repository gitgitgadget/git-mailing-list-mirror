From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Refactor sha1_pack_index_name and sha1_pack_name to use a common backend
Date: Mon, 28 Aug 2006 02:16:10 +0200
Message-ID: <20060828001610.GC20904@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 28 02:16:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHUnb-0006pG-Ob
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 02:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWH1AQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 20:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWH1AQQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 20:16:16 -0400
Received: from [130.225.96.91] ([130.225.96.91]:55766 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751259AbWH1AQP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 20:16:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 6BB49770022
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:16:12 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32108-08 for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:16:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 34FD177000B
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:16:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 57C0D6DF88D
	for <git@vger.kernel.org>; Mon, 28 Aug 2006 02:14:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 1C0D962A02; Mon, 28 Aug 2006 02:16:11 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26130>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Tested with doing a local cg-clone, since there doesn't seem to be any
tests of users, such as git-local-fetch, under t/.

This adds another pair of static buffers, if that's a problem and the
cleanup is still wanted I can change it to use malloc.

 sha1_file.c |   64 +++++++++++++++++++++++------------------------------------
 1 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 01aa745..5a846f5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -147,65 +147,51 @@ char *sha1_file_name(const unsigned char
 	return base;
 }
 
-char *sha1_pack_name(const unsigned char *sha1)
+static int fill_sha1_pack_name(const unsigned char *sha1, char base[], size_t baselen,
+			       int dir_offset, const char *extension)
 {
 	static const char hex[] = "0123456789abcdef";
-	static char *name, *base, *buf;
-	static const char *last_objdir;
 	const char *sha1_file_directory = get_object_directory();
+	char *buf;
 	int i;
 
-	if (!last_objdir || strcmp(last_objdir, sha1_file_directory)) {
-		int len = strlen(sha1_file_directory);
-		if (base)
-			free(base);
-		base = xmalloc(len + 60);
-		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.pack", sha1_file_directory);
-		name = base + len + 11;
-		if (last_objdir)
-			free((char *) last_objdir);
-		last_objdir = strdup(sha1_file_directory);
+	base[dir_offset] = 0;
+	if (strcmp(base, sha1_file_directory)) {
+		dir_offset = strlen(sha1_file_directory);
+		if (snprintf(base, baselen,
+			     "%s/pack/pack-1234567890123456789012345678901234567890.%s",
+			     sha1_file_directory, extension) >= baselen)
+			die("pack name too long");
 	}
+	base[dir_offset] = '/';
 
-	buf = name;
+	buf = base + dir_offset + 11;
 
 	for (i = 0; i < 20; i++) {
 		unsigned int val = *sha1++;
+
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
 	}
-	
-	return base;
+
+	return dir_offset;
 }
 
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
-	static const char hex[] = "0123456789abcdef";
-	static char *name, *base, *buf;
-	static const char *last_objdir;
-	const char *sha1_file_directory = get_object_directory();
-	int i;
+	static char base[PATH_MAX + 1];
+	static int offset;
 
-	if (!last_objdir || strcmp(last_objdir, sha1_file_directory)) {
-		int len = strlen(sha1_file_directory);
-		if (base)
-			free(base);
-		base = xmalloc(len + 60);
-		sprintf(base, "%s/pack/pack-1234567890123456789012345678901234567890.idx", sha1_file_directory);
-		name = base + len + 11;
-		if (last_objdir)
-			free((char *) last_objdir);
-		last_objdir = strdup(sha1_file_directory);
-	}
+	offset = fill_sha1_pack_name(sha1, base, sizeof(base), offset, "idx");
+	return base;
+}
 
-	buf = name;
+char *sha1_pack_name(const unsigned char *sha1)
+{
+	static char base[PATH_MAX + 1];
+	static int offset;
 
-	for (i = 0; i < 20; i++) {
-		unsigned int val = *sha1++;
-		*buf++ = hex[val >> 4];
-		*buf++ = hex[val & 0xf];
-	}
-	
+	offset = fill_sha1_pack_name(sha1, base, sizeof(base), offset, "pack");
 	return base;
 }
 
-- 
1.4.2.g2f76-dirty

-- 
Jonas Fonseca
