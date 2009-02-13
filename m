From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 15:24:52 +0100
Message-ID: <1234535092-20133-1-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0902131445390.10279@pacific.mpi-cbg.de>
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 15:26:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXz06-00057q-9P
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 15:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbZBMOZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 09:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZBMOZO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 09:25:14 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:32029 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbZBMOZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 09:25:13 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 15:25:09 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 15:25:09 +0100
X-Mailer: git-send-email 1.6.2.rc0.274.g97213
In-Reply-To: <alpine.DEB.1.00.0902131445390.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 13 Feb 2009 14:25:09.0727 (UTC) FILETIME=[E0063EF0:01C98DE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109750>

'git log --abbrev-commit' adds an ellipsis to all commit names that
were abbreviated.  This is annoying if you want to cut&paste the sha1
from the terminal, since selecting by word will pick up '...' too.
(And this cannot be fixed by making '.' a non-word character; in other
instances, such as the '123457..abcdef0' from git-fetch, it's part of
the expression.)

So we introduce a new variable format.abbrevEllipsis that defaults to
true (previous behaviour).  If disabled, the formatting routines for
log/show/whatchanged do not append an ellipsis.

Internally we use a new global variable that is only set to false in
git_log_config, which is only called from log, show, whatchanged and
reflog, thus not affecting plumbing.  For symmetry with abbrev_commit,
it should go in rev_info, but that way we could not reach the
formatting in add_merge_info() without touching all calls of
pretty_print_commit().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changed the commit message to reflect the discussion in this thread.


 Documentation/config.txt |    6 ++++++
 builtin-log.c            |    4 ++++
 log-tree.c               |   19 ++++++++++++++-----
 log-tree.h               |    3 +++
 pretty.c                 |    6 ++----
 t/t4202-log.sh           |   23 +++++++++++++++++++++++
 6 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1806a60..ee5b76f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -656,6 +656,12 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
+format.abbrevEllipsis::
+	Whether --abbrev-commit for log/show/whatchanged should append
+	an ellipsis (...) to the abbreviated SHA-1.  Defaults to true.
+	See linkgit:git-log[1], linkgit:git-show[1],
+	linkgit:git-whatchanged[1].
+
 format.numbered::
 	A boolean which can enable or disable sequence numbers in patch
 	subjects.  It defaults to "auto" which enables it only if there
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..f85e469 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -227,6 +227,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.abbrevellipsis")) {
+		log_abbrev_commit_ellipsis = git_config_bool(var, value);
+		return 0;
+	}
 	return git_diff_ui_config(var, value, cb);
 }
 
diff --git a/log-tree.c b/log-tree.c
index 194ddb1..ec7d3e4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 
 struct decoration name_decoration = { "object names" };
+int log_abbrev_commit_ellipsis = 1;
 
 static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
 {
@@ -43,12 +44,20 @@ void load_ref_decorations(void)
 	}
 }
 
+const char *log_unique_abbrev(const unsigned char *sha1, int abbrev)
+{
+	if (log_abbrev_commit_ellipsis)
+		return diff_unique_abbrev(sha1, abbrev);
+	else
+		return find_unique_abbrev(sha1, abbrev);
+}
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
 	for (p = commit->parents; p ; p = p->next) {
 		struct commit *parent = p->item;
-		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
+		printf(" %s", log_unique_abbrev(parent->object.sha1, abbrev));
 	}
 }
 
@@ -280,7 +289,7 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
+		fputs(log_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		show_decorations(opt, commit);
@@ -348,14 +357,14 @@ void show_log(struct rev_info *opt)
 					putchar('>');
 			}
 		}
-		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
+		fputs(log_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
-			       diff_unique_abbrev(parent->object.sha1,
-						  abbrev_commit));
+			       log_unique_abbrev(parent->object.sha1,
+						 abbrev_commit));
 		show_decorations(opt, commit);
 		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format == CMIT_FMT_ONELINE) {
diff --git a/log-tree.h b/log-tree.h
index f2a9008..af99c69 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -3,6 +3,8 @@
 
 #include "revision.h"
 
+extern int log_abbrev_commit_ellipsis;
+
 struct log_info {
 	struct commit *commit, *parent;
 };
@@ -18,5 +20,6 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
 void load_ref_decorations(void);
+const char *log_unique_abbrev(const unsigned char *sha1, int abbrev);
 
 #endif
diff --git a/pretty.c b/pretty.c
index cc460b5..c64ad23 100644
--- a/pretty.c
+++ b/pretty.c
@@ -210,15 +210,13 @@ static void add_merge_info(enum cmit_fmt fmt, struct strbuf *sb,
 	while (parent) {
 		struct commit *p = parent->item;
 		const char *hex = NULL;
-		const char *dots;
 		if (abbrev)
-			hex = find_unique_abbrev(p->object.sha1, abbrev);
+			hex = log_unique_abbrev(p->object.sha1, abbrev);
 		if (!hex)
 			hex = sha1_to_hex(p->object.sha1);
-		dots = (abbrev && strlen(hex) != 40) ?  "..." : "";
 		parent = parent->next;
 
-		strbuf_addf(sb, " %s%s", hex, dots);
+		strbuf_addf(sb, " %s", hex);
 	}
 	strbuf_addch(sb, '\n');
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7b976ee..730036e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -134,5 +134,28 @@ test_expect_success 'log --grep -i' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git log --abbrev-commit (default: ellipsis enabled)' '
+	git log --pretty=oneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=format:%h -1)\\.\\.\\."
+'
+
+test_expect_success 'enable format.abbrevEllipsis' '
+	git config format.abbrevEllipsis true
+'
+
+test_expect_success 'git log --abbrev-commit (ellipsis enabled)' '
+	git log --pretty=oneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=format:%h -1)\\.\\.\\."
+'
+
+test_expect_success 'disable format.abbrevEllipsis' '
+	git config format.abbrevEllipsis false
+'
+
+test_expect_success 'git log --abbrev-commit (ellipsis disabled)' '
+	git log --pretty=oneline --abbrev-commit -1 |
+	grep "^$(git log --pretty=format:%h -1) "
+'
+
 test_done
 
-- 
1.6.2.rc0.274.g97213
