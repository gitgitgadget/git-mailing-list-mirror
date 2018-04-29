Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4301A1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeD2WSh (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:18:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:46299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754403AbeD2WSg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:18:36 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MhQju-1ez79Z1hJK-00MfYg; Mon, 30 Apr 2018 00:18:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 3/6] refs/*: report bugs using the BUG() macro
Date:   Mon, 30 Apr 2018 00:18:02 +0200
Message-Id: <b44ce003ae6d6bb8c7bb343168e48af7fbac867f.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CQuBLfLECGbv7ccfnPH4rJzGb6rtDWWhIM/EPvfpXRDgAdpXGLb
 6jdGZZLq+9Wum04+73VLRoH+8Np0HhZ/88AMxdSwxuAQPPr+FlgdosN66Pmv/EuO87cCGn9
 Q6gT+1rib71As2HfppqLU9tWfD7oXs6voa6zzX89cTjMbGPHg04IiP1lne7ddo8XJG4BR6p
 EwwQyfonudbCIkeBEvJvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:13ykQDgoO3U=:ORiqPxDUIKPBhRWM7rLOiv
 qTfWh/gTTLdChxzdbT0ODg35ZmpT6HXQYX2JmOQlNGuKD0K0KOTgi4C6dWSBzo1/W2qNn4tiE
 kfnPnTmUME7nuSp4Dvc7+01wc0wS5RvCJJfBo2ztm0G8UGAyuG6WcCn/RMNDVl+EiSvPCqeQY
 UjAVP1aFiEiiZ3w8Ogd2Uus4AR9xSyEm4i43e3XVuj700SqAh5XuwvOfZb0QD3tcUh2CWLPJ/
 YhbLeP9rAxtWKtD80rzkh+gC9V9m37ag+Z2wqNeCAxuxYyaXbZL+rtQgh6jbhC6uiAo8/jQHj
 cQlMr0t4Pch/SlwwQRG3j2hFDxN/XTsr8y+VIlf9LwAG/aAlLg97KjKpdI1MrL/Wqk4kTJG7E
 zA1Q5bTJD0MD+pJdOQTBXTVz166fpdFI1VVCNEXHbbtzUQx1XrEfEqDoUrh/nvxjD2/bIm24A
 mXlRj0dExPxOgIwxqQnPM9CuPwyRXTn7XvlpxrjfaAuylV8eLXEpQQcTHOezP+vhgAHIVjxOI
 A99BlqgePCxZbbedeA3ofk497qAU51iNtUtrTlct/u4QSIJpTqrOmI4IwiQ6APsjQyKkkn2w3
 YnQLfM3wf4eoif58VHhrG37FjbuGQliz2QMFqYFexideK5JGRtvg9EiIUb5Eod1FDF37HD079
 btDJjGoAawb2HNXn+4dhxJQkafxpvmD5lJkAig4lIAWgqH8+5gXUcx9xAsKgkOTWpqvncCzeG
 lddfCZEnDOq7yAFqiAq+C4z/1eq/S6ej+rKlQ9B6LtLIQpRSl3GsXulR8WALZrFdV4fdRPI4x
 TeLAWBd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We just prepared t1406 to be okay with BUG reports resulting in SIGABRT
instead of a regular exit code indicating failure. This commit now makes
it so: by calling BUG() (which eventually calls `abort()`), we no longer
exit with code 128 but instead throw that signal.

This trick was performed by this invocation:

	sed -i 's/die("BUG: /BUG("/' $(git grep -l 'die("BUG' refs/\*.c)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 refs/files-backend.c  | 20 ++++++++++----------
 refs/iterator.c       |  6 +++---
 refs/packed-backend.c | 16 ++++++++--------
 refs/ref-cache.c      |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a92a2aa8213..332da47edd9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -125,7 +125,7 @@ static void files_assert_main_repository(struct files_ref_store *refs,
 	if (refs->store_flags & REF_STORE_MAIN)
 		return;
 
-	die("BUG: operation %s only allowed for main ref store", caller);
+	BUG("operation %s only allowed for main ref store", caller);
 }
 
 /*
@@ -141,13 +141,13 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	struct files_ref_store *refs;
 
 	if (ref_store->be != &refs_be_files)
-		die("BUG: ref_store is type \"%s\" not \"files\" in %s",
+		BUG("ref_store is type \"%s\" not \"files\" in %s",
 		    ref_store->be->name, caller);
 
 	refs = (struct files_ref_store *)ref_store;
 
 	if ((refs->store_flags & required_flags) != required_flags)
-		die("BUG: operation %s requires abilities 0x%x, but only have 0x%x",
+		BUG("operation %s requires abilities 0x%x, but only have 0x%x",
 		    caller, required_flags, refs->store_flags);
 
 	return refs;
@@ -166,7 +166,7 @@ static void files_reflog_path(struct files_ref_store *refs,
 		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
 		break;
 	default:
-		die("BUG: unknown ref type %d of ref %s",
+		BUG("unknown ref type %d of ref %s",
 		    ref_type(refname), refname);
 	}
 }
@@ -184,7 +184,7 @@ static void files_ref_path(struct files_ref_store *refs,
 		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
 		break;
 	default:
-		die("BUG: unknown ref type %d of ref %s",
+		BUG("unknown ref type %d of ref %s",
 		    ref_type(refname), refname);
 	}
 }
@@ -2010,7 +2010,7 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 
 	}
 	if (!ret && sb.len)
-		die("BUG: reverse reflog parser had leftover data");
+		BUG("reverse reflog parser had leftover data");
 
 	fclose(logfp);
 	strbuf_release(&sb);
@@ -2088,7 +2088,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	die("BUG: ref_iterator_peel() called for reflog_iterator");
+	BUG("ref_iterator_peel() called for reflog_iterator");
 }
 
 static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
@@ -2873,7 +2873,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	assert(err);
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: commit called for transaction that is not open");
+		BUG("commit called for transaction that is not open");
 
 	/* Fail if a refname appears more than once in the transaction: */
 	for (i = 0; i < transaction->nr; i++)
