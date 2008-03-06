From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] format-patch: add --reviewed-by=<ident>
Date: Thu, 6 Mar 2008 02:15:24 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803060214520.15786@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 02:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX4jP-0001mX-Nv
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 02:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762387AbYCFBPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 20:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760670AbYCFBPj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 20:15:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:42264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762711AbYCFBPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 20:15:23 -0500
Received: (qmail invoked by alias); 06 Mar 2008 01:15:21 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 06 Mar 2008 02:15:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1895wpDXIQ9Jwx4WSPq462yGn9U92gC0v4YuS/A0G
	XoMYXMIt/P3KCz
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803052327570.15786@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76304>


Now you can conveniently add lines with format-patch, adding missing
Reviewed-by: lines (if it is already present at the end of the commit
message, it will not be repeated).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	And this is the actual patch...

	It is just a patch for format-patch... the patch for git-am should 
	be trivial.

 Documentation/git-format-patch.txt |    5 ++++
 builtin-log.c                      |    9 +++++++
 log-tree.c                         |   44 +++++++++++++++++++++++++++++++++++-
 revision.h                         |    1 +
 t/t4014-format-patch.sh            |   26 +++++++++++++++++++++
 5 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b5207b7..da52720 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 [verse]
 'git-format-patch' [-k] [-o <dir> | --stdout] [--thread]
 		   [--attach[=<boundary>] | --inline[=<boundary>]]
+		   [--reviewed-by=<ident>]
 		   [-s | --signoff] [<common diff options>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
@@ -96,6 +97,10 @@ include::diff-options.txt[]
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
 
+--reviewed-by=<ident>::
+	Add `Reviewed-by:` line to the commit message, using
+	the given identity.
+
 -s|--signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
diff --git a/builtin-log.c b/builtin-log.c
index fe8fc6f..90573b3 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -753,6 +753,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
+	struct path_list add_reviewed_by = { NULL, 0, 0, 0 };
 	struct strbuf buf;
 
 	git_config(git_format_config);
@@ -821,6 +822,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				die("bogos committer info %s\n", committer);
 			add_signoff = xmemdupz(committer, endpos - committer + 1);
 		}
+		else if (!prefixcmp(argv[i], "--reviewed-by=")) {
+			struct strbuf buf;
+
+			strbuf_initf(&buf, "Reviewed-by: %s", argv[i] + 14);
+			path_list_append(strbuf_detach(&buf, NULL),
+					&add_reviewed_by);
+		}
 		else if (!strcmp(argv[i], "--attach")) {
 			rev.mime_boundary = git_version_string;
 			rev.no_inline = 1;
@@ -994,6 +1002,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		start_number--;
 	}
 	rev.add_signoff = add_signoff;
+	rev.add_reviewed_by = &add_reviewed_by;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
diff --git a/log-tree.c b/log-tree.c
index 608f697..36621ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
+#include "path-list.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -79,6 +80,34 @@ static int detect_any_signoff(char *letter, int size)
 	return seen_head && seen_name;
 }
 
+static void append_reviewed_by(struct strbuf *sb, struct path_list *reviewed)
+{
+	struct path_list already_reviewed = { NULL, 0, 0, 0 };
+	int i, eol = sb->len + 1;
+
+	/* find the last Reviewed-by: lines */
+	for (i = eol - 2; i > 0; i--)
+		if (i == 0 || sb->buf[i - 1] == '\n') {
+			if (!prefixcmp(sb->buf + i, "Reviewed-by:"))
+				path_list_insert(xstrndup(sb->buf + i,
+							eol - i - 1),
+						&already_reviewed);
+			else if (eol - i > 1)
+				break;
+			eol = i;
+		}
+
+	for (i = 0; i < reviewed->nr; i++) {
+		const char *line = reviewed->items[i].path;
+		if (!path_list_has_path(&already_reviewed, line))
+			strbuf_addf(sb, "%s\n", line);
+	}
+
+	/* all strings were xstrndup()ed, clean them up */
+	already_reviewed.strdup_paths = 1;
+	path_list_clear(&already_reviewed, 0);
+}
+
 static void append_signoff(struct strbuf *sb, const char *signoff)
 {
 	static const char signed_off_by[] = "Signed-off-by: ";
@@ -137,6 +166,16 @@ static int has_non_ascii(const char *s)
 	return 0;
 }
 
+static int path_list_has_non_ascii(struct path_list *list)
+{
+	int i;
+
+	for (i = 0; list && i < list->nr; i++)
+		if (has_non_ascii(list->items[i].path))
+			return 1;
+	return 0;
+}
+
 void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **subject_p, const char **extra_headers_p)
 {
@@ -301,8 +340,11 @@ void show_log(struct rev_info *opt, const char *sep)
 	strbuf_init(&msgbuf, 0);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
 			    abbrev, subject, extra_headers, opt->date_mode,
-			    has_non_ascii(opt->add_signoff));
+			    has_non_ascii(opt->add_signoff) ||
+			    path_list_has_non_ascii(opt->add_reviewed_by));
 
+	if (opt->add_reviewed_by && opt->add_reviewed_by->nr)
+		append_reviewed_by(&msgbuf, opt->add_reviewed_by);
 	if (opt->add_signoff)
 		append_signoff(&msgbuf, opt->add_signoff);
 	if (opt->show_log_size)
diff --git a/revision.h b/revision.h
index c8b3b94..eb4cc3b 100644
--- a/revision.h
+++ b/revision.h
@@ -78,6 +78,7 @@ struct rev_info {
 	char		*message_id;
 	const char	*ref_message_id;
 	const char	*add_signoff;
+	struct path_list *add_reviewed_by;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b2b7a8d..e2ff94f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -230,4 +230,30 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 '
 
+cat > expect << EOF
+
+Reviewed-by: Ken Robinson
+
+Reviewed-by: Sergey Rachmaninov
+
+Reviewed-by: Ronny O Sullivan
+Reviewed-by: Mickey Mouse
+Reviewed-by: Mahatma Gandhi
+EOF
+
+test_expect_success '--reviewed-by' '
+
+	echo reviewed > foo &&
+	test_tick &&
+	git commit -m "Reviewed" -m "Reviewed-by: Ken Robinson" \
+		-m "Reviewed-by: Sergey Rachmaninov" \
+		-m "Reviewed-by: Ronny O Sullivan" foo &&
+	git format-patch --reviewed-by="Mickey Mouse" \
+		--reviewed-by="Sergey Rachmaninov" \
+		--reviewed-by="Mahatma Gandhi" -1 HEAD &&
+	sed -e "1,/^Cc: /d" -e "/^---/,\$d" < 0001-Reviewed.patch > output &&
+	git diff expect output
+
+'
+
 test_done
-- 
1.5.4.3.571.g9aec3


