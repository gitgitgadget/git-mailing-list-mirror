From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] read_sha1_file(): get rid of read_sha1_file_repl()
 madness
Date: Sun, 15 May 2011 12:54:52 -0700
Message-ID: <1305489294-14341-4-git-send-email-gitster@pobox.com>
References: <1305489294-14341-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 21:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhPH-0004le-Re
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1EOTzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 15:55:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab1EOTzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 15:55:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 939074D38
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WS77
	yuXpvbrzh08LBHfAp+cPLZI=; b=Nn+tzWS4uFhgeDLm0SGa6NCha3L9dJBvpG9R
	K0XDpzGm3mPg0biunYIfjZlsLrnab+fMPgDQ59FDabLAZF74SIzaEc66HhRpBYx5
	Q18SIfuv03nVcgeXWq4pDNbPxmpuMijq4DvVRQ1zNezYSyjIdPEbSCezLso7215L
	hKcPhvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=S6Oj2J
	Dxz/o16DC8uo45hpGhE8bmBjAw6ONCN/JLfiVhk305xVE1jTv7HQoLPSXWr7656I
	4dp3y33n3tqhYPi2Z5K+2mw/vNOWV4FGw8HWNv5tqFk0sTqNhtdHIzLTmMkXxszC
	MbPEGV4UU/CQGzXx/ZbErINE3ay4cty4z/7l4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FC534D37
	for <git@vger.kernel.org>; Sun, 15 May 2011 15:57:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0EC24D35 for
 <git@vger.kernel.org>; Sun, 15 May 2011 15:57:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.334.gdfd07
In-Reply-To: <1305489294-14341-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 848AD726-7F2D-11E0-B563-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173652>

Most callers want to silently get a replacement object, and they do not
care what the real name of the replacement object is.  Worse yet, no sane
interface to return the underlying object without replacement is provided.

Remove the function and make only the few callers that want the name of
the replacement object find it themselves.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mktag.c |    4 ++--
 cache.h         |    6 +-----
 object.c        |    4 ++--
 sha1_file.c     |   12 ++++--------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 324a267..640ab64 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -23,8 +23,8 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	const unsigned char *repl;
-	void *buffer = read_sha1_file_repl(sha1, &type, &size, &repl);
+	void *buffer = read_sha1_file(sha1, &type, &size);
+	const unsigned char *repl = lookup_replace_object(sha1);
 
 	if (buffer) {
 		if (type == type_from_string(expected_type))
diff --git a/cache.h b/cache.h
index e09cf75..a9ae100 100644
--- a/cache.h
+++ b/cache.h
@@ -758,11 +758,7 @@ int offset_1st_component(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
-extern void *read_sha1_file_repl(const unsigned char *sha1, enum object_type *type, unsigned long *size, const unsigned char **replacement);
-static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
-{
-	return read_sha1_file_repl(sha1, type, size, NULL);
-}
+extern void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size);
 extern const unsigned char *lookup_replace_object(const unsigned char *sha1);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
diff --git a/object.c b/object.c
index 7e1f2bb..31976b5 100644
--- a/object.c
+++ b/object.c
@@ -188,8 +188,8 @@ struct object *parse_object(const unsigned char *sha1)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl;
-	void *buffer = read_sha1_file_repl(sha1, &type, &size, &repl);
+	const unsigned char *repl = lookup_replace_object(sha1);
+	void *buffer = read_sha1_file(sha1, &type, &size);
 
 	if (buffer) {
 		struct object *obj;
diff --git a/sha1_file.c b/sha1_file.c
index 889fe71..5d80feb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2206,10 +2206,9 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_sha1_file_repl(const unsigned char *sha1,
-			  enum object_type *type,
-			  unsigned long *size,
-			  const unsigned char **replacement)
+void *read_sha1_file(const unsigned char *sha1,
+		     enum object_type *type,
+		     unsigned long *size)
 {
 	const unsigned char *repl = lookup_replace_object(sha1);
 	void *data;
@@ -2218,11 +2217,8 @@ void *read_sha1_file_repl(const unsigned char *sha1,
 
 	errno = 0;
 	data = read_object(repl, type, size);
-	if (data) {
-		if (replacement)
-			*replacement = repl;
+	if (data)
 		return data;
-	}
 
 	if (errno && errno != ENOENT)
 		die_errno("failed to read object %s", sha1_to_hex(sha1));
-- 
1.7.5.1.334.gdfd07
