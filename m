From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 16:41:52 -0500
Message-ID: <20100120214152.GC9107@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <20100120203636.GA9221@gnu.kitenet.net>
 <20100120205452.GA8843@coredump.intra.peff.net>
 <7viqaw1ohx.fsf@alter.siamese.dyndns.org>
 <20100120213137.GA9107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:42:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiJM-0002p7-4R
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab0ATVl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819Ab0ATVlz
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:41:55 -0500
Received: from peff.net ([208.65.91.99]:41382 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab0ATVly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:41:54 -0500
Received: (qmail 10141 invoked by uid 107); 20 Jan 2010 21:46:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 16:46:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 16:41:52 -0500
Content-Disposition: inline
In-Reply-To: <20100120213137.GA9107@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137587>

On Wed, Jan 20, 2010 at 04:31:38PM -0500, Jeff King wrote:

> We can start with this patch, which clears up Joey's problem.
> 
> -- >8 --
> Subject: [PATCH] don't show notes for --pretty=raw
> 
> The --pretty=raw format of the log family is likely to be
> used by scripts. Such scripts may parse the output into
> records on blank lines, since doing so in the past has
> always worked. However, with the recently added notes
> output, such parsers will see an extra stanza for any
> commits that have notes.
> 
> This patch turns off the notes output for the raw format to
> avoid breaking such scripts.

And the second half would be something like the patch below implementing
--show-notes, so that things like "gitk" which can handle the new
feature can turn it on.

I'm not that happy with this patch, though. If we have --show-notes, we
should probably have --no-show-notes, which this doesn't do, since a
lack of --show-notes simply means "do whatever the format dictates".

Also, passing everything through a pretty_print_context seems kind of
hack-ish, as we just end up copying items from the rev-list context into
the pp_context. I did so here only in the log_tree_commit case. I don't
think there are other places which would want to propagate it, but I
might have missed one. I wonder if we would do better to simply past the
rev-list options into pretty_print_commit and let it pick what it wants
out of the struct.

Anyway, I am out of time to work on git for now, so maybe somebody who
cares more about notes can pick this up. I think the first patch (the
one I am replying to) should definitely go in to un-break Joey's case
(or an alternative patch that turns it off in even more cases), and
people who care about it can fight about whether and by what mechanism
things like gitk should see the notes.

-- >8 --
Subject: [PATCH] teach log family to --show-notes

Most log formats will implicitly show commit notes, but the
raw format will not. Callers can now explicitly call
--show-notes to enable them.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.h         |    1 +
 log-tree.c       |    1 +
 pretty.c         |    3 ++-
 revision.c       |    2 ++
 revision.h       |    1 +
 t/t3301-notes.sh |   16 ++++++++++++++++
 6 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/commit.h b/commit.h
index 24128d7..4646751 100644
--- a/commit.h
+++ b/commit.h
@@ -71,6 +71,7 @@ struct pretty_print_context
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	struct reflog_walk_info *reflog_info;
+	int show_notes;
 };
 
 extern int has_non_ascii(const char *text);
diff --git a/log-tree.c b/log-tree.c
index 0fdf159..9155a31 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -412,6 +412,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+	ctx.show_notes = opt->show_notes;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 0674027..95fe39a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1094,7 +1094,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW)
+	if (context->show_notes ||
+	    (fmt != CMIT_FMT_ONELINE && fmt != CMIT_FMT_RAW))
 		get_commit_notes(commit, sb, encoding,
 				 NOTES_SHOW_HEADER | NOTES_INDENT);
 
diff --git a/revision.c b/revision.c
index 7328201..3815dd3 100644
--- a/revision.c
+++ b/revision.c
@@ -1175,6 +1175,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
 		revs->abbrev_commit = 1;
+	} else if (!strcmp(arg, "--show-notes")) {
+		revs->show_notes = 1;
 	} else if (!strcmp(arg, "--graph")) {
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
diff --git a/revision.h b/revision.h
index d368003..e51842f 100644
--- a/revision.h
+++ b/revision.h
@@ -83,6 +83,7 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
+			show_notes:1,
 			date_mode_explicit:1;
 	unsigned int	disable_stdin:1;
 
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 4c3de9d..d51e8bd 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -161,4 +161,20 @@ test_expect_success 'git log --pretty=raw does not show notes' '
 	test_cmp expect output
 '
 
+cat >>expect <<EOF
+
+Notes:
+    spam
+$whitespace
+    xyzzy
+$whitespace
+    foo
+    bar
+    baz
+EOF
+test_expect_success 'git log --show-notes' '
+	git log -1 --pretty=raw --show-notes >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.6.6.510.g159cf
