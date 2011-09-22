From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] format-patch: use branch description in cover letter
Date: Thu, 22 Sep 2011 15:09:18 -0700
Message-ID: <1316729362-7714-3-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSl-0007M2-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab1IVWJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab1IVWJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BB06ED1
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4roc
	GJWeNKtsvS2bPhaq8l2Wq5E=; b=eXRpTVLACHvNzxIPTg8PY8XGZs22tAzoGmze
	LO1iw49mFsudqRKC7QrncD42H99cMpLpmimqEMI+VeqG5eX74agCZU+3GRj33evB
	uqRlfZFXbDFTUrCIzZLXCQOqTIiIsXPB6g/Z04zGR1uuIYtNS/oaDXpeYJlupGQG
	sc3nh4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=cJcm2F
	Q/gI1oJZPXecsN+g6s267tN8CaovCz96KFYZVkSfh4kCt+T1GWEBvg/S6VMxIhoG
	aKjgPzkTY/l8AT+ftCsIMxqK4d0VfQnJ/h+oYpyaEVCku1HlbwTU4vDM0RuSZOIK
	MKsV8x7rzGyRZFOZ1DblO/FhsAEESuwFyLSMc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EFB56ECF
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACBEE6ECE for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 89C92F44-E567-11E0-AA99-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181926>

Use the description for the branch when preparing the cover letter
when available.

While at it, mark a loosely written codepath that would do a random and
useless thing given an unusual input (e.g. "^master HEAD HEAD^"), which
we may want to fix someday.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 branch.c      |    2 +-
 builtin/log.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 88da275..50088a4 100644
--- a/branch.c
+++ b/branch.c
@@ -156,7 +156,7 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
 	strbuf_addf(&name, "branch.%s.description", branch_name);
 	cb.config_name = name.buf;
 	cb.value = NULL;
-	if (git_config(read_branch_desc_cb, &cb)) {
+	if (git_config(read_branch_desc_cb, &cb) < 0) {
 		strbuf_release(&name);
 		return -1;
 	}
diff --git a/builtin/log.c b/builtin/log.c
index f5d4930..e80a925 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -19,6 +19,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "branch.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -746,10 +747,24 @@ static void print_signature(void)
 		printf("-- \n%s\n\n", signature);
 }
 
+static void add_branch_description(struct strbuf *buf, const char *branch_name)
+{
+	struct strbuf desc = STRBUF_INIT;
+	if (!branch_name || !*branch_name)
+		return;
+	read_branch_desc(&desc, branch_name);
+	if (desc.len) {
+		strbuf_addch(buf, '\n');
+		strbuf_add(buf, desc.buf, desc.len);
+		strbuf_addch(buf, '\n');
+	}
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int numbered, int numbered_files,
 			      struct commit *origin,
 			      int nr, struct commit **list, struct commit *head,
+			      const char *branch_name,
 			      int quiet)
 {
 	const char *committer;
@@ -807,6 +822,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
 	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
 	pp_remainder(&pp, &msg, &sb, 0);
+	add_branch_description(&sb, branch_name);
 	printf("%s\n", sb.buf);
 
 	strbuf_release(&sb);
@@ -1006,6 +1022,35 @@ static int cc_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static char *find_branch_name(struct rev_info *rev)
+{
+	int i, positive = -1;
+	unsigned char branch_sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+	const char *branch;
+
+	for (i = 0; i < rev->cmdline.nr; i++) {
+		if (rev->cmdline.rev[i].flags & UNINTERESTING)
+			continue;
+		if (positive < 0)
+			positive = i;
+		else
+			return NULL;
+	}
+	if (positive < 0)
+		return NULL;
+	strbuf_addf(&buf, "refs/heads/%s", rev->cmdline.rev[positive].name);
+	branch = resolve_ref(buf.buf, branch_sha1, 1, 0);
+	if (!branch ||
+	    prefixcmp(branch, "refs/heads/") ||
+	    hashcmp(rev->cmdline.rev[positive].item->sha1, branch_sha1))
+		branch = NULL;
+	strbuf_release(&buf);
+	if (branch)
+		return xstrdup(rev->cmdline.rev[positive].name);
+	return NULL;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1027,6 +1072,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
+	char *branch_name = NULL;
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    "use [PATCH n/m] even with a single patch",
@@ -1217,8 +1263,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			 * origin" that prepares what the origin side still
 			 * does not have.
 			 */
+			unsigned char sha1[20];
+			const char *ref;
+
 			rev.pending.objects[0].item->flags |= UNINTERESTING;
 			add_head_to_pending(&rev);
+			ref = resolve_ref("HEAD", sha1, 1, NULL);
+			if (ref && !prefixcmp(ref, "refs/heads/"))
+				branch_name = xstrdup(ref + strlen("refs/heads/"));
+			else
+				branch_name = xstrdup(""); /* no branch */
 		}
 		/*
 		 * Otherwise, it is "format-patch -22 HEAD", and/or
@@ -1234,16 +1288,26 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.show_root_diff = 1;
 
 	if (cover_letter) {
-		/* remember the range */
+		/*
+		 * NEEDSWORK:randomly pick one positive commit to show
+		 * diffstat; this is often the tip and the command
+		 * happens to do the right thing in most cases, but a
+		 * complex command like "--cover-letter a b c ^bottom"
+		 * picks "c" and shows diffstat between bottom..c
+		 * which may not match what the series represents at
+		 * all and totally broken.
+		 */
 		int i;
 		for (i = 0; i < rev.pending.nr; i++) {
 			struct object *o = rev.pending.objects[i].item;
 			if (!(o->flags & UNINTERESTING))
 				head = (struct commit *)o;
 		}
-		/* We can't generate a cover letter without any patches */
+		/* There is nothing to show; it is not an error, though. */
 		if (!head)
 			return 0;
+		if (!branch_name)
+			branch_name = find_branch_name(&rev);
 	}
 
 	if (ignore_if_in_upstream) {
@@ -1294,7 +1358,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
-				  origin, nr, list, head, quiet);
+				  origin, nr, list, head, branch_name, quiet);
 		total++;
 		start_number--;
 	}
@@ -1366,6 +1430,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			fclose(stdout);
 	}
 	free(list);
+	free(branch_name);
 	string_list_clear(&extra_to, 0);
 	string_list_clear(&extra_cc, 0);
 	string_list_clear(&extra_hdr, 0);
-- 
1.7.7.rc2.4.g5ec82
