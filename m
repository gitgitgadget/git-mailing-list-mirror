From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] git stat -s: short status output
Date: Mon, 10 Aug 2009 01:54:25 -0700
Message-ID: <1249894465-11018-9-git-send-email-gitster@pobox.com>
References: <1249894465-11018-1-git-send-email-gitster@pobox.com>
 <1249894465-11018-2-git-send-email-gitster@pobox.com>
 <1249894465-11018-3-git-send-email-gitster@pobox.com>
 <1249894465-11018-4-git-send-email-gitster@pobox.com>
 <1249894465-11018-5-git-send-email-gitster@pobox.com>
 <1249894465-11018-6-git-send-email-gitster@pobox.com>
 <1249894465-11018-7-git-send-email-gitster@pobox.com>
 <1249894465-11018-8-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 10:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQfP-00083M-7J
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbZHJIyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZHJIyq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:54:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbZHJIyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:54:43 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E76AA56A3
	for <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57A6856A2 for
 <git@vger.kernel.org>; Mon, 10 Aug 2009 04:54:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.173.g72959
In-Reply-To: <1249894465-11018-8-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 73513C90-858B-11DE-BF20-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125419>

Give -s(hort) option to "git stat" that shows the status of paths in a
more concise way.

    XY PATH1 -> PATH2

format to be more machine readable than output from "git status", which is
about previewing of "git commit" with the same arguments.

PATH1 is the path in the HEAD, and " -> PATH2" part is shown only when
PATH1 corresponds to a different path in the index/worktree.

For unmerged entries, X shows the status of stage #2 (i.e. ours) and Y
shows the status of stage #3 (i.e. theirs).  For entries that do not have
conflicts, X shows the status of the index, and Y shows the status of the
work tree.  For untracked paths, XY are "??".

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

    ?           ?    untracked

When given -z option, the records are terminated by NUL characters for
better machine readability.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9c2a70c..0ed0d71 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -898,11 +898,86 @@ static int git_status_config(const char *k, const char *v, void *cb)
 	return git_diff_ui_config(k, v, NULL);
 }
 
+#define quote_path quote_path_relative
+
+static void short_unmerged(int null_termination, struct string_list_item *it,
+			   struct wt_status *s)
+{
+	struct wt_status_change_data *d = it->util;
+	const char *how = "??";
+
+	switch (d->stagemask) {
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
+static void short_status(int null_termination, struct string_list_item *it,
+			 struct wt_status *s)
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
+static void short_untracked(int null_termination, struct string_list_item *it,
+			    struct wt_status *s)
+{
+	if (null_termination) {
+		fprintf(stdout, "?? %s%c", it->string, 0);
+	} else {
+		struct strbuf onebuf = STRBUF_INIT;
+		const char *one;
+		one = quote_path(it->string, -1, &onebuf, s->prefix);
+		printf("?? %s\n", one);
+		strbuf_release(&onebuf);
+	}
+}
+
 int cmd_stat(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
+	static int null_termination, shortstatus;
+	int i;
 	unsigned char sha1[20];
 	static struct option builtin_stat_options[] = {
+		OPT_BOOLEAN('s', "short", &shortstatus,
+			    "show status concicely"),
+		OPT_BOOLEAN('z', "null", &null_termination,
+			    "terminate entries with NUL"),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
@@ -925,7 +1000,27 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
-	wt_status_print_body(&s);
+	if (shortstatus) {
+		for (i = 0; i < s.change.nr; i++) {
+			struct wt_status_change_data *d;
+			struct string_list_item *it;
+
+			it = &(s.change.items[i]);
+			d = it->util;
+			if (d->stagemask)
+				short_unmerged(null_termination, it, &s);
+			else
+				short_status(null_termination, it, &s);
+		}
+		for (i = 0; i < s.untracked.nr; i++) {
+			struct string_list_item *it;
+
+			it = &(s.untracked.items[i]);
+			short_untracked(null_termination, it, &s);
+		}
+	} else {
+		wt_status_print_body(&s);
+	}
 	return 0;
 }
 
-- 
1.6.4.173.g72959
