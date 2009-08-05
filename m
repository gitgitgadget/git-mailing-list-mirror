From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] shortstatus: a new command
Date: Wed,  5 Aug 2009 02:15:46 -0700
Message-ID: <1249463746-21538-6-git-send-email-gitster@pobox.com>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYccU-0008UQ-NM
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933922AbZHEJQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbZHEJQL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:16:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917AbZHEJQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:16:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8284F210B9
	for <git@vger.kernel.org>; Wed,  5 Aug 2009 05:16:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DF8BD210B8 for
 <git@vger.kernel.org>; Wed,  5 Aug 2009 05:16:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.18.g07a4a
In-Reply-To: <1249463746-21538-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 98C11534-81A0-11DE-A6F4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124883>

Add a new command that gives the status in

    XY PATH1 -> PATH2

format to be more machine readable than output from "git status", which is
about previewing of "git commit" with the same arguments.

PATH1 is the path in the HEAD, and " -> PATH2" part is shown only when
PATH1 corresponds to a different path in the index/worktree.

For unmerged entries, X shows the status of stage #2 (i.e. ours) and Y
shows the status of stage #3 (i.e. theirs).  For entries that do not have
conflicts, X shows the status of the index, and Y shows the status of the
work tree.

    X          Y     Meaning
    -------------------------------------------------
              [MD]   not updated
    M        [ MD]   updated in index
    A        [ MD]   added to index
    D        [ MD]   deleted from index
    R        [ MD]   renamed in index
    C        [ MD]   copied in index
    [MARC]           index and work tree matches
    [ MARC]     M    work tree changed since index
    [ MARC]     D    deleted in work tree
    D           D    unmerged, both deleted
    A           U    unmerged, added by us
    U           D    unmerged, deleted by them
    U           A    unmerged, added by them
    D           U    unmerged, deleted by us
    A           A    unmerged, both added
    U           U    unmerged, both modified

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         |    1 +
 builtin-commit.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h        |    1 +
 git.c            |    1 +
 4 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index daf4296..bcefbd3 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,7 @@ BUILT_INS += git-init$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-peek-remote$X
 BUILT_INS += git-repo-config$X
+BUILT_INS += git-shortstatus$X
 BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
diff --git a/builtin-commit.c b/builtin-commit.c
index 6d12c2e..7a4ddab 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -24,6 +24,7 @@
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
+#include "quote.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -35,6 +36,11 @@ static const char * const builtin_status_usage[] = {
 	NULL
 };
 
+static const char * const builtin_shortstatus_usage[] = {
+	"git shortstatus [options]",
+	NULL
+};
+
 static unsigned char head_sha1[20], merge_head_sha1[20];
 static char *use_message_buffer;
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
@@ -813,6 +819,94 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
+#define quote_path quote_path_relative
+
+static void show_unmerged(int null_termination, struct string_list_item *it,
+			  struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	const char *how = "??";
+
+	switch (d->stagemask >> 1) {
+	case 1: how = "DD"; break; /* both deleted */
+	case 2: how = "AU"; break; /* added by us */
+	case 3: how = "UD"; break; /* deleted by them */
+	case 4: how = "UA"; break; /* added by them */
+	case 5: how = "DU"; break; /* deleted by us */
+	case 6: how = "AA"; break; /* both added */
+	case 7: how = "UU"; break; /* both modified */
+	}
+	printf("%s ", how);
+	if (null_termination) {
+		fprintf(stdout, "%s%c", it->string, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("%s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
+static void show_status(int null_termination, struct string_list_item *it,
+		struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+
+	printf("%c%c ",
+	       !d->index_status ? ' ' : d->index_status,
+	       !d->worktree_status ? ' ' : d->worktree_status);
+	if (null_termination) {
+		fprintf(stdout, "%s%c", it->string, 0);
+		if (d->head_path)
+			fprintf(stdout, "%s%c", d->head_path, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		if (d->head_path) {
+			one = quote_path(d->head_path, -1, &onebuf, s->prefix);
+			printf("%s -> ", one);
+			strbuf_release(&onebuf);
+		}
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("%s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
+int cmd_shortstatus(int argc, const char **argv, const char *prefix)
+{
+	struct wt_status s;
+	static int null_termination;
+	int i;
+	static struct option builtin_shortstatus_options[] = {
+		OPT_BOOLEAN('z', "null", &null_termination,
+			    "terminate entries with NUL"),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_shortstatus_options,
+			     builtin_shortstatus_usage, 0);
+
+	read_cache();
+	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
+	wt_status_prepare(&s);
+	wt_status_collect_changes(&s);
+	for (i = 0; i < s.change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+
+		it = &(s.change.items[i]);
+		d = it->util;
+		if (d->stagemask)
+			show_unmerged(null_termination, it, &s);
+		else
+			show_status(null_termination, it, &s);
+	}
+	return 0;
+}
+
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	const char *index_file;
diff --git a/builtin.h b/builtin.h
index 20427d2..825a96f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -96,6 +96,7 @@ extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
+extern int cmd_shortstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 807d875..3977d60 100644
--- a/git.c
+++ b/git.c
@@ -348,6 +348,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, USE_PAGER },
+		{ "shortstatus", cmd_shortstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
-- 
1.6.4.18.g07a4a
