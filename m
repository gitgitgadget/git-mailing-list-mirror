From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Add the --submodule option to the diff option family
Date: Sat, 17 Oct 2009 20:46:20 +0200
Message-ID: <4ADA10FC.40708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 20:49:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzELk-0003q0-1C
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 20:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbZJQStP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZJQStO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 14:49:14 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39216 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZJQStN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 14:49:13 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 666BB126C778B;
	Sat, 17 Oct 2009 20:46:25 +0200 (CEST)
Received: from [80.128.52.242] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MzEIL-0001kn-00; Sat, 17 Oct 2009 20:46:25 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19/gVOxe1VIQqn/RpkqlX5i8lMg5oxMEu/G0ykp
	TqBL2sSB2riZ9YzLUeCIvX090zQ62fzc+aUKfuqkmtQnX3h9Wj
	700KqIkBPbrqvSE4WwIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130574>

When you use the option --submodule=left-right-log you can see the submodule
summaries inlined in the diff, instead of not-quite-helpful SHA-1 pairs.

The format imitates what "git submodule summary" shows.

To do that, <path>/.git/objects/ is added to the alternate object
databases (if that directory exists).

This option was requested by Jens Lehmann at the GitTogether in Berlin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


In this patch i tried to address all the issues mentioned so far, please
let me know if anything is missing.


 Documentation/diff-options.txt |    7 +++
 Makefile                       |    2 +
 diff.c                         |   16 ++++++
 diff.h                         |    1 +
 submodule.c                    |  112 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    8 +++
 6 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9276fae..99cb517 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -87,6 +87,13 @@ endif::git-format-patch[]
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.

+--submodule[=<format>]::
+	Chose the output format for submodule differences. <format> can be one of
+	'short' and 'left-right-log'. 'short' is the default value for this
+	option and and shows pairs of commit names. 'left-right-log' lists the
+	commits in that commit range like the 'summary' option of
+	linkgit:git-submodule[1] does.
+
 --color::
 	Show colored diff.

diff --git a/Makefile b/Makefile
index c0eff64..2f61e17 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ LIB_H += sideband.h
 LIB_H += sigchain.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
+LIB_H += submodule.h
 LIB_H += tag.h
 LIB_H += transport.h
 LIB_H += tree.h
@@ -551,6 +552,7 @@ LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += string-list.o
+LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/diff.c b/diff.c
index c719ce2..8af1ae2 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include "submodule.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1557,6 +1558,17 @@ static void builtin_diff(const char *name_a,
 	const char *a_prefix, *b_prefix;
 	const char *textconv_one = NULL, *textconv_two = NULL;

+	if (DIFF_OPT_TST(o, SUBMODULE_LEFT_RIGHT_LOG) &&
+			(!one->mode || S_ISGITLINK(one->mode)) &&
+			(!two->mode || S_ISGITLINK(two->mode))) {
+		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
+		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
+		show_submodule_summary(o->file, one ? one->path : two->path,
+				one->sha1, two->sha1,
+				del, add, reset);
+		return;
+	}
+
 	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
 		textconv_one = get_textconv(one);
 		textconv_two = get_textconv(two);
@@ -2771,6 +2783,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!prefixcmp(arg, "--submodule=")) {
+		if (!strcmp(arg + 12, "left-right-log"))
+			DIFF_OPT_SET(options, SUBMODULE_LEFT_RIGHT_LOG);
+	}

 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index a7e7ccb..8079f5b 100644
