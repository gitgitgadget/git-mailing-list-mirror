From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] write_file(): drop caller-supplied LF from multi-line file
Date: Mon, 24 Aug 2015 13:58:10 -0700
Message-ID: <1440449890-29490-7-git-send-email-gitster@pobox.com>
References: <xmqqzj1g31e5.fsf@gitster.dls.corp.google.com>
 <1440449890-29490-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 22:58:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTyp1-0006xJ-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 22:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbbHXU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 16:58:19 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35406 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbbHXU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 16:58:17 -0400
Received: by pdob1 with SMTP id b1so57509236pdo.2
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=CKx497Yi0vKRnvWQFLED1YwH3pI/FfYC58MJDcutGic=;
        b=v8KtX261TSPGGjbZhm3cS5r30jAVIaNZzWc4zGyb1zzlDymVoC5nPqtKcSLZCwohgZ
         btHW87WqZHQTAKVZB+XIxn2ItacRRPAdrr44L4sdxd9jQ6Z2B7ThPbzpQjEZbYTwZfVb
         MwHA5IvewmuQReQedjRcwg6WhkDUsERbkA5yXrWhEQDfykQSm1cGwW8qPv1ktHqvFFH/
         O22D6nhQla2SPlc0nBbasuKGLZ6pyT5Z0lRB0CcDOLAs+8O6dunrinGch3khzZkaW4nk
         K8ND5YVJuQIHjZMoV4TU3miJZYXl0t3j/7dkzQN8aDHELZy1UQlAvFs01O17DNSuPqDR
         AkkQ==
X-Received: by 10.70.91.14 with SMTP id ca14mr49592383pdb.79.1440449897144;
        Mon, 24 Aug 2015 13:58:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id w6sm18458195pdn.46.2015.08.24.13.58.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 13:58:16 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-568-g53a3e28
In-Reply-To: <1440449890-29490-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276482>

This is just to illustrate that we _could_ do this; I think it is
better to leave these places as they are.  The primary thing we
wanted to do with the automatic addition of LF to an incomplete line
was to make it easier to write a caller that creates a single-liner
file.  For callers that want to fully create a multi-line input, the
resulting code is easier to see if we let them continue to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c     | 1 -
 builtin/branch.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 486ff59..c544091 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -381,7 +381,6 @@ static void write_author_script(const struct am_state *state)
 
 	strbuf_addstr(&sb, "GIT_AUTHOR_DATE=");
 	sq_quote_buf(&sb, state->author_date);
-	strbuf_addch(&sb, '\n');
 
 	write_state_text(state, "author-script", sb.buf);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index ff05869..cdf7f13 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -774,7 +774,7 @@ static int edit_branch_description(const char *branch_name)
 	strbuf_commented_addf(&buf,
 		    "Please edit the description for the branch\n"
 		    "  %s\n"
-		    "Lines starting with '%c' will be stripped.\n",
+		    "Lines starting with '%c' will be stripped.",
 		    branch_name, comment_line_char);
 	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
 		strbuf_release(&buf);
-- 
2.5.0-568-g53a3e28
