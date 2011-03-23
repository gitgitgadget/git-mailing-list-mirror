From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/5] squash! revision.c: introduce --min-parents and --max-parents
Date: Wed, 23 Mar 2011 10:38:50 +0100
Message-ID: <0b4b1841cb30b6840782f7d7d38361cefdf66fb5.1300872923.git.git@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 10:42:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Kad-0008Vn-1Z
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab1CWJmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:42:36 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44420 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752788Ab1CWJmd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 05:42:33 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AE60220521;
	Wed, 23 Mar 2011 05:42:32 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 05:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=zc/HatwONDORViWuQLh4hk5xjuM=; b=kmrzOlIjkSa8ftOcIT4CEbPclsiWAPLwZjtVTPM8tVm7cLXPyTxnG5DpU12HNk2uK2529jAuff4vhDItBtaMS0yl1kx6+kd+yYCArvvTAI9rlyMLieYIx6ioMp+UD84JywISOBB7nK52ktG/pi64mS/6SNi3ulmVjbwDsqK2rUE=
X-Sasl-enc: +WsLsHBjgQrA4piZZytmQxLjaWKWxl6hJdElQBvUm8Zu 1300873352
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1A17A408DD3;
	Wed, 23 Mar 2011 05:42:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <20110321105628.GC16334@sigill.intra.peff.net>
In-Reply-To: <cover.1300872923.git.git@drmicha.warpmail.net>
References: <cover.1300872923.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169808>

Also, introduce --no-min-parents and --no-max-parents to do the obvious
thing for convenience.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/rev-list.c  |    2 ++
 builtin/rev-parse.c |    2 ++
 revision.c          |    4 ++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7b276e0..9bfb942 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -17,7 +17,9 @@ static const char rev_list_usage[] =
 "    --sparse\n"
 "    --no-merges\n"
 "    --min-parents=<n>\n"
+"    --no-min-parents\n"
 "    --max-parents=<n>\n"
+"    --no-max-parents\n"
 "    --remove-empty\n"
 "    --all\n"
 "    --branches\n"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9940546..adb1cae 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -49,7 +49,9 @@ static int is_rev_argument(const char *arg)
 		"--min-age=",
 		"--no-merges",
 		"--min-parents=",
+		"--no-min-parents",
 		"--max-parents=",
+		"--no-max-parents",
 		"--objects",
 		"--objects-edge",
 		"--parents",
diff --git a/revision.c b/revision.c
index 8d48870..0f38364 100644
--- a/revision.c
+++ b/revision.c
@@ -1283,8 +1283,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->max_parents = 1;
 	} else if (!prefixcmp(arg, "--min-parents=")) {
 		revs->min_parents = atoi(arg+14);
+	} else if (!prefixcmp(arg, "--no-min-parents")) {
+		revs->min_parents = 0;
 	} else if (!prefixcmp(arg, "--max-parents=")) {
 		revs->max_parents = atoi(arg+14);
+	} else if (!prefixcmp(arg, "--no-max-parents")) {
+		revs->max_parents = -1;
 	} else if (!strcmp(arg, "--boundary")) {
 		revs->boundary = 1;
 	} else if (!strcmp(arg, "--left-right")) {
-- 
1.7.4.1.511.g72e46
