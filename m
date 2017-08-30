Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33951F4DD
	for <e@80x24.org>; Wed, 30 Aug 2017 04:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdH3Ez6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 00:55:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750756AbdH3Ez6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 00:55:58 -0400
Received: (qmail 31931 invoked by uid 109); 30 Aug 2017 04:55:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 04:55:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15927 invoked by uid 111); 30 Aug 2017 04:56:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 00:56:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 00:55:55 -0400
Date:   Wed, 30 Aug 2017 00:55:55 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
References: <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
 <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
 <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
 <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 12:31:47AM -0400, Jeff King wrote:

> > It was surprisingly hard trying to get that code to do the right thing,
> > non-racily, in every error path. Since `remove_tempfiles()` can be
> > called any time (even from a signal handler), the linked list of
> > `tempfile` objects has to be kept valid at all times but can't use
> > mutexes. I didn't have the energy to keep going and make the lock
> > objects freeable.
> > 
> > I suppose the task could be made a bit easier by using `sigprocmask(2)`
> > or `pthread_sigmask(3)` to make its running environment a little bit
> > less hostile.
> 
> I think there are really two levels of carefulness here:
> 
>   1. Avoiding complicated things during a signal handler that may rely
>      on having a sane state from the rest of the program (e.g.,
>      half-formed entries, stdio locks, etc).
> 
>   2. Being truly race-free in the face of a signal arriving while we're
>      running arbitrary code that might have a tempfile struct in a funny
>      state.
> 
> I feel like right now we meet (1) and not (2). But I think if we keep to
> that lower bar of (1), it might not be that bad. We're assuming now that
> there's no race on the tempfile->active flag, for instance. We could
> probably make a similar assumption about putting items onto or taking
> them off of a linked list (it's not really atomic, but a single pointer
> assignment is probably "atomic enough" for our purposes).

Something like this, which AFAICT is about as safe as the existing code
in its list manipulation. It retains the "active" flag as an additional
check which I think isn't strictly necessary, but potentially catches
some logic errors.

The strbuf_reset() calls become strbuf_release(), since we're promising
the caller that they could now free the struct (or let it go out of
scope) if they chose. Probably during a signal handler we should skip
that (we know the struct is off the list and non-active at that point,
but we could possibly hit libc's free() mutex).

diff --git a/tempfile.c b/tempfile.c
index 6843710670..a7d964ebf8 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -69,7 +69,6 @@ static void remove_tempfiles(int skip_fclose)
 				tempfile_list->fp = NULL;
 			delete_tempfile(tempfile_list);
 		}
-		tempfile_list = tempfile_list->next;
 	}
 }
 
@@ -85,39 +84,54 @@ static void remove_tempfiles_on_signal(int signo)
 	raise(signo);
 }
 
