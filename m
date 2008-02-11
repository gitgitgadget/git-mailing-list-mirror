From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] pack-objects: only throw away data during memory pressure
Date: Mon, 11 Feb 2008 08:26:25 +0100
Message-ID: <120271478556-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOT4H-0004EI-Fa
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYBKH01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 02:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYBKH01
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:26:27 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35772 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYBKH00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 02:26:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 6DCDE680BF6C;
	Mon, 11 Feb 2008 08:26:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGrKb3JW+uwu; Mon, 11 Feb 2008 08:26:25 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5147568018CD; Mon, 11 Feb 2008 08:26:25 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73475>

If pack-objects hit the memory limit, it deletes objects from the delta
window.

This patch make it only delete the data, which is recomputed, if needed again.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
What about this not really tested patch for dealing with memory pressure in git-pack-objects?

It will slow down the repack in the case of memory pressure, but missing memory will not affect the results.

 builtin-pack-objects.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 6f8f388..231d65f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1464,7 +1464,7 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static unsigned long free_unpacked_data(struct unpacked *n)
 {
 	unsigned long freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
@@ -1474,6 +1474,12 @@ static unsigned long free_unpacked(struct unpacked *n)
 		free(n->data);
 		n->data = NULL;
 	}
+	return freed_mem;
+}
+
+static unsigned long free_unpacked(struct unpacked *n)
+{
+	unsigned long freed_mem = free_unpacked_data(n);
 	n->entry = NULL;
 	n->depth = 0;
 	return freed_mem;
@@ -1514,7 +1520,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 		       mem_usage > window_memory_limit &&
 		       count > 1) {
 			uint32_t tail = (idx + window - count) % window;
-			mem_usage -= free_unpacked(array + tail);
+			mem_usage -= free_unpacked_data(array + tail);
 			count--;
 		}
 
@@ -1547,6 +1553,9 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			if (!m->entry)
 				break;
 			ret = try_delta(n, m, max_depth, &mem_usage);
+			if (window_memory_limit &&
+			    mem_usage > window_memory_limit)
+				mem_usage -= free_unpacked_data(m);
 			if (ret < 0)
 				break;
 			else if (ret > 0)
-- 
1.5.4.g42f90
