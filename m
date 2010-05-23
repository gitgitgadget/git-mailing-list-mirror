From: Jeff King <peff@peff.net>
Subject: Re: [tig PATCH] fix off-by-one on parent selection
Date: Sun, 23 May 2010 03:40:52 -0400
Message-ID: <20100523074051.GA16730@coredump.intra.peff.net>
References: <20100510085504.GA2283@coredump.intra.peff.net>
 <AANLkTim8cQ-1oBE-BOwbjTlyn2E2V64NvM_6Drs3kTAS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun May 23 09:41:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG5ny-0003rC-7t
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 09:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab0EWHk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 03:40:57 -0400
Received: from peff.net ([208.65.91.99]:60966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab0EWHk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 03:40:56 -0400
Received: (qmail 20812 invoked by uid 107); 23 May 2010 07:40:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 03:40:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 03:40:52 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim8cQ-1oBE-BOwbjTlyn2E2V64NvM_6Drs3kTAS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147555>

On Sat, May 22, 2010 at 01:19:12PM -0400, Jonas Fonseca wrote:

> > AFAICT, fixing it would mean improving iobuf_read to differentiate "no
> > output" from "there were errors". I'll leave that sort of infrastructure
> > refactoring to you if you want to do it. The resulting bug is quite
> > minor.
> 
> The spaced damaged patch below fixes the first error.
> --- >8 --- >8 --- >8 ---
> diff --git a/tig.c b/tig.c
> index 35b0cfa..f5bb1b9 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -1028,7 +1028,7 @@ io_read_buf(struct io *io, char buf[], size_t bufsize)
>                 string_ncopy_do(buf, bufsize, result, strlen(result));
>         }
> 
> -       return io_done(io) && result;
> +       return io_done(io) && !io_error(io);
>  }
> 
>  static bool
> --- 8< --- 8< --- 8< ---

Yeah, that works for me. I was hesitant to do it because I wasn't sure
if other callers were relying on that behavior, but it looks like all
calls properly check the output for sanity.

> However, it seems that the output of the command that was previously
> used for fetching parents and the current one pretty printing using
> the %P flag is also the cause of the breakage.
> 
> In the tig repository, trying to "blame" the parent of b801d8b2b shows
> reproduces the problem. Commit b801d8b2b replaced cgit.c with tig.c,
> which means there is no parent blame to show.
> 
> Before:
> > git rev-list -1 --parents b801d8b2b -- tig.c
> b801d8b2bc1a6aac6b9744f21f7a10a51e16c53e
> .. i.e no parents as expected.
> 
> Now:
> > git log --no-color -1 --pretty=format:%P b801d8b2b -- tig.c
> a7bc4b1447f974fbbe400c3657d9ec3d0fda133e
> .. i.e. the parent of b801d8b2b, but where tig.c does not exist.

This confused me at first, because those outputs should be the same, but
now I see: the pretty %P does not respect history simplification, so you
get the _true_ parent of b801d8b2b, and not the simplified one when
limiting history to 'tig.c'.

So yes, the rev-list version is better, because it at least realizes
that tig.c has no parent.

But I think neither is ideal. What we probably want is to detect the
rename between the two, and do the blame from the parent using cgit.c.
git-blame will already recognize content coming from another file and
give us that filename, but we are moving to the parent ourselves, so we
have to do that rename detection manually (IOW, this behavior triggers
_only_ when you are trying to blame the parent of a commit which
simultaneously introduced the line and moved the filename).

Patch is below. After writing it, I realized that tig.c is not
actually a rename of cgit.c (they are too dissimilar). It does provide
the correct "Path 'tig.c' does not exist in the parent". And you can see
the rename-following behavior with something like:

  perl -e 'print "$_\n" for 1..1000' >old
  git add . && git commit -m added
  perl -pe 's/^1$/foo/' <old >new
  git add new && git rm old && git commit -m moved

