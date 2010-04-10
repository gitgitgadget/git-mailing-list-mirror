From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] wt-status: rename and restructure status-print-untracked
Date: Sat, 10 Apr 2010 00:40:55 -0700
Message-ID: <1270885256-31589-5-git-send-email-gitster@pobox.com>
References: <1270885256-31589-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 09:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0VJj-0000KR-Tr
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 09:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab0DJHlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 03:41:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab0DJHlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 03:41:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB73A9555
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uacA
	5M/qoh5x+Eu5v5k47Qk33hM=; b=J/WaNT0vVIFQLwASCt8JAReNwNNzlD809VsX
	Yvge3LpQizMlA1YLo2exOJJ6qtArqqQPsd8a+oPLIE5Unk5wR4YATNdlrnGUF7SJ
	6VcXggMsDZMPc2SRaxuLP8nFl/r3eLyC0G+76as4n2FQjGT1QC+wFDU9nbfS8h5c
	bWtAbcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fKyzne
	wGIhNGOPnSMW0RaZNsdRxihukEGAAAGp3uyQk7bcwIL3OomTGhd7Nowb+tq51P5P
	crwkQx2yadl49b+FQ+sWrYZq6kFvAMxqIbeMQOqXtFm943Jv0hlIFBPafxmATw9s
	y7vOyhhe7LZsRGFhHqnIaxXycIjITARyiVdd0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A851A9554
	for <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B929BA9553 for
 <git@vger.kernel.org>; Sat, 10 Apr 2010 03:41:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc0.264.g94f6e
In-Reply-To: <1270885256-31589-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6D2C7EE4-4474-11DF-A34E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144527>

I will be reusing this to show ignored stuff in the next patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index f13c7da..2c9a05d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -97,13 +97,15 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 	color_fprintf_ln(s->fp, c, "#");
 }
 
-static void wt_status_print_untracked_header(struct wt_status *s)
+static void wt_status_print_other_header(struct wt_status *s,
+					 const char *what,
+					 const char *how)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
-	color_fprintf_ln(s->fp, c, "# Untracked files:");
+	color_fprintf_ln(s->fp, c, "# %s files:", what);
 	if (!advice_status_hints)
 		return;
-	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git %s <file>...\" to include in what will be committed)", how);
 	color_fprintf_ln(s->fp, c, "#");
 }
 
@@ -541,7 +543,10 @@ static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitt
 	run_command(&sm_summary);
 }
 
-static void wt_status_print_untracked(struct wt_status *s)
+static void wt_status_print_other(struct wt_status *s,
+				  struct string_list *l,
+				  const char *what,
+				  const char *how)
 {
 	int i;
 	struct strbuf buf = STRBUF_INIT;
@@ -549,10 +554,11 @@ static void wt_status_print_untracked(struct wt_status *s)
 	if (!s->untracked.nr)
 		return;
 
-	wt_status_print_untracked_header(s);
-	for (i = 0; i < s->untracked.nr; i++) {
+	wt_status_print_other_header(s, what, how);
+
+	for (i = 0; i < l->nr; i++) {
 		struct string_list_item *it;
-		it = &(s->untracked.items[i]);
+		it = &(l->items[i]);
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
 		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED, s), "%s",
 				 quote_path(it->string, strlen(it->string),
@@ -641,7 +647,7 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files)
-		wt_status_print_untracked(s);
+		wt_status_print_other(s, &s->untracked, "Untracked", "add");
 	else if (s->commitable)
 		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
 
-- 
1.7.1.rc0.264.g94f6e
