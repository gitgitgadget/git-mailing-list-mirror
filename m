From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] index-pack: show histogram when emulating "verify-pack
 -v"
Date: Fri,  3 Jun 2011 15:32:16 -0700
Message-ID: <1307140337-27676-4-git-send-email-gitster@pobox.com>
References: <1307140337-27676-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:32:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QScvA-0005VB-OF
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 00:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab1FCWc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 18:32:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1FCWc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 18:32:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1462056EF
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jCPC
	5byJ+hp1Tkm5Hv57NHMnHvo=; b=a48UiLG7VxvonyfpHE+ZRacVz9wz4A+oaAa9
	S6c9ZBSzZgDFk1ZDislx15Qg1n5xBf5dE6oSDNnU5spU3U/Mz0+zmYNhLTYsO7Co
	XSDR6DO53gdCoScz+naBVXYzZjrqxo6fFfeveWMJfU8ozUf1OUBaLgyqo9uWtS8j
	P7EMu+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Iymp3n
	IR3QEJEepOQs0zGXok9ZUQwrlmyjdwsaqmR9o0L3n1d75Z9fsWofaXuHTbRjdOGi
	6ciDLqcdPiBPnalsTrFTVbtsD/HEX3OET87bPL9BG0ZyQHAs2Uss8cSC38/N3ueT
	61TVrwHdDMBjDkUCu7g7TvcWtIpWWCbDd8b7c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1287A56EE
	for <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7BBC456ED for
 <git@vger.kernel.org>; Fri,  3 Jun 2011 18:34:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc0.106.g68174
In-Reply-To: <1307140337-27676-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A98876C4-8E31-11E0-97F6-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175035>

The histogram produced by "verify-pack -v" always had an artificial
limit of 50, but index-pack knows what the maximum delta depth is, so
we do not have to limit it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * We could limit it, but I do not see a practical value of doing so.

 builtin/index-pack.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index aa3c9c6..ed4c3bb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -70,6 +70,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
@@ -538,6 +539,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 
 	delta_obj->real_type = base->obj->real_type;
 	delta_obj->delta_depth = base->obj->delta_depth + 1;
+	if (deepest_delta < delta_obj->delta_depth)
+		deepest_delta = delta_obj->delta_depth;
 	delta_obj->base_object_no = base->obj - objects;
 	delta_data = get_data_from_pack(delta_obj);
 	base_data = get_base_data(base);
@@ -973,12 +976,17 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 
 static void show_pack_info(int stat_only)
 {
-	int i;
+	int i, baseobjects = nr_objects - nr_deltas;
+	unsigned long *chain_histogram = NULL;
+
+	if (deepest_delta)
+		chain_histogram = xcalloc(deepest_delta, sizeof(unsigned long));
+
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 
-		/* NEEDSWORK: Compute data necessary for the "histogram" here */
-
+		if (is_delta_type(obj->type))
+			chain_histogram[obj->delta_depth - 1]++;
 		if (stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
@@ -992,6 +1000,18 @@ static void show_pack_info(int stat_only)
 		}
 		putchar('\n');
 	}
+
+	if (baseobjects)
+		printf("non delta: %d object%s\n",
+		       baseobjects, baseobjects > 1 ? "s" : "");
+	for (i = 0; i < deepest_delta; i++) {
+		if (!chain_histogram[i])
+			continue;
+		printf("chain length = %d: %lu object%s\n",
+		       i + 1,
+		       chain_histogram[i],
+		       chain_histogram[i] > 1 ? "s" : "");
+	}
 }
 
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
-- 
1.7.6.rc0.106.g68174
