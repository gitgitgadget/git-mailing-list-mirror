From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] status: --ignored option shows ignored files
Date: Sat, 10 Apr 2010 00:40:56 -0700
Message-ID: <1270885256-31589-6-git-send-email-gitster@pobox.com>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VK1-0000V7-Cp
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0DJHlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0DJHlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A66CA9558
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ey/I
	J39a7gsuCJ0pe1LozUrZ8H8=; b=Eir3K+wItBmKSJ5pNSkP6ODxFFS8Dr0EaufT
	Rf4BLJTHhiKS6VgLxKBLT335MS34FIQggGR2KyO3aJaWb7Dx9h2yRHcic+NtU8Gk
	K4bsoTXJUT0pJAZRb/mHlOzoze9b1zNha325Z8q3LsnqHlUvfEj4MuM6SwGBcaBI
	lqWl9bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=MNTDu3
	kEhdfU3HrZrzlPL3F6gJFkbZoyxbEOXzWFTKBW7BxBqo7MC4qkFErsL+puej1TbN
	bwvG9aH50SVVUDdAcU24ajWE+gxTmZ2vyL9pTLyvqjo4lKZGMqAH+Tj35fUKbTQ6
	xTHKUcoYKzIgIhd1wc/vNx9XZU+kz/Somwt8c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CB5A9557
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EA5DA9556 for
 <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6E2D8220-4474-11DF-88E3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144528>

There is no stronger reason behind the choice of "!!" than just I happened
to have typed them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c |    6 +++++-
 wt-status.c      |   22 +++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..761ca07 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -83,6 +83,7 @@ static enum {
 static char *cleanup_arg;
 
 static int use_editor = 1, initial_commit, in_merge, include_status = 1;
+static int show_ignored_in_status;
 static const char *only_include_assumed;
 static struct strbuf message;
 
@@ -1031,6 +1032,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  "mode",
 		  "show untracked files, optional modes: all, normal, no. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_BOOLEAN(0, "ignored", &show_ignored_in_status,
+			    "show ignored files"),
 		OPT_END(),
 	};
 
@@ -1044,7 +1047,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			     builtin_status_options,
 			     builtin_status_usage, 0);
 	handle_untracked_files_arg(&s);
-
+	if (show_ignored_in_status)
+		s.show_ignored_files = 1;
 	if (*argv)
 		s.pathspec = get_pathspec(prefix, argv);
 
diff --git a/wt-status.c b/wt-status.c
index 2c9a05d..7bda995 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -646,9 +646,11 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 0);  /* staged */
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
-	if (s->show_untracked_files)
+	if (s->show_untracked_files) {
 		wt_status_print_other(s, &s->untracked, "Untracked", "add");
-	else if (s->commitable)
+		if (s->show_ignored_files)
+			wt_status_print_other(s, &s->ignored, "Ignored", "add -f");
+	} else if (s->commitable)
 		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
 	if (s->verbose)
@@ -730,16 +732,16 @@ static void wt_shortstatus_status(int null_termination, struct string_list_item
 	}
 }
 
-static void wt_shortstatus_untracked(int null_termination, struct string_list_item *it,
-			    struct wt_status *s)
+static void wt_shortstatus_other(int null_termination, struct string_list_item *it,
+				 struct wt_status *s, const char *sign)
 {
 	if (null_termination) {
-		fprintf(stdout, "?? %s%c", it->string, 0);
+		fprintf(stdout, "%s %s%c", sign, it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, -1, &onebuf, s->prefix);
-		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "??");
+		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), sign);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -763,7 +765,13 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination)
 		struct string_list_item *it;
 
 		it = &(s->untracked.items[i]);
-		wt_shortstatus_untracked(null_termination, it, s);
+		wt_shortstatus_other(null_termination, it, s, "??");
+	}
+	for (i = 0; i < s->ignored.nr; i++) {
+		struct string_list_item *it;
+
+		it = &(s->ignored.items[i]);
+		wt_shortstatus_other(null_termination, it, s, "!!");
 	}
 }
 
-- 
1.7.1.rc0.264.g94f6e
