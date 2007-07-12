From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 4/6] Add pack-objects window memory usage limit
Date: Thu, 12 Jul 2007 07:55:50 -0500
Message-ID: <11842449521798-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yD6-0005M9-D4
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbXGLMzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763602AbXGLMzv
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:55:51 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:64177 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758456AbXGLMzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:50 -0400
Received: by silvara (Postfix, from userid 1000)
	id 9DBA952138; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52275>

This adds an option (--window-memory=N) and configuration variable
(pack.windowMemory = N) to limit the memory size of the pack-objects
delta search window.  This works by removing the oldest unpacked objects
whenever the total size goes above the limit.  It will always leave
at least one object, though, so as not to completely eliminate the
possibility of computing deltas.

This is an extra limit on top of the normal window size (--window=N);
the window will not dynamically grow above the fixed number of entries
specified to fill the memory limit.

With this, repacking a repository with a mix of large and small objects
is possible even with a very large window.

Cleaner and correct circular buffer handling courtesy of Nicolas Pitre.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-pack-objects.c |   50 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 132ce96..dc6a5f4 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -16,8 +16,9 @@
 #include "progress.h"
 
 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
-	[--local] [--incremental] [--window=N] [--depth=N] \n\
+git-pack-objects [{ -q | --progress | --all-progress }] \n\
+	[--max-pack-size=N] [--local] [--incremental] \n\
+	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
 	[--stdout | base-name] [<ref-list | <object-list]";
@@ -79,6 +80,9 @@ static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
 static unsigned long cache_max_small_delta_size = 1000;
 
+static unsigned long window_memory_usage = 0;
+static unsigned long window_memory_limit = 0;
+
 /*
  * The object names in objects array are hashed with this hashtable,
  * to help looking up the entry by object name.
@@ -1351,12 +1355,14 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
+		window_memory_usage += sz;
 	}
 	if (!src->data) {
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
+		window_memory_usage += sz;
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
@@ -1366,6 +1372,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 				warning("suboptimal pack - out of memory");
 			return 0;
 		}
+		window_memory_usage += sizeof_delta_index(src->index);
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
@@ -1408,9 +1415,22 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
+static void free_unpacked(struct unpacked *n)
+{
+	window_memory_usage -= sizeof_delta_index(n->index);
+	free_delta_index(n->index);
+	n->index = NULL;
+	if (n->data) {
+		free(n->data);
+		n->data = NULL;
+		window_memory_usage -= n->entry->size;
+	}
+	n->entry = NULL;
+}
+
 static void find_deltas(struct object_entry **list, int window, int depth)
 {
-	uint32_t i = nr_objects, idx = 0, processed = 0;
+	uint32_t i = nr_objects, idx = 0, count = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
 	int max_depth;
@@ -1445,12 +1465,17 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (entry->no_try_delta)
 			continue;
 
-		free_delta_index(n->index);
-		n->index = NULL;
-		free(n->data);
-		n->data = NULL;
+		free_unpacked(n);
 		n->entry = entry;
 
+		while (window_memory_limit &&
+		       window_memory_usage > window_memory_limit &&
+		       count > 1) {
+			uint32_t tail = (idx + window - count) % window;
+			free_unpacked(array + tail);
+			count--;
+		}
+
 		/*
 		 * If the current object is at pack edge, take the depth the
 		 * objects that depend on the current object into account
@@ -1485,6 +1510,8 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 
 		next:
 		idx++;
+		if (count + 1 < window)
+			count++;
 		if (idx >= window)
 			idx = 0;
 	} while (i > 0);
@@ -1523,6 +1550,10 @@ static int git_pack_config(const char *k, const char *v)
 		window = git_config_int(k, v);
 		return 0;
 	}
+	if(!strcmp(k, "pack.windowmemory")) {
+		window_memory_limit = git_config_ulong(k, v);
+		return 0;
+	}
 	if(!strcmp(k, "pack.depth")) {
 		depth = git_config_int(k, v);
 		return 0;
@@ -1699,6 +1730,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				usage(pack_usage);
 			continue;
 		}
+		if (!prefixcmp(arg, "--window-memory=")) {
+			if (!git_parse_ulong(arg+15, &window_memory_limit))
+				usage(pack_usage);
+			continue;
+		}
 		if (!prefixcmp(arg, "--depth=")) {
 			char *end;
 			depth = strtoul(arg+8, &end, 0);
-- 
1.5.2.GIT
