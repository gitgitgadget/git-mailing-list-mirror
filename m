From: Jeff King <peff@peff.net>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 18:46:26 -0400
Message-ID: <20110525224626.GA2296@sigill.intra.peff.net>
References: <loom.20110525T192418-887@post.gmane.org>
 <7vvcwy37de.fsf@alter.siamese.dyndns.org>
 <20110525195032.GC27260@sigill.intra.peff.net>
 <7vei3m3571.fsf@alter.siamese.dyndns.org>
 <7vzkma1p95.fsf@alter.siamese.dyndns.org>
 <20110525210254.GA29716@sigill.intra.peff.net>
 <20110525212510.GA14214@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPMqY-0007m5-4w
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 00:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab1EYWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 18:46:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43335
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab1EYWq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 18:46:28 -0400
Received: (qmail 6824 invoked by uid 107); 25 May 2011 22:46:28 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 18:46:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 18:46:26 -0400
Content-Disposition: inline
In-Reply-To: <20110525212510.GA14214@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174471>

On Wed, May 25, 2011 at 05:25:10PM -0400, Jeff King wrote:

> Though if we are going to change it, I think my preference would
> actually be:
> 
>   8e46cad HEAD@{0}: reset: moving to HEAD^
> 
> which reads better. The "updating HEAD" is just pointless. Of course
> we're updating HEAD; we're in the HEAD reflog and we're running reset!

Actually, this gets written also to the branch's reflog, so saying
"updating HEAD" has a little bit of value. Of course, saying "reset" is
even better, since that is the command to update HEAD.

> However, if GIT_REFLOG_ACTION is already set (by a script calling us),
> then we won't say "reset". So for example, I have entries in my reflog
> like:
> 
>   944af8c HEAD@{311}: rebase -i (squash): updating HEAD
> 
> So maybe it makes sense to leave those ones as-is, and adjust only the
> case where GIT_REFLOG_ACTION is unset.

...and for the reason above, it makes sense to leave this as "updating
HEAD" for the per-branch reflog, since whatever the script put into
GIT_REFLOG_ACTION may be more clear with that information.

So here's what I think we should do.

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
1.7.4.5.34.g0787f
