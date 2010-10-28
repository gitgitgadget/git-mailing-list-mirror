From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] read_sha1_file(): report correct name of packfile with a
 corrupt object
Date: Thu, 28 Oct 2010 13:53:29 -0700
Message-ID: <1288299210-27092-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 22:53:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZTo-0007fH-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 22:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761060Ab0J1Uxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 16:53:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759653Ab0J1Uxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 16:53:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3081EF5
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=wR8xcCDtMCHt6pMHI2wvcExvPCQ
	=; b=XEwGfK9E7v6QwaAUbAQagc4YZSdYTk8SA+vTPbgruX7Tyl/fb9ar9JoTsG8
	e53ZE/Ghqh/CgoLdLd6MK0uKsJScLjh6hr0NBipvLICnG55PeRifjc1RoBesQ336
	OCPZMBxYVXF5JyBxoDQIUf2oxI5S8LdDAaN0m7NUcIjEA+y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=ZpD4a6fmU+M7jYyna8l2bROzcvEde
	MkY/Wuq7huYVlUqQ4lQqhI+NBiBsJ/j2zeADsjFoY8bj6ysAjXPiA5Hb3uCJt1lp
	btwttiPhQT+/946rxsQP3HrzhCBsUB7Jo/DJPgoM0wCldp3XcPrOx2Gml3mi6YVx
	ROjuZY5NFkgBlA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3B21EF4
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 121751EF3 for
 <git@vger.kernel.org>; Thu, 28 Oct 2010 16:53:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.191.g2d0e57
X-Pobox-Relay-ID: 6CDC4032-E2D5-11DF-84B1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160225>

Clarify the error reporting logic by moving the normal codepath (i.e. we
read the object we wanted to read correctly) up and return early.

The logic to report the name of the packfile with a corrupt object,
introduced by e8b15e6 (sha1_file: Show the the type and path to corrupt
objects, 2010-06-10), was totally bogus.  The function that knows which
bad object came from what packfile is has_packed_and_bad(); make it report
which packfile the problem was found.

"Corrupt" is already an adjective, e.g. an object is "corrupt"; we do not
have to say "corrupted".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0cd9435..5ed5497 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1003,7 +1003,7 @@ static void mark_bad_packed_object(struct packed_git *p,
 	p->num_bad_objects++;
 }
 
-static int has_packed_and_bad(const unsigned char *sha1)
+static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
 {
 	struct packed_git *p;
 	unsigned i;
@@ -1011,8 +1011,8 @@ static int has_packed_and_bad(const unsigned char *sha1)
 	for (p = packed_git; p; p = p->next)
 		for (i = 0; i < p->num_bad_objects; i++)
 			if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
-				return 1;
-	return 0;
+				return p;
+	return NULL;
 }
 
 int check_sha1_signature(const unsigned char *sha1, void *map, unsigned long size, const char *type)
@@ -2079,6 +2079,11 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 	return read_packed_sha1(sha1, type, size);
 }
 
+/*
+ * This function dies on corrupted objects; the callers who want to
+ * deal with them should arrange to call read_object() and give error
+ * messages themselves.
+ */
 void *read_sha1_file_repl(const unsigned char *sha1,
 			  enum object_type *type,
 			  unsigned long *size,
@@ -2087,28 +2092,30 @@ void *read_sha1_file_repl(const unsigned char *sha1,
 	const unsigned char *repl = lookup_replace_object(sha1);
 	void *data = read_object(repl, type, size);
 	char *path;
+	const struct packed_git *p;
+
+	if (data) {
+		if (replacement)
+			*replacement = repl;
+		return data;
+	}
 
 	/* die if we replaced an object with one that does not exist */
-	if (!data && repl != sha1)
+	if (repl != sha1)
 		die("replacement %s not found for %s",
 		    sha1_to_hex(repl), sha1_to_hex(sha1));
 
-	/* legacy behavior is to die on corrupted objects */
-	if (!data) {
-		if (has_loose_object(repl)) {
-			path = sha1_file_name(sha1);
-			die("loose object %s (stored in %s) is corrupted", sha1_to_hex(repl), path);
-		}
-		if (has_packed_and_bad(repl)) {
-			path = sha1_pack_name(sha1);
-			die("packed object %s (stored in %s) is corrupted", sha1_to_hex(repl), path);
-		}
+	if (has_loose_object(repl)) {
+		path = sha1_file_name(sha1);
+		die("loose object %s (stored in %s) is corrupt",
+		    sha1_to_hex(repl), path);
 	}
 
-	if (replacement)
-		*replacement = repl;
+	if ((p = has_packed_and_bad(repl)) != NULL)
+		die("packed object %s (stored in %s) is corrupt",
+		    sha1_to_hex(repl), p->pack_name);
 
-	return data;
+	return NULL;
 }
 
 void *read_object_with_reference(const unsigned char *sha1,
-- 
1.7.3.2.191.g2d0e57
