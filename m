From: Jeff King <peff@peff.net>
Subject: Re: 'git grep needle rev' attempts to access
 'rev:.../.gitattributes' in the worktree
Date: Tue, 9 Oct 2012 08:41:44 -0400
Message-ID: <20121009124144.GB12465@sigill.intra.peff.net>
References: <5073E87D.9020100@viscovery.net>
 <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
 <20121009120144.GA8780@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLZ8I-0000fz-UW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 14:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab2JIMls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 08:41:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45068 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab2JIMlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 08:41:47 -0400
Received: (qmail 32376 invoked by uid 107); 9 Oct 2012 12:42:20 -0000
Received: from wsip-70-169-140-85.hr.hr.cox.net (HELO sigill.intra.peff.net) (70.169.140.85)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Oct 2012 08:42:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2012 08:41:44 -0400
Content-Disposition: inline
In-Reply-To: <20121009120144.GA8780@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207319>

On Tue, Oct 09, 2012 at 07:01:44PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Oct 09, 2012 at 04:38:32PM +0700, Nguyen Thai Ngoc Duy wrote:
> > #5  0x0815e736 in userdiff_find_by_path (path=0x820e7f0
> > "HEAD:Documentation/.gitattributes") at userdiff.c:278
> > #6  0x081058ca in grep_source_load_driver (gs=0xbfffd978) at grep.c:1504
> 
> A bandage patch may look like this. But it does not solve the real
> problem:
> 
>  - we should be able to look up in-tree .gitattributes, not just
>    ignore like this patch does
> 
>  - gs->name seems to be prepared for human consumption, not for
>    accessing files. grep_file() with opt->relative is true can put
>    quotes in gs->name, for example.

Right. For the second, you would probably want gs->identifier in the
case of GREP_SOURCE_FILE. But that identifier information is not
available at all for GREP_SOURCE_SHA1, which is what is breaking the
first point.

> I feel like we should make this function a callback and let git-grep
> deal with driver loading itself.

I think we just need to have callers of grep_source_init provide us with
the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That is
where the information is lost.

Like this incomplete and untested patch, which should fix the quoting
problem for GREP_SOURCE_FILE, but leave the sha1 bits broken (see the
in-code comment). I'm traveling this week, so I doubt I'll have time to
look for a few more days. If you want to work on it, please do.

diff --git a/builtin/grep.c b/builtin/grep.c
index 82530a6..be602dd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -86,7 +86,7 @@ static void add_work(struct grep_opt *opt, enum grep_source_type type,
 static int skip_first_line;
 
 static void add_work(struct grep_opt *opt, enum grep_source_type type,
-		     const char *name, const void *id)
+		     const char *name, const char *path, const void *id)
 {
 	grep_lock();
 
@@ -94,7 +94,7 @@ static void add_work(struct grep_opt *opt, enum grep_source_type type,
 		pthread_cond_wait(&cond_write, &grep_mutex);
 	}
 
-	grep_source_init(&todo[todo_end].source, type, name, id);
+	grep_source_init(&todo[todo_end].source, type, name, path, id);
 	if (opt->binary != GREP_BINARY_TEXT)
 		grep_source_load_driver(&todo[todo_end].source);
 	todo[todo_end].done = 0;
@@ -378,14 +378,21 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 	if (opt->relative && opt->prefix_length) {
 		quote_path_relative(filename + tree_name_len, -1, &pathbuf,
 				    opt->prefix);
+		/* XXX Why do we insert here instead of just putting it in
+		 * first? */
 		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
 	} else {
 		strbuf_addstr(&pathbuf, filename);
 	}
 
+	/* XXX We seem to get all kinds of junk via the filename field here,
+	 * including partial filenames, sha1:path, etc. We could parse it
+	 * ourselves, but that is probably insanity. We should ask the
+	 * caller to break it down more for us. For now, just pass NULL. */
+
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, NULL, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -394,7 +401,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		grep_source_init(&gs, GREP_SOURCE_SHA1, pathbuf.buf, NULL, sha1);
 		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
@@ -414,7 +421,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename);
+		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		return 0;
 	} else
@@ -423,7 +430,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		struct grep_source gs;
 		int hit;
 
-		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename);
+		grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 		strbuf_release(&buf);
 		hit = grep_source(opt, &gs);
 
diff --git a/grep.c b/grep.c
index edc7776..06bc1c6 100644
--- a/grep.c
+++ b/grep.c
@@ -1373,7 +1373,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL);
+	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
 	gs.buf = buf;
 	gs.size = size;
 
@@ -1384,10 +1384,12 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 }
 
 void grep_source_init(struct grep_source *gs, enum grep_source_type type,
-		      const char *name, const void *identifier)
+		      const char *name, const char *path,
+		      const void *identifier)
 {
 	gs->type = type;
 	gs->name = name ? xstrdup(name) : NULL;
+	gs->path = path ? xstrdup(path) : NULL;
 	gs->buf = NULL;
 	gs->size = 0;
 	gs->driver = NULL;
@@ -1409,6 +1411,8 @@ void grep_source_clear(struct grep_source *gs)
 {
 	free(gs->name);
 	gs->name = NULL;
+	free(gs->path);
+	gs->path = NULL;
 	free(gs->identifier);
 	gs->identifier = NULL;
 	grep_source_clear_data(gs);
diff --git a/grep.h b/grep.h
index c256ac6..c2cf57b 100644
--- a/grep.h
+++ b/grep.h
@@ -158,11 +158,13 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	char *buf;
 	unsigned long size;
 
+	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
 };
 
 void grep_source_init(struct grep_source *gs, enum grep_source_type type,
-		      const char *name, const void *identifier);
+		      const char *name, const char *path,
+		      const void *identifier);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs);
