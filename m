From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pass config slots as pointers instead of offsets
Date: Tue, 14 Oct 2014 10:43:41 -0700
Message-ID: <xmqqk342zgvm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe68V-0005GW-En
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 19:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166AbaJNRnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 13:43:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752580AbaJNRnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 13:43:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9913615201;
	Tue, 14 Oct 2014 13:43:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	4ZuWKyqUE1tPTVxwJCE8bts0eQ=; b=fhBOBo/c/b6fwa3kWynkTlGVUSfCmeQOY
	J1u9Ya1ddnBm+TqDXoAhva4zvv2OkdB7ftPnIBQ6zttvrXoHlT92n+imN4VdSI6c
	zFJyDgz7T6BpSs/bCHJIKNS+nKG43BvCmGRPbuXIRbrDCHG0GOq0Q/90BuxE70RF
	y5AGYReUrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=O77St41PuypMp+3sp3iNn3+ha/ikfDpCf4e3zphbwky5H6gJZmtTyAxr
	iu7WX1pLMvtFhmQ4dYEQB4Gpvu4ptZQY2JlmpOevFEM4cAkvfrLYkowdcmDEfB60
	n0ujttF3ovc92m97qObGHNrBlQyaGCc+ntnXSlPg8aJ9MrK5jaY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FB5115200;
	Tue, 14 Oct 2014 13:43:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E562151FF;
	Tue, 14 Oct 2014 13:43:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A423382A-53C9-11E4-8032-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Tue, 7 Oct 2014 15:16:57 -0400

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Can we have your Sign-off (and a quick eyeballing again), please?

 builtin/branch.c | 16 ++++++++--------
 builtin/commit.c | 19 +++++++++----------
 builtin/log.c    |  2 +-
 log-tree.c       |  4 ++--
 log-tree.h       |  2 +-
 5 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0591b22..b2e1895c 100644
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
index 5ed6036..5a8a29e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1238,22 +1238,21 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
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
@@ -1291,7 +1290,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (starts_with(k, "status.color.") || starts_with(k, "color.status.")) {
-		int slot = parse_status_slot(k, 13);
+		int slot = parse_status_slot(k + 13);
 		if (slot < 0)
 			return 0;
 		if (!v)
diff --git a/builtin/log.c b/builtin/log.c
index 4389722..4c5fc4b 100644
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
index 95e9b1d..479b1d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -66,9 +66,9 @@ static int parse_decorate_color_slot(const char *slot)
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
2.1.2-487-ga3682c8
