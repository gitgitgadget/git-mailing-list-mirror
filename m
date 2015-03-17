From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Mar 2015 22:40:05 -0400
Message-ID: <20150317024005.GA26313@peff.net>
References: <20150316142026.GJ7847@inner.h.apk.li>
 <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
 <20150316184040.GA8902@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 03:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXhQU-0001rT-TS
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 03:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbbCQCkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 22:40:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:33849 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750839AbbCQCkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 22:40:08 -0400
Received: (qmail 11835 invoked by uid 102); 17 Mar 2015 02:40:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Mar 2015 21:40:08 -0500
Received: (qmail 21549 invoked by uid 107); 17 Mar 2015 02:40:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Mar 2015 22:40:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Mar 2015 22:40:05 -0400
Content-Disposition: inline
In-Reply-To: <20150316184040.GA8902@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265603>

[+cc Michael for get_ref_cache wisdom]

On Mon, Mar 16, 2015 at 07:40:40PM +0100, Andreas Krey wrote:

> >I am guessing that the repository has tons
> > of submodules?
> 
> Not a single one. Thats's thie interesting thing that
> makes me think I'm not actually solving the right problem.
> 
> This repo has about 100k subdirectories that are ignored
> (I don't know whether directly or within ignored dirs),
> and strace said that git looks for '.git/HEAD' and one
> other file in each of these. Apparently it trieds to
> find out if any of these dirs happen to be a git repo
> which git clean treats specially, but it seems it also
> calls get_ref_cache for each of these dires even though
> the turn out not to be a sub-repo.
> 
> In other words: I suspect that get_ref_cache shouldn't
> be called that often, or that the cache entries should
> be removed once a directory is found not to be a sub repo.
> Then the linear list wouldn't really hurt.

Yeah, I'd agree.

The get_ref_cache code was designed to scale to the actual number of
submodules. I do not mind seeing it become a hash if people really do
have a large number of submodules, but that is not what is happening
here.

Bisecting, it looks like things got slow for your case starting in
f538a91 (git-clean: Display more accurate delete messages, 2013-01-11).
I reproduced with basically:

  git init
  for i in $(seq 30000); do mkdir $i; done
  time git clean -nd >/dev/null

It jumps in that commit from ~50ms to ~3000ms.

A backtrace from get_ref_cache shows:

  #0  get_ref_cache (submodule=0xa6a4f0 "1") at refs.c:1070
  #1  0x0000000000516469 in resolve_gitlink_ref (path=0xa6a4d0 "1/", refname=0x584822 "HEAD", 
      sha1=0x7fffffffde90 "\002") at refs.c:1429
  #2  0x0000000000423584 in remove_dirs (path=0x7fffffffe2f0, prefix=0x0, force_flag=2, dry_run=1, quiet=0, 
      dir_gone=0x7fffffffe314) at builtin/clean.c:164
  #3  0x00000000004255a9 in cmd_clean (argc=0, argv=0x7fffffffe5e0, prefix=0x0) at builtin/clean.c:981
  #4  0x0000000000405554 in run_builtin (p=0x7f7b18 <commands+408>, argc=2, argv=0x7fffffffe5e0) at git.c:348
  #5  0x0000000000405761 in handle_builtin (argc=2, argv=0x7fffffffe5e0) at git.c:530
  #6  0x000000000040587d in run_argv (argcp=0x7fffffffe4cc, argv=0x7fffffffe4d8) at git.c:576
  #7  0x0000000000405a6e in main (argc=2, av=0x7fffffffe5d8) at git.c:685

So git-clean speculatively asks "what is HEAD in this maybe-submodule?". The
right solution is probably one of:

  1. In remove_dirs, find out if we have an actual submodule before calling
     resolve_gitlink_ref.

  2. Teach get_ref_cache a "read-only" mode that will not auto-vivify the cache
     if it does not already exist.

Of the two, I think (1) is probably cleaner (I think the way the ref
code is structured, we have to create the submodule ref_cache in order
to start looking things up in it).

It looks like we don't even really care about the value of HEAD. We just
want to know "is it a git directory?". I think in other places (like
"git add"), we just do an existence check for "$dir/.git". That would
not catch a bare repository, but I do not think the current check does
either (it is looking for submodules, which always have a .git).

Maybe something like (largely untested):

diff --git a/builtin/clean.c b/builtin/clean.c
index 98c103f..e2cc47b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -148,6 +148,32 @@ static int exclude_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int dir_is_repo(struct strbuf *path)
+{
+	size_t orig = path->len;
+	int ret;
+
+	strbuf_addstr(path, "/.git");
+	if (!access(path->buf, F_OK))
+		ret = 1; /* definitely */
+	else if (errno == ENOENT)
+		ret = 0; /* definitely not */
+	else {
+		/*
+		 * We couldn't tell. It would probably be safer to err
+		 * on the side of saying "yes" here, because we are
+		 * deciding what to delete, and are more likely to keep
+		 * a sub-repo. But it would probably also create annoying
+		 * false positives, where a directory we do not have
+		 * permission to read would say something misleading
+		 * like "not deleting sub-repo foo..."
+		 */
+		ret = 0;
+	}
+	strbuf_setlen(path, orig);
+	return ret;
+}
+
 static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 		int dry_run, int quiet, int *dir_gone)
 {
@@ -155,13 +181,11 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct strbuf quoted = STRBUF_INIT;
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
-	unsigned char submodule_head[20];
 	struct string_list dels = STRING_LIST_INIT_DUP;
 
 	*dir_gone = 1;
 
-	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-			!resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
+	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && dir_is_repo(path)) {
 		if (!quiet) {
 			quote_path_relative(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
