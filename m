Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847F2C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 11:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiI0Lom (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiI0Loj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 07:44:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1DA277
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:44:37 -0700 (PDT)
Received: (qmail 30981 invoked by uid 109); 27 Sep 2022 11:44:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Sep 2022 11:44:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18189 invoked by uid 111); 27 Sep 2022 11:44:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Sep 2022 07:44:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Sep 2022 07:44:35 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Message-ID: <YzLiI1HZeBszsIJq@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 11:53:03PM +0000, John Cai via GitGitGadget wrote:

> One place we call tmp_objdir_create() is in git-receive-pack, where
> we create a temporary quarantine directory "incoming". Incoming
> objects will be written to this directory before they get moved to
> the object directory.
> 
> We have observed this code leading to a deadlock:
> 
> 	Thread 1 (Thread 0x7f621ba0b200 (LWP 326305)):
> 	#0  __lll_lock_wait_private (futex=futex@entry=0x7f621bbf8b80
> 		<main_arena>) at ./lowlevellock.c:35
> 	#1  0x00007f621baa635b in __GI___libc_malloc
> 		(bytes=bytes@entry=32816) at malloc.c:3064
> 	#2  0x00007f621bae9f49 in __alloc_dir (statp=0x7fff2ea7ed60,
> 		flags=0, close_fd=true, fd=5)
> 		at ../sysdeps/posix/opendir.c:118
> 	#3  opendir_tail (fd=5) at ../sysdeps/posix/opendir.c:69
> 	#4  __opendir (name=<optimized out>)
> 		at ../sysdeps/posix/opendir.c:92
> 	#5  0x0000557c19c77de1 in remove_dir_recurse ()
> 	#6  0x0000557c19d81a4f in remove_tmp_objdir_on_signal ()
> 	#7  <signal handler called>

Yuck. Your analysis looks right, and certainly opendir() can't really
work without allocating memory for the pointer-to-DIR.

> To prevent this, add a flag REMOVE_DIR_SIGNAL that allows
> remove_dir_recurse() to know that a signal is being handled and avoid
> calling opendir(3). One implication of this change is that when
> signal handling, the temporary directory may not get cleaned up
> properly.

It's not really "may not" here, is it? It will never get cleaned up on a
signal now. I don't think remove_dir_recursively() will try to rmdir()
in this case. But even if it did, we'll always have a "pack"
subdirectory (minus the small race before we've created it).

That's unfortunate, but I don't think we really have a portable
alternative. We can't keep an exact list of files to be deleted, because
some of them will be created by sub-processes. We could perhaps exec a
helper that does the deletion, but that seems like a race and
portability nightmare. On Linux, we could probably use open() and
getdents64() to traverse, but obviously that won't work everywhere. It
_might_ be worth having some kind of compat/ wrapper here, to let
supported systems do as good a job as they can. But it's not like there
aren't already cases where we might leave the tmp-objdir directory
around (say, SIGKILL), so this is really just extending the existing
problem to more signals.

I was going to suggest we should do a better job of cleaning up these
directories via git-gc. But it looks like b3cecf49ea (tmp-objdir: new
API for creating temporary writable databases, 2021-12-06) changed the
default name such that a regular git-gc should do so. So I think we're
covered there.

The main case we care about is normal exit when index-pack or a hook
sees an error, in which case we should still be cleaning up via the
atexit() handler.

So I think your patch is going in the right direction, but...

>  static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  {
> -	DIR *dir;
> +	DIR *dir = NULL;
>  	struct dirent *e;
>  	int ret = 0, original_len = path->len, len, kept_down = 0;
>  	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
> @@ -3261,7 +3261,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
>  	}
>  
>  	flag &= ~REMOVE_DIR_KEEP_TOPLEVEL;
> -	dir = opendir(path->buf);
> +
> +	if ((flag & REMOVE_DIR_SIGNAL) == 0)
> +		dir = opendir(path->buf);
> +
>  	if (!dir) {
>  		if (errno == ENOENT)
>  			return keep_toplevel ? -1 : 0;

We skip calling opendir() entirely, so "dir" will still be NULL. But we
immediately start looking at errno, which will have some undefined value
(based on some previous syscall).

If we set "errno" to "EACCES" in this case, then we'd at least hit the
rmdir() below:

         if (!dir) {
                  if (errno == ENOENT)
                          return keep_toplevel ? -1 : 0;
                  else if (errno == EACCES && !keep_toplevel)
                          /*
                           * An empty dir could be removable even if it
                           * is unreadable:
                           */
                          return rmdir(path->buf);
                  else
                          return -1;
          }

but we know it won't really do anything for our proposed caller, since
it will have files inside the directory that need to be removed before
rmdir() can work.

Moreover, if you were to combine REMOVE_DIR_SIGNAL with
REMOVE_DIR_KEEP_NESTED_GIT, I suspect that the call to
resolve_gitlink_ref() would end up with similar deadlocks. Obviously
nobody is proposing to do that, but it is a pitfall in the API.

So all of that makes me think we should not add a new flag here, but
instead just avoid calling the function entirely from
tmp_objdir_destroy_1().

But then we can observe that tmp_objdir_destroy_1() is basically doing
nothing if on_signal is set. So there is really no point in setting up
the signal handler at all. We should just set up the atexit() handler.
I.e., something like:

diff --git a/tmp-objdir.c b/tmp-objdir.c
index a8be92bca1..10549e95db 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -169,7 +169,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	the_tmp_objdir = t;
 	if (!installed_handlers) {
 		atexit(remove_tmp_objdir);
-		sigchain_push_common(remove_tmp_objdir_on_signal);
 		installed_handlers++;
 	}
 

with the commit message explaining that we can't do the cleanup in a
portable and signal-safe way, so we just punt on the whole concept.

There's also some minor cleanup we could do elsewhere to drop the
"on_signal" argument (which can come as part of the same patch, or on
top).

-Peff
