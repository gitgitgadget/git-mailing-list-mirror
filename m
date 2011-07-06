From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/14] revert: Inline add_message_to_msg function
Date: Wed,  6 Jul 2011 07:54:16 +0000
Message-ID: <1309938868-2028-3-git-send-email-artagnon@gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:54:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMwP-0005pA-Ma
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab1GFHyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:54:35 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48564 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab1GFHyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:54:33 -0400
Received: by qyk29 with SMTP id 29so1924487qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lHmqxFrC6BVJJzsZcHaru4Tq5fNfj/eoNfq/mE65yEw=;
        b=STVAr9wHDDHnKDpawoEW/UvrjsGAIOxcGhaiQuUmtpXavGkPdP0bljtaW0fBDODgZC
         1ouOxeV0mk9wxXnJYngeW0QB36yTSrkyQpSRNhvK7m4AskypN27oUiCNOfc51pOXAko+
         Q2DNw+MlK60L0cMP9DRoa87cwUGOZh0bo1Xp0=
Received: by 10.224.32.90 with SMTP id b26mr5895629qad.394.1309938873081;
        Wed, 06 Jul 2011 00:54:33 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id e18sm6212790qcs.5.2011.07.06.00.54.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 00:54:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176649>

The add_message_to_msg function is poorly implemented, has an unclear
API, and only one callsite.  Replace the callsite with a cleaner
implementation.  Additionally, fix a bug introduced in 9509af6 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointer
was being incremented when "\n\n" was not found in "message".

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1f27c63..19d604c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -185,19 +185,6 @@ static char *get_encoding(const char *message)
 	return NULL;
 }
 
-static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
-{
-	const char *p = message;
-	while (*p && (*p != '\n' || p[1] != '\n'))
-		p++;
-
-	if (!*p)
-		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
-
-	p += 2;
-	strbuf_addstr(msgbuf, p);
-}
-
 static void write_cherry_pick_head(void)
 {
 	int fd;
@@ -471,11 +458,16 @@ static int do_pick_commit(void)
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
+		const char *p = strstr(msg.message, "\n\n");
+
 		base = parent;
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		add_message_to_msg(&msgbuf, msg.message);
+
+		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
+		strbuf_addstr(&msgbuf, p);
+
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-- 
1.7.5.GIT
