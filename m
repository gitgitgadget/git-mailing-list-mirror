From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/10] log: add --use-mailmap option
Date: Mon,  7 Jan 2013 16:10:18 -0800
Message-ID: <1357603821-8647-8-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMme-0006ZE-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab3AHAKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab3AHAKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E2AB7BD;
	Mon,  7 Jan 2013 19:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qfdr
	DnzIKKKipWVkylrZqtITjnw=; b=boRDLs9H8f7TWY3UtS3GOF8KYb26u7yhlZ60
	MFOGhFD3nnwcwERpZusytYC2gp5kCVeQkO8Oinqfm2XqsgIoxfAcjkZg2JfUegaR
	mnC5/dOnrhNqkuyb5rKcVJNvwylV4RoiXjjgiXN61e0l6y0o6WfSp0Tnm+9XMZ/c
	FX45Anw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	sybxZAlUoOYwAmvF2ImMMNBWXFJ/Un1KFoyFcVtKE8XMZzt/DLx1IoZY/aOCq6Ca
	3PlxYdvlUf2JCqMhrnkrRn8PSob2xL6eD3aKO32EbC1XGIIvIUnKeBdUCf9KMGdk
	/wuUAqSGCC3yXmJpZATtwIpv6MPnAJOcsinytGDNfcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73948B7BC;
	Mon,  7 Jan 2013 19:10:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA60BB7BB; Mon,  7 Jan 2013
 19:10:38 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D5199DC8-5927-11E2-95FF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212925>

From: Antoine Pelisse <apelisse@gmail.com>

Add the --use-mailmap option to log commands. It allows to display
names from mailmap file when displaying logs, whatever the format
used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-log.txt | 5 +++++
 builtin/log.c             | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 585dac4..a99be97 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -47,6 +47,11 @@ OPTIONS
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
+--use-mailmap::
+	Use mailmap file to map author and committer names and email
+	to canonical real names and email addresses. See
+	linkgit:git-shortlog[1].
+
 --full-diff::
 	Without this flag, "git log -p <path>..." shows commits that
 	touch the specified paths, and diffs about the same specified
diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..d2bd8ce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -22,6 +22,7 @@
 #include "branch.h"
 #include "streaming.h"
 #include "version.h"
+#include "mailmap.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -94,11 +95,12 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	struct userformat_want w;
-	int quiet = 0, source = 0;
+	int quiet = 0, source = 0, mailmap = 0;
 
 	const struct option builtin_log_options[] = {
 		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
 		OPT_BOOLEAN(0, "source", &source, N_("show source")),
+		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mail map file")),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
@@ -136,6 +138,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
+	if (mailmap) {
+		rev->mailmap = xcalloc(1, sizeof(struct string_list));
+		read_mailmap(rev->mailmap, NULL);
+	}
+
 	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
 		/*
 		 * "log --pretty=raw" is special; ignore UI oriented
-- 
1.8.1.304.gf036638
