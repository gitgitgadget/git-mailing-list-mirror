From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/4] format-patch: improve head calculation for cover-letter
Date: Sun,  7 Apr 2013 01:10:28 -0600
Message-ID: <1365318630-11882-3-git-send-email-felipe.contreras@gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjlO-0000Ky-EU
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab3DGHLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:11:37 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:50842 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355Ab3DGHLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:11:35 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so5224337oag.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+mAvG8MgLba45+REDFuoKzaMgcJke0aoJmrXkcEUWZQ=;
        b=TjJd5ID8jkhZ1mgzgBBfNs+Rj7NrQ6fQbHbtGEe/KU1FCtRdI/bM47ENObPQYELSDL
         rQPBbQdnp9Ecfvu+mHlv4bE0dAytwrshwaBIQ35lqUvVrYpHEY2e/j029XdIOytjTcSs
         ptIXu9BkDbN5jWN5vQ0tmCy56WkRsEEuyXMf2BckbxjvS9w3H5fPn2o9+zlHm0AiXQ84
         VjzwKqeGT68H21o5lnBmDQ0A2PP+h8wTokgPhpuxsunCtxvvDI+Tw5v7/xa17jYyaK3I
         IC4yWKd6xXxgHoZK6JFrxWBR1+eSrIXnj1ObwfgJkWR9RLP1aDDiG02+mUs13AJH13gk
         pB6A==
X-Received: by 10.60.40.105 with SMTP id w9mr11799108oek.36.1365318694877;
        Sun, 07 Apr 2013 00:11:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id l4sm19905474oek.3.2013.04.07.00.11.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:11:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220284>

If we do it after the revision traversal we can be sure that this is
indeed a commit that will be processed (i.e. not a merge) and it's the
top most one (thus removing the NEEDSWORK comment).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/log.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..6c78d7f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1319,24 +1319,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.show_root_diff = 1;
 
 	if (cover_letter) {
-		/*
-		 * NEEDSWORK:randomly pick one positive commit to show
-		 * diffstat; this is often the tip and the command
-		 * happens to do the right thing in most cases, but a
-		 * complex command like "--cover-letter a b c ^bottom"
-		 * picks "c" and shows diffstat between bottom..c
-		 * which may not match what the series represents at
-		 * all and totally broken.
-		 */
-		int i;
-		for (i = 0; i < rev.pending.nr; i++) {
-			struct object *o = rev.pending.objects[i].item;
-			if (!(o->flags & UNINTERESTING))
-				head = (struct commit *)o;
-		}
-		/* There is nothing to show; it is not an error, though. */
-		if (!head)
-			return 0;
 		if (!branch_name)
 			branch_name = find_branch_name(&rev);
 	}
@@ -1372,6 +1354,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		list = xrealloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
+	if (nr > 0)
+		head = list[0];
 	total = nr;
 	if (!keep_subject && auto_number && total > 1)
 		numbered = 1;
-- 
1.8.2
