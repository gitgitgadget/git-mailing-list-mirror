From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/10] revert: simplify getting commit subject in format_todo()
Date: Wed, 14 Dec 2011 22:24:31 +0530
Message-ID: <1323881677-11117-5-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7B-0004kJ-4A
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612Ab1LNQzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:04 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61872 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604Ab1LNQzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:03 -0500
Received: by mail-vx0-f174.google.com with SMTP id fk14so763696vcb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MtmexAvAtun/AKgYj578Z3vQa8yeSam6wauYtTROm5Y=;
        b=SkwKQ34QcBoaH7h3yZBkMFxvfrmJhF7C18vBO1vxwwkA9wEaK/FbrctYrG6e/dpvcY
         MUUEMWT6H75f9qWLSLfbyWuLXiy4HHPZI73nanMTf27EcAOym1uD2zbUAgF/GCNN7NMy
         fhReptuMr5j2Hp7fmZ6W/SamO5To93e+On8RQ=
Received: by 10.52.172.196 with SMTP id be4mr5315086vdc.80.1323881703112;
        Wed, 14 Dec 2011 08:55:03 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:02 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187148>

format_todo() calls get_message(), but uses only the subject line of
the commit message.  As a minor optimization, save work and
unnecessary memory allocations by using find_commit_subject() instead.
Also, remove the unnecessary check on cur->item->buffer: the
lookup_commit_reference() call in parse_insn_line() has already made
sure of this.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index be0686d..0a4b215 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -697,16 +697,16 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
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
