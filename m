Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C762ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 19:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiH3Tpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiH3Tp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 15:45:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CBC30F4E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 12:45:08 -0700 (PDT)
Received: (qmail 7551 invoked by uid 109); 30 Aug 2022 19:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 19:45:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28416 invoked by uid 111); 30 Aug 2022 19:45:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 15:45:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 15:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 1/2] tempfile: drop active flag
Message-ID: <Yw5owr6JrxE8L7jT@coredump.intra.peff.net>
References: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our tempfile struct contains an "active" flag. Long ago, this flag was
important: tempfile structs were always allocated for the lifetime of
the program and added to a global linked list, and the active flag was
what told us whether a struct's tempfile needed to be cleaned up on
exit.

But since 422a21c6a0 (tempfile: remove deactivated list entries,
2017-09-05) and 076aa2cbda (tempfile: auto-allocate tempfiles on heap,
2017-09-05), we actually remove items from the list, and the active flag
is generally always set to true for any allocated struct. We set it to
true in all of the creation functions, and in the normal code flow it
becomes false only in deactivate_tempfile(), which then immediately
frees the struct.

So the flag isn't performing that role anymore, and in fact makes things
more confusing. Dscho noted that delete_tempfile() is a noop for an
inactive struct. Since 076aa2cbda taught it to free the struct when
deactivating, we'd leak any struct whose active flag is unset. But in
practice it's not a leak, because again, we'll free when we unset the
flag, and never see the allocated-but-inactive state.

Can we just get rid of the flag? The answer is yes, but it requires
looking at a few other spots:

  1. I said above that the flag only becomes false before we deallocate,
     but there's one exception: when we call remove_tempfiles() from a
     signal or atexit handler, we unset the active flag as we remove
     each file. This isn't important for delete_tempfile(), as nobody
     would call it anymore, since we're exiting.

     It does in theory provide us some protection against racily
     double-removing a tempfile. If we receive a second signal while we
     are already in the cleanup routines, we'll start the cleanup loop
     again, and may visit the same tempfile. But this race already
     exists, because calling unlink() and unsetting the active flag
     aren't atomic! And it's OK in practice, because unlink() is
     idempotent (barring the unlikely event that some other process
     chooses our exact temp filename in that instant).

     So dropping the active flag widens the race a bit, but it was
     already there, and is fairly harmless in practice. If we really
     care about addressing it, the right thing is probably to block
     further signals while we're doing our cleanup (which we could
     actually do atomically).

  2. The active flag is declared as "volatile sig_atomic_t". The idea is
     that it's the final bit that gets set to tell the cleanup routines
     that the tempfile is ready to be used (or not used), and it's safe
     to receive a signal racing with regular code which adds or removes
     a tempfile from the list.

     In practice, I don't think this is buying us anything. The presence
     on the linked list is really what tells the cleanup routines to
     look at the struct. That is already marked as "volatile". It's not
     a sig_atomic_t, so it's possible that we could see a sheared write
     there as an entry is added or removed. But that is true of the
     current code, too! Before we can even look at the "active" flag,
     we'd have to follow a link to the struct itself. If we see a
     sheared write in the pointer to the struct, then we'll look at
     garbage memory anyway, and there's not much we can do.

This patch removes the active flag entirely, using presence on the
global linked list as an indicator that a tempfile ought to be cleaned
up. We are already careful to add to the list as the final step in
activating. On deactivation, we'll make sure to remove from the list as
the first step, before freeing any fields. The use of the volatile
keyword should mean that those things happen in the expected order.

Signed-off-by: Jeff King <peff@peff.net>
---
I recognize this is a high-risk cleanup, as there's a lot of hand-waving
about volatile and sig_atomic_t. But I'm fairly convinced it's not
making anything materially worse. And while the number of dropped lines
is small, I hope it makes this tricky code easier to reason about.

 tempfile.c | 10 +---------
 tempfile.h |  3 +--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/tempfile.c b/tempfile.c
index 7414c81e31..29e61077a8 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -86,8 +86,6 @@ static void remove_tempfiles(int in_signal_handler)
 		else
 			unlink_or_warn(p->filename.buf);
 		remove_template_directory(p, in_signal_handler);
-
-		p->active = 0;
 	}
 }
 
@@ -108,7 +106,6 @@ static struct tempfile *new_tempfile(void)
 	struct tempfile *tempfile = xmalloc(sizeof(*tempfile));
 	tempfile->fd = -1;
 	tempfile->fp = NULL;
-	tempfile->active = 0;
 	tempfile->owner = 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
@@ -120,9 +117,6 @@ static void activate_tempfile(struct tempfile *tempfile)
 {
 	static int initialized;
 
-	if (is_tempfile_active(tempfile))
-		BUG("activate_tempfile called for active object");
-
 	if (!initialized) {
 		sigchain_push_common(remove_tempfiles_on_signal);
 		atexit(remove_tempfiles_on_exit);
@@ -131,15 +125,13 @@ static void activate_tempfile(struct tempfile *tempfile)
 
 	volatile_list_add(&tempfile->list, &tempfile_list);
 	tempfile->owner = getpid();
-	tempfile->active = 1;
 }
 
 static void deactivate_tempfile(struct tempfile *tempfile)
 {
-	tempfile->active = 0;
+	volatile_list_del(&tempfile->list);
 	strbuf_release(&tempfile->filename);
 	free(tempfile->directory);
-	volatile_list_del(&tempfile->list);
 	free(tempfile);
 }
 
diff --git a/tempfile.h b/tempfile.h
index 5b9e8743dd..d0413af733 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -77,7 +77,6 @@
 
 struct tempfile {
 	volatile struct volatile_list_head list;
-	volatile sig_atomic_t active;
 	volatile int fd;
 	FILE *volatile fp;
 	volatile pid_t owner;
@@ -221,7 +220,7 @@ FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
 
 static inline int is_tempfile_active(struct tempfile *tempfile)
 {
-	return tempfile && tempfile->active;
+	return !!tempfile;
 }
 
 /*
-- 
2.37.3.1051.g85dc4064ac

