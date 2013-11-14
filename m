From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 14/14] read-cache.c: fix memory leaks caused by removed
 cache entries
Date: Thu, 14 Nov 2013 20:24:37 +0100
Message-ID: <52852375.8040008@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:24:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2Wy-0004ab-IC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab3KNTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:24:41 -0500
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35609 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab3KNTYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:24:40 -0500
Received: by mail-wi0-f181.google.com with SMTP id f4so3207207wiw.8
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=H2CG1yR71yO6wNsLtgrf1Ku33c56lFDEMFVsSnLH9bc=;
        b=H1/dZCEloU/hwqARF0TFD/4FEfHa0HcE3eI8PKz9nND+0fpCMZvwkQAHEk3t7kC/12
         mx2gFILDmhsASeaaX3e4D4OMvM6Q8w3Od654bRPXO1kzZtkYhQ4xA5fQZVhdlY85D6vZ
         HUKCjkE2298YY3ICxWR3IoNHoeeAZDvHuNYU5gSOPjgXvAGqdmktniUqku0ptq9K3RIw
         T7yyZ5lYwobk4Zsj9XXdM0JnTWwseWxdBrJdZMxEuGH0aHGbwmPDe01WASg+ArCQnMQ/
         DcELRQMleWm8MszlBa8SO7FphMVeWFO695oaMhvqoOlDuP4istAT2lG+Zb4drRFch0aG
         ScEQ==
X-Received: by 10.194.123.8 with SMTP id lw8mr3688849wjb.40.1384457076050;
        Thu, 14 Nov 2013 11:24:36 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ey4sm1549201wic.11.2013.11.14.11.24.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:24:35 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237875>

When cache_entry structs are removed from index_state.cache, they are not
properly freed. Freeing those entries wasn't possible before because we
couldn't remove them from index_state.name_hash.

Now that we _do_ remove the entries from name_hash, we can also free them.
Add 'free(cache_entry)' to all call sites of name-hash.c::remove_name_hash
in read-cache.c (we could free() directly in remove_name_hash(), but
name-hash.c isn't concerned with cache_entry allocation at all).

Accessing a cache_entry after removing it from the index is now no longer
allowed, as the memory has been freed. The following functions need minor
fixes (typically by copying ce->name before use):
 - builtin/rm.c::cmd_rm
 - builtin/update-index.c::do_reupdate
 - read-cache.c::read_index_unmerged
 - resolve-undo.c::unmerge_index_entry_at

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/rm.c           | 2 +-
 builtin/update-index.c | 5 ++++-
 read-cache.c           | 8 ++++++--
 resolve-undo.c         | 7 +++++--
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3a0e0ea..171f37c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -311,7 +311,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		ALLOC_GROW(list.entry, list.nr + 1, list.alloc);
-		list.entry[list.nr].name = ce->name;
+		list.entry[list.nr].name = xstrdup(ce->name);
 		list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
 		if (list.entry[list.nr++].is_submodule &&
 		    !is_staging_gitmodules_ok())
diff --git a/builtin/update-index.c b/builtin/update-index.c
index c8f0d5f..00313f3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -559,6 +559,7 @@ static int do_reupdate(int ac, const char **av,
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
+		char *path;
 
 		if (ce_stage(ce) || !ce_path_match(ce, &pathspec))
 			continue;
@@ -575,7 +576,9 @@ static int do_reupdate(int ac, const char **av,
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
 		save_nr = active_nr;
-		update_one(ce->name);
+		path = xstrdup(ce->name);
+		update_one(path);
+		free(path);
 		if (save_nr != active_nr)
 			goto redo;
 	}
diff --git a/read-cache.c b/read-cache.c
index 00af9ad..3f735f3 100644
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
@@ -1894,7 +1898,7 @@ int read_index_unmerged(struct index_state *istate)
 		new_ce->ce_mode = ce->ce_mode;
 		if (add_index_entry(istate, new_ce, 0))
 			return error("%s: cannot drop to stage #0",
-				     ce->name);
+				     new_ce->name);
 		i = index_name_pos(istate, new_ce->name, len);
 	}
 	return unmerged;
diff --git a/resolve-undo.c b/resolve-undo.c
index c09b006..49ebaaf 100644
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
1.8.5.rc0.333.g5394214
