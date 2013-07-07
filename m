From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] name-rev: allow converting the exact object name at the tip of a ref
Date: Sun,  7 Jul 2013 15:33:42 -0700
Message-ID: <1373236424-25617-3-git-send-email-gitster@pobox.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:34:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxWw-00050T-BW
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab3GGWdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:33:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab3GGWdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:33:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65F5E2EA7A
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+GPi
	zWqSRJYyG7QkcWDJj4W4S/k=; b=lpTUHH+eHSJTLmm0jE9z/zkDcMWGHZUGxGS5
	ThLu1VDa6ejr4unX6qF5/NG3XW6I2Gl3PpYzcQroqrLTdQXkaXmCTOZ33TH3E4bQ
	x9l2f/hm/lGPGYsKiJBypRL5JTPzWFiBMjhlODmiBQZBQF/TVXMZyEpVvinSZWWi
	HRwtYQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cWVVpH
	+8Y1ISVtXv6P6iym54Q3RjjdjILtsbxizNSP14waAKOdZtEmPl1ZdLtGpr1YQrqk
	cp7x7yDYho6B55GP1lLjGl5zYsWSM7uk5b5hmKpjjzWp2OAx5tVk8dhh0bCAxz0P
	L9xmN/nevII3Ao4rqXdHjHjWT92HZU+J02ud8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB272EA78
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8624F2EA71
	for <git@vger.kernel.org>; Sun,  7 Jul 2013 22:33:49 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-853-ga8cbcc9
In-Reply-To: <1373236424-25617-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4B44E6AE-E755-11E2-9CD7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229814>

"git name-rev" is supposed to convert 40-hex object names into
strings that name the same objects based on refs, that can be fed to
"git rev-parse" to get the same object names back, so

    $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
    8af06057d0c31a24e8737ae846ac2e116e8bafb9
    edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)

has to have "^0" at the end, as "edca41" is a commit, not the tag
that references it.

The command however did not bother to see if the object is at the
tip of some ref, and failed to convert a tag object.

Teach it to show this instead:

    $ git rev-parse v1.8.3 v1.8.3^0 | git name-rev --stdin
    8af06057d0c31a24e8737ae846ac2e116e8bafb9 (tags/v1.8.3)
    edca4152560522a431a51fc0a06147fc680b5b18 (tags/v1.8.3^0)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 1234ebb..29a6f56 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "sha1-lookup.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -113,6 +114,34 @@ struct name_ref_data {
 	const char *ref_filter;
 };
 
+static struct tip_table {
+	struct tip_table_entry {
+		unsigned char sha1[20];
+		const char *refname;
+	} *table;
+	int nr;
+	int alloc;
+	int sorted;
+} tip_table;
+
+static void add_to_tip_table(const unsigned char *sha1, const char *refname,
+			     int shorten_unambiguous)
+{
+	refname = name_ref_abbrev(refname, shorten_unambiguous);
+
+	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
+	hashcpy(tip_table.table[tip_table.nr].sha1, sha1);
+	tip_table.table[tip_table.nr].refname = xstrdup(refname);
+	tip_table.nr++;
+	tip_table.sorted = 0;
+}
+
+static int tipcmp(const void *a_, const void *b_)
+{
+	const struct tip_table_entry *a = a_, *b = b_;
+	return hashcmp(a->sha1, b->sha1);
+}
+
 static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *o = parse_object(sha1);
@@ -135,6 +164,8 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		}
 	}
 
+	add_to_tip_table(sha1, path, can_abbreviate_output);
+
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
 		if (!t->tagged)
@@ -151,6 +182,32 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	return 0;
 }
 
+static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
+{
+	struct tip_table_entry *table = table_;
+	return table[ix].sha1;
+}
+
+static const char *get_exact_ref_match(const struct object *o)
+{
+	int found;
+
+	if (!tip_table.table || !tip_table.nr)
+		return NULL;
+
+	if (!tip_table.sorted) {
+		qsort(tip_table.table, tip_table.nr, sizeof(*tip_table.table),
+		      tipcmp);
+		tip_table.sorted = 1;
+	}
+
+	found = sha1_pos(o->sha1, tip_table.table, tip_table.nr,
+			 nth_tip_table_ent);
+	if (0 <= found)
+		return tip_table.table[found].refname;
+	return NULL;
+}
+
 /* returns a static buffer */
 static const char *get_rev_name(const struct object *o)
 {
@@ -159,7 +216,7 @@ static const char *get_rev_name(const struct object *o)
 	struct commit *c;
 
 	if (o->type != OBJ_COMMIT)
-		return NULL;
+		return get_exact_ref_match(o);
 	c = (struct commit *) o;
 	n = c->util;
 	if (!n)
-- 
1.8.3.2-853-ga8cbcc9