Now try "tig blame new". For all of the lines but the first, blaming the
parent gets you the correct "The selected commit has no parents". But
parent-blaming the first line will correctly re-blame using the filename
"old".

There are some possible optimizations that I didn't implement:

  1. With this patch, we always check for a rename to the parent. But we
     really only need to do so if the commit in question introduced the
     file. One way to detect that is by first running "git diff-tree
     $file", and only doing the rename detection if the file was added.
     We could also potentially use the rev-list in select_commit_parent
     to see that we have no parents. That would mean combining
     select_commit_parent and my new follow_parent_rename.

  2. The diff-tree could potentially be combined with the one we execute
     immediately after in setup_blame_parent_line. But I don't think it
     is worth it. In the rename-follow, we have to look at _all_ of the
     files, as they are potential sources. But in
     setup_blame_parent_line, we are generating diffs and can restrict
     our diff to only the file of interest. I don't think there is a way
     to say "consider all files as rename sources, but only show the
     patch for this one file".

diff --git a/tig.c b/tig.c
index 28679f9..cfa26ce 100644
--- a/tig.c
+++ b/tig.c
@@ -3991,12 +3991,12 @@ open_commit_parent_menu(char buf[SIZEOF_STR], int *parents)
 }
 
 static bool
-select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
+select_commit_parent(const char *id, char rev[SIZEOF_REV])
 {
 	char buf[SIZEOF_STR * 4];
 	const char *revlist_argv[] = {
 		"git", "log", "--no-color", "-1",
-			"--pretty=format:%P", id, "--", path, NULL
+			"--pretty=format:%P", id, "--", NULL
 	};
 	int parents;
 
@@ -4006,10 +4006,7 @@ select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
 		return FALSE;
 
 	} else if (parents == 0) {
-		if (path)
-			report("Path '%s' does not exist in the parent", path);
-		else
-			report("The selected commit has no parents");
+		report("The selected commit has no parents");
 		return FALSE;
 	}
 
@@ -4022,6 +4019,48 @@ select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
 	return TRUE;
 }
 
+static int
+follow_parent_rename(const char *id, const char *parent, const char *dest,
+		     char source[SIZEOF_STR])
+{
+	const char *diff_argv[] = {
+		"git", "diff-tree", "-z", "--name-status", "-M",
+		parent, id, "--", NULL
+	};
+	struct io io = {};
+	char *buf;
+
+	if (!io_run(&io, diff_argv, opt_cdup, IO_RD))
+		return FALSE;
+
+	while ((buf = io_get(&io, 0, TRUE))) {
+		int status = buf[0];
+
+		if (!(buf = io_get(&io, 0, TRUE)))
+			break;
+
+		if (status == 'A' && !strcmp(buf, dest)) {
+			report("Path '%s' does not exist in the parent", dest);
+			io_done(&io);
+			return FALSE;
+		}
+
+		if (status == 'R') {
+			string_ncopy_do(source, SIZEOF_STR, buf, strlen(buf));
+			if (!(buf = io_get(&io, 0, TRUE)))
+				break;
+			if (!strcmp(buf, dest)) {
+				io_done(&io);
+				return TRUE;
+			}
+		}
+	}
+
+	string_ncopy_do(source, SIZEOF_STR, dest, strlen(dest));
+	io_done(&io);
+	return TRUE;
+}
+
 /*
  * Pager backend
  */
@@ -5190,9 +5229,9 @@ blame_request(struct view *view, enum request request, struct line *line)
 
 	case REQ_PARENT:
 		if (check_blame_commit(blame, TRUE) &&
-		    select_commit_parent(blame->commit->id, opt_ref,
-					 blame->commit->filename)) {
-			string_copy(opt_file, blame->commit->filename);
+		    select_commit_parent(blame->commit->id, opt_ref) &&
+		    follow_parent_rename(blame->commit->id, opt_ref,
+					 blame->commit->filename, opt_file)) {
 			setup_blame_parent_line(view, blame);
 			open_view(view, REQ_VIEW_BLAME, OPEN_REFRESH);
 		}
