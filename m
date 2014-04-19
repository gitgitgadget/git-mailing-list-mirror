From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] run_external_diff: hoist common bits out of conditional
Date: Sat, 19 Apr 2014 15:20:46 -0400
Message-ID: <20140419192045.GA9189@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbaom-0003ee-IF
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbaDSTUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:20:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:34501 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161024AbaDSTUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:20:48 -0400
Received: (qmail 26759 invoked by uid 102); 19 Apr 2014 19:20:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:20:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:20:46 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246535>

Whether we have diff_filespecs to give to the diff command
or not, we always are going to run the program and pass it
the pathname. Let's pull that duplicated part out of the
conditional to make it more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index fdb7f6c..173b657 100644
--- a/diff.c
+++ b/diff.c
@@ -2907,26 +2907,24 @@ static void run_external_diff(const char *pgm,
 	struct argv_array env = ARGV_ARRAY_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
+	argv_array_push(&argv, pgm);
+	argv_array_push(&argv, name);
+
 	if (one && two) {
 		struct diff_tempfile *temp_one, *temp_two;
 		const char *othername = (other ? other : name);
 		temp_one = prepare_temp_file(name, one);
 		temp_two = prepare_temp_file(othername, two);
-		argv_array_push(&argv, pgm);
-		argv_array_push(&argv, name);
 		argv_array_push(&argv, temp_one->name);
 		argv_array_push(&argv, temp_one->hex);
 		argv_array_push(&argv, temp_one->mode);
 		argv_array_push(&argv, temp_two->name);
 		argv_array_push(&argv, temp_two->hex);
 		argv_array_push(&argv, temp_two->mode);
 		if (other) {
 			argv_array_push(&argv, other);
 			argv_array_push(&argv, xfrm_msg);
 		}
-	} else {
-		argv_array_push(&argv, pgm);
-		argv_array_push(&argv, name);
 	}
 
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
-- 
1.9.1.656.ge8a0637
