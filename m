From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/13] sequencer: add "do_commit()" and related functions
Date: Wed, 12 Aug 2009 07:15:49 +0200
Message-ID: <20090812051552.18155.51306.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6Ov-000460-AG
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbZHLF2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbZHLF2O
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47776 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbZHLF2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:10 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CEE598180BA;
	Wed, 12 Aug 2009 07:27:59 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B72A48180F2;
	Wed, 12 Aug 2009 07:27:56 +0200 (CEST)
X-git-sha1: 8a7f306555e2af039d63ec74105b087700d68bd5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125667>

From: Stephan Beyer <s-beyer@gmx.net>

This patch adds some code that comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)

It adds "struct commit_info", the "next_commit" static variable and
the following functions:

        - do_commit()
        - set_author_info()
        - set_message_source()
        - set_pick_subject()
        - write_commit_summary_into()

This makes it possible to prepare and perform a commit.

Compared to the sequencer project, the only change is that "mark"
related (3 lines long) code has been removed from do_commit().

    Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
    Mentored-by: Christian Couder <chriscool@tuxfamily.org>
    Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
    Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |  214 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 214 insertions(+), 0 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 71a7fef..61a8f2e 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -5,26 +5,69 @@
 #include "refs.h"
 #include "diff.h"
 #include "unpack-trees.h"
+#include "string-list.h"
+#include "pick.h"
+#include "rerere.h"
+#include "dir.h"
+#include "cache-tree.h"
+#include "utf8.h"
 
 #define SEQ_DIR "rebase-merge"
 
 #define PATCH_FILE	git_path(SEQ_DIR "/patch")
+#define MERGE_MSG	git_path("MERGE_MSG")
+#define SQUASH_MSG	git_path("SQUASH_MSG")
+
+/**********************************************************************
+ * Data structures
+ */
+
+struct user_info {
+	const char *name;
+	const char *mail;
+	const char *time; /* "<timestamp> <timezone>" */
+};
+
+struct commit_info {
+	struct user_info author; /* author info */
+	struct user_info committer; /* not used, but for easy extendability */
+	const char *encoding; /* encoding */
+	char *subject; /* basically the first line of the summary */
+	struct strbuf summary; /* the commit message */
+	char *source; /* source of the commit message, either
+		       * "message", "merge", "squash" or a commit SHA1 */
+	char *patch; /* a patch */
+	struct string_list parents; /* list of parents' hex'ed sha1 ids */
+};
+
+/**********************************************************************
+ * Global variables
+ */
 
 static char *reflog;
 
+static int squash_count = 0;
+
 static int allow_dirty = 0, verbosity = 1, advice = 1;
 
 static unsigned char head_sha1[20];
 
+static struct commit_info next_commit;
+
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
 	"git sequencer--helper --reset-hard <commit> <reflog-msg> "
 		"<verbosity> [<allow-dirty>]",
 	"git sequencer--helper --fast-forward <commit> <reflog-msg> "
 		"<verbosity> [<allow-dirty>]",
+	"git sequencer--helper --cherry-pick <commit> [<do-not-commit>]",
 	NULL
 };
 
+/**********************************************************************
+ * Sequencer functions
+ */
+
 static int parse_and_init_tree_desc(const unsigned char *sha1,
 				    struct tree_desc *desc)
 {
@@ -162,6 +205,157 @@ static void make_patch(struct commit *commit)
 	free(args);
 }
 
