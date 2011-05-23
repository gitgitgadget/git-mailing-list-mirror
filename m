From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 09/10] pack-objects: Estimate pack size; abort early if pack
 size limit is exceeded
Date: Mon, 23 May 2011 02:52:02 +0200
Message-ID: <1306111923-16859-10-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:53:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJOM-0000eg-B1
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab1EWAwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:35 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578Ab1EWAwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:33 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001RTIFD4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:25 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 06C791EA6132_DD9AFC9B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E4CFF1EA3564_DD9AFC6F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:22 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:22 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1306111923-16859-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174212>

Currently, when pushing a pack to the server that has specified a pack size
limit, we don't detect that we exceed that limit until we have already
generated (and started transmitting) that much pack data.

Ideally, we should be able to predict the approximate pack size _before_ we
start generating and transmitting the pack data, and abort early if the
estimated pack size exceeds the pack size limit.

This patch tries to provide such an estimate: It looks at the objects that
are to be included in the pack, and for already-packed objects, it assumes
that their compressed in-pack size is a good estimate of how much they will
contribute to the pack currently being generated. This assumption should be
valid as long as the objects are reused as-is.

For loose objects that are to be included in the pack, we currently have no
good estimate as to how much they will contribute to the pack size. Since
it's better to underestimate (because an overestimation will prevent us
from sending a pack that might actually be within the pack size limit),
we don't include loose objects at all in the pack size estimate. This makes
the estimate somewhat useless in common workflows (where the push happens
before (most of) the pushed objects are packed).

The estimate is generated before the "Compressing" and "Writing" phases of
the push, so if the estimate exceeds the pack size limit, we abort before
sending any pack data to the server.

If the estimate turns out to be too low (e.g. because we're pushing many
loose objects), there is still code in place to abort the push when we
reach the pack size limit during transmission.

Signed-off-by: Johan Herland <johan@herland.net>
---

I'm not really happy with excluding loose objects in the pack size
estimate. However, the size contributed by loose objects varies wildly
depending on whether a (good) delta is found. Therefore, any estimate
done at an early stage is bound to be wildly inaccurate. We could maybe
use some sort of absolute minimum size per object instead, but I
thought I should publish this version before spending more time futzing
with it...

A drawback of not including loose objects in the pack size estimate,
is that pushing loose objects is a very common use case (most people
push more often than they 'git gc'). However, for the pack sizes that
servers are most likely to refuse (hundreds of megabytes), most of
those objects will probably already be packed anyway (e.g. by
'git gc --auto'), so I still hope the pack size estimate will be useful
when it really matters.


...Johan


 builtin/pack-objects.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e226053..c0c6a0a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1141,23 +1141,46 @@ static int pack_offset_sort(const void *_a, const void *_b)
 			(a->in_pack_offset > b->in_pack_offset);
 }
 
+static unsigned long estimate_packed_size(const struct object_entry *entry)
+{
+	unsigned long ret;
+	if (entry->in_pack) {
+		/* Assume that all packed objects are reused as-is */
+		struct revindex_entry *revidx = find_pack_revindex(
+			entry->in_pack,
+			entry->in_pack_offset);
+		return revidx[1].offset - entry->in_pack_offset;
+	}
+	return 0;
+}
+
 static void get_object_details(void)
 {
 	uint32_t i;
 	struct object_entry **sorted_by_offset;
+	unsigned long sum_size;
 
 	sorted_by_offset = xcalloc(nr_objects, sizeof(struct object_entry *));
 	for (i = 0; i < nr_objects; i++)
 		sorted_by_offset[i] = objects + i;
 	qsort(sorted_by_offset, nr_objects, sizeof(*sorted_by_offset), pack_offset_sort);
 
+	if (pack_to_stdout && pack_size_limit)
+		sum_size = sizeof(struct pack_header) + 20; /* pack overhead */
+
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry);
 		if (big_file_threshold <= entry->size)
 			entry->no_try_delta = 1;
+		if (pack_to_stdout && pack_size_limit && !entry->preferred_base)
+			sum_size += estimate_packed_size(entry);
 	}
 
+	if (pack_to_stdout && pack_size_limit && sum_size > pack_size_limit)
+		die("estimated pack size exceeds the pack size limit (%lu bytes)",
+		    pack_size_limit);
+
 	free(sorted_by_offset);
 }
 
-- 
1.7.5.rc1.3.g4d7b
