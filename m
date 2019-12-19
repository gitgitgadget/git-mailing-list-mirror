Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E6FC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD92465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfLSWYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:24:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:50754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726866AbfLSWYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:24:05 -0500
Received: (qmail 26928 invoked by uid 109); 19 Dec 2019 22:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Dec 2019 22:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7724 invoked by uid 111); 19 Dec 2019 22:28:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Dec 2019 17:28:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Dec 2019 17:24:03 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v4 6/8] dir: fix checks on common prefix directory
Message-ID: <20191219222403.GA705525@coredump.intra.peff.net>
References: <pull.676.v3.git.git.1576571586.gitgitgadget@gmail.com>
 <pull.676.v4.git.git.1576697386.gitgitgadget@gmail.com>
 <1f3978aa461929923eeb5037e69be6569f0ba331.1576697386.git.gitgitgadget@gmail.com>
 <xmqq1rt1e30q.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHhAPjL9daPdp7UmVT+vLrcpo6SX0rKt5s1bH4Vz31wxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 19, 2019 at 12:23:29PM -0800, Elijah Newren wrote:

> > >       while (len && path[len - 1] == '/')
> > >               len--;
> > >       if (!len)
> > >               return 1;
> > > +
> > > +     de = xcalloc(1, sizeof(struct dirent)+len+1);
> >
> > That "+len+1" may deserve a comment?
> 
> Good point, I'll add one and send a re-roll.

Please use st_add3() while you are at it.

I'd also usually suggest FLEX_ALLOC_MEM() for even more simplicity, but
it looks like filling the string is handled separately (and done many
times).

I have to wonder, though, if it wouldn't be simpler to move away from
"struct dirent" here (and it looks like Junio suggested the same earlier
in the thread). I don't know this code very well, but it looks
like it could easily get by passing around a name pointer and a dtype
through the cached_dir. The patch below seems like it's not too bad a
cleanup, but possibly the names could be better.

---
 dir.c | 48 ++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index 43e2f47f66..e1cba688f3 100644
--- a/dir.c
+++ b/dir.c
@@ -41,7 +41,8 @@ struct cached_dir {
 	int nr_files;
 	int nr_dirs;
 
-	struct dirent *de;
+	const char *d_name;
+	int d_type;
 	const char *file;
 	struct untracked_cache_dir *ucd;
 };
@@ -50,8 +51,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *path, int len,
 	struct untracked_cache_dir *untracked,
 	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
-static int get_dtype(struct dirent *de, struct index_state *istate,
-		     const char *path, int len);
+static int resolve_dtype(int dtype, struct index_state *istate,
+			 const char *path, int len);
 
 int count_slashes(const char *s)
 {
@@ -1050,8 +1051,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		int prefix = pattern->nowildcardlen;
 
 		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
-			if (*dtype == DT_UNKNOWN)
-				*dtype = get_dtype(NULL, istate, pathname, pathlen);
+			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
@@ -1639,10 +1639,9 @@ static int get_index_dtype(struct index_state *istate,
 	return DT_UNKNOWN;
 }
 
-static int get_dtype(struct dirent *de, struct index_state *istate,
-		     const char *path, int len)
+static int resolve_dtype(int dtype, struct index_state *istate,
+			 const char *path, int len)
 {
-	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
@@ -1667,14 +1666,13 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  int baselen,
 					  const struct pathspec *pathspec,
-					  int dtype, struct dirent *de)
+					  int dtype)
 {
 	int exclude;
 	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
 	enum path_treatment path_treatment;
 
-	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, istate, path->buf, path->len);
+	dtype = resolve_dtype(dtype, istate, path->buf, path->len);
 
 	/* Always exclude indexed files */
 	if (dtype != DT_DIR && has_path_in_index)
@@ -1782,21 +1780,18 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      int baselen,
 				      const struct pathspec *pathspec)
 {
-	int dtype;
-	struct dirent *de = cdir->de;
-
-	if (!de)
+	if (!cdir->d_name)
 		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
-	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
+	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
-	strbuf_addstr(path, de->d_name);
+	strbuf_addstr(path, cdir->d_name);
 	if (simplify_away(path->buf, path->len, pathspec))
 		return path_none;
 
-	dtype = DTYPE(de);
-	return treat_one_path(dir, untracked, istate, path, baselen, pathspec, dtype, de);
+	return treat_one_path(dir, untracked, istate, path, baselen, pathspec,
+			      cdir->d_type);
 }
 
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
@@ -1884,10 +1879,17 @@ static int open_cached_dir(struct cached_dir *cdir,
 
 static int read_cached_dir(struct cached_dir *cdir)
 {
+	struct dirent *de;
+
 	if (cdir->fdir) {
-		cdir->de = readdir(cdir->fdir);
-		if (!cdir->de)
+		de = readdir(cdir->fdir);
+		if (!de) {
+			cdir->d_name = NULL;
+			cdir->d_type = DT_UNKNOWN;
 			return -1;
+		}
+		cdir->d_name = de->d_name;
+		cdir->d_type = DTYPE(de);
 		return 0;
 	}
 	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
@@ -1970,7 +1972,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 (resolve_dtype(cdir.d_type, istate, path.buf, path.len) == DT_DIR) &&
 			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 			  (pathspec &&
 			   do_match_pathspec(istate, pathspec, path.buf, path.len,
@@ -2103,7 +2105,7 @@ static int treat_leading_path(struct dir_struct *dir,
 		if (simplify_away(sb.buf, sb.len, pathspec))
 			break;
 		if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
-				   DT_DIR, NULL) == path_none)
+				   DT_DIR) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
 			rc = 1;