+/* Commit current index with information next_commit onto parent_sha1. */
+static int do_commit(unsigned char *parent_sha1)
+{
+	int failed;
+	unsigned char tree_sha1[20];
+	unsigned char commit_sha1[20];
+	struct strbuf sbuf;
+	const char *reencoded = NULL;
+
+	if (squash_count) {
+		squash_count = 0;
+		if (file_exists(SQUASH_MSG))
+			unlink(SQUASH_MSG);
+	}
+
+	if (!index_differs_from("HEAD", 0) &&
+	    !next_commit.parents.nr)
+		return error("No changes! Do you really want an empty commit?");
+
+	if (!next_commit.author.name || !next_commit.author.mail)
+		return error("Internal error: Author information not set properly.");
+
+	if (write_cache_as_tree(tree_sha1, 0, NULL))
+		return 1;
+
+	if (!next_commit.encoding)
+		next_commit.encoding = xstrdup("utf-8");
+	if (!git_commit_encoding)
+		git_commit_encoding = "utf-8";
+
+	strbuf_init(&sbuf, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(&sbuf, "tree %s\n", sha1_to_hex(tree_sha1));
+	if (parent_sha1)
+		strbuf_addf(&sbuf, "parent %s\n", sha1_to_hex(parent_sha1));
+	if (next_commit.parents.nr) {
+		int i;
+		for (i = 0; i < next_commit.parents.nr; ++i)
+			strbuf_addf(&sbuf, "parent %s\n",
+					next_commit.parents.items[i].string);
+	}
+	if (!next_commit.author.time) {
+		char time[50];
+		datestamp(time, sizeof(time));
+		next_commit.author.time = xstrdup(time);
+	}
+
+	stripspace(&next_commit.summary, 1);
+
+	/* if encodings differ, reencode whole buffer */
+	if (strcasecmp(git_commit_encoding, next_commit.encoding)) {
+		if ((reencoded = reencode_string(next_commit.author.name,
+				git_commit_encoding, next_commit.encoding))) {
+			free((void *)next_commit.author.name);
+			next_commit.author.name = reencoded;
+		}
+		if ((reencoded = reencode_string(next_commit.summary.buf,
+				git_commit_encoding, next_commit.encoding))) {
+			strbuf_reset(&next_commit.summary);
+			strbuf_addstr(&next_commit.summary, reencoded);
+		}
+	}
+	strbuf_addf(&sbuf, "author %s <%s> %s\n", next_commit.author.name,
+			next_commit.author.mail, next_commit.author.time);
+	strbuf_addf(&sbuf, "committer %s\n", git_committer_info(0));
+	if (!is_encoding_utf8(git_commit_encoding))
+		strbuf_addf(&sbuf, "encoding %s\n", git_commit_encoding);
+	strbuf_addch(&sbuf, '\n');
+	strbuf_addbuf(&sbuf, &next_commit.summary);
+	if (sbuf.buf[sbuf.len-1] != '\n')
+		strbuf_addch(&sbuf, '\n');
+
+	failed = write_sha1_file(sbuf.buf, sbuf.len, commit_type, commit_sha1);
+	strbuf_release(&sbuf);
+	if (failed)
+		return 1;
+
+	if (verbosity > 1)
+		printf("Created %scommit %s\n",
+			parent_sha1 || next_commit.parents.nr ? "" : "initial ",
+			sha1_to_hex(commit_sha1));
+
+	if (update_ref(reflog, "HEAD", commit_sha1, NULL, 0, 0))
+		return error("Could not update HEAD to %s.",
+						sha1_to_hex(commit_sha1));
+
+	return 0;
+}
+
+/*
+ * Fill next_commit.author according to ident.
+ * Ident may have one of the following forms:
+ * 	"name <e-mail> timestamp timezone\n..."
+ * 	"name <e-mail> timestamp timezone"
+ * 	"name <e-mail>"
+ */
+static void set_author_info(const char *ident)
+{
+	const char *tmp1 = strstr(ident, " <");
+	const char *tmp2;
+	char *data;
+	if (!tmp1)
+		return;
+	tmp2 = strstr(tmp1+2, ">");
+	if (!tmp2)
+		return;
+	if (tmp2[1] != 0 && tmp2[1] != ' ')
+		return;
+
+	data = xmalloc(strlen(ident)); /* a trivial upper bound */
+
+	snprintf(data, tmp1-ident+1, "%s", ident);
+	next_commit.author.name = xstrdup(data);
+	snprintf(data, tmp2-tmp1-1, "%s", tmp1+2);
+	next_commit.author.mail = xstrdup(data);
+
+	if (tmp2[1] == 0) {
+		free(data);
+		return;
+	}
+
+	tmp1 = strpbrk(tmp2+2, "\r\n");
+	if (!tmp1)
+		tmp1 = tmp2 + strlen(tmp2);
+
+	snprintf(data, tmp1-tmp2-1, "%s", tmp2+2);
+	next_commit.author.time = xstrdup(data);
+	free(data);
+}
+
+static void set_message_source(const char *source)
+{
+	if (next_commit.source)
+		free(next_commit.source);
+	next_commit.source = xstrdup(source);
+}
+
+/* Set subject, an information for the case of conflict */
+static void set_pick_subject(const char *hex, struct commit *commit)
+{
+	const char *tmp = strstr(commit->buffer, "\n\n");
+	if (tmp) {
+		const char *eol;
+		int len = strlen(hex);
+		tmp += 2;
+		eol = strchrnul(tmp, '\n');
+		next_commit.subject = xmalloc(eol - tmp + len + 5);
+		snprintf(next_commit.subject, eol - tmp + len + 5, "%s... %s",
+								hex, tmp);
+	}
+}
+
 /* Return a commit object of "arg" */
 static struct commit *get_commit(const char *arg)
 {
@@ -198,6 +392,26 @@ static int set_verbosity(int verbose)
 	return 0;
 }
 
+static int write_commit_summary_into(const char *filename)
+{
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	int fd = hold_lock_file_for_update(lock, filename, 0);
+	if (fd < 0)
+		return error("Unable to create '%s.lock': %s", filename,
+							strerror(errno));
+	if (write_in_full(fd, next_commit.summary.buf,
+			      next_commit.summary.len) < 0)
+		return error("Could not write to %s: %s",
+						filename, strerror(errno));
+	if (commit_lock_file(lock) < 0)
+		return error("Error wrapping up %s", filename);
+	return 0;
+}
+
+/**********************************************************************
+ * Builtin sequencer helper functions
+ */
+
 /* v should be "" or "t" or "\d" */
 static int parse_verbosity(const char *v)
 {
-- 
1.6.4.271.ge010d
