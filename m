From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Mon,  1 Aug 2011 23:36:50 +0530
Message-ID: <1312222025-28453-4-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwxV-0003iO-1K
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab1HASLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:11:05 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41572 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1HASLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:11:01 -0400
Received: by mail-yx0-f174.google.com with SMTP id 11so3305634yxi.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9ILyhf/yc7GhFdUAeWW4i6WFwdi+Mve2mi7F6ieq9bo=;
        b=q9SNnO0sbc4a4RMnTrIX1yzu5iobrWxOVwkD0DcInfbS8hNdFkdrFFdCJaS217KYuc
         b+arnPmEArrz2nF98rPTaVsDTLIBrWDHLsao6JtWTp8Thuj5XXxZa1q2iJNGYtTVG4N8
         LaevvBGqxKUcKY7P+12sVIZCYu2LWj3rNZNaA=
Received: by 10.68.0.101 with SMTP id 5mr5286883pbd.99.1312222261066;
        Mon, 01 Aug 2011 11:11:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.10.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178376>

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
1.7.4.rc1.7.g2cf08.dirty
