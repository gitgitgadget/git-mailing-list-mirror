From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 00/44] Use ref transactions for all ref updates
Date: Thu, 15 May 2014 11:06:18 -0700
Message-ID: <20140515180618.GA26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:08:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl04a-0002OX-2r
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbaEOSH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:07:59 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35050 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbaEOSH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:07:58 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so1421875pbb.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lZqP0yufzFNb6OV5JxT6tcNidceX/xcYd3SWuEISP8k=;
        b=q55R67ILb5/ekflnSzpPhoO4fxhzBKx89NBrK05/YzX0YsPa8P1bZrO6JdtMHd4bWF
         u6kUWp+Hueh/Z1+CYJRiF7LBf2cRrk6XUgM3Z1gtdLkY+a99YlWVMeR9WZncoNpJo+X1
         C5VgyYP9Wbnyq9kTHTpF/JBmypCYQnLhNPr4Kt46mT5ex14kqUjq3qKqJGtqeJntmyzn
         SDLZJFuxozL2ONYt2+6Lj4dI40w+k3jMGBTIZN2+xdOHl3zJohTbrNhpqwG8pnvlsaqx
         WNNRj3sxywz0WtvN57Yd/1zTB0whdQYIUbFVpBfpoikRk/vJCU7gkmiU6hlpysJEXyDK
         flGg==
X-Received: by 10.66.242.204 with SMTP id ws12mr14593764pac.10.1400177278193;
        Thu, 15 May 2014 11:07:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id is5sm10254713pbb.8.2014.05.15.11.07.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 11:07:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249173>

Ronnie Sahlberg wrote:

> This patch series is based on next and expands on the transaction API.

Thanks.  Will pick up in v8 where I left off with v6.

Applies with just one minor conflict on top of a merge of
mh/ref-transaction, rs/ref-update-check-errors-early, and
rs/reflog-exists.  Here's an interdiff against version 6 for those
following along.

> Version 8:
>  - Updates after review by JN
>  - Improve commit messages
>  - Add a patch that adds an err argument to repack_without_refs
>  - Add a patch that adds an err argument to delete_loose_ref
>  - Better document that a _update/_delete/_create failure means the whole
>    transaction has failed and needs rollback.
>
> Version 7:
>  - Updated commit messages per JNs review comments.
>  - Changed REF_ISPRUNING and REF_ISPACKONLY to be private flags and not
>    exposed through refs.h

diff --git a/builtin/commit.c b/builtin/commit.c
index 0f4e1fc..07ccc97 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1684,7 +1684,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				   0, !!current_head, sb.buf) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
-		die(_("HEAD: cannot update ref: %s"), err.buf);
+		die("%s", err.buf);
 	}
 	ref_transaction_free(transaction);
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 47c360c..952b589 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -163,7 +163,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	    ref_transaction_update(transaction, ref, repl, prev,
 				   0, !is_null_sha1(prev), NULL) ||
 	    ref_transaction_commit(transaction, &err))
-		die(_("%s: failed to replace ref: %s"), ref, err.buf);
+		die("%s: failed to replace ref: %s", ref, err.buf);
 
 	ref_transaction_free(transaction);
 	return 0;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index c5aff92..bd7e96f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -228,7 +228,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
 				   update_flags, msg))
-		die("failed transaction create for %s", refname);
+		die("cannot create ref '%s'", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 302a2b3..ed93b75 100644
--- a/refs.c
+++ b/refs.c
@@ -29,6 +29,15 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+/** Used as a flag to ref_transaction_delete when a loose ref is beeing
+ *  pruned.
+ */
+#define REF_ISPRUNING	0x0100
+/** Deletion of a ref that only exists as a packed ref in which case we do not
+ *  need to lock the loose ref during the transaction.
+ */
+#define REF_ISPACKONLY	0x0200
+
 /*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
@@ -2447,12 +2456,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_refs(const char **refnames, int n)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2465,6 +2474,9 @@ static int repack_without_refs(const char **refnames, int n)
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
+		if (err)
+			strbuf_addf(err, "cannot delete '%s' from packed refs",
+				    refnames[i]);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
 	packed = get_packed_refs(&ref_cache);
@@ -2490,20 +2502,28 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file");
+	return ret;
 }
 
-static int delete_ref_loose(struct ref_lock *lock, int flag)
+static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
+		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
 
 		lock->lk->filename[i] = 0;
-		err = unlink_or_warn(lock->lk->filename);
+		res = unlink_or_warn(lock->lk->filename);
 		lock->lk->filename[i] = '.';
-		if (err && errno != ENOENT)
+		if (res && errno != ENOENT) {
+			if (err)
+				strbuf_addf(err,
+					    "failed to delete loose ref '%s'",
+					    lock->lk->filename);
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -3483,7 +3503,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   delnames, delnum);
 		if (!update->lock) {
 			if (err)
-				strbuf_addf(err ,"Cannot lock the ref '%s'.",
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
 			ret = 1;
 			goto cleanup;
@@ -3516,13 +3536,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			continue;
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type);
+			ret |= delete_ref_loose(update->lock, update->type,
+						err);
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 03b4a7e..0e6d416 100644
--- a/refs.h
+++ b/refs.h
@@ -134,10 +134,6 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
-/** Deleting a loose ref during prune */
-#define REF_ISPRUNING	0x02
-/** Deletion of a ref that only exists as a packed ref */
-#define REF_ISPACKONLY	0x04
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
@@ -240,6 +236,9 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure. A failure to update
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
@@ -252,6 +251,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
@@ -262,6 +264,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
@@ -272,7 +277,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem. If err is non-NULL we will add an error string to it to explain
- * why the transaction failed.
+ * why the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
