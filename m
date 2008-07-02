From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git-status: show the remote tracking statistics
Date: Wed, 02 Jul 2008 00:52:16 -0700
Message-ID: <7vod5gen9r.fsf@gitster.siamese.dyndns.org>
References: <20080701091347.GA11817@elte.hu> <80iqvq2bw0.fsf@tiny.isode.net>
 <20080701101414.GG31309@elte.hu> <7vlk0lmn32.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Stephens <bruce.stephens@isode.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 02 09:53:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDx9c-0004kI-4L
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 09:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYGBHwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 03:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbYGBHwb
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 03:52:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYGBHwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 03:52:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69639284B7;
	Wed,  2 Jul 2008 03:52:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7A906284B6; Wed,  2 Jul 2008 03:52:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1E3E88E-480B-11DD-B5E1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87096>

This teaches "git status" to show the same remote tracking statistics
"git checkout" gives at the beginning of the output.

Now the necessary low-level machinery is properly factored out, we can do
this quite cleanly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 28c9e63..eeb106e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "diffcore.h"
 #include "quote.h"
 #include "run-command.h"
+#include "remote.h"
 
 int wt_status_relative_paths = 1;
 int wt_status_use_color = -1;
@@ -315,6 +316,25 @@ static void wt_status_print_verbose(struct wt_status *s)
 	run_diff_index(&rev, 1);
 }
 
+static void wt_status_print_tracking(struct wt_status *s)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *cp, *ep;
+	struct branch *branch;
+
+	assert(s->branch && !s->is_initial);
+	if (prefixcmp(s->branch, "refs/heads/"))
+		return;
+	branch = branch_get(s->branch + 11);
+	if (!format_tracking_info(branch, &sb))
+		return;
+
+	for (cp = sb.buf; (ep = strchr(cp, '\n')) != NULL; cp = ep + 1)
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
+				 "# %.*s", (int)(ep - cp), cp);
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	unsigned char sha1[20];
@@ -333,6 +353,8 @@ void wt_status_print(struct wt_status *s)
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
 		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+		if (!s->is_initial)
+			wt_status_print_tracking(s);
 	}
 
 	if (s->is_initial) {
-- 
1.5.6.1.156.ge903b
