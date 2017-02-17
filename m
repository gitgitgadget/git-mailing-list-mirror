Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21AB0201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935020AbdBQUCl (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 15:02:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:57351 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935015AbdBQUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 15:02:38 -0500
Received: (qmail 16965 invoked by uid 109); 17 Feb 2017 19:55:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 19:55:52 +0000
Received: (qmail 5104 invoked by uid 111); 17 Feb 2017 19:55:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 14:55:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 14:55:49 -0500
Date:   Fri, 17 Feb 2017 14:55:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's
 log
Message-ID: <20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-4-kyle@kyleam.com>
 <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
 <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
 <20170217194350.prhp5joh33cbvwsd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217194350.prhp5joh33cbvwsd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 02:43:50PM -0500, Jeff King wrote:

> Yes. I think the options are basically (in order of decreasing
> preference in my opinion):
> 
>   1. Log a rename entry (same sha1, but note the rename in the free-form
>      text).
> 
>   2. Log a delete (sha1 goes to null) followed by a creation (from null
>      back to the original sha1).
> 
>   3. Log nothing at all for HEAD.
> 
> This does half of (2). If we do the second half, then I'd prefer it to
> (3). But if we can do (1), that is better still (IMHO).
> 
> > *1* Is the reason why the code in files_rename_ref() we are looking
> >     at does not adjust HEAD to point at the new ref is because it is
> >     just handing one ref-store and obviouvious to symrefs in other
> >     backends?
> 
> I'm actually confused about which bit of code is updating HEAD. I do not
> see it either in files_rename_ref() or in the caller. Yet it clearly
> happens. But that is the code that would know enough to do (1) or the
> second half of (2) above.

Ah, I found it. It's in replace_each_worktree_head_symref() these days,
which does not bother to pass a log message.

So I think the second half of (2) is probably something like the patch
below.

Thinking on it more, we probably _do_ want two entries. Because the
operations are not atomic, it's possible that we may end up in a
half-way state after the first entry is written. And when debugging such
a case, I'd much rather see the first half of the operation logged than
nothing at all.

-Peff

---
diff --git a/branch.c b/branch.c
index b955d4f31..5c12036b0 100644
--- a/branch.c
+++ b/branch.c
@@ -345,7 +345,8 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
 	    branch, wt->path);
 }
 
-int replace_each_worktree_head_symref(const char *oldref, const char *newref)
+int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+				      const char *logmsg)
 {
 	int ret = 0;
 	struct worktree **worktrees = get_worktrees(0);
@@ -358,7 +359,7 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref)
 			continue;
 
 		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
-					     newref)) {
+					     newref, logmsg)) {
 			ret = -1;
 			error(_("HEAD of working tree %s is not updated"),
 			      worktrees[i]->path);
diff --git a/branch.h b/branch.h
index 3103eb9ad..b07788558 100644
--- a/branch.h
+++ b/branch.h
@@ -71,6 +71,7 @@ extern void die_if_checked_out(const char *branch, int ignore_current_worktree);
  * This will be used when renaming a branch. Returns 0 if successful, non-zero
  * otherwise.
  */
-extern int replace_each_worktree_head_symref(const char *oldref, const char *newref);
+extern int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+					     const char *logmsg);
 
 #endif
diff --git a/builtin/branch.c b/builtin/branch.c
index cbaa6d03c..383005912 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -471,14 +471,15 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 
 	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
-	strbuf_release(&logmsg);
 
 	if (recovery)
 		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
 
-	if (replace_each_worktree_head_symref(oldref.buf, newref.buf))
+	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
+	strbuf_release(&logmsg);
+
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
diff --git a/refs.h b/refs.h
index 9fbff90e7..b33035c4a 100644
--- a/refs.h
+++ b/refs.h
@@ -334,7 +334,8 @@ int create_symref(const char *refname, const char *target, const char *logmsg);
  * $GIT_DIR points to.
  * Return 0 if successful, non-zero otherwise.
  * */
-int set_worktree_head_symref(const char *gitdir, const char *target);
+int set_worktree_head_symref(const char *gitdir, const char *target,
+			     const char *logmsg);
 
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4f1a88f6d..fa8d08e3c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3024,7 +3024,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	return ret;
 }
 
-int set_worktree_head_symref(const char *gitdir, const char *target)
+int set_worktree_head_symref(const char *gitdir, const char *target, const char *logmsg)
 {
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
@@ -3052,7 +3052,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
 
-	ret = create_symref_locked(lock, head_rel, target, NULL);
+	ret = create_symref_locked(lock, head_rel, target, logmsg);
 
 	unlock_ref(lock); /* will free lock */
 	strbuf_release(&head_path);
