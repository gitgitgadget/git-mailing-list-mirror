From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] revert: Simplify getting commit subject
Date: Sat,  8 Oct 2011 23:06:43 +0530
Message-ID: <1318095407-26429-3-git-send-email-artagnon@gmail.com>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCapr-0004l3-0e
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab1JHRhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:37:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab1JHRhF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 13:37:05 -0400
Received: by mail-gy0-f174.google.com with SMTP id 10so4416168gyg.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2wxSlKtqQE8PfiNkK87QD96CK37t9ckFTSgRRdgRVmU=;
        b=aV60kHZL8YGYYTqbukKE0MfxqQqsL4kM7VaGXLxof2Bg+P2TLlCOj6QeLDCAFfC0DL
         xkrnXbzpg+ff/6EzNPm+NuxOEJjscrMqYRpbVlF0UH6W87eAKtxDvd282wq0ReXrXUNB
         wr2mULxVdd+4cljTA05ufCLv7WVQuOoQk8kQg=
Received: by 10.68.72.73 with SMTP id b9mr17169742pbv.100.1318095424850;
        Sat, 08 Oct 2011 10:37:04 -0700 (PDT)
Received: from localhost.localdomain ([122.174.152.157])
        by mx.google.com with ESMTPS id h5sm45151528pbq.11.2011.10.08.10.37.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 10:37:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183160>

The heavy parsing and memory allocations performed by get_message is
unnecessary when only the commit subject is desired.  Use
find_commit_subject instead.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a2c304d..b3c5e0e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -673,16 +673,16 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		struct replay_opts *opts)
 {
 	struct commit_list *cur = NULL;
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	const char *sha1_abbrev = NULL;
 	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *subject;
+	int subject_len;
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->item, &msg))
-			return error(_("Cannot get commit message for %s"), sha1_abbrev);
-		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
-		free_message(&msg);
+		subject_len = find_commit_subject(cur->item->buffer, &subject);
+		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
+			subject_len, subject);
 	}
 	return 0;
 }
-- 
1.7.4.1
