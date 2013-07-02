From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH] remote.c: avoid O(n^2) behavior in match_push_refs by using string_list
Date: Tue, 2 Jul 2013 16:53:48 -0700
Message-ID: <1372809228-2963-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <peff@peff.net>, <mfick@codeaurora.org>, <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 03 01:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuAOf-0004ep-SF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 01:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab3GBXyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 19:54:05 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18766 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3GBXyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 19:54:04 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51d369cc0000>; Tue, 02 Jul 2013 17:01:16 -0700
Received: from hqemhub03.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Tue, 02 Jul 2013 16:54:59 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Tue, 02 Jul 2013 16:54:59 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.298.1; Tue, 2 Jul 2013
 16:53:50 -0700
X-Mailer: git-send-email 1.8.3.1.440.gc2bf105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229450>

From: Brandon Casey <drafnel@gmail.com>

When pushing, each ref in the local repository must be paired with a
ref advertised by the remote server.  Currently, this is performed by
first applying the refspec to the local ref to transform the local ref
into the name of the remote ref, and then performing a linear search
through the list of remote refs to see if the remote ref was advertised
by the remote system.

This has O(n) complexity and makes match_push_refs() be an O(n^2)
operation.  If there are many refs 100,000+, then this ref matching
can take a significant amount of time.  Let's populate a string_list
with the remote ref names to allow searching in O(log n) time and
reduce the complexity of match_push_refs() to O(n log n).

Dry-run push of a repository with 121913 refs:

        before     after
real    1m40.582s  0m0.804s
user    1m39.914s  0m0.515s
sys     0m0.125s   0m0.106s

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 remote.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 6f57830..b416b8e 100644
--- a/remote.c
+++ b/remote.c
@@ -1302,6 +1302,15 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	free(sent_tips.tip);
 }
 
+static void prepare_searchable_ref_list(struct ref *ref, struct string_list *ref_list)
+{
+	for ( ; ref; ref = ref->next)
+		string_list_append_nodup(ref_list, ref->name)->util = ref;
+
+	sort_string_list(ref_list);
+}
+
+
 /*
  * Given the set of refs the local repository has, the set of refs the
  * remote repository has, and the refspec used for push, determine
@@ -1320,6 +1329,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
 	struct ref *ref, **dst_tail = tail_ref(dst);
+	struct string_list ref_list = STRING_LIST_INIT_NODUP;
 
 	if (!nr_refspec) {
 		nr_refspec = 1;
@@ -1328,8 +1338,11 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
 	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
 
+	prepare_searchable_ref_list(*dst, &ref_list);
+
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
+		struct string_list_item *dst_item;
 		struct ref *dst_peer;
 		const struct refspec *pat = NULL;
 		char *dst_name;
@@ -1338,7 +1351,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		if (!dst_name)
 			continue;
 
-		dst_peer = find_ref_by_name(*dst, dst_name);
+		dst_item = string_list_lookup(&ref_list, dst_name);
+		dst_peer = dst_item ? dst_item->util : NULL;
 		if (dst_peer) {
 			if (dst_peer->peer_ref)
 				/* We're already sending something to this ref. */
@@ -1355,6 +1369,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 			/* Create a new one and link it */
 			dst_peer = make_linked_ref(dst_name, &dst_tail);
 			hashcpy(dst_peer->new_sha1, ref->new_sha1);
+			string_list_insert(&ref_list, dst_peer->name)->util =
+				dst_peer;
 		}
 		dst_peer->peer_ref = copy_ref(ref);
 		dst_peer->force = pat->force;
@@ -1362,6 +1378,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		free(dst_name);
 	}
 
+	string_list_clear(&ref_list, 0);
+
 	if (flags & MATCH_REFS_FOLLOW_TAGS)
 		add_missing_tags(src, dst, &dst_tail);
 
@@ -1376,11 +1394,15 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 			src_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
-				if (!find_ref_by_name(src, src_name))
+				if (!ref_list.nr)
+					prepare_searchable_ref_list(src,
+						&ref_list);
+				if (!string_list_has_string(&ref_list, src_name))
 					ref->peer_ref = alloc_delete_ref();
 				free(src_name);
 			}
 		}
+		string_list_clear(&ref_list, 0);
 	}
 	if (errs)
 		return -1;
-- 
1.8.3.1.440.gc2bf105
