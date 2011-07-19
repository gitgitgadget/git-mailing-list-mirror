From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/18] revert: Simplify and inline add_message_to_msg
Date: Tue, 19 Jul 2011 22:47:41 +0530
Message-ID: <1311095876-3098-4-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDwk-0002wg-0m
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab1GSRSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:18:53 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48493 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1GSRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:18:52 -0400
Received: by pzk3 with SMTP id 3so5220029pzk.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KVxqZt74Mhh8Sorkq2xMrm/WVzy9tmlg0/aMXWXQpc0=;
        b=aXqpw6us3jekV0yJ5A74x15oMHymjj6UukmP5cgaNComi8UgNmqJ74+47enKBWymtJ
         W0mKZALlsZHePJ54C1P4wf7opfVvTTz55UYEM8HRstk3b+lwdQAxqxzvV8Nvb42+aeke
         d9yOiZQpuiP1TnShlzpvqSr+Q4O5uqAQto0Vo=
Received: by 10.143.21.32 with SMTP id y32mr3755267wfi.95.1311095932377;
        Tue, 19 Jul 2011 10:18:52 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.18.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:18:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177468>

The add_message_to_msg function has some dead code, an unclear API,
only one callsite.  While it originally intended fill up an empty
commit message with the commit object name while picking, it really
doesn't do this -- a bug introduced in 9509af6 (Make git-revert &
git-cherry-pick a builtin, 2007-03-01).  Today, tests in
t3505-cherry-pick-empty.sh indicate that not filling up an empty
commit message is the desired behavior.  Re-implement and inline the
function accordingly.

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
