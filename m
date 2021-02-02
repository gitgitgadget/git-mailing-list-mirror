Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91014C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3534964EE2
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 10:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhBBK1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:27:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:44324 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBBK1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 05:27:35 -0500
Received: (qmail 12971 invoked by uid 109); 2 Feb 2021 10:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 10:26:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 907 invoked by uid 111); 2 Feb 2021 10:26:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 05:26:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 05:26:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 12/14] unix-socket: add no-chdir option to
 unix_stream_listen()
Message-ID: <YBko7m8TJgTm/7lQ@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <745b6d5fb74699b7fe7e32080b18779aa4a82547.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <745b6d5fb74699b7fe7e32080b18779aa4a82547.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:45PM +0000, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Calls to `chdir()` are dangerous in a multi-threaded context.  If
> `unix_stream_listen()` is given a socket pathname that is too big to
> fit in a `sockaddr_un` structure, it will `chdir()` to the parent
> directory of the requested socket pathname, create the socket using a
> relative pathname, and then `chdir()` back.  This is not thread-safe.
> 
> Add `disallow_chdir` flag to `struct unix_sockaddr_context` and change
> all callers to pass an initialized context structure.
> 
> Teach `unix_sockaddr_init()` to not allow calls to `chdir()` when flag
> is set.

Makes sense, and it fits nicely into the options pattern you set up in
the earlier patch.

>  struct unix_sockaddr_context {
>  	char *orig_dir;
> +	unsigned int disallow_chdir:1;
>  };
>  
> +#define UNIX_SOCKADDR_CONTEXT_INIT \
> +{ \
> +	.orig_dir=NULL, \
> +	.disallow_chdir=0, \
> +}

It is really just zero-initializing, so "{ 0 }" would be OK (I think we
are relaxed about allowing 0 as NULL in initializers). But I don't mind
it being written out (but do mind whitespace around the "=").

However, the point of unix_sockaddr_init() is that it's supposed to
initialize the struct. And I don't think we need to carry disallow_chdir
around; the cleanup function knows from orig_dir whether it's supposed
to do any cleanup, so only the init function has to care. So would:

diff --git a/unix-socket.c b/unix-socket.c
index 19ed48be99..0eb14faf54 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -36,16 +36,23 @@ static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 }
 
 static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
-			      struct unix_sockaddr_context *ctx)
+			      struct unix_sockaddr_context *ctx,
+			      int disallow_chdir)
 {
 	int size = strlen(path) + 1;
 
 	ctx->orig_dir = NULL;
 	if (size > sizeof(sa->sun_path)) {
-		const char *slash = find_last_dir_sep(path);
+		const char *slash;
 		const char *dir;
 		struct strbuf cwd = STRBUF_INIT;
 
+		if (disallow_chdir) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+
+		slash = find_last_dir_sep(path);
 		if (!slash) {
 			errno = ENAMETOOLONG;
 			return -1;

make it more obvious? There are only two callers, and this is all
file-local, so I don't mind adding the extra parameter there. And you
would not need an initializer at all.

>  #define UNIX_STREAM_LISTEN_OPTS_INIT \
>  { \
>  	.listen_backlog_size = 5, \
>  	.force_unlink_before_bind = 1, \
> +	.disallow_chdir = 0, \
>  }

I don't know if we care, but some options are positive "do this unlink"
and some are negative "do not do this chdir". Those could be made
consistent (and flip the initializer value to keep the same defaults).

There is actually value in making struct defaults generally "0" unless
we have reason not to, because callers sometimes zero-initialize without
thinking about it. I doubt that would happen for this particular struct,
and I'm deep into bike-shedding anyway, so I'm OK either way. But
something like:

  struct unix_stream_listen_opts_init {
	int listen_backlog_size;
	int disallow_unlink;
	int disallow_chdir;
  };

would work with just a "{ 0 }" zero-initializer. :)

-Peff
