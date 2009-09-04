From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] pack-objects: free preferred base memory after usage
Date: Thu, 03 Sep 2009 21:54:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909032139010.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 03:54:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjO0M-0005X1-D3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 03:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbZIDByL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 21:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755944AbZIDByK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 21:54:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbZIDByK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 21:54:10 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPF0028JBY4DJL0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Sep 2009 21:54:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127673>

When adding objects for preferred delta base, the content from tree 
objects leading to given paths is kept in a cache. This has the 
potential to grow significantly, especially with large directories as 
the whole tree object content is loaded in memory, even if in practice 
the number of those objects is limited to the 256 cache entries plus the 
$window root tree objects.  Still, that can't hurt freeing that up after 
object enumeration is done, and before more memory is needed for delta 
search.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 1ff2ce6..ae7ce0f 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1008,6 +1008,33 @@ static void add_preferred_base(unsigned char *sha1)
 	it->pcache.tree_size = size;
 }
 
+static void cleanup_preferred_base(void)
+{
+	struct pbase_tree *it;
+	unsigned i;
+	
+	it = pbase_tree;
+	pbase_tree = NULL;
+	while (it) {
+		struct pbase_tree *this = it;
+		it = this->next;
+		free(this->pcache.tree_data);
+		free(this);
+	}
+	
+	for (i = 0; i < ARRAY_SIZE(pbase_tree_cache); i++) {
+		if (!pbase_tree_cache[i])
+			continue;
+		free(pbase_tree_cache[i]->tree_data);
+		free(pbase_tree_cache[i]);
+		pbase_tree_cache[i] = NULL;
+	}
+
+	free(done_pbase_paths);
+	done_pbase_paths = NULL;
+	done_pbase_paths_num = done_pbase_paths_alloc = 0;
+}
+
 static void check_object(struct object_entry *entry)
 {
 	if (entry->in_pack) {
@@ -2312,6 +2339,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		rp_av[rp_ac] = NULL;
 		get_object_list(rp_ac, rp_av);
 	}
+	cleanup_preferred_base();
 	if (include_tag && nr_result)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
