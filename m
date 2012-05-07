From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] status: fix null termination with "-b"
Date: Mon, 7 May 2012 17:24:38 -0400
Message-ID: <20120507212438.GD19567@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVQD-0007QP-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab2EGVYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:24:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33255
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932301Ab2EGVYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:24:40 -0400
Received: (qmail 27489 invoked by uid 107); 7 May 2012 21:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:24:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:24:38 -0400
Content-Disposition: inline
In-Reply-To: <20120507212125.GA19532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197312>

When the "-z" option is given to status, we are supposed to
NUL-terminate each record. However, the "-b" code to show
the tracking branch did not respect this, and always ended
with a newline.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7508-status.sh | 9 +++++++++
 wt-status.c       | 7 ++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8f5cfac..f60f49b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -295,6 +295,15 @@ test_expect_success 'status -s -b' '
 
 '
 
+test_expect_success 'status -s -z -b' '
+	tr "\\n" Q <expect >expect.q &&
+	mv expect.q expect &&
+	git status -s -z -b >output &&
+	nul_to_q <output >output.q &&
+	mv output.q output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup dir3' '
 	mkdir dir3 &&
 	: >dir3/untracked1 &&
diff --git a/wt-status.c b/wt-status.c
index 284dc61..21c0d4d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -913,8 +913,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		color_fprintf_ln(s->fp, branch_color_local,
-			"%s", branch_name);
+		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
 	}
 
@@ -938,7 +938,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	}
 
-	color_fprintf_ln(s->fp, header_color, "]");
+	color_fprintf(s->fp, header_color, "]");
+	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
 
 void wt_shortstatus_print(struct wt_status *s, int show_branch)
-- 
1.7.10.1.12.gd79f7ab
