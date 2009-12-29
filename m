From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] resolve-undo: "checkout -m path" uses resolve-undo
 information
Date: Tue, 29 Dec 2009 13:42:34 -0800
Message-ID: <1262122958-9378-6-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqV-0003SS-1X
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZL2Vm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZL2Vm4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbZL2Vmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EDBD5ABFBA
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+ReM
	x/XETPnYpL1BIvHvhu9JrTU=; b=Uq2YA4FUkyO0kX3YcbeUuivAwQOdP0qMg4/0
	QlW2nNSaykN2W3i8QQMA1x06MNJtTW4MHmEIv+jBOZAQcPZDJyXFCyAf5KFH3u67
	cOMqdT5/P+/tyaf16sVEMxORru0gHiIneHyLij0rLHlfPgmTTR5k3rhAerBdfYp7
	jyZ8Wng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wtzc7a
	04ANzywse//BV8D3fedT9Eo34WoAKfuf3GOx1JtxsKe0snBa3ko6+Lioc4KZbsxv
	PKePUMr4GejIMTEo62Ekd6on23OLX7k7Ol6Eu3zhMbxRt2NHsfz86bKL9eVt+Z7a
	JKjuNytazQhFXxuOr4D5DEIXvCb63x52moZm0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB483ABFB9
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 38502ABFB8 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:49 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1CF4009C-F4C3-11DE-B5CB-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135834>

Once you resolved conflicts by "git add path", you cannot recreate the
conflicted state with "git checkout -m path", because you lost information
from higher stages in the index when you resolved them.

Since we record the necessary information in the resolve-undo index
extension these days, we can reproduce the unmerged state in the index and
check it out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c        |    4 +++
 cache.h                   |    1 +
 resolve-undo.c            |   59 +++++++++++++++++++++++++++++++++++++++++++++
 resolve-undo.h            |    2 +
 t/t2030-unresolve-info.sh |   11 ++++++++
 5 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index a0fe7a4..bdef1aa 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -235,6 +235,10 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	if (report_path_error(ps_matched, pathspec, 0))
 		return 1;
 
+	/* "checkout -m path" to recreate conflicted state */
+	if (opts->merge)
+		unmerge_cache(pathspec);
+
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
diff --git a/cache.h b/cache.h
index 310d9e6..f479f09 100644
--- a/cache.h
+++ b/cache.h
@@ -338,6 +338,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
 #define resolve_undo_clear() resolve_undo_clear_index(&the_index)
+#define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #endif
 
 enum object_type {
diff --git a/resolve-undo.c b/resolve-undo.c
index 86e8547..37d73cd 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "resolve-undo.h"
 #include "string-list.h"
 
@@ -115,3 +116,61 @@ void resolve_undo_clear_index(struct index_state *istate)
 	istate->resolve_undo = NULL;
 	istate->cache_changed = 1;
 }
+
+int unmerge_index_entry_at(struct index_state *istate, int pos)
+{
+	struct cache_entry *ce;
+	struct string_list_item *item;
+	struct resolve_undo_info *ru;
+	int i, err = 0;
+
+	if (!istate->resolve_undo)
+		return pos;
+
+	ce = istate->cache[pos];
+	if (ce_stage(ce)) {
+		/* already unmerged */
+		while ((pos < istate->cache_nr) &&
+		       ! strcmp(istate->cache[pos]->name, ce->name))
+			pos++;
+		return pos - 1; /* return the last entry processed */
+	}
+	item = string_list_lookup(ce->name, istate->resolve_undo);
+	if (!item)
+		return pos;
+	ru = item->util;
+	if (!ru)
+		return pos;
+	remove_index_entry_at(istate, pos);
+	for (i = 0; i < 3; i++) {
+		struct cache_entry *nce;
+		if (!ru->mode[i])
+			continue;
+		nce = make_cache_entry(ru->mode[i], ru->sha1[i],
+				       ce->name, i + 1, 0);
+		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
+			err = 1;
+			error("cannot unmerge '%s'", ce->name);
+		}
+	}
+	if (err)
+		return pos;
+	free(ru);
+	item->util = NULL;
+	return unmerge_index_entry_at(istate, pos);
+}
+
+void unmerge_index(struct index_state *istate, const char **pathspec)
+{
+	int i;
+
+	if (!istate->resolve_undo)
+		return;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+			continue;
+		i = unmerge_index_entry_at(istate, i);
+	}
+}
diff --git a/resolve-undo.h b/resolve-undo.h
index 74194d0..e4e5c1b 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -10,5 +10,7 @@ extern void record_resolve_undo(struct index_state *, struct cache_entry *);
 extern void resolve_undo_write(struct strbuf *, struct string_list *);
 extern struct string_list *resolve_undo_read(void *, unsigned long);
 extern void resolve_undo_clear_index(struct index_state *);
+extern int unmerge_index_entry_at(struct index_state *, int);
+extern void unmerge_index(struct index_state *, const char **);
 
 #endif
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 9844802..ea65f39 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -97,4 +97,15 @@ test_expect_success 'plumbing clears' '
 	check_resolve_undo cleared
 '
 
+test_expect_success 'add records checkout -m undoes' '
+	prime_resolve_undo &&
+	git diff HEAD &&
+	git checkout --conflict=merge file &&
+	echo checkout used the record and removed it &&
+	check_resolve_undo removed &&
+	echo the index and the work tree is unmerged again &&
+	git diff >actual &&
+	grep "^++<<<<<<<" actual
+'
+
 test_done
-- 
1.6.6