@@ -2899,7 +2899,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	 */
 	if (refs_for_each_rawref(&refs->base, ref_present,
 				 &affected_refnames))
-		die("BUG: initial ref transaction called with existing refs");
+		BUG("initial ref transaction called with existing refs");
 
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store, err);
 	if (!packed_transaction) {
@@ -2912,7 +2912,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 		if ((update->flags & REF_HAVE_OLD) &&
 		    !is_null_oid(&update->old_oid))
-			die("BUG: initial ref transaction with old_sha1 set");
+			BUG("initial ref transaction with old_sha1 set");
 		if (refs_verify_refname_available(&refs->base, update->refname,
 						  &affected_refnames, NULL,
 						  err)) {
diff --git a/refs/iterator.c b/refs/iterator.c
index bd35da4e622..2ac91ac3401 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -54,7 +54,7 @@ static int empty_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	die("BUG: peel called for empty iterator");
+	BUG("peel called for empty iterator");
 }
 
 static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
@@ -177,7 +177,7 @@ static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
 		(struct merge_ref_iterator *)ref_iterator;
 
 	if (!iter->current) {
-		die("BUG: peel called before advance for merge iterator");
+		BUG("peel called before advance for merge iterator");
 	}
 	return ref_iterator_peel(*iter->current, peeled);
 }
@@ -338,7 +338,7 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			 * trimming, report it as a bug:
 			 */
 			if (strlen(iter->iter0->refname) <= iter->trim)
-				die("BUG: attempt to trim too many characters");
+				BUG("attempt to trim too many characters");
 			iter->base.refname = iter->iter0->refname + iter->trim;
 		} else {
 			iter->base.refname = iter->iter0->refname;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 369c34f886f..cec3fb9e00f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -221,13 +221,13 @@ static struct packed_ref_store *packed_downcast(struct ref_store *ref_store,
 	struct packed_ref_store *refs;
 
 	if (ref_store->be != &refs_be_packed)
-		die("BUG: ref_store is type \"%s\" not \"packed\" in %s",
+		BUG("ref_store is type \"%s\" not \"packed\" in %s",
 		    ref_store->be->name, caller);
 
 	refs = (struct packed_ref_store *)ref_store;
 
 	if ((refs->store_flags & required_flags) != required_flags)
-		die("BUG: unallowed operation (%s), requires %x, has %x\n",
+		BUG("unallowed operation (%s), requires %x, has %x\n",
 		    caller, required_flags, refs->store_flags);
 
 	return refs;
@@ -1036,7 +1036,7 @@ void packed_refs_unlock(struct ref_store *ref_store)
 			"packed_refs_unlock");
 
 	if (!is_lock_file_locked(&refs->lock))
-		die("BUG: packed_refs_unlock() called when not locked");
+		BUG("packed_refs_unlock() called when not locked");
 	rollback_lock_file(&refs->lock);
 }
 
@@ -1089,7 +1089,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 	char *packed_refs_path;
 
 	if (!is_lock_file_locked(&refs->lock))
-		die("BUG: write_with_updates() called while unlocked");
+		BUG("write_with_updates() called while unlocked");
 
 	/*
 	 * If packed-refs is a symlink, we want to overwrite the
@@ -1563,21 +1563,21 @@ static int packed_create_symref(struct ref_store *ref_store,
 			       const char *refname, const char *target,
 			       const char *logmsg)
 {
-	die("BUG: packed reference store does not support symrefs");
+	BUG("packed reference store does not support symrefs");
 }
 
 static int packed_rename_ref(struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
 			    const char *logmsg)
 {
-	die("BUG: packed reference store does not support renaming references");
+	BUG("packed reference store does not support renaming references");
 }
 
 static int packed_copy_ref(struct ref_store *ref_store,
 			   const char *oldrefname, const char *newrefname,
 			   const char *logmsg)
 {
-	die("BUG: packed reference store does not support copying references");
+	BUG("packed reference store does not support copying references");
 }
 
 static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
@@ -1610,7 +1610,7 @@ static int packed_create_reflog(struct ref_store *ref_store,
 			       const char *refname, int force_create,
 			       struct strbuf *err)
 {
-	die("BUG: packed reference store does not support reflogs");
+	BUG("packed reference store does not support reflogs");
 }
 
 static int packed_delete_reflog(struct ref_store *ref_store,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index e90bd3e727f..9b110c8494f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -23,7 +23,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	dir = &entry->u.subdir;
 	if (entry->flag & REF_INCOMPLETE) {
 		if (!dir->cache->fill_ref_dir)
-			die("BUG: incomplete ref_store without fill_ref_dir function");
+			BUG("incomplete ref_store without fill_ref_dir function");
 
 		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
 		entry->flag &= ~REF_INCOMPLETE;
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


