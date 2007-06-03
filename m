From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] pack-check: Sort entries by pack offset before unpacking them.
Date: Sun, 03 Jun 2007 20:21:41 +0200
Message-ID: <87ps4csxu2.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 03 20:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuuiP-0001Mp-G6
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXFCSVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXFCSVq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:21:46 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57235 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbXFCSVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:21:45 -0400
Received: from adsl-89-217-82-99.adslplus.ch ([89.217.82.99] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Huui0-0008IJ-F9
	for git@vger.kernel.org; Sun, 03 Jun 2007 13:21:45 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7EE474F68B; Sun,  3 Jun 2007 20:21:41 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49018>

Because of the way objects are sorted in a pack, unpacking them in
disk order is much more efficient than random access. Tests on the
Wine repository show a gain in pack validation time of about 35%.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 pack-check.c |   47 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 3623c71..d7dd62b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,6 +1,23 @@
 #include "cache.h"
 #include "pack.h"
 
+struct idx_entry
+{
+	const unsigned char *sha1;
+	off_t                offset;
+};
+
+static int compare_entries(const void *e1, const void *e2)
+{
+	const struct idx_entry *entry1 = e1;
+	const struct idx_entry *entry2 = e2;
+	if (entry1->offset < entry2->offset)
+		return -1;
+	if (entry1->offset > entry2->offset)
+		return 1;
+	return 0;
+}
+
 static int verify_packfile(struct packed_git *p,
 		struct pack_window **w_curs)
 {
@@ -11,6 +28,7 @@ static int verify_packfile(struct packed_git *p,
 	off_t offset = 0, pack_sig = p->pack_size - 20;
 	uint32_t nr_objects, i;
 	int err;
+	struct idx_entry *entries;
 
 	/* Note that the pack header checks are actually performed by
 	 * use_pack when it first opens the pack file.  If anything
@@ -41,33 +59,38 @@ static int verify_packfile(struct packed_git *p,
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	nr_objects = p->num_objects;
+	entries = xmalloc(nr_objects * sizeof(*entries));
+	/* first sort entries by pack offset, since unpacking them is more efficient that way */
+	for (i = 0; i < nr_objects; i++) {
+		entries[i].sha1 = nth_packed_object_sha1(p, i);
+		if (!entries[i].sha1)
+			die("internal error pack-check nth-packed-object");
+		entries[i].offset = find_pack_entry_one(entries[i].sha1, p);
+		if (!entries[i].offset)
+			die("internal error pack-check find-pack-entry-one");
+	}
+	qsort(entries, nr_objects, sizeof(*entries), compare_entries);
+
 	for (i = 0, err = 0; i < nr_objects; i++) {
-		const unsigned char *sha1;
 		void *data;
 		enum object_type type;
 		unsigned long size;
-		off_t offset;
 
-		sha1 = nth_packed_object_sha1(p, i);
-		if (!sha1)
-			die("internal error pack-check nth-packed-object");
-		offset = find_pack_entry_one(sha1, p);
-		if (!offset)
-			die("internal error pack-check find-pack-entry-one");
-		data = unpack_entry(p, offset, &type, &size);
+		data = unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data) {
 			err = error("cannot unpack %s from %s",
-				    sha1_to_hex(sha1), p->pack_name);
+				    sha1_to_hex(entries[i].sha1), p->pack_name);
 			continue;
 		}
-		if (check_sha1_signature(sha1, data, size, typename(type))) {
+		if (check_sha1_signature(entries[i].sha1, data, size, typename(type))) {
 			err = error("packed %s from %s is corrupt",
-				    sha1_to_hex(sha1), p->pack_name);
+				    sha1_to_hex(entries[i].sha1), p->pack_name);
 			free(data);
 			continue;
 		}
 		free(data);
 	}
+	free(entries);
 
 	return err;
 }
-- 
1.5.2.156.gb09c8

-- 
Alexandre Julliard
julliard@winehq.org
