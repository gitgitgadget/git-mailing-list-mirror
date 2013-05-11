From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 10/10] branch: Fix display of remote branches in refs/peers/*
Date: Sat, 11 May 2013 18:21:20 +0200
Message-ID: <1368289280-30337-11-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYP-0007Zt-BI
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab3EKQVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:46 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38830 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab3EKQVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:45 -0400
Received: by mail-wi0-f177.google.com with SMTP id hr14so1575260wib.4
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=MT1fpJiJOkR3iPzI5E52uG4jWT4TAVrA4gqPFfolsVk=;
        b=isnMIMsGmtLPiEpw1GQjPjmdGtXHOWcZmkbdoNQbd1yqO0noKF8vxKdIrF+wdvfzrX
         32VRXehFrVuJQYHoFiewt40xN2SyQrCd76B/jyWDE5e0gm8nca9+/YRGZgJdlG2bTxT5
         qRKmQWxKAUMd4WARrU5o6sKBqWdEsOLa2WdLwWP/x0W+a3uTQYKwQbG0F5cYz6NVO2V1
         UUMSzcl9lG3wfuDYJHLcdNJew+u6uscqTeHu4L4jBb8uuPbPcR+xQxrX8xdU6ILbzgff
         aTBSOZT9tXz1cKVmmss0MZ3pMBWRTvtLLesXHSLgF6IArVWac2cTrVW1LLAr5E5gy2bn
         pqlQ==
X-Received: by 10.180.21.167 with SMTP id w7mr9824489wie.2.1368289303213;
        Sat, 11 May 2013 09:21:43 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223988>

The current branch display code assumes all remote-tracking branches live
inside refs/remotes/*, and that their appropriate shorthand names can be
retrieved by simply stripping off the "refs/remotes/" prefix.

When we add remote-tracking branches in refs/peers/$remote/heads/*, the
code must not only be taught how to list refs from the new location, but
also how to appropriately derive shorthand names for the remote-tracking
branches there (instead of stripping off a hardcoded prefix, we must use
the refname_shorten() function introduced in an earlier patch.)

There is already a good set of tests for the expected output from git
branch, and this patch does not break any of them. However, we do fix
the two tests with remote-tracking branches in refs/peers/* introduced
in a previous patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/branch.c                               | 66 ++++++++++++++------------
 refs.c                                         |  4 +-
 refs.h                                         |  3 ++
 t/t7900-working-with-namespaced-remote-refs.sh |  4 +-
 4 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 4480be2..9a6bce8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -290,18 +290,16 @@ struct ref_list {
 	int kinds;
 };
 
-static char *resolve_symref(const char *src, const char *prefix)
+static void resolve_symref(struct strbuf *shortname, const char *pattern, const char *src)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *dst, *cp;
+	const char *dst;
 
 	dst = resolve_ref_unsafe(src, sha1, 0, &flag);
-	if (!(dst && (flag & REF_ISSYMREF)))
-		return NULL;
-	if (prefix && (cp = skip_prefix(dst, prefix)))
-		dst = cp;
-	return xstrdup(dst);
+	if (dst && (flag & REF_ISSYMREF) &&
+	    refname_shorten(shortname, pattern, dst, strlen(dst)))
+		strbuf_addstr(shortname, dst);
 }
 
 struct append_ref_cb {
@@ -328,74 +326,80 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	struct ref_list *ref_list = cb->ref_list;
 	struct ref_item *newitem;
 	struct commit *commit;
+	struct strbuf ref = STRBUF_INIT;
 	int kind, i;
-	const char *prefix, *orig_refname = refname;
+	const char *pattern;
+	size_t refname_len = strlen(refname);
 
 	static struct {
 		int kind;
-		const char *prefix;
-		int pfxlen;
+		const char *pattern;
 	} ref_kind[] = {
-		{ REF_LOCAL_BRANCH, "refs/heads/", 11 },
-		{ REF_REMOTE_BRANCH, "refs/remotes/", 13 },
+		{ REF_LOCAL_BRANCH, "refs/heads/%*" },
+		{ REF_REMOTE_BRANCH, "refs/remotes/%*" },
+		{ REF_REMOTE_BRANCH, "refs/peers/%1/heads/%*" },
 	};
 
 	/* Detect kind */
 	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
-		prefix = ref_kind[i].prefix;
-		if (strncmp(refname, prefix, ref_kind[i].pfxlen))
+		if (refname_shorten(&ref, ref_kind[i].pattern, refname, refname_len))
 			continue;
 		kind = ref_kind[i].kind;
-		refname += ref_kind[i].pfxlen;
+		pattern = ref_kind[i].pattern;
 		break;
 	}
 	if (ARRAY_SIZE(ref_kind) <= i)
