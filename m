From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v3 10/11] read-cache.c: fix memory leaks caused by removed
 cache entries
Date: Tue, 01 Oct 2013 11:40:22 +0200
Message-ID: <524A9886.2030508@gmail.com>
References: <524A96FF.5090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 01 11:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQwRQ-0007MD-0U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 11:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab3JAJkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 05:40:24 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:40674 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab3JAJkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 05:40:23 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so3226153eae.23
        for <git@vger.kernel.org>; Tue, 01 Oct 2013 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+vrI/6TCe2hP0hojY1vm7ajK13W7dKPQM0UPKHDl/uM=;
        b=vA+HsoxqrjhSWMDJ/j6R4/H+n/fzmPeJARd5GnKyNYGy+YPl4U+0JefVNyelwGn+CM
         a0LiftAv/GmsLvQy+W4rMhkbvOcXfjzBSCL6y/AKtJYstGrDyI8UH4y7mdoq65hAEU+j
         yzCj1m1I0iA7W2V88rKo6PKnm0Rq/BHoNR7KB2wMwIjPtCQw5/jq7hfipzWqBbl5ehpg
         DuS4Ldo8N/Gr3nZTNO1uZReSJpmPAUxR6ttXa66UVxkR7XyDm5Vz5SkpMVZTeP9epH6M
         IGeqGDI8hER7MHRBwp9upiWtS1W3KmhDS5ATYebSmOkQdQcE7M98mBjk37zWdnaIPi5a
         VuFA==
X-Received: by 10.15.33.132 with SMTP id c4mr45233887eev.2.1380620422318;
        Tue, 01 Oct 2013 02:40:22 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id h45sm11151265eeg.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Oct 2013 02:40:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <524A96FF.5090604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235654>

When cache_entry structs are removed from index_state.cache, they are not
properly freed. Freeing those entries wasn't possible before because we
couldn't remove them from index_state.name_hash.

Now that we _do_ remove the entries from name_hash, we can also free them.
Add free(cache_entry) to all call sites of name-hash.c::remove_name_hash in
read-cache.c, as name-hash.c isn't concerned with cache_entry allocation.

cmd_rm and unmerge_index_entry_at use cache_entry.name after removing the
entry. Copy the name so that we don't access memory that has been freed.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/rm.c   | 2 +-
 read-cache.c   | 6 +++++-
 resolve-undo.c | 7 +++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 0df0b4d..678da8a 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -324,7 +324,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
-		list.entry[list.nr].name = ce->name;
+		list.entry[list.nr].name = xstrdup(ce->name);
 		list.entry[list.nr++].is_submodule = S_ISGITLINK(ce->ce_mode);
 	}
 
diff --git a/read-cache.c b/read-cache.c
index 0b5c44b..4c570a1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -47,6 +47,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 	struct cache_entry *old = istate->cache[nr];
 
 	remove_name_hash(istate, old);
+	free(old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
@@ -478,6 +479,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 
 	record_resolve_undo(istate, ce);
 	remove_name_hash(istate, ce);
+	free(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
@@ -499,8 +501,10 @@ void remove_marked_cache_entries(struct index_state *istate)
 	unsigned int i, j;
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
-		if (ce_array[i]->ce_flags & CE_REMOVE)
+		if (ce_array[i]->ce_flags & CE_REMOVE) {
 			remove_name_hash(istate, ce_array[i]);
+			free(ce_array[i]);
+		}
 		else
 			ce_array[j++] = ce_array[i];
 	}
diff --git a/resolve-undo.c b/resolve-undo.c
index 77101f5..64793db 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -119,6 +119,7 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 	struct string_list_item *item;
 	struct resolve_undo_info *ru;
 	int i, err = 0, matched;
+	char *name;
 
 	if (!istate->resolve_undo)
 		return pos;
@@ -138,20 +139,22 @@ int unmerge_index_entry_at(struct index_state *istate, int pos)
 	if (!ru)
 		return pos;
 	matched = ce->ce_flags & CE_MATCHED;
+	name = xstrdup(ce->name);
 	remove_index_entry_at(istate, pos);
 	for (i = 0; i < 3; i++) {
 		struct cache_entry *nce;
 		if (!ru->mode[i])
 			continue;
 		nce = make_cache_entry(ru->mode[i], ru->sha1[i],
-				       ce->name, i + 1, 0);
+				       name, i + 1, 0);
 		if (matched)
 			nce->ce_flags |= CE_MATCHED;
 		if (add_index_entry(istate, nce, ADD_CACHE_OK_TO_ADD)) {
 			err = 1;
-			error("cannot unmerge '%s'", ce->name);
+			error("cannot unmerge '%s'", name);
 		}
 	}
+	free(name);
 	if (err)
 		return pos;
 	free(ru);
-- 
1.8.4.11.g4f52745.dirty
