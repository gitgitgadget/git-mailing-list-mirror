From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 02/13] revert: Factor out add_message_to_msg function
Date: Tue, 21 Jun 2011 13:04:38 +0000
Message-ID: <1308661489-20080-3-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0e4-00065X-B3
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab1FUNFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:05:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475Ab1FUNE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:04:57 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1674206vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=hMapxRwD7s5NldqlvzUA1yCxLUsFyzNPmFyGdV1vMFQ=;
        b=WbFEiJhkID+f0YJMIJy5QKLpotX51c0Os/sElL9hvsaBOCfj/X3j/OanhiOE4uUJxd
         ZHmpAH0dA3ySV9hu0P+NBRRzV/wKl/PgXxZCcJPjIhWHoDJwWMWBz1iPhRicth1rQ741
         0XztGfYXWeunZis5Em9duqrlvVYDL/6SST7GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BKSswrwpMA29OdjRB+KwumYRO00PVixSxIDdbxfLXfxO7mrI91OVBmxidWpVTfnt+9
         aUmRG/q2T8Z0BCLLCFhSVoAVgc1HSdyoFSp54G2Hko2USo9eII/z5UJ/4oGvGmzVV0IK
         CTzuHGUpGXFGqxRrjrvrL8oozWmvfU6mb+FDs=
Received: by 10.52.108.165 with SMTP id hl5mr8574653vdb.178.1308661496223;
        Tue, 21 Jun 2011 06:04:56 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.04.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:04:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176141>

The add_message_to_msg function is poorly implemented, has an unclear
API, and only one callsite.  Replace the callsite with a cleaner
implementation.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1f27c63..d6d2356 100644
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
@@ -471,11 +458,17 @@ static int do_pick_commit(void)
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
+		/* Add msg.message to msgbuf */
+		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
+		strbuf_addstr(&msgbuf, p);
+
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-- 
1.7.5.GIT
