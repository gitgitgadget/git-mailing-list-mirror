From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Tue, 24 Jun 2008 18:21:38 -0400
Message-ID: <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
References: <20080624222105.GA24549@dervierte>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org, jeske@google.com
X-From: git-owner@vger.kernel.org Wed Jun 25 00:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGuN-0000OE-DK
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYFXWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbYFXWVn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:21:43 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:35639 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbYFXWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:21:42 -0400
Received: by yx-out-2324.google.com with SMTP id 31so611402yxl.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Q3GKX0ia9SeVJe/p+ogDkFdNdqgsYtPPnL2JftS0YSQ=;
        b=CAdDzeioC2Iv0Tc5oIxHik6LtKpOThLlYPWLduf/EZHdKHUyOKPJX2tLbIH84/kLnj
         KHJLizopqO7n6YLOc5hf04279dHEzmDUdbHM+v995c9VnEZC0sviTJL8/tzencgTSuBR
         B6hpvLKeX1vKwZZuVH0xn/u5s66gunLnLFlvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K1qu5Rp+4AqLubV/3Zae8rQlpIrxEysrV7kZA8cCFxMwg3Q6pR2QBqPjejt7Cpl+aT
         ik1x5r9qColEhLLxYqKh9BEcc/wkHythUepcDmoxWEfJYmhPkDe/AqcQ4qyuK9DUkWzE
         N7f1b99VFQDatS4BUdc82xhOYT72RWql7ZwdI=
Received: by 10.142.245.6 with SMTP id s6mr6397592wfh.141.1214346100856;
        Tue, 24 Jun 2008 15:21:40 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.32.143])
        by mx.google.com with ESMTPS id 5sm9459177yxt.1.2008.06.24.15.21.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 15:21:39 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id A256339DDE; Tue, 24 Jun 2008 18:21:38 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.dirty
In-Reply-To: <20080624222105.GA24549@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86158>

Give "reset --hard" a -f (force) flag, without which it will refuse to
proceed if there are changes in the index or working tree.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 builtin-reset.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index f34acb1..6ee8448 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -11,8 +11,10 @@
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
+#include "diff.h"
 #include "run-command.h"
 #include "refs.h"
+#include "revision.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
@@ -165,12 +167,26 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 		warning("Reflog action message too long: %.*s...", 50, buf);
 }
 
+/* Stolen from builtin-revert.c... */
+static int index_is_dirty(void)
+{
+	struct rev_info rev;
+        read_cache();
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, "HEAD");
+	DIFF_OPT_SET(&rev.diffopt, QUIET);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	run_diff_files(&rev, 1);
+	return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+}
+
 enum reset_type { MIXED, SOFT, HARD, NONE };
 static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0,
+            force = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
@@ -184,6 +200,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
+		OPT_BOOLEAN('f', NULL, &force,
+				"proceed even if there are uncommitted changes"),
 		OPT_END()
 	};
 
@@ -225,6 +243,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == HARD && is_bare_repository())
 		die("hard reset makes no sense in a bare repository");
 
+        if (reset_type == HARD && !force && index_is_dirty()) {
+                die("Uncommitted changes; re-run with -f to trash them");
+        }
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
-- 
1.5.6.dirty