--- a/diff.h
+++ b/diff.h
@@ -67,6 +67,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_DIFF_FROM_CONTENTS  (1 << 22)
+#define DIFF_OPT_SUBMODULE_LEFT_RIGHT_LOG (1 << 23)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/submodule.c b/submodule.c
new file mode 100644
index 0000000..206386f
--- /dev/null
+++ b/submodule.c
@@ -0,0 +1,112 @@
+#include "cache.h"
+#include "submodule.h"
+#include "dir.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
+
+int add_submodule_odb(const char *path)
+{
+	struct strbuf objects_directory = STRBUF_INIT;
+	struct alternate_object_database *alt_odb;
+
+	strbuf_addf(&objects_directory, "%s/.git/objects/", path);
+	if (!is_directory(objects_directory.buf))
+		return -1;
+
+	/* avoid adding it twice */
+	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
+		if (alt_odb->name - alt_odb->base == objects_directory.len &&
+				!strncmp(alt_odb->base, objects_directory.buf,
+					objects_directory.len))
+			return 0;
+
+	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
+	alt_odb->next = alt_odb_list;
+	strcpy(alt_odb->base, objects_directory.buf);
+	alt_odb->name = alt_odb->base + objects_directory.len;
+	alt_odb->name[2] = '/';
+	alt_odb->name[40] = '\0';
+	alt_odb->name[41] = '\0';
+	alt_odb_list = alt_odb;
+	prepare_alt_odb();
+	return 0;
+}
+
+void show_submodule_summary(FILE *f, const char *path,
+		unsigned char one[20], unsigned char two[20],
+		const char *del, const char *add, const char *reset)
+{
+	struct rev_info rev;
+	struct commit *commit, *left = left, *right;
+	struct commit_list *merge_bases, *list;
+	const char *message = NULL;
+	struct strbuf sb = STRBUF_INIT;
+	static const char *format = "  %m %s";
+	int fast_forward = 0, fast_backward = 0;
+
+	if (is_null_sha1(two))
+		message = "(submodule deleted)";
+	else if (add_submodule_odb(path))
+		message = "(not checked out)";
+	else if (is_null_sha1(one))
+		message = "(new submodule)";
+	else if (!(left = lookup_commit_reference(one)) ||
+		 !(right = lookup_commit_reference(two)))
+		message = "(commits not present)";
+
+	if (!message) {
+		init_revisions(&rev, NULL);
+		setup_revisions(0, NULL, &rev, NULL);
+		rev.left_right = 1;
+		rev.first_parent_only = 1;
+		left->object.flags |= SYMMETRIC_LEFT;
+		add_pending_object(&rev, &left->object, path);
+		add_pending_object(&rev, &right->object, path);
+		merge_bases = get_merge_bases(left, right, 1);
+		if (merge_bases) {
+			if (merge_bases->item == left)
+				fast_forward = 1;
+			else if (merge_bases->item == right)
+				fast_backward = 1;
+		}
+		for (list = merge_bases; list; list = list->next) {
+			list->item->object.flags |= UNINTERESTING;
+			add_pending_object(&rev, &list->item->object,
+				sha1_to_hex(list->item->object.sha1));
+		}
+		if (prepare_revision_walk(&rev))
+			message = "(revision walker failed)";
+	}
+
+	strbuf_addf(&sb, "Submodule %s %s..", path,
+			find_unique_abbrev(one, DEFAULT_ABBREV));
+	if (!fast_backward && !fast_forward)
+		strbuf_addch(&sb, '.');
+	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
+	if (message)
+		strbuf_addf(&sb, " %s\n", message);
+	else
+		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+	fwrite(sb.buf, sb.len, 1, f);
+
+	if (!message) {
+		while ((commit = get_revision(&rev))) {
+			strbuf_setlen(&sb, 0);
+			if (commit->object.flags & SYMMETRIC_LEFT) {
+				if (del)
+					strbuf_addstr(&sb, del);
+			}
+			else if (add)
+				strbuf_addstr(&sb, add);
+			format_commit_message(commit, format, &sb,
+					rev.date_mode);
+			if (reset)
+				strbuf_addstr(&sb, reset);
+			strbuf_addch(&sb, '\n');
+			fprintf(f, "%s", sb.buf);
+		}
+		clear_commit_marks(left, ~0);
+		clear_commit_marks(right, ~0);
+	}
+}
diff --git a/submodule.h b/submodule.h
new file mode 100644
index 0000000..4c0269d
--- /dev/null
+++ b/submodule.h
@@ -0,0 +1,8 @@
+#ifndef SUBMODULE_H
+#define SUBMODULE_H
+
+void show_submodule_summary(FILE *f, const char *path,
+		unsigned char one[20], unsigned char two[20],
+		const char *del, const char *add, const char *reset);
+
+#endif
-- 
1.6.5.3.g464e1.dirty
