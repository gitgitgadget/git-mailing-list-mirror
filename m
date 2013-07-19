From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] status_printf_ln: Suppress false positive warnings of empty format string.
Date: Fri, 19 Jul 2013 16:08:09 +0200
Message-ID: <1374242889-14239-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: peff@peff.net, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 16:08:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0BM5-0007lH-TE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab3GSOIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 10:08:15 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44157 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3GSOIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 10:08:13 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so681825wiw.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 07:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=a00qAnjJ4kvggNbtVQA0p2vPmdMp0MHfnvkjG1ZKzsE=;
        b=pV1rfrkzA4hK2yRdB0tfHlUCMWOBBwzJDdC/3ENkHg1Bv/j4FjtqC5Ez/QPLwMNwYV
         JyT/wfD7IAbH9yPZO7uhve5GjSwsOfRy1kOugtQFyS7sigFsoqueL7z1sYPAbfUOK/j9
         8hTS8T3J+G7yCZqvwW6vcsLjreXflLp5RvHTnLNURyPoQA5ZWF++Mb7WGPkFDcAhNds7
         2cGZeJJnIktm/jN99Is+sks+9XvM88s2BI/VyIzRuCuWf4uHaXeZ/fXAc848uUkrX8Xq
         jGkGwv1IiTMEATRSv54aPkYwxmq8QdnH9F22tPwA2DTETiIim81B5oHn5r4kgWEVLyav
         9k0A==
X-Received: by 10.194.108.73 with SMTP id hi9mr1195246wjb.85.1374242891849;
        Fri, 19 Jul 2013 07:08:11 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fb9sm48706799wid.2.2013.07.19.07.08.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 07:08:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230806>

This is a response to 8dd0ee823f1829a3aa228c3c73e31de5c89b5317.

Instead of having an empty string as format for the printf like function
status_printf_ln, we could insert an empty string into the format
parameter.

A similar fixup commit is found in linux (2e4c332913b5), but there
the empty string is replaced by a string containing one whitespace.

To determine, which approach is better I setup 2 test programs, which
either have a whitespace format (" ") or the empty string ("%s", ""),
looking like:
-
	#include <stdlib.h>
	#include <stdio.h>
	int main (int argc, char** argv) {
		long i;
		for (i = 0; i < 1024*1024*1024; ++i)
			printf(" ");
	}
-
Checking the required time of the programs, while redirecting the actual
output (the billion white spaces compared to nothing) to /dev/null
indicates that the approach used in this patch is faster regardless
of the optimization level of gcc.

Also this patch doesn't change output, which favors this approach over
the whitespace approach.

The only thing left to discuss, whether this patch is worth it, as it
only suppresses false positive warnings from gcc, but makes the
code slightly harder to read.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/commit.c |  2 +-
 wt-status.c      | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 65cf2a7..34bc274 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -773,7 +773,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				committer_ident.buf);
 
 		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/wt-status.c b/wt-status.c
index cb24f1f..912ed88 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -179,7 +179,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
@@ -195,7 +195,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -214,7 +214,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_other_header(struct wt_status *s,
@@ -226,12 +226,12 @@ static void wt_status_print_other_header(struct wt_status *s,
 	if (!advice_status_hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
-	status_printf_ln(s, c, "");
+	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
 
 #define quote_path quote_path_relative
@@ -1192,7 +1192,7 @@ void wt_status_print(struct wt_status *s)
 				on_what = _("Not currently on any branch.");
 			}
 		}
-		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
@@ -1205,9 +1205,9 @@ void wt_status_print(struct wt_status *s)
 	free(state.detached_from);
 
 	if (s->is_initial) {
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
 	wt_status_print_updated(s);
@@ -1224,7 +1224,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
-			status_printf_ln(s, GIT_COLOR_NORMAL, "");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					 _("It took %.2f seconds to enumerate untracked files. 'status -uno'\n"
 					   "may speed it up, but you have to be careful not to forget to add\n"
-- 
1.8.3.3.754.g9c3c367.dirty
