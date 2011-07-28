From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Thu, 28 Jul 2011 22:22:16 +0530
Message-ID: <1311871951-3497-4-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTsL-0003XD-Er
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1G1Qzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:55:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59637 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab1G1Qzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:55:50 -0400
Received: by mail-yx0-f174.google.com with SMTP id 11so1647404yxi.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ebysc0mC/xOtMoR6L+f9T1b1jqmSTpFKvUNRKZqV2R8=;
        b=ksuK9ksaosRaJSpe+aIeDCszZIfp6aBywsNiA2aahfarguoctzAnIFr1sDrznyzH7A
         NJ6alQ9aH7AlnkQgWKB20u05/sWSvYBgP3S3XbOpNITHs2Z5QHh6SjdeTq6nSuCL3vgQ
         jQ4lWsn8QpIqlTTZEHhe3FjFjLYT5o3uc+BNM=
Received: by 10.42.133.195 with SMTP id i3mr144325ict.449.1311872150018;
        Thu, 28 Jul 2011 09:55:50 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.55.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:55:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178084>

The add_message_to_msg function has some dead code, an unclear API,
only one callsite.  While it originally intended fill up an empty
commit message with the commit object name while picking, it really
doesn't do this -- a bug introduced in v1.5.1-rc1~65^2~2 (Make
git-revert & git-cherry-pick a builtin, 2007-03-01).  Today, tests in
t3505-cherry-pick-empty.sh indicate that not filling up an empty
commit message is the desired behavior.  Re-implement and inline the
function accordingly, with a benefecial side-effect: don't dereference
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