-		return 0;
+		goto out;
 
 	/* Don't add types the caller doesn't want */
 	if ((kind & ref_list->kinds) == 0)
-		return 0;
+		goto out;
 
-	if (!match_patterns(cb->pattern, refname))
-		return 0;
+	if (!match_patterns(cb->pattern, ref.buf))
+		goto out;
 
 	commit = NULL;
 	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
 		commit = lookup_commit_reference_gently(sha1, 1);
 		if (!commit) {
-			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
-			return 0;
+			cb->ret = error(_("branch '%s' does not point at a commit"), ref.buf);
+			goto out;
 		}
 
 		/* Filter with with_commit if specified */
 		if (!is_descendant_of(commit, ref_list->with_commit))
-			return 0;
+			goto out;
 
 		if (merge_filter != NO_FILTER)
 			add_pending_object(&ref_list->revs,
-					   (struct object *)commit, refname);
+					   (struct object *)commit, ref.buf);
 	}
 
+	/*
+	 * When displaying more then just remote-tracking branches, make the
+	 * remote-tracking branches more explicit, e.g. instead of printing
+	 * "origin/master", we should print "remote/origin/master" (or
+	 * "peers/origin/heads/master").
+	 */
+	if (kind == REF_REMOTE_BRANCH && ref_list->kinds != REF_REMOTE_BRANCH)
+		refname_shorten(&ref, "refs/%*", refname, refname_len);
+
 	ALLOC_GROW(ref_list->list, ref_list->index + 1, ref_list->alloc);
 
 	/* Record the new item */
 	newitem = &(ref_list->list[ref_list->index++]);
 	strbuf_init(&newitem->name, 0);
-	strbuf_addstr(&newitem->name, refname);
+	strbuf_addbuf(&newitem->name, &ref);
 	newitem->kind = kind;
 	newitem->commit = commit;
 	strbuf_init(&newitem->dest, 0);
-	orig_refname = resolve_symref(orig_refname, prefix);
-	if (orig_refname)
-		strbuf_addstr(&newitem->dest, orig_refname);
-	/* adjust for "remotes/" */
-	if (newitem->kind == REF_REMOTE_BRANCH &&
-	    ref_list->kinds != REF_REMOTE_BRANCH)
-		strbuf_insert(&newitem->name, 0, "remotes/", 8);
+	resolve_symref(&newitem->dest, pattern, refname);
 	newitem->width = utf8_strwidth(newitem->name.buf);
 	if (newitem->width > ref_list->maxwidth)
 		ref_list->maxwidth = newitem->width;
 
+out:
+	strbuf_release(&ref);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 188a9eb..a78199a 100644
--- a/refs.c
+++ b/refs.c
@@ -1873,8 +1873,8 @@ static int handle_fragment(struct strbuf *dst, struct strbuf *fragment,
 	return (ref - refname) + trail_len;
 }
 
-static int refname_shorten(struct strbuf *dst, const char *pattern,
-			   const char *refname, size_t refname_len)
+int refname_shorten(struct strbuf *dst, const char *pattern,
+		    const char *refname, size_t refname_len)
 {
 	/*
 	 * Match refname against pattern, using "%*" as wildcard, and
diff --git a/refs.h b/refs.h
index e05c1f1..245d53d 100644
--- a/refs.h
+++ b/refs.h
@@ -165,6 +165,9 @@ extern int check_refname_format(const char *refname, int flags);
 
 extern const char *prettify_refname(const char *refname);
 
+extern int refname_shorten(struct strbuf *dst, const char *pattern,
+			   const char *refname, size_t refname_len);
+
 extern int refname_match(const char *abbrev_name, const char *full_name);
 
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
index 279664c..450b193 100755
--- a/t/t7900-working-with-namespaced-remote-refs.sh
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -112,7 +112,7 @@ cat >expect.branch-r << EOF
   origin/other
 EOF
 
-test_expect_failure 'git branch -r should show remote-tracking branches' '
+test_expect_success 'git branch -r should show remote-tracking branches' '
 	git branch -r >actual.branch-r &&
 	test_cmp expect.branch-r actual.branch-r
 '
@@ -123,7 +123,7 @@ cat >expect.branch-a << EOF
   peers/origin/heads/other
 EOF
 
-test_expect_failure 'git branch -a should also show remote-tracking branches' '
+test_expect_success 'git branch -a should also show remote-tracking branches' '
 	git branch -a >actual.branch-a &&
 	test_cmp expect.branch-a actual.branch-a
 '
-- 
1.8.1.3.704.g33f7d4f
