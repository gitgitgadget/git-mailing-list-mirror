From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Thu,  4 Aug 2011 16:09:01 +0530
Message-ID: <1312454356-3070-4-git-send-email-artagnon@gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 12:42:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QovNw-0006rV-Vp
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 12:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab1HDKmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 06:42:37 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62187 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab1HDKmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 06:42:35 -0400
Received: by yia27 with SMTP id 27so962642yia.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=A21qrTuDjA3tHeDWVdzX0WG2r+tJVMdbKHmP47y1uN4=;
        b=PLTK3SEY6qzPpeIbFTTHltGLnJZQV9oR14sdid7lEbpJouY6TpATEcWo8F4Th1HcGe
         yU6QD+eTd/nIGMHIfGifOWhtpXCplQPrd0wJHKeQ17ZqjqLhi/5cJIHymuwkpZIBhPql
         pTOLXE9/63nKDcOSOu5UYjGPT8hky4HPD2wTA=
Received: by 10.143.76.8 with SMTP id d8mr656768wfl.400.1312454553582;
        Thu, 04 Aug 2011 03:42:33 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id m7sm2090440pbk.6.2011.08.04.03.42.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 03:42:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178719>

The add_message_to_msg function has some dead code, an unclear API,
only one callsite.  While it originally intended fill up an empty
commit message with the commit object name while picking, it really
doesn't do this -- a bug introduced in v1.5.1-rc1~65^2~2 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01).  Today, tests in
t3505-cherry-pick-empty.sh indicate that not filling up an empty
commit message is the desired behavior.  Re-implement and inline the
function accordingly, with a beneficial side-effect: don't dereference
a NULL pointer when the commit doesn't have a delimeter after the
header.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2df3f3b..7dfe295 100644
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
@@ -462,11 +449,24 @@ static int do_pick_commit(void)
 		}
 		strbuf_addstr(&msgbuf, ".\n");
 	} else {
+		const char *p;
+
 		base = parent;
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		add_message_to_msg(&msgbuf, msg.message);
+
+		/*
+		 * Append the commit log message to msgbuf; it starts
+		 * after the tree, parent, author, committer
+		 * information followed by "\n\n".
+		 */
+		p = strstr(msg.message, "\n\n");
+		if (p) {
+			p += 2;
+			strbuf_addstr(&msgbuf, p);
+		}
+
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-- 
1.7.6.351.gb35ac.dirty
