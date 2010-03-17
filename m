From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 8/9] fetch: Don't fetch tags twice
Date: Thu, 18 Mar 2010 00:02:23 +0100
Message-ID: <3f1d446c333b7eaabce513e846efe5313d2084fb.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
	<672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
	<dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
	<d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
	<24bf0bf2a12b1eccf3aa8f6bd1753012dfdb9987.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEK9-0001wv-JW
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab0CRLzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:53039 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab0CRLz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:28 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 926AD90847
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:27 +0100 (CET)
In-Reply-To: <24bf0bf2a12b1eccf3aa8f6bd1753012dfdb9987.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142456>

When refspecs are fetched which match tags (e.g.,
+refs/tags/*:refs/tags/<remote>/* or +refs/*:refs/remotes/<remote>/*)
and without --no-tags, we end up fetching the same tags twice because of
the +refs/tags/*:refs/tags/* refspec built into fetch.  Instead, when
processing the built-in refspec, ignore tags which are already mapped.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8728153..8c01876 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -149,6 +149,7 @@ static void add_default_tags(const struct ref *remote_refs,
 			     struct ref *ref_map,
 			     struct ref ***tail)
 {
+	struct string_list mapped_refs = { NULL, 0, 0, 0 };
 	struct ref *tags = NULL, **tags_tail = &tags;
 	struct ref *ref, *peer_ref, **tag;
 
@@ -168,15 +169,19 @@ static void add_default_tags(const struct ref *remote_refs,
 	}
 	sort_string_list(peeled_map);
 
-	for (ref = ref_map; ref; ref = ref->next)
+	for (ref = ref_map; ref; ref = ref->next) {
+		string_list_append(ref->name, &mapped_refs);
 		if (ref->peer_ref)
 			string_list_insert(ref->peer_ref->name, existing_refs);
+	}
+	sort_string_list(&mapped_refs);
 
 	get_fetch_map(remote_refs, tag_refspec, &tags_tail, 0);
 	for (tag = &tags; *tag; ) {
 		ref = *tag;
 		peer_ref = ref->peer_ref;
-		if (!string_list_has_string(existing_refs, peer_ref->name)) {
+		if (!(string_list_has_string(existing_refs, peer_ref->name) ||
+		      string_list_has_string(&mapped_refs, ref->name))) {
 			struct string_list_item *item;
 
 			item = string_list_lookup(ref->name, peeled_map);
@@ -187,6 +192,7 @@ static void add_default_tags(const struct ref *remote_refs,
 		}
 		tag = &(*tag)->next;
 	}
+	string_list_clear(&mapped_refs, 0);
 
 	free_refs(tags);
 }
-- 
1.7.0.2.273.gc2413
