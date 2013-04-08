From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit: rename parse_commit_date()
Date: Mon,  8 Apr 2013 16:01:53 -0700
Message-ID: <1365462114-8630-3-git-send-email-gitster@pobox.com>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 01:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPL4y-0001TW-BX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 01:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936478Ab3DHXCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 19:02:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935717Ab3DHXCB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 19:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ABDF14916;
	Mon,  8 Apr 2013 23:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=S32n
	Phd859g58+/HDBHrCR0X8S4=; b=xtSsmSSD/quyzFNajV4qtGUEN6tvbvsXxPQc
	ni+SoWXZ51UBJv0ArycXMVnonxVysM7jO80yHBeElTjihorEj0ghSGbRbWRFk6Bc
	iMMuJGzQaURuugLxDhknYUe6emFaQMOIxGYFsrnq79m/dptwNvu6xKWzFIFlBA9I
	Ms9z9uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	eXmE6Q0Z/qQAgodp9dbajk2kJFGfQ+UcFHKuIWgrhSZfaxAnvAQj1pbZha5ZejYE
	1/k4vG06m5SzY+Y7baJbFxN5Gz0XS8SX+/xqTTdFWzIGHZ0xjRUwGyG5rAQDY/H5
	BnQnb2VGe4T7hwxUrqXUUjY92NzRkK1cEqjgN2hxo2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114CF14915;
	Mon,  8 Apr 2013 23:02:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469A014912; Mon,  8 Apr
 2013 23:02:00 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-450-gd047976
In-Reply-To: <1365462114-8630-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 51D98C1E-A0A0-11E2-A90E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220541>

This function does a lot more than parsing the committer date out of
a commit object buffer.  After its sole caller parses one "tree",
and 0 or more "parent", it makes sure the next one is "author" (and
skips it), makes sure "committer" follows (and skips the committer
identity), and parses the date field.  Each of these fields must be
on its own line (no header folding is allowed).

Rename it to parse_commit_standard_header(), and change the function
signature to accept "struct commit *" to be updated as a parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/commit.c b/commit.c
index 9d7e81b..50a9827 100644
--- a/commit.c
+++ b/commit.c
@@ -78,31 +78,33 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	return commit;
 }
 
-static unsigned long parse_commit_date(const char *buf, const char *tail)
+static void parse_commit_standard_headers(const char *buf, const char *tail,
+					  struct commit *item)
 {
 	const char *dateptr;
 
+	item->date = 0;
 	if (buf + 6 >= tail)
-		return 0;
+		return;
 	if (memcmp(buf, "author", 6))
-		return 0;
+		return;
 	while (buf < tail && *buf++ != '\n')
-		/* nada */;
+		; /* skip to the end of the line */
 	if (buf + 9 >= tail)
-		return 0;
+		return;
 	if (memcmp(buf, "committer", 9))
-		return 0;
+		return;
 	while (buf < tail && *buf++ != '>')
-		/* nada */;
+		; /* skip to the end of the e-mail */
 	if (buf >= tail)
-		return 0;
+		return;
 	dateptr = buf;
 	while (buf < tail && *buf++ != '\n')
-		/* nada */;
+		; /* skip to the end of the line */
 	if (buf >= tail)
-		return 0;
+		return;
 	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	item->date = strtoul(dateptr, NULL, 10);
 }
 
 static struct commit_graft **commit_graft;
@@ -262,6 +264,11 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
+
+	/*
+	 * tree, 0-or-more parents, author and committer are required
+	 * and must appear in this order; no line folding is allowed.
+	 */
 	tail += size;
 	if (tail <= bufptr + 46 || memcmp(bufptr, "tree ", 5) || bufptr[45] != '\n')
 		return error("bogus commit object %s", sha1_to_hex(item->object.sha1));
@@ -301,8 +308,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 		}
 	}
-	item->date = parse_commit_date(bufptr, tail);
-
+	parse_commit_standard_headers(bufptr, tail, item);
 	return 0;
 }
 
-- 
1.8.2.1-450-gd047976
