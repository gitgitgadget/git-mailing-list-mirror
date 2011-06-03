From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] index-pack: start learning to emulate "verify-pack -v"
Date: Fri,  3 Jun 2011 15:32:15 -0700
Message-ID: <1307140337-27676-3-git-send-email-gitster@pobox.com>
References: <1307140337-27676-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QScus-0005LU-OL
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab1FCWc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:32:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1FCWcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:32:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE54656EC
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6dZ0
	rz3GrCmhCJxaEJAoTblLTz8=; b=los67kG0paICclHHp5pcBjk4vbF4bTDqiWp5
	jUy/Kv0ZgGgi0pruLUiQ5bSghUhUzkYFyhG+uVwbnQK8pgHhJxgiTIb6Oglr8yrC
	e+PKmozhUpjGmJdt7DgvpFjyqdYj+Mka6DW4CvwnpF1bvAfEeVjyT0BhjsCo9get
	9renn9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Q9jqp1
	GXEbKLEGdUbPKTQWUQuzLE3AZJcbs/2EMlf8VvX5qSXgkP4lZWRw/AJLIhP0MXNn
	lbIDDhntWFj+5jz6pbsBIS8IOnI0akfAdj57aOoNOY/xwO+9mphvfoLjPMI3SP7j
	P6O8fSyZVwgHdn/JWEmqTnlSVSj5NFd1MNWck=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAFA556EA
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3583C56E9 for
 <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc0.106.g68174
In-Reply-To: <1307140337-27676-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A83C26BC-8E31-11E0-962D-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175033>

The "index-pack" machinery already has almost enough knowledge to produce
the same output as "verify-pack -v". Fill small gaps in its bookkeeping,
and teach it to show what it knows.

Add a few more command line options that do not have to be advertised to
the end users. They will be used internally when verify-pack calls this.
The eventual goal is to remove verify-pack implementation and redo it as a
thin wrapper around the index-pack, so that we can remove the rather
expensive packed_object_info_detail() API.

This still does not do the delta-chain-depth histogram yet but that part
is easy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0216af7..aa3c9c6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -20,6 +20,8 @@ struct object_entry
 	unsigned int hdr_size;
 	enum object_type type;
 	enum object_type real_type;
+	unsigned delta_depth;
+	int base_object_no;
 };
 
 union delta_base {
@@ -535,6 +537,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	void *base_data, *delta_data;
 
 	delta_obj->real_type = base->obj->real_type;
+	delta_obj->delta_depth = base->obj->delta_depth + 1;
+	delta_obj->base_object_no = base->obj - objects;
 	delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);
 	result->obj = delta_obj;
@@ -967,9 +971,32 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 	free(p);
 }
 
+static void show_pack_info(int stat_only)
+{
+	int i;
+	for (i = 0; i < nr_objects; i++) {
+		struct object_entry *obj = &objects[i];
+
+		/* NEEDSWORK: Compute data necessary for the "histogram" here */
+
+		if (stat_only)
+			continue;
+		printf("%s %-6s %lu %lu %"PRIuMAX,
+		       sha1_to_hex(obj->idx.sha1),
+		       typename(obj->real_type), obj->size,
+		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
+		       (uintmax_t)obj->idx.offset);
+		if (is_delta_type(obj->type)) {
+			struct object_entry *bobj = &objects[obj->base_object_no];
+			printf(" %u %s", obj->delta_depth, sha1_to_hex(bobj->idx.sha1));
+		}
+		putchar('\n');
+	}
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
-	int i, fix_thin_pack = 0, verify = 0;
+	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, stat = 0;
 	const char *curr_pack, *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
@@ -1000,6 +1027,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				strict = 1;
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
+			} else if (!strcmp(arg, "--verify-stat")) {
+				verify = 1;
+				stat = 1;
+			} else if (!strcmp(arg, "--verify-stat-only")) {
+				verify = 1;
+				stat = 1;
+				stat_only = 1;
 			} else if (!strcmp(arg, "--keep")) {
 				keep_msg = "";
 			} else if (!prefixcmp(arg, "--keep=")) {
@@ -1075,8 +1109,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
-	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
+	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
+	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(pack_sha1);
 	if (nr_deltas == nr_resolved_deltas) {
 		stop_progress(&progress);
@@ -1116,6 +1150,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (strict)
 		check_objects();
 
+	if (stat)
+		show_pack_info(stat_only);
+
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-- 
1.7.6.rc0.106.g68174
