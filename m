From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] resolve-undo: teach "update-index --unresolve" to use
 resolve-undo info
Date: Tue, 29 Dec 2009 13:42:35 -0800
Message-ID: <1262122958-9378-7-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqn-0003gs-3C
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbZL2VnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbZL2Vmz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZL2Vmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8EC8C7F0
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fv0o
	l7DcjHqtOCY6GqkvJRUg4aA=; b=SPFa4tnHS96PoHacPPX1tQJwOo1/vQZlAdqT
	+9NJqr3VYrtLbtTW8AIBCCWlMOhnu6fcIOIfkgBSnRGz2SuCytE94xZ4s49LsOD7
	ffWbKC6dDCYOx/3KynnuAMhjLegKk/fnVjM5DTtxmYRbgwsWB0QlAvdK9qKxq115
	4HEvqBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vE0SEl
	KlVvGHZiiwFPLbtDDe98KG1Z0LGwPXPfXhhh0HDpuFtr+mtp9L9RnfLBEphQKhJk
	jBeM+nj9eZdfeIcknlQB4N8mPvzloqsfitt4bJ5hQVafIpPh73Ha4o8p0imOHRbg
	C3HVi3vOz6pUdC5S7oOABFqoU77FoTSqUj9Yw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B97518C7EF
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3654A8C7EE for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:52 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E06C4B0-F4C3-11DE-B0A2-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135832>

The update-index plumbing command had a hacky --unresolve implementation
that was written back in the days when merge was the only way for users to
end up with higher stages in the index, and assumed that stage #2 must
have come from HEAD, stage #3 from MERGE_HEAD and didn't bother to compute
the stage #1 information.

There were several issues with this approach:

 - These days, merge is not the only command, and conflicts coming from
   commands like cherry-pick, "am -3", etc. cannot be recreated by looking
   at MERGE_HEAD;

 - For a conflict that came from a merge that had renames, picking up the
   same path from MERGE_HEAD and HEAD wouldn't help recreating it, either;

 - It may have been Ok not to recreate stage #1 back when it was written,
   because "diff --ours/--theirs" were the only availble ways to review
   conflicts and they don't need stage #1 information.  "diff --cc" that
   was invented much later is a lot more useful way but it needs stage #1.

We can use resolve-undo information recorded in the index extension to
solve all of these issues.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-update-index.c    |   13 ++++++++++++-
 cache.h                   |    1 +
 t/t2030-unresolve-info.sh |    7 +++++++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index a19e786..750db16 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -433,7 +433,18 @@ static int unresolve_one(const char *path)
 
 	/* See if there is such entry in the index. */
 	pos = cache_name_pos(path, namelen);
-	if (pos < 0) {
+	if (0 <= pos) {
+		/* already merged */
+		pos = unmerge_cache_entry_at(pos);
+		if (pos < active_nr) {
+			struct cache_entry *ce = active_cache[pos];
+			if (ce_stage(ce) &&
+			    ce_namelen(ce) == namelen &&
+			    !memcmp(ce->name, path, namelen))
+				return 0;
+		}
+		/* no resolve-undo information; fall back */
+	} else {
 		/* If there isn't, either it is unmerged, or
 		 * resolved as "removed" by mistake.  We do not
 		 * want to do anything in the former case.
diff --git a/cache.h b/cache.h
index f479f09..97b4a74 100644
--- a/cache.h
+++ b/cache.h
@@ -338,6 +338,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
+#define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #endif
 
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index ea65f39..28e2eb1 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -108,4 +108,11 @@ test_expect_success 'add records checkout -m undoes' '
 	grep "^++<<<<<<<" actual
 '
 
+test_expect_success 'unmerge with plumbing' '
+	prime_resolve_undo &&
+	git update-index --unresolve file &&
+	git ls-files -u >actual &&
+	test $(wc -l <actual) = 3
+'
+
 test_done
-- 
1.6.6
