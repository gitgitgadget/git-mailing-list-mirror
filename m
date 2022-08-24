Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35341C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 09:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiHXJfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 05:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiHXJf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 05:35:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECC53D2B
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 02:35:25 -0700 (PDT)
Received: (qmail 8259 invoked by uid 109); 24 Aug 2022 09:35:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Aug 2022 09:35:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17527 invoked by uid 111); 24 Aug 2022 09:35:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Aug 2022 05:35:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Aug 2022 05:35:23 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: curiosities with tempfile.active
Message-ID: <YwXw2ytUlrXSSRh7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[starting a new thread, as this ended up rather long;
 +cc René as there's an interesting twist at the end]

On Tue, Aug 23, 2022 at 11:12:21AM +0200, Johannes Schindelin wrote:

> Side note: I do notice that `delete_tempfile(&tmpedit)` seems to _not_
> release memory when `tmpedit` is non-NULL when `tmpedit->active == 0`.
> I consider this a bug in the `delete_tempfile()` code (in its `if
> (!is_tempfile_active(tempfile))` clause, it should call
> `deactivate_tempfile()` for non-NULL `tempfile`s and set `*tempfile_p =
> NULL;`), but it is outside the scope of your patch to address that.

I agree it is confusing, but I think this turns out not to be a bug in
practice. In ye olden days, tempfile structs lived on the global
linked-list of entries to cleanup forever, so they were statically
allocated or effectively leaked from the heap. And that's why we needed
an "active" flag in the first place.

That changed around 422a21c6a0 (tempfile: remove deactivated list
entries, 2017-09-05) and 076aa2cbda (tempfile: auto-allocate tempfiles
on heap, 2017-09-05). Now calling deactivate_tempfile() unsets the
active flag _and_ frees the struct. And in normal calling, that's the
only way to unset the active flag (it also starts life unset, but the
creation functions always activate on success, or deactivate+free on
error).

So can we just get rid of the active flag? Possibly. I said "normal
calling" above, because the exception is in our remove_tempfiles()
cleanup routine, where we unset the "active" flag as we remove each
file. We can't use the regular delete_tempfile(), or even
deactivate_tempfile() here, because we may be in a signal handler, so
things like free() are forbidden. So we just "leak" the memory, but it's
OK because we're exiting (and even leak detection won't complain,
because it's reachable from the global list).

But why do we care about the flag, then? We just iterate over the list
once, so we should handle each entry once. But it can be called both as
an atexit() handler, as well as a signal handler. So it's possible that
we can be mid-iteration and get another signal (because the original was
via exit, or because we hook multiple signals for the cleanup). So the
active flag in theory is protecting us from that.

But it's not foolproof. We remove the tempfile and then unset the flag,
so there's a moment (albeit small) where that other signal could come
in. It shouldn't be a big deal because unlinking the tempfiles is mostly
idempotent-ish; barring the unlikely chance that somebody else creates
the same random filename as us, the second unlink will do nothing. So
while removing the active flag would increase the size of that race
(from handling a single entry to completing the whole atexit), that
shouldn't matter much in practice.

But here's the interesting twist. Commit 2c2db194bd (tempfile: add
mks_tempfile_dt(), 2022-04-20) recently taught remove_tempfiles() to
drop a surrounding directory. And it does so by munging the filename
buffer. It has to, because we can't allocate a new buffer in a signal
handler.

But is it also idempotent(-ish)? The directory removal itself is,
because it checks:

  tempfile->filename.buf[tempfile->directorylen] == '/'

before overwriting that byte with a NUL, so it should only be true once
(though I note this violates the usual "volatile" rules for signal
handlers, it's probably OK in practice since we know the NUL will be
written before we call rmdir()).

But after that happens, the filename buffer now contains a C string that
points to the directory. And if we end up in remove_tempfiles() again
due to another signal, we'll try to unlink(p->filename.buf), which will
now unlink the directory! I'm not sure how that behaves on all systems.
On Linux it's a noop. And if it just deleted the directory, that would
be OK. I seem to recall on old versions of SunOS it did bad things
(maybe because it really did unlink it, but without checking for
orphaned entries inside).

The good news is that it won't walk further up the tree. I was worried
that a second round might then try to rmdir the parent (usually "/tmp"
in this case). But the directory removal always uses the same length.

So...maybe it's all OK in practice? If not, this is an issue even
without removing the active flag. But removing it would make the race
window larger. I suspect it probably is OK in practice, but saying that
about a race always feels like famous last words.

If we did want to keep it, I suspect we could get the same effect by
munging the volatile "pid_t owner" field, but I think anything we munge
is supposed to be a sig_atomic_t according to the letter of the law.

Patch below shows what it would look like to just drop "active"
entirely. Test suite behaves as expected, but again, the real question
is what it might be doing in a weird racy situation. The one above, but
also a signal racing with adding an entry to the list. The volatile
sig_atomic_t is what tells the removal process in the signal handler
that it's OK to look at. But again, maybe that's OK in practice.

-Peff

---
diff --git a/tempfile.c b/tempfile.c
index 2024c82691..6134b73972 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -89,8 +89,6 @@ static void remove_tempfiles(int in_signal_handler)
 		else
 			unlink_or_warn(p->filename.buf);
 		remove_template_directory(p, in_signal_handler);
-
-		p->active = 0;
 	}
 }
 
@@ -111,7 +109,6 @@ static struct tempfile *new_tempfile(void)
 	struct tempfile *tempfile = xmalloc(sizeof(*tempfile));
 	tempfile->fd = -1;
 	tempfile->fp = NULL;
-	tempfile->active = 0;
 	tempfile->owner = 0;
 	INIT_LIST_HEAD(&tempfile->list);
 	strbuf_init(&tempfile->filename, 0);
@@ -123,9 +120,6 @@ static void activate_tempfile(struct tempfile *tempfile)
 {
 	static int initialized;
 
-	if (is_tempfile_active(tempfile))
-		BUG("activate_tempfile called for active object");
-
 	if (!initialized) {
 		sigchain_push_common(remove_tempfiles_on_signal);
 		atexit(remove_tempfiles_on_exit);
@@ -134,12 +128,10 @@ static void activate_tempfile(struct tempfile *tempfile)
 
 	volatile_list_add(&tempfile->list, &tempfile_list);
 	tempfile->owner = getpid();
-	tempfile->active = 1;
 }
 
 static void deactivate_tempfile(struct tempfile *tempfile)
 {
-	tempfile->active = 0;
 	strbuf_release(&tempfile->filename);
 	volatile_list_del(&tempfile->list);
 	free(tempfile);
diff --git a/tempfile.h b/tempfile.h
index d7804a214a..f0bf59dbac 100644
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