-/*
- * Initialize *tempfile if necessary and add it to tempfile_list.
- */
-static void prepare_tempfile_object(struct tempfile *tempfile)
+static void init_tempfile(struct tempfile *tempfile)
+{
+	tempfile->fd = -1;
+	tempfile->fp = NULL;
+	tempfile->active = 0;
+	tempfile->owner = 0;
+	tempfile->next = NULL;
+	strbuf_init(&tempfile->filename, 0);
+}
+
+static void activate_tempfile(struct tempfile *tempfile)
 {
-	if (!tempfile_list) {
-		/* One-time initialization */
+	static volatile int initialized;
+
+	if (!initialized) {
 		sigchain_push_common(remove_tempfiles_on_signal);
 		atexit(remove_tempfiles_on_exit);
+		initialized = 1;
 	}
 
 	if (tempfile->active)
-		die("BUG: prepare_tempfile_object called for active object");
-	if (!tempfile->on_list) {
-		/* Initialize *tempfile and add it to tempfile_list: */
-		tempfile->fd = -1;
-		tempfile->fp = NULL;
-		tempfile->active = 0;
-		tempfile->owner = 0;
-		strbuf_init(&tempfile->filename, 0);
-		tempfile->next = tempfile_list;
-		tempfile_list = tempfile;
-		tempfile->on_list = 1;
-	} else if (tempfile->filename.len) {
-		/* This shouldn't happen, but better safe than sorry. */
-		die("BUG: prepare_tempfile_object called for improperly-reset object");
+		die("BUG: activate_tempfile called for active object");
+
+	tempfile->next = tempfile_list;
+	tempfile_list = tempfile;
+	tempfile->active = 1;
+}
+
+static void deactivate_tempfile(struct tempfile *tempfile)
+{
+	struct tempfile *volatile *p;
+
+	if (!tempfile->active)
+		return;
+
+	tempfile->active = 0;
+	for (p = &tempfile_list; *p; p = &(*p)->next) {
+		if (*p == tempfile) {
+			*p = tempfile->next;
+			break;
+		}
 	}
 }
 
 /* Make sure errno contains a meaningful value on error */
 int create_tempfile(struct tempfile *tempfile, const char *path)
 {
-	prepare_tempfile_object(tempfile);
+	init_tempfile(tempfile);
 
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->fd = open(tempfile->filename.buf,
@@ -127,11 +141,11 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 		tempfile->fd = open(tempfile->filename.buf,
 				    O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		strbuf_release(&tempfile->filename);
 		return -1;
 	}
 	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	if (adjust_shared_perm(tempfile->filename.buf)) {
 		int save_errno = errno;
 		error("cannot fix permission bits on %s", tempfile->filename.buf);
@@ -144,25 +158,25 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 
 void register_tempfile(struct tempfile *tempfile, const char *path)
 {
-	prepare_tempfile_object(tempfile);
+	init_tempfile(tempfile);
 	strbuf_add_absolute_path(&tempfile->filename, path);
 	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 }
 
 int mks_tempfile_sm(struct tempfile *tempfile,
 		    const char *template, int suffixlen, int mode)
 {
-	prepare_tempfile_object(tempfile);
+	init_tempfile(tempfile);
 
 	strbuf_add_absolute_path(&tempfile->filename, template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		strbuf_release(&tempfile->filename);
 		return -1;
 	}
 	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	return tempfile->fd;
 }
 
@@ -171,7 +185,7 @@ int mks_tempfile_tsm(struct tempfile *tempfile,
 {
 	const char *tmpdir;
 
-	prepare_tempfile_object(tempfile);
+	init_tempfile(tempfile);
 
 	tmpdir = getenv("TMPDIR");
 	if (!tmpdir)
@@ -180,11 +194,11 @@ int mks_tempfile_tsm(struct tempfile *tempfile,
 	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, template);
 	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
 	if (tempfile->fd < 0) {
-		strbuf_reset(&tempfile->filename);
+		strbuf_release(&tempfile->filename);
 		return -1;
 	}
 	tempfile->owner = getpid();
-	tempfile->active = 1;
+	activate_tempfile(tempfile);
 	return tempfile->fd;
 }
 
@@ -293,8 +307,8 @@ int rename_tempfile(struct tempfile *tempfile, const char *path)
 		return -1;
 	}
 
-	tempfile->active = 0;
-	strbuf_reset(&tempfile->filename);
+	deactivate_tempfile(tempfile);
+	strbuf_release(&tempfile->filename);
 	return 0;
 }
 
@@ -305,7 +319,7 @@ void delete_tempfile(struct tempfile *tempfile)
 
 	if (!close_tempfile(tempfile)) {
 		unlink_or_warn(tempfile->filename.buf);
-		tempfile->active = 0;
-		strbuf_reset(&tempfile->filename);
+		deactivate_tempfile(tempfile);
+		strbuf_release(&tempfile->filename);
 	}
 }
diff --git a/tempfile.h b/tempfile.h
index 2f0038decd..df96f82e84 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -85,7 +85,6 @@ struct tempfile {
 	volatile int fd;
 	FILE *volatile fp;
 	volatile pid_t owner;
-	char on_list;
 	struct strbuf filename;
 };
 
