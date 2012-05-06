From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] correct git-status Porcelain Format documentation
Date: Sun, 6 May 2012 09:51:42 -0400
Message-ID: <20120506135141.GA17176@sigill.intra.peff.net>
References: <20120506132959.GA28214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zak Johnson <zakj@nox.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 15:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR1sl-0006hT-Lc
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 15:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab2EFNvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 09:51:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59677
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2EFNvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 09:51:43 -0400
Received: (qmail 11424 invoked by uid 107); 6 May 2012 13:52:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 09:52:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 09:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20120506132959.GA28214@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197187>

[+cc Zak, who I forgot in the first email]

On Sun, May 06, 2012 at 09:29:59AM -0400, Jeff King wrote:

> From: Zak Johnson <zakj@nox.cx>
> 
> The existing documentation implies that "git status --porcelain" has a branch
> line while "git status --porcelain -z" does not; in fact, neither includes a
> branch line.
> 
> Signed-off-by: Zak Johnson <zakj@nox.cx>
> ---
> This was forward to me by the original author, who had trouble posting
> to the list. So I'm trying it (I didn't see anything from the taboo list
> in the patch, but we'll see...).
> 
> The patch itself looks obviously correct and describes the current
> behavior. But I have to wonder: the --short format will also not produce
> the branch line unless you provide "-b". So why is it that the porcelain
> format does not respect "-b", since anybody who asked for it would
> obviously be expecting to find and parse it?
> 
> Should this bit of documentation be dropped in favor of just making "-b"
> work properly?

So that patch could look like the one below. But that brings up new
confusion.

What should "git status --porcelain -z -b" look like? With my patch, it
prints the branch-line with only a newline, not respecting the NUL
termination. Which sounds like a bug, except that's what happens _now_
with "git status --short -z -b".  Which seems like a bug to me, but
maybe somebody is relying on that. It seems kind of broken to me.

Also, while looking at the documentation, we say of "-z": "This implies
the --porcelain output format if no other format is given". But the only
other format you could give is "--short", since there is no way to ask
for the long output (and nor do we handle NUL-termination in that code,
anyway). Should this be simplified to just "this implies porcelain"?
That would technically break somebody who wanted their
status.relativePaths config option respected. But it kind of seems crazy
to me.

-- >8 --
Subject: [PATCH] status: respect "-b" for porcelain format

There is no reason not to, as the user has to explicitly ask
for it, so we are not breaking compatibility by doing so.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-status.txt | 2 +-
 builtin/commit.c             | 4 ++--
 t/t7508-status.sh            | 8 ++++++--
 wt-status.c                  | 5 +++--
 wt-status.h                  | 2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2883a28..67e5f53 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -184,7 +184,7 @@ order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-backslash-escaping is performed. Fourth, there is no branch line.
+backslash-escaping is performed.
 
 CONFIGURATION
 -------------
diff --git a/builtin/commit.c b/builtin/commit.c
index a876a73..0e898e6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -504,7 +504,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		wt_shortstatus_print(s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(s, null_termination);
+		wt_porcelain_print(s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -1287,7 +1287,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_shortstatus_print(&s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_porcelain_print(&s, null_termination);
+		wt_porcelain_print(&s, null_termination, status_show_branch);
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8f5cfac..695b6a8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -671,11 +671,15 @@ test_expect_success 'status --porcelain ignores color.status' '
 git config --unset color.status
 git config --unset color.ui
 
-test_expect_success 'status --porcelain ignores -b' '
+test_expect_success 'status --porcelain respects -b' '
 
 	git status --porcelain -b >output &&
+	{
+		echo "## master" &&
+		cat expect
+	} >tmp &&
+	mv tmp expect &&
 	test_cmp expect output
-
 '
 
 cat >expect <<\EOF
diff --git a/wt-status.c b/wt-status.c
index eeef17e..7d2dbcd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -973,10 +973,11 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_br
 	}
 }
 
-void wt_porcelain_print(struct wt_status *s, int null_termination)
+void wt_porcelain_print(struct wt_status *s, int null_termination,
+			int show_branch)
 {
 	s->use_color = 0;
 	s->relative_paths = 0;
 	s->prefix = NULL;
-	wt_shortstatus_print(s, null_termination, 0);
+	wt_shortstatus_print(s, null_termination, show_branch);
 }
diff --git a/wt-status.h b/wt-status.h
index 6dd7207..b8e8758 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -74,7 +74,7 @@ void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s, int null_termination, int show_branch);
-void wt_porcelain_print(struct wt_status *s, int null_termination);
+void wt_porcelain_print(struct wt_status *s, int null_termination, int show_branch);
 
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...)
 	;
-- 
1.7.10.1.14.gb97aca1
