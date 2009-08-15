From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] git stat -s: short status output
Date: Sat, 15 Aug 2009 03:06:42 -0700
Message-ID: <1250330803-22171-6-git-send-email-gitster@pobox.com>
References: <1250330803-22171-1-git-send-email-gitster@pobox.com>
 <1250330803-22171-2-git-send-email-gitster@pobox.com>
 <1250330803-22171-3-git-send-email-gitster@pobox.com>
 <1250330803-22171-4-git-send-email-gitster@pobox.com>
 <1250330803-22171-5-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 12:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McGAO-00053t-IJ
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 12:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbZHOKHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 06:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbZHOKHB
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 06:07:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbZHOKHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 06:07:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E87752ABCE;
	Sat, 15 Aug 2009 06:07:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7BD82ABCD; Sat, 15 Aug 2009
 06:06:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.224.g3be84
In-Reply-To: <1250330803-22171-5-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 606D6F3A-8983-11DE-86CC-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125994>

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
better machine readability.  Because the traditional long format is
designed for human consumption, NUL termination does not make sense.
For this reason, -z option implies -s (short output).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

* Unlike what was in 'pu', -z now implies -s.  I do not think the machine
  readble -s format should use color, but I _could_ be talked into
  coloring the output when -z is not used.

 builtin-commit.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 64ae45f..6d9bd84 100644
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
@@ -910,6 +985,9 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (null_termination)
+		shortstatus = 1;
+
 	wt_status_prepare(&s);
 	git_config(git_status_config, &s);
 	argc = parse_options(argc, argv, prefix,
@@ -925,11 +1003,31 @@ int cmd_stat(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
-	if (s.use_color == -1)
-		s.use_color = git_use_color_default;
-	if (diff_use_color_default == -1)
-		diff_use_color_default = git_use_color_default;
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
+		if (s.use_color == -1)
+			s.use_color = git_use_color_default;
+		if (diff_use_color_default == -1)
+			diff_use_color_default = git_use_color_default;
+		wt_status_print_body(&s);
+	}
 	return 0;
 }
 
-- 
1.6.4.224.g3be84
