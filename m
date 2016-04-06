From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/11] rerere: delay the recording of preimage
Date: Wed,  6 Apr 2016 16:05:28 -0700
Message-ID: <1459983935-25267-5-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWi-00007K-Af
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbcDFXFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbcDFXFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1159F53726;
	Wed,  6 Apr 2016 19:05:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kXbJ
	E7CQdG6oPurKWd74br0pekY=; b=LujYrKfNshssa7TQmN1YDguKV9Ptrs0IrJkJ
	GT3asAWfqiQH0a4nGN6FjUqqK0mzAZN7dFI4BR05rnRcSrpO/N79Z0BSggyI4v28
	AdfNmuszKigqtX6mTCgaDddMa1O0wtGQ3l4kDPgTkPpSJ5Y3v+jDsOKszUCXRcJC
	4S1TBN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q+H9AE
	3+arFd94sMVGrOH26nSgP1FpZdOgxc12exjjQDkTe/uYgQuoyS32WKqTwR7ULIYC
	J1HgmZmU+uZzYYLoFbX51WTonEiGQruMK7cvuc6m2YB/Oh0yq6N65QsC/Lbm4wN6
	3Pu7tJs+L7d8bhlI7wGeuz1YnHhI2G97iEdtk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0758753724;
	Wed,  6 Apr 2016 19:05:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DB4553722;
	Wed,  6 Apr 2016 19:05:43 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 16D2708A-FC4C-11E5-BEC6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290899>

We record the preimage only when there is no directory to record the
conflict we encountered, i.e. when $GIT_DIR/rr-cache/$ID does not
exist.  As the plan is to allow multiple <preimage,postimage> pairs
as variants for the same conflict ID eventually, this logic needs to
go.

As the first step in that direction, stop the "did we create the
directory?  Then we record the preimage" logic.  Instead, we record
if a preimage does not exist when we saw a conflict in a path.  Also
make sure that we remove a stale postimage, which most likely is
totally unrelated to the resolution of this new conflict, when we
create a new preimage under $ID when $GIT_DIR/rr-cache/$ID already
exists.

In later patches, we will further update this logic to be "do we
have <preimage,postimage> pair that cleanly resolve the current
conflicts?  If not, record a new preimage as a new variant", but
that does not happen at this stage yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 52 +++++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/rerere.c b/rerere.c
index a1e2963..33b1348 100644
--- a/rerere.c
+++ b/rerere.c
@@ -122,6 +122,11 @@ static int has_rerere_resolution(const struct rerere_id *id)
 	return ((id->collection->status & both) == both);
 }
 
+static int has_rerere_preimage(const struct rerere_id *id)
+{
+	return (id->collection->status & RR_HAS_PREIMAGE);
+}
+
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
@@ -749,8 +754,24 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	const char *path = rr_item->string;
 	const struct rerere_id *id = rr_item->util;
 
-	/* Is there a recorded resolution we could attempt to apply? */
-	if (has_rerere_resolution(id)) {
+	if (!has_rerere_preimage(id)) {
+		/*
+		 * We are the first to encounter this conflict.  Ask
+		 * handle_file() to write the normalized contents to
+		 * the "preimage" file.
+		 */
+		handle_file(path, NULL, rerere_path(id, "preimage"));
+		if (id->collection->status & RR_HAS_POSTIMAGE) {
+			const char *path = rerere_path(id, "postimage");
+			if (unlink(path))
+				die_errno("cannot unlink stray '%s'", path);
+			id->collection->status &= ~RR_HAS_POSTIMAGE;
+		}
+		id->collection->status |= RR_HAS_PREIMAGE;
+		fprintf(stderr, "Recorded preimage for '%s'\n", path);
+		return;
+	} else if (has_rerere_resolution(id)) {
+		/* Is there a recorded resolution we could attempt to apply? */
 		if (merge(id, path))
 			return; /* failed to replay */
 
@@ -807,31 +828,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		id = new_rerere_id(sha1);
 		string_list_insert(rr, path)->util = id;
 
-		/*
-		 * Ensure that the directory exists.
-		 * mkdir_in_gitdir() will fail with EEXIST if there
-		 * already is one.
-		 */
-		if (mkdir_in_gitdir(rerere_path(id, NULL)) &&
-		    errno != EEXIST)
-			continue; /* NEEDSWORK: perhaps we should die? */
-
-		if (id->collection->status & RR_HAS_PREIMAGE) {
-			;
-		} else {
-			/*
-			 * We are the first to encounter this
-			 * conflict.  Ask handle_file() to write the
-			 * normalized contents to the "preimage" file.
-			 *
-			 * NEEDSWORK: what should happen if we had a
-			 * leftover postimage that is totally
-			 * unrelated?  Perhaps we should unlink it?
-			 */
-			handle_file(path, NULL, rerere_path(id, "preimage"));
-			id->collection->status |= RR_HAS_PREIMAGE;
-			fprintf(stderr, "Recorded preimage for '%s'\n", path);
-		}
+		/* Ensure that the directory exists. */
+		mkdir_in_gitdir(rerere_path(id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
-- 
2.8.1-273-ga2cd0f9
