From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] format-patch: add --reroll-count=$N option
Date: Sat, 22 Dec 2012 00:33:32 -0800
Message-ID: <1356165212-5611-8-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKX1-0007tg-OP
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab2LVIdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2LVIdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5938295
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=to7Z
	gtz8aihBtBh2Se9E7CT5EWQ=; b=NgvSFqsEgZy10QrbYlVxBI7zrRCwgw+y5fj1
	tBvV1As4rtyeLGKgr6Y5uAp5a+D1MEP83R5bdBC/2Y9BglrJ1iAl+Frp92EvWHmL
	l9X/mm69f8l/lAdxVETpernhMZGwTpbJVrNCd8u/u/r7f303v/e2RDnXrNpw4Gmn
	z7rry60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TUyNvz
	svAeL9ZfEMur4r1oJ37pUY1ZOXSRe7oiRNUra+Tl7Sn4zfdP8103i6hCk4aQoQ8v
	CaCyfWZ7bXCDpnFeLr7ly1MUmTK36V1NS1bU3YDmA1e9XMbXqOrbMLKjl5kseEDE
	jnt9cXg7KbEGM3wI8yFV1lA5yM8+bhhSw6RaQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA098294
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C4D78292 for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:48 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4E4B6866-4C12-11E2-81D3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212040>

The --reroll-count=$N option, when given a positive integer:

 - Adds " v$N" to the subject prefix specified.  As the default
   subject prefix string is "PATCH", --reroll-count=2 makes it
   "PATCH v2".

 - Prefixes "v$N-" to the names used for output files.  The cover
   letter, whose name is usually 0000-cover-letter.patch, becomes
   v2-0000-cover-letter.patch when given --reroll-count=2.

This allows users to use the same --output-directory for multiple
iterations of the same series, without letting the output for a
newer round overwrite output files from the earlier rounds.  The
user can incorporate materials from earlier rounds to update the
newly minted iteration, and use "send-email v2-*.patch" to send out
the patches belonging to the second iteration easily.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 11 +++++++++++
 log-tree.c    |  2 ++
 revision.h    |  1 +
 3 files changed, 14 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8cfb4da..e101498 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1061,6 +1061,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	int use_patch_format = 0;
 	int quiet = 0;
+	int reroll_count = -1;
 	char *branch_name = NULL;
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
@@ -1080,6 +1081,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
 			    N_("start numbering patches at <n> instead of 1")),
+		OPT_INTEGER(0, "reroll-count", &reroll_count,
+			    N_("mark the series as Nth re-roll")),
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
@@ -1152,6 +1155,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (0 < reroll_count) {
+		struct strbuf sprefix = STRBUF_INIT;
+		strbuf_addf(&sprefix, "%s v%d",
+			    rev.subject_prefix, reroll_count);
+		rev.reroll_count = reroll_count;
+		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
+	}
+
 	if (do_signoff) {
 		const char *committer;
 		const char *endpos;
diff --git a/log-tree.c b/log-tree.c
index 670beae..5dc126b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -308,6 +308,8 @@ void fmt_output_subject(struct strbuf *filename,
 	int start_len = filename->len;
 	int max_len = start_len + FORMAT_PATCH_NAME_MAX - (strlen(suffix) + 1);
 
+	if (0 < info->reroll_count)
+		strbuf_addf(filename, "v%d-", info->reroll_count);
 	strbuf_addf(filename, "%04d-%s", nr, subject);
 
 	if (max_len < filename->len)
diff --git a/revision.h b/revision.h
index a95bd0b..e4a912a 100644
--- a/revision.h
+++ b/revision.h
@@ -134,6 +134,7 @@ struct rev_info {
 	const char	*mime_boundary;
 	const char	*patch_suffix;
 	int		numbered_files;
+	int		reroll_count;
 	char		*message_id;
 	struct string_list *ref_message_ids;
 	const char	*add_signoff;
-- 
1.8.0.6.gd28b5d4.dirty
