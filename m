From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] demonstrate format-callback used in combined diff
Date: Fri, 19 Aug 2011 23:34:54 -0700
Message-ID: <7vd3g0zj3l.fsf_-_@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 08:35:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Quf9B-0002zv-LB
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 08:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab1HTGfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 02:35:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab1HTGe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 02:34:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D06762AD3;
	Sat, 20 Aug 2011 02:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n6xUDgeQkUgV3/bZhisnJaRjHYY=; b=HAOU9V
	n6Xoc+5TLQk1eqbECtanJUPe7//Ws/0ooKYcYVWuIXURt8O+gQKi/eKjMrE8J2m5
	BYHdOtfz+PI6QRzbjpnVarAFBxIhy+PnmO9wgcjBhkhSaWTasxyloenIkLUixQCl
	Fv1DYK4Fz9Zi6H1BOZypzljjF8Hu5wzFMn8PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E+VPXtj7MUz0hLQspTcX0JDgciNmikNb
	4dpr14RUoyIZnq1nGTuB9wRZFI9LJVViMYbCk3Jx5ND/DJb5lc+CkV2C3vJYqfTd
	9YoOwFKby0c1U1BnesY5DVXxyU78a+/Pjbo2AEJK3SXIC5SBwh0hal+FO/Rc6Aei
	8PAEn3Cx5Cg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C73D42AD2;
	Sat, 20 Aug 2011 02:34:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12CC12AD1; Sat, 20 Aug 2011
 02:34:55 -0400 (EDT)
In-Reply-To: <7vwre9yodc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Aug 2011 16:26:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85744DCE-CAF6-11E0-AF73-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179754>

This demonstrates how to use the format-callback machinery added
to combined diff.

 $ ./git demo v1.7.6..maint

works like "git log" with the same revision-range arguments, but shows
list of paths that have contents in the child commit different from any of
its parent commit(s). As a consequence, when a trivial merge takes the
contents of a path as a whole from one parent, such a path is not shown.

Notice how the same function can be used to be called back for a two-way
diff (i.e. there is only one entry on the preimage "one" side) and also
for a combined diff.

Obviously not meant for inclusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin.h     |    1 +
 builtin/log.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 git.c         |    1 +
 3 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..aef8917 100644
--- a/builtin.h
+++ b/builtin.h
@@ -59,6 +59,7 @@ extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_demo(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/log.c b/builtin/log.c
index 5c2af59..cc222c8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -8,6 +8,7 @@
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
@@ -436,6 +437,53 @@ static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 }
 
+static void show_paths_callback(struct diff_queue_struct *q,
+				struct diff_options *options,
+				void *data)
+{
+	int i;
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *pair = q->queue[i];
+		struct diff_filespec *spec;
+		int j;
+
+		j = 0;
+		spec = pair->one;
+		while (1) {
+			printf("Parent[%d] %s (%s)\n",
+			       j, spec->path, sha1_to_hex(spec->sha1));
+			if (!spec->has_more_entries)
+				break;
+			j++;
+			spec++;
+		}
+		printf("Result    %s (%s)\n",
+		       pair->two->path, sha1_to_hex(pair->two->sha1));
+	}
+}
+
+int cmd_demo(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+
+	init_revisions(&rev, prefix);
+	rev.diff = 1;
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	cmd_log_init(argc, argv, prefix, &rev, &opt);
+
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = show_paths_callback;
+	rev.diffopt.format_callback_data = NULL;
+	rev.diff = 1;
+	rev.combine_merges = 1;
+	rev.dense_combined_merges = 0;
+	rev.ignore_merges = 0;
+
+	return cmd_log_walk(&rev);
+}
+
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
diff --git a/git.c b/git.c
index 89721d4..34d2381 100644
--- a/git.c
+++ b/git.c
@@ -346,6 +346,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "demo", cmd_demo, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
-- 
1.7.6.557.gcee42
