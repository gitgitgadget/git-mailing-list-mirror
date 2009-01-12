From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 4/7] sha1_file: add a "read_sha1_file_repl" function
Date: Mon, 12 Jan 2009 18:51:00 +0100
Message-ID: <20090112185100.67c4a40e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQx1-0002OG-Cx
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbZALRuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZALRuX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:50:23 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:49909 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbZALRuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:50:23 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 3A8D7D488D4;
	Mon, 12 Jan 2009 18:50:14 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with SMTP id 38939D48FDD;
	Mon, 12 Jan 2009 18:50:12 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105366>

This new function will replace "read_sha1_file". This latter function
becoming just a stub to call the former will a NULL "replacement"
argument.

This new function is needed because sometimes we need to use the
replacement sha1.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     |    6 +++++-
 sha1_file.c |    9 +++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 8e1af26..1b34381 100644
--- a/cache.h
+++ b/cache.h
@@ -625,7 +625,11 @@ int longest_ancestor_length(const char *path, const char *prefix_list);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern void * read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
+extern void *read_sha1_file_repl(const unsigned char *sha1, enum object_type *type, unsigned long *size, const unsigned char **replacement);
+static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+{
+	return read_sha1_file_repl(sha1, type, size, NULL);
+}
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
diff --git a/sha1_file.c b/sha1_file.c
index 4f2fd10..ea89ce5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2160,8 +2160,10 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	return read_packed_sha1(sha1, type, size);
 }
 
-void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
-		     unsigned long *size)
+void *read_sha1_file_repl(const unsigned char *sha1,
+			  enum object_type *type,
+			  unsigned long *size,
+			  const unsigned char **replacement)
 {
 	const unsigned char *repl = lookup_replace_object(sha1);
 	void *data = read_object(repl, type, size);
@@ -2175,6 +2177,9 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 	if (!data && (has_loose_object(repl) || has_packed_and_bad(repl)))
 		die("object %s is corrupted", sha1_to_hex(repl));
 
+	if (replacement)
+		*replacement = repl;
+
 	return data;
 }
 
-- 
1.6.1.83.g16e5
