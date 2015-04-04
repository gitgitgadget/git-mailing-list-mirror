From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: [PATCH v2 1/5] revision: add --merges={show|only|hide} option
Date: Sat,  4 Apr 2015 03:21:57 +0200
Message-ID: <1428110521-31028-1-git-send-email-koosha@posteo.de>
References: <266077>
Cc: sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 03:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeCno-00085F-OO
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 03:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbbDDBXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 21:23:07 -0400
Received: from mx02.posteo.de ([89.146.194.165]:60065 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbDDBXD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 21:23:03 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id BA05F25AF52E;
	Sat,  4 Apr 2015 03:23:00 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lJgP00ZVPz5vN4;
	Sat,  4 Apr 2015 03:22:59 +0200 (CEST)
X-Mailer: git-send-email 2.3.3.263.g095251d.dirty
In-Reply-To: <266077>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266754>

From: Junio C Hamano <gitster@pobox.com>

revision: add a new option 'merges=' with
possible values of 'only', 'show' and 'hide'.
The option is used when showing the list of commits.
The value 'only' lists only merges. The value 'show'
is the default behavior which shows the commits as well
as merges and the value 'hide' makes it just list commit
items.

[kk: chose names for options; wrote commit message]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
---
 revision.c | 20 ++++++++++++++++++++
 revision.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/revision.c b/revision.c
index 6399a04..c3c3dcc 100644
--- a/revision.c
+++ b/revision.c
@@ -1678,6 +1678,23 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+int parse_merges_opt(struct rev_info *revs, const char *param)
+{
+	if (!strcmp(param, "show")) {
+		revs->min_parents = 0;
+		revs->max_parents = -1;
+	} else if (!strcmp(param, "only")) {
+		revs->min_parents = 2;
+		revs->max_parents = -1;
+	} else if (!strcmp(param, "hide")) {
+		revs->min_parents = 0;
+		revs->max_parents = 1;
+	} else {
+		return -1;
+	}
+	return 0;
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv)
 {
@@ -1800,6 +1817,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_all = 1;
 	} else if (!strcmp(arg, "--remove-empty")) {
 		revs->remove_empty_trees = 1;
+	} else if (starts_with(arg, "--merges=")) {
+		if (parse_merges_opt(revs, arg + 9))
+			die("unknown option: %s", arg);
 	} else if (!strcmp(arg, "--merges")) {
 		revs->min_parents = 2;
 	} else if (!strcmp(arg, "--no-merges")) {
diff --git a/revision.h b/revision.h
index 0ea8b4e..f9df58c 100644
--- a/revision.h
+++ b/revision.h
@@ -240,6 +240,7 @@ extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			       const struct option *options,
 			       const char * const usagestr[]);
+extern int parse_merges_opt(struct rev_info *, const char *);
 #define REVARG_CANNOT_BE_FILENAME 01
 #define REVARG_COMMITTISH 02
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,
-- 
2.3.3.263.g095251d.dirty
