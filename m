From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: [PATCH] progress: use \r as EOL only if isatty(stderr) is true
Date: Tue, 28 Jun 2011 16:40:09 +0200
Message-ID: <1309272009-23076-1-git-send-email-sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 16:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbZYP-0005Ky-95
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 16:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab1F1Oli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 10:41:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43085 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758294Ab1F1OlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 10:41:01 -0400
Received: by bwd5 with SMTP id 5so242163bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        bh=x4c3Cqv1YDBTx+/mzAO7o5fF2NygtziiZgGpUGKbicA=;
        b=Z96z26eHh/fXw5lZfIvizeAzVwVXJ5y6wdFmptmJs8eNCzIv0eJ2wTgRrkfo88267d
         xNrZAuraes2KRsF+GBf+6bwgtjFur4xkp0kHzTO+6W+o3eqn86D7cCDa6J1fsiUfaA33
         0v52Us1LJZ5PX3esvXYjExGjm9buwY5MMc6s8=
Received: by 10.204.75.94 with SMTP id x30mr4121039bkj.79.1309272059638;
        Tue, 28 Jun 2011 07:40:59 -0700 (PDT)
Received: from localhost.localdomain ([82.113.99.172])
        by mx.google.com with ESMTPS id l24sm276881bkw.3.2011.06.28.07.40.57
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 07:40:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176402>

So far progress always uses \r to produce one-line output on stderr.
This only produces useful and easy parsable output if stderr is opened
on a file which does interpret CR as a real carriage return operation.
This patch changes EOL to the plain newline \n control if isatty() is
false instead.

Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 progress.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..c548de4 100644
--- a/progress.c
+++ b/progress.c
@@ -27,6 +27,7 @@ struct throughput {
 
 struct progress {
 	const char *title;
+	const char *eol;
 	int last_value;
 	unsigned total;
 	unsigned last_percent;
@@ -90,7 +91,7 @@ static int display(struct progress *progress, unsigned n, const char *done)
 
 	progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display : "";
-	eol = done ? done : "   \r";
+	eol = done ? done : progress->eol;
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
@@ -219,6 +220,7 @@ struct progress *start_progress_delay(const char *title, unsigned total,
 		return NULL;
 	}
 	progress->title = title;
+	progress->eol = isatty(fileno(stderr)) ? "   \r" : "\n";
 	progress->total = total;
 	progress->last_value = -1;
 	progress->last_percent = -1;
-- 
1.7.6.rc0
