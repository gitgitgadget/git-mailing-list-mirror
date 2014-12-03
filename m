From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/14] lock_packed_refs: pass error message back through a
 strbuf
Date: Tue, 2 Dec 2014 21:16:15 -0800
Message-ID: <20141203051615.GO6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 06:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw2IZ-0006LB-EB
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 06:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbaLCFQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 00:16:19 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:64061 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaLCFQT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 00:16:19 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so13103597ier.14
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 21:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zuqlUVbwmhKCuHx7q+AnDR1okZaIImJnUr1RzTrJuoQ=;
        b=GzRtKbrtYhLDzFBTTQyyQo4kTNPju+vGC0MiJu2ASby/e22Zh8b3knqb7Ju9ESz47a
         1um3wAGmzeQIoCvEJdO2bLmS+CDqaa/p1kbdVf6PuIVmcizOIVQR9tLLWkvlinaP053t
         bObS3E2ZtPVgWTX97P0DUIM2/1KE2k0cIlUUaYERT3Eu9Y/8h4woGdHfZ9Hu+psG7PKt
         DvmUTI5tXIEpJYoBYLWwxh49c421cJMjkjPU2AKC+4YjMlflWxxrLP5s/Sg5LpQwI55l
         4gGLhyTgIIq7wDepT6VrWWs2ye8bk+q2NJaIaIYEopXb4Sf10/KrAKWYpTzo3kH1QhN9
         +W9Q==
X-Received: by 10.43.148.74 with SMTP id kf10mr5826874icc.9.1417583778310;
        Tue, 02 Dec 2014 21:16:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id u33sm12232750ioi.6.2014.12.02.21.16.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Dec 2014 21:16:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203050217.GJ6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260629>

This saves us from having to be careful about preserving errno and
makes it more explicit in the die-on-error case that the caller is
exiting without a chance to clean up.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/clone.c |  6 +++++-
 refs.c          | 17 ++++++++++-------
 refs.h          |  8 ++------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d5e7532..b07d740 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -495,8 +495,10 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
+	struct strbuf err = STRBUF_INIT;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	if (lock_packed_refs(&err))
+		die("%s", err.buf);
 
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
@@ -506,6 +508,8 @@ static void write_remote_refs(const struct ref *local_refs)
 
 	if (commit_packed_refs())
 		die_errno("unable to overwrite old ref-pack file");
+
+	strbuf_release(&err);
 }
 
 static void write_followtags(const struct ref *refs, const char *msg)
diff --git a/refs.c b/refs.c
index 5ff457e..917f8fc 100644
--- a/refs.c
+++ b/refs.c
@@ -2371,13 +2371,15 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-/* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+int lock_packed_refs(struct strbuf *err)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
+	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0) < 0) {
+		unable_to_lock_message(git_path("packed-refs"), errno, err);
 		return -1;
+	}
+
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
 	 * packed-refs file has been modified since we last read it,
@@ -2565,11 +2567,13 @@ static void prune_refs(struct ref_to_prune *r)
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	if (lock_packed_refs(&err))
+		die("%s", err.buf);
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
@@ -2579,6 +2583,7 @@ int pack_refs(unsigned int flags)
 		die_errno("unable to overwrite old ref-pack file");
 
 	prune_refs(cbdata.ref_to_prune);
+	strbuf_release(&err);
 	return 0;
 }
 
@@ -2657,10 +2662,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	if (i == n)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+	if (lock_packed_refs(err))
 		return -1;
-	}
 	packed = get_packed_refs(&ref_cache);
 
 	/* Remove refnames from the cache */
diff --git a/refs.h b/refs.h
index 2bc3556..ca6a567 100644
--- a/refs.h
+++ b/refs.h
@@ -119,12 +119,8 @@ extern int for_each_rawref(each_ref_fn, void *);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
-/*
- * Lock the packed-refs file for writing.  Flags is passed to
- * hold_lock_file_for_update().  Return 0 on success.
- * Errno is set to something meaningful on error.
- */
-extern int lock_packed_refs(int flags);
+/* Lock the packed-refs file for writing.  Returns 0 on success. */
+extern int lock_packed_refs(struct strbuf *err);
 
 /*
  * Add a reference to the in-memory packed reference cache.  This may
-- 
2.2.0.rc0.207.ga3a616c
