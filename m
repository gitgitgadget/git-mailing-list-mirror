From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] commit notes workflow
Date: Fri, 25 Feb 2011 08:30:57 -0500
Message-ID: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 14:31:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psxl9-0004aG-5h
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 14:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab1BYNa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 08:30:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33368 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab1BYNa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 08:30:57 -0500
Received: (qmail 1802 invoked by uid 111); 25 Feb 2011 13:30:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 25 Feb 2011 13:30:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Feb 2011 08:30:57 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167905>

I was revising a long-ish series today, and I have been wanting to start
using "git notes" to store information on what's changed between
versions (which will eventually go after the "---" in format-patch).

So my workflow was something like:

  1. git rebase -i, mark one or more commits for edit

  2. For each commit we stop at:

     a. Tweak the tree either with enhancements, or to resolve
        conflicts from tweaks to earlier patches.

     b. commit --amend, tweak commit message is needed

     c. git notes add, mention changes

     d. git rebase --continue

Two things annoyed me:

  1. Editing the commit message and notes separately felt awkward. They
     are conceptually part of the same task to me.

  2. In the conflict case, there is no opportunity to run "git notes
     add" because you fix up commits and directly run "rebase
     --continue".

So my solution was that "git commit" should be able to embed and extract
notes from the commit message itself. The patch below implements "git
commit --notes", which does two things:

  1. If we are amending, it populates the commit message not just with
     the existing message, but also with a "---" divider and any notes on
     the commit.

  2. After editing the commit message, it looks for the "---" divider
     and puts everything after it into a commit note (whether or not it
     put in a divider in step (1), so you can add new notes, too).

So your commit template looks like:

  subject

  commit message body
  ---
  notes data

  # usual template stuff

I'm curious what people think. Do others find this useful? Does it seem
harmful?

It's yet another magic format to worry about when writing a commit
message. But you don't need to care unless you use "--notes" (and I
would probably add a config option, since I would always want this on
personally). And "---" is already something to be aware of, since "am"
treats it specially (technically, I could just drop "notes" entirely and
use "---" in my commit message; so perhaps this is just
overengineering).

My initial attempt was to implement in terms of prepare-commit-msg,
commit-msg, and post-commit hooks. And it worked OK, but was foiled by
rebase using "git commit --no-verify".

There are still a few questions to address.

How should this interact with --cleanup? Right now it splits everything
after the "---" into the notes part, including any "#" lines. Which
should be fine, I think, because they get pulled out by stripspace
in either case. If you were using --cleanup=verbatim, then you'd have
gotten rid of them manually anyway. And if you really want a literal
"---", you would use "git commit" (or "git commit --no-notes" once there
is a config option). So I think the behavior in this patch is sane.

I only turn on --edit when we launch an editor. It seems somehow more
confusing to me that "git commit -F file" should split notes out (or
worse, "git commit -m"). If you are doing things non-interactively, it's
probably not a big deal to just call "git notes add" separately. And I
expect "-F" is used by porcelains, or people wanting to do verbatim
stuff.

How should this interact with the commit-msg hook? In my implementation,
it sees the whole thing, message and notes. Should we be picking apart
the two bits after the editor and rewriting the COMMIT_EDITMSG before
the hook sees it?

How should this interact with the post-rewrite hook? I obviously need to
set that up for my workflow, too, but I haven't yet. This patch does
nothing, but I'm pretty sure it should turn of "git commit --amend"
calling the rewrite hook if we are using --notes (since the user has
already seen and edited the notes, and we've written them out).

Anyway, here is the patch.

---
 builtin/commit.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5295032..3e21e33 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "blob.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -104,6 +105,7 @@ static char *cleanup_arg;
 static enum commit_whence whence;
 static int use_editor = 1, initial_commit, include_status = 1;
 static int show_ignored_in_status;
+static int edit_notes;
 static const char *only_include_assumed;
 static struct strbuf message;
 
@@ -146,6 +148,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+	OPT_BOOLEAN(0, "notes", &edit_notes, "edit notes interactively"),
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
@@ -603,6 +606,53 @@ static char *cut_ident_timestamp_part(char *string)
 	return ket;
 }
 
+static void add_notes_from_commit(struct strbuf *out, const char *name)
+{
+	struct commit *commit;
+	struct strbuf note = STRBUF_INIT;
+
+	commit = lookup_commit_reference_by_name(name);
+	if (!commit)
+		die("could not lookup commit %s", name);
+	format_note(NULL, commit->object.sha1, &note,
+		    get_commit_output_encoding(), 0);
+
+	if (note.len) {
+		strbuf_addstr(out, "\n---\n");
+		strbuf_addbuf(out, &note);
+	}
+	strbuf_release(&note);
+}
+
+static void extract_notes_from_message(struct strbuf *msg, struct strbuf *notes)
+{
+	const char *separator = strstr(msg->buf, "\n---\n");
+
+	if (!separator)
+		return;
+
+	strbuf_addstr(notes, separator + 5);
+	strbuf_setlen(msg, separator - msg->buf + 1);
+}
+
+static void update_notes_for_commit(struct strbuf *notes,
+				    unsigned char *commit_sha1)
+{
+	stripspace(notes, cleanup_mode == CLEANUP_ALL);
+
+	if (!notes->len)
+		remove_note(NULL, commit_sha1);
+	else {
+		unsigned char blob_sha1[20];
+		if (write_sha1_file(notes->buf, notes->len,
+				    blob_type, blob_sha1) < 0)
+			die("unable to write note blob");
+		add_note(NULL, commit_sha1, blob_sha1,
+			 combine_notes_overwrite);
+	}
+	commit_notes(NULL, "updated by commit --notes");
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s,
 			     struct strbuf *author_ident)
@@ -730,6 +780,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_release(&sob);
 	}
 
+	if (edit_notes && amend)
+		add_notes_from_commit(&sb, "HEAD");
+
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
 		die_errno("could not write commit template");
 
@@ -997,8 +1050,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (edit_flag)
 		use_editor = 1;
-	if (!use_editor)
+	if (!use_editor) {
 		xsetenv("GIT_EDITOR", ":", 1);
+		edit_notes = 0;
+	}
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
@@ -1357,6 +1412,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf notes = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
@@ -1458,6 +1514,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			strbuf_setlen(&sb, p - sb.buf + 1);
 	}
 
+	if (edit_notes)
+		extract_notes_from_message(&sb, &notes);
+
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (message_is_empty(&sb) && !allow_empty_message) {
@@ -1473,6 +1532,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	strbuf_release(&author_ident);
 
+	if (edit_notes)
+		update_notes_for_commit(&notes, commit_sha1);
+	strbuf_release(&notes);
+
 	ref_lock = lock_any_ref_for_update("HEAD",
 					   initial_commit ? NULL : head_sha1,
 					   0);
-- 
1.7.2.5.20.g7ba93.dirty
