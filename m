From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] apply: refactor read_file_or_gitlink()
Date: Wed,  9 May 2012 23:02:22 -0700
Message-ID: <1336629745-22436-6-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSu-0002NM-25
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585Ab2EJGCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:02:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab2EJGCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1715FDA
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=G2N/
	Po0XmLEdlVBETdU7rRrzZzw=; b=nYLFuHz2MhbVCwH+wkmepaWH4JUYI5iLKZH/
	H/LVeV8zdAYR0pXFcuueUj/rY8P5F42km+TNoksN3WoekAJBy8cqe5C7w+YbzYUa
	Zcg9U60VOB9qxbIYdV9aSuYLjjtZT1lmAwRNfXxC5JEfSa0XEAMhMhxpzFryj9dk
	mYxbOHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PwswO6
	38ad19pSIS7nzFi13g7L847r6hZiJKlupLtttv9kqZl4uY/TyQN6aI80AYHG0vJl
	SptNxQnXyAMqY28HGtSpWynETEC1GlVyDRXf0e0TKgquSSmQJVecapbx7lIQRICZ
	VbverhTnN+K6OXlLUpBpyQvA2H7bDLWBN/JTQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E27645FD9
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 921255FD8 for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BF15E968-9A65-11E1-BFDA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197540>

Reading a blob out of the object store does not have to require that the
caller has a cache entry for it.

Create a read_blob_object() helper function that takes the object name and
mode, and use it to reimplement the original function as a thin wrapper to
it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 628a89e..b1dd23c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2931,20 +2931,17 @@ static int apply_fragments(struct image *img, struct patch *patch)
 	return 0;
 }
 
-static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
+static int read_blob_object(struct strbuf *buf, const unsigned char *sha1, unsigned mode)
 {
-	if (!ce)
-		return 0;
-
-	if (S_ISGITLINK(ce->ce_mode)) {
+	if (S_ISGITLINK(mode)) {
 		strbuf_grow(buf, 100);
-		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(ce->sha1));
+		strbuf_addf(buf, "Subproject commit %s\n", sha1_to_hex(sha1));
 	} else {
 		enum object_type type;
 		unsigned long sz;
 		char *result;
 
-		result = read_sha1_file(ce->sha1, &type, &sz);
+		result = read_sha1_file(sha1, &type, &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
@@ -2953,6 +2950,13 @@ static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
 	return 0;
 }
 
+static int read_file_or_gitlink(struct cache_entry *ce, struct strbuf *buf)
+{
+	if (!ce)
+		return 0;
+	return read_blob_object(buf, ce->sha1, ce->ce_mode);
+}
+
 static struct patch *in_fn_table(const char *name)
 {
 	struct string_list_item *item;
-- 
1.7.10.1.562.gfc79b1c
