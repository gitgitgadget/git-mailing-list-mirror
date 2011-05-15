From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] read_sha1_file(): allow selective bypassing of
 replacement mechanism
Date: Sun, 15 May 2011 12:54:54 -0700
Message-ID: <1305489294-14341-6-git-send-email-gitster@pobox.com>
References: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhPI-0004le-EZ
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab1EOTzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:55:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab1EOTzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:55:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F37754D46
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=z2XL
	jL1mfpzFlrEyqQ46cj5woQI=; b=HZUasVGYswesTRISqbz8l1ix9CEupI/BfdvU
	/KfIEf91ZSn7atTXj6RkvkmKV9/jxa4jiYFCdahfwRQuy290Rv9/kfsLUQ4T2YZ9
	ZOgenX2EwxIVOZEaotaGMSLrsbu+JLI8T5lDU2pyYIbvywr4wXmU3v+4oqMj6Hzw
	2rA3pEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eXA7Dm
	6ijJBjlXg2Tsuu3BNS7O1hdYx+s/b9I5tlIusgp2NJq6lXwKiqrVtlacXOK4nU0H
	hTG3qZhxQ13zI+noyCQMTB9OADNPtYpiBAMJAFwRumbHi5+sqYAqHQVwXQPOH733
	fEcCgKt+oIXNcC4EjFkpDh64SAiJ4h+I4lY+Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F07A14D45
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5D4544D43 for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
In-Reply-To: <1305489294-14341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 87293478-7F2D-11E0-B122-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173651>

The way "object replacement" mechanism was tucked to the read_sha1_file()
interface was suboptimal in a couple of ways:

 - Callers that want it to die with useful diagnosis upon seeing a corrupt
   object does not have a way to say that they do not want any object
   replacement.

 - Callers who do not want it to die but want to handle the errors
   themselves are told to arrange to call read_object(), but the function
   does not use the replacement mechanism, and also it is a file scope
   static function that not many callers can call to begin with.

This adds a read_sha1_file_extended() that takes a set of flags; the
callers of read_sha1_file() passes a flag READ_SHA1_FILE_REPLACE to ask
for object replacement mechanism to kick in.

Later, we could add another flag bit to tell the function to return an
error instead of dying and then remove the misguided "call read_object()
yourself".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h     |    7 ++++++-
 sha1_file.c |   10 ++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index c10a91d..5f1f5c3 100644
--- a/cache.h
+++ b/cache.h
@@ -757,7 +757,12 @@ int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
 
 /* object replacement */
-extern void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
+#define READ_SHA1_FILE_REPLACE 1
+extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
+static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+{
+	return read_sha1_file_extended(sha1, type, size, READ_SHA1_FILE_REPLACE);
+}
 extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 5d80feb..7e6e976 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2206,14 +2206,16 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_sha1_file(const unsigned char *sha1,
-		     enum object_type *type,
-		     unsigned long *size)
+void *read_sha1_file_extended(const unsigned char *sha1,
+			      enum object_type *type,
+			      unsigned long *size,
+			      unsigned flag)
 {
-	const unsigned char *repl = lookup_replace_object(sha1);
 	void *data;
 	char *path;
 	const struct packed_git *p;
+	const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
+		? lookup_replace_object(sha1) : sha1;
 
 	errno = 0;
 	data = read_object(repl, type, size);
-- 
1.7.5.1.334.gdfd07
