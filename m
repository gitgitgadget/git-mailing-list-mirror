From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 1/4] Add the --submodule-summary option to the diff option
 family
Date: Wed, 14 Oct 2009 20:30:43 +0200
Message-ID: <4AD618D3.3020105@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8ml-0005gB-L0
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbZJNSb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbZJNSb7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:31:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42975 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbZJNSb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:31:58 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id DD5621246A05B;
	Wed, 14 Oct 2009 20:30:44 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My8cW-00080B-00; Wed, 14 Oct 2009 20:30:44 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <4AD61880.4040600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+t7IvpeWeJMhtXv5Nv2PetrvcJF9lihJyqOPzK
	+nE7qPj2o91drpr4aGOWMXmWyy2diG/kveQX8iugfdeQnNNJLZ
	VpFa3FawUBozvrVdVEmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130316>

Now you can see the submodule summaries inlined in the diff, instead of
not-quite-helpful SHA-1 pairs.

The format imitates what "git submodule summary" shows.

To do that, <path>/.git/objects/ is added to the alternate object
databases (if that directory exists).

This option was requested by Jens Lehmann at the GitTogether in Berlin.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |    4 ++
 Makefile                       |    2 +
 diff.c                         |   14 +++++
 diff.h                         |    3 +
 submodule.c                    |  113 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    8 +++
 6 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 submodule.c
 create mode 100644 submodule.h

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 9276fae..5fcc5a8 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -87,6 +87,10 @@ endif::git-format-patch[]
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.

+--submodule-summary::
+	Instead of showing pairs of commit names, list the commits in that
+	commit range in the same style as linkgit:git-submodule[1].
+
 --color::
 	Show colored diff.

diff --git a/Makefile b/Makefile
index fea237b..2356de4 100644
--- a/Makefile
+++ b/Makefile
@@ -452,6 +452,7 @@ LIB_H += sideband.h
 LIB_H += sigchain.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
+LIB_H += submodule.h
 LIB_H += tag.h
 LIB_H += transport.h
 LIB_H += tree.h
@@ -550,6 +551,7 @@ LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += string-list.o
+LIB_OBJS += submodule.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += trace.o
diff --git a/diff.c b/diff.c
index e1be189..bcf2f77 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include "submodule.h"

 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1453,6 +1454,17 @@ static void builtin_diff(const char *name_a,
 	const char *a_prefix, *b_prefix;
 	const char *textconv_one = NULL, *textconv_two = NULL;

+	if (DIFF_OPT_TST(o, SUMMARIZE_SUBMODULES) &&
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
@@ -2640,6 +2652,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
+	else if (!strcmp(arg, "--submodule-summary"))
+		DIFF_OPT_SET(options, SUMMARIZE_SUBMODULES);

 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index 6616877..9019f6f 100644
--- a/diff.h
+++ b/diff.h
@@ -66,6 +66,9 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
 #define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
+
+#define DIFF_OPT_SUMMARIZE_SUBMODULES (1 << 23)
+
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/submodule.c b/submodule.c
new file mode 100644
index 0000000..129583b
--- /dev/null
+++ b/submodule.c
@@ -0,0 +1,113 @@
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
+	static const char *format = "    %m %s";
+	int fast_forward = 0, fast_backward = 0;
+
+	if (add_submodule_odb(path))
+		message = "(not checked out)";
+	else if (is_null_sha1(one))
+		message = "(new submodule)";
+	else if (is_null_sha1(two))
+		message = "(submodule deleted)";
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
+	strbuf_release(&sb);
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
1.6.5.4.g707c
