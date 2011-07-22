From: Jeff King <peff@peff.net>
Subject: Re: A few questions about git-reset's reflog messages
Date: Fri, 22 Jul 2011 10:12:23 -0600
Message-ID: <20110722161222.GA20700@sigill.intra.peff.net>
References: <4E287DDE.8020108@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Fri Jul 22 18:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkIL3-00068o-FD
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 18:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1GVQM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 12:12:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57637
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003Ab1GVQM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 12:12:26 -0400
Received: (qmail 21069 invoked by uid 107); 22 Jul 2011 16:12:54 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 12:12:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 10:12:23 -0600
Content-Disposition: inline
In-Reply-To: <4E287DDE.8020108@avtalion.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177646>

On Thu, Jul 21, 2011 at 10:28:30PM +0300, Ori Avtalion wrote:

> I noticed an inconsistency with the reset command's reflog messages.
> 
> The command:
>     g reset <tree-ish>
> 
> Prints this reflog message:
> 
>     <tree-ish>: updating HEAD
> 
> Usually, actual lines from "git reflog" are:
> 640a027 HEAD@{0}: HEAD~1: updating HEAD
> 0657539 HEAD@{1}: 0657539: updating HEAD
> 
> This feels redundant and not very informative.
> 
> Is there any reason to print the tree-ish in the command? The 'raw' sha1
> is already recorded in the reflog.
> 
> Why does the message not mention 'reset' in the beginning like (most?)
> other commands?

I posted this patch recently:

  http://article.gmane.org/gmane.comp.version-control.git/174471

but it didn't get any comment, probably because we were in release
freeze. Here's a repost:

-- >8 --
Subject: [PATCH] reset: give better reflog messages

The reset command creates its reflog entry from argv.
However, it does so after having run parse_options, which
means the only thing left in argv is any non-option
arguments. Thus you would end up with confusing reflog
entries like:

  $ git reset --hard HEAD^
  $ git reset --soft HEAD@{1}
  $ git log -2 -g --oneline
  8e46cad HEAD@{0}: HEAD@{1}: updating HEAD
  1eb9486 HEAD@{1}: HEAD^: updating HEAD

However, we must also consider that some scripts may set
GIT_REFLOG_ACTION before calling reset, and we need to show
their reflog action (with our text appended). For example:

  rebase -i (squash): updating HEAD

On top of that, we also set the ORIG_HEAD reflog action
(even though it doesn't generally exist). In that case, the
reset argument is somewhat meaningless, as it has nothing to
do with what's in ORIG_HEAD.

This patch changes the reset reflog code to show:

  $GIT_REFLOG_ACTION: updating {HEAD,ORIG_HEAD}

as before, but only if GIT_REFLOG_ACTION is set. Otherwise,
show:

   reset: moving to $rev

for HEAD, and:

   reset: updating ORIG_HEAD

for ORIG_HEAD (this is still somewhat superfluous, since we
are in the ORIG_HEAD reflog, obviously, but at least we now
mention which command was used to update it).

While we're at it, we can clean up the code a bit:

  1. Use strbufs to make the message.

  1. Use the "rev" parameter instead of showing all options.
     This makes more sense, since it is the only thing
     impacting the writing of the ref.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reset.c        |   49 +++++++++++++++--------------------------------
 t/t1412-reflog-loop.sh |    8 +++---
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..27b3426 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -33,25 +33,6 @@ static const char *reset_type_names[] = {
 	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
 };
 
-static char *args_to_str(const char **argv)
-{
-	char *buf = NULL;
-	unsigned long len, space = 0, nr = 0;
-
-	for (; *argv; argv++) {
-		len = strlen(*argv);
-		ALLOC_GROW(buf, nr + 1 + len, space);
-		if (nr)
-			buf[nr++] = ' ';
-		memcpy(buf + nr, *argv, len);
-		nr += len;
-	}
-	ALLOC_GROW(buf, nr + 1, space);
-	buf[nr] = '\0';
-
-	return buf;
-}
-
 static inline int is_merge(void)
 {
 	return !access(git_path("MERGE_HEAD"), F_OK);
@@ -215,14 +196,18 @@ static int read_from_tree(const char *prefix, const char **argv,
 	return update_index_refresh(index_fd, lock, refresh_flags);
 }
 
-static void prepend_reflog_action(const char *action, char *buf, size_t size)
+static void set_reflog_message(struct strbuf *sb, const char *action,
+			       const char *rev)
 {
-	const char *sep = ": ";
 	const char *rla = getenv("GIT_REFLOG_ACTION");
-	if (!rla)
-		rla = sep = "";
-	if (snprintf(buf, size, "%s%s%s", rla, sep, action) >= size)
-		warning(_("Reflog action message too long: %.*s..."), 50, buf);
+
+	strbuf_reset(sb);
+	if (rla)
+		strbuf_addf(sb, "%s: %s", rla, action);
+	else if (rev)
+		strbuf_addf(sb, "reset: moving to %s", rev);
+	else
+		strbuf_addf(sb, "reset: %s", action);
 }
 
 static void die_if_unmerged_cache(int reset_type)
@@ -241,7 +226,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
-	char *reflog_action, msg[1024];
+	struct strbuf msg = STRBUF_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, "be quiet, only report errors"),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -261,8 +246,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
-	reflog_action = args_to_str(argv);
-	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
 	/*
 	 * Possible arguments are:
@@ -357,13 +340,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		old_orig = sha1_old_orig;
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
-		prepend_reflog_action("updating ORIG_HEAD", msg, sizeof(msg));
-		update_ref(msg, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
+		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
 	}
 	else if (old_orig)
 		delete_ref("ORIG_HEAD", old_orig, 0);
-	prepend_reflog_action("updating HEAD", msg, sizeof(msg));
-	update_ref_status = update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+	set_reflog_message(&msg, "updating HEAD", rev);
+	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 
 	switch (reset_type) {
 	case HARD:
@@ -380,7 +363,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	remove_branch_state();
 
-	free(reflog_action);
+	strbuf_release(&msg);
 
 	return update_ref_status;
 }
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 7f519e5..647d888 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -21,10 +21,10 @@ test_expect_success 'setup reflog with alternating commits' '
 
 test_expect_success 'reflog shows all entries' '
 	cat >expect <<-\EOF
-		topic@{0} two: updating HEAD
-		topic@{1} one: updating HEAD
-		topic@{2} two: updating HEAD
-		topic@{3} one: updating HEAD
+		topic@{0} reset: moving to two
+		topic@{1} reset: moving to one
+		topic@{2} reset: moving to two
+		topic@{3} reset: moving to one
 		topic@{4} branch: Created from HEAD
 	EOF
 	git log -g --format="%gd %gs" topic >actual &&
-- 
1.7.6.rc1.12.g65e2
