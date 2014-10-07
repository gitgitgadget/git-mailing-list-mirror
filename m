From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Tue, 7 Oct 2014 15:16:57 -0400
Message-ID: <20141007191656.GB32374@peff.net>
References: <5430427A.5080800@web.de>
 <20141005224919.GA19998@google.com>
 <20141006011827.GA11027@peff.net>
 <xmqqtx3fg31w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:17:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbaFs-0001h7-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 21:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbaJGTRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 15:17:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:55871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932080AbaJGTQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 15:16:59 -0400
Received: (qmail 28934 invoked by uid 102); 7 Oct 2014 19:16:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 14:16:59 -0500
Received: (qmail 8518 invoked by uid 107); 7 Oct 2014 19:16:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 15:16:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 15:16:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtx3fg31w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257947>

On Tue, Oct 07, 2014 at 11:14:35AM -0700, Junio C Hamano wrote:

> > The fix you proposed below is along the same line, and looks good to me
> > (and grepping for 'var *+ *ofs' shows only the two sites you found, so
> > hopefully that is the last of it).
> 
> So perhaps we would want this change as a preliminary separate
> patch?

Here it is on top of master, with a commit message (and including the
other case you found). I've attributed it to Jonathan, who did most of
the work. We'd need his signoff and approval, of course.

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Subject: pass config slots as pointers instead of offsets

Many config-parsing helpers, like parse_branch_color_slot,
take the name of a config variable and an offset to the
"slot" name (e.g., "color.branch.plain" is passed along with
"13" to effectively pass "plain"). This is leftover from the
time that these functions would die() on error, and would
want the full variable name for error reporting.

These days they do not use the full variable name at all.
Passing a single pointer to the slot name is more natural,
and lets us more easily adjust the callers to use skip_prefix
to avoid manually writing offset numbers.

This is effectively a continuation of 9e1a5eb, which did the
same for parse_diff_color_slot. This patch covers all of the
remaining similar constructs.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, parse_decorate_color_config is slightly odd in that it takes
the variable and the slot_name after this patch. That's because it
passes the full variable name to color_parse, which does still die() on
error. Perhaps it should be converted to return an error, too.

 builtin/branch.c | 16 ++++++++--------
 builtin/commit.c | 19 +++++++++----------
 builtin/log.c    |  2 +-
 log-tree.c       |  4 ++--
 log-tree.h       |  2 +-
 5 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9e4666f..2c97141 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -62,19 +62,19 @@ static unsigned char merge_filter_ref[20];
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
-static int parse_branch_color_slot(const char *var, int ofs)
+static int parse_branch_color_slot(const char *slot)
 {
-	if (!strcasecmp(var+ofs, "plain"))
+	if (!strcasecmp(slot, "plain"))
 		return BRANCH_COLOR_PLAIN;
-	if (!strcasecmp(var+ofs, "reset"))
+	if (!strcasecmp(slot, "reset"))
 		return BRANCH_COLOR_RESET;
-	if (!strcasecmp(var+ofs, "remote"))
+	if (!strcasecmp(slot, "remote"))
 		return BRANCH_COLOR_REMOTE;
-	if (!strcasecmp(var+ofs, "local"))
+	if (!strcasecmp(slot, "local"))
 		return BRANCH_COLOR_LOCAL;
-	if (!strcasecmp(var+ofs, "current"))
+	if (!strcasecmp(slot, "current"))
 		return BRANCH_COLOR_CURRENT;
-	if (!strcasecmp(var+ofs, "upstream"))
+	if (!strcasecmp(slot, "upstream"))
 		return BRANCH_COLOR_UPSTREAM;
 	return -1;
 }
@@ -88,7 +88,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (starts_with(var, "color.branch.")) {
-		int slot = parse_branch_color_slot(var, 13);
+		int slot = parse_branch_color_slot(var + 13);
 		if (slot < 0)
 			return 0;
 		if (!value)
diff --git a/builtin/commit.c b/builtin/commit.c
index b0fe784..c45613a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1271,22 +1271,21 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
 	return commitable ? 0 : 1;
 }
 
-static int parse_status_slot(const char *var, int offset)
+static int parse_status_slot(const char *slot)
 {
-	if (!strcasecmp(var+offset, "header"))
+	if (!strcasecmp(slot, "header"))
 		return WT_STATUS_HEADER;
-	if (!strcasecmp(var+offset, "branch"))
+	if (!strcasecmp(slot, "branch"))
 		return WT_STATUS_ONBRANCH;
-	if (!strcasecmp(var+offset, "updated")
-		|| !strcasecmp(var+offset, "added"))
+	if (!strcasecmp(slot, "updated") || !strcasecmp(slot, "added"))
 		return WT_STATUS_UPDATED;
-	if (!strcasecmp(var+offset, "changed"))
+	if (!strcasecmp(slot, "changed"))
 		return WT_STATUS_CHANGED;
-	if (!strcasecmp(var+offset, "untracked"))
+	if (!strcasecmp(slot, "untracked"))
 		return WT_STATUS_UNTRACKED;
-	if (!strcasecmp(var+offset, "nobranch"))
+	if (!strcasecmp(slot, "nobranch"))
 		return WT_STATUS_NOBRANCH;
-	if (!strcasecmp(var+offset, "unmerged"))
+	if (!strcasecmp(slot, "unmerged"))
 		return WT_STATUS_UNMERGED;
 	return -1;
 }
@@ -1324,7 +1323,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (starts_with(k, "status.color.") || starts_with(k, "color.status.")) {
-		int slot = parse_status_slot(k, 13);
+		int slot = parse_status_slot(k + 13);
 		if (slot < 0)
 			return 0;
 		if (!v)
diff --git a/builtin/log.c b/builtin/log.c
index 2fb34c7..9c75447 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -389,7 +389,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (starts_with(var, "color.decorate."))
-		return parse_decorate_color_config(var, 15, value);
+		return parse_decorate_color_config(var, var + 15, value);
 	if (!strcmp(var, "log.mailmap")) {
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
diff --git a/log-tree.c b/log-tree.c
index bcee7c5..877d976 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -56,9 +56,9 @@ static int parse_decorate_color_slot(const char *slot)
 	return -1;
 }
 
-int parse_decorate_color_config(const char *var, const int ofs, const char *value)
+int parse_decorate_color_config(const char *var, const char *slot_name, const char *value)
 {
-	int slot = parse_decorate_color_slot(var + ofs);
+	int slot = parse_decorate_color_slot(slot_name);
 	if (slot < 0)
 		return 0;
 	if (!value)
diff --git a/log-tree.h b/log-tree.h
index d6ecd4d..8cbefac 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -7,7 +7,7 @@ struct log_info {
 	struct commit *commit, *parent;
 };
 
-int parse_decorate_color_config(const char *var, const int ofs, const char *value);
+int parse_decorate_color_config(const char *var, const char *slot_name, const char *value);
 void init_log_tree_opt(struct rev_info *);
 int log_tree_diff_flush(struct rev_info *);
 int log_tree_commit(struct rev_info *, struct commit *);
-- 
2.1.1.566.gdb1f904
