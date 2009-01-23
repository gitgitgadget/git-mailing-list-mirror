From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/7] sha1_file: add a "read_sha1_file_repl" function
Date: Fri, 23 Jan 2009 10:07:01 +0100
Message-ID: <20090123100701.caf62822.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:08:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI1O-0007kV-UH
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbZAWJGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753873AbZAWJGo
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:06:44 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:40061 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751405AbZAWJGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:06:43 -0500
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 9D82FE0813D;
	Fri, 23 Jan 2009 10:06:36 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with SMTP id 99532E080F3;
	Fri, 23 Jan 2009 10:06:33 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106862>

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
1.6.1.231.g9c286
