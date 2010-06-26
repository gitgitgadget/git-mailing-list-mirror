From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 09/12] map/print ranges along traversing the history topologically
Date: Sat, 26 Jun 2010 06:27:34 -0700
Message-ID: <1277558857-23103-10-git-send-email-struggleyb.nku@gmail.com>
References: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 15:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVQn-0007r7-IN
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab0FZN2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 09:28:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0FZN2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 09:28:17 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so2772894pwj.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bDEKG278TjyAUMBJErs8V7QY2HfwWg6tVGJTzfdfG0g=;
        b=QL29X+B9D3M82OA+G9aeEz4ktodtqJNKZ6hKE6Wrh1lUxlkhaKn6OhGKJVWmhUzozx
         euqIBTyAM+E3Atz8+uHpLInIcA/SSkcRijo5tZUG4irgRdrgwY7oUgx3n4dY43w0VR8d
         xpyfeU2oIumOXscLW/4Mo5n1Z9rTMuRdFdeYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=knnymcscoRbzSnMFg1i1nWs1iqCN2WWoE8WBKFNJi/CCzQNpa+X+3RGrxeSqJgsQG5
         Pet3/dR3X6SuGcx6MiFBo7gMg9D3NUqFkUPcL97bUpGJp1N4qgQc3z2GQFpmdUOQAG/z
         0bNfNkSvFH3HaCNaiqpGRz4jP1yOre1RjXEno=
Received: by 10.142.187.19 with SMTP id k19mr286440wff.153.1277558897679;
        Sat, 26 Jun 2010 06:28:17 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id b23sm1553667wfj.0.2010.06.26.06.28.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 06:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.577.g36cf0.dirty
In-Reply-To: <1277558857-23103-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149751>

Since ranges may change in different branches, we should
make sure we do not pass range to parent until all the
ranges get 'combined' at the commit which is a split commit.
So, topological traversing is necessary.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    5 ++++-
 line.c        |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h        |    2 ++
 3 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f204129..87d6b2f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -632,7 +632,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_walk(&rev);
+	if (rev.line)
+		return cmd_line_log_walk(&rev);
+	else
+		return cmd_log_walk(&rev);
 }
 
 /* format-patch */
diff --git a/line.c b/line.c
index 29bda11..46d0937 100644
--- a/line.c
+++ b/line.c
@@ -1183,3 +1183,55 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	}
 }
 
+int cmd_line_log_walk(struct rev_info *rev)
+{
+	struct commit *commit;
+	struct commit_list *list = NULL;
+	struct diff_line_range *r = NULL;
+
+	if (prepare_revision_walk(rev))
+		die("revision walk prepare failed");
+
+	list = rev->commits;
+	if (list) {
+		list->item->object.flags |= RANGE_UPDATE;
+		list = list->next;
+	}
+	/* Clear the flags */
+	while (list) {
+		list->item->object.flags &= 0x0;
+		list = list->next;
+	}
+
+	list = rev->commits;
+	while (list) {
+		commit = list->item;
+
+		if (commit->object.flags & RANGE_UPDATE) {
+			assign_parents_range(rev, commit);
+		}
+
+		if (commit->object.flags & NEED_PRINT) {
+			line_log_flush(rev, commit);
+		}
+
+		r = lookup_line_range(rev, commit);
+		if (r) {
+			cleanup(r);
+			r = NULL;
+			add_line_range(rev, commit, r);
+		}
+
+		r = lookup_decoration(&rev->nontrivial_merge, &commit->object);
+		if (r) {
+			cleanup(r);
+			r = NULL;
+			add_decoration(&rev->nontrivial_merge, &commit->object, r);
+		}
+
+		list = list->next;
+	}
+
+	return 0;
+}
+
diff --git a/line.h b/line.h
index b6f328c..203c323 100644
--- a/line.h
+++ b/line.h
@@ -123,4 +123,6 @@ extern void add_line_range(struct rev_info *revs, struct commit *commit, struct
 
 extern struct diff_line_range *lookup_line_range(struct rev_info *revs, struct commit *commit);
 
+extern int cmd_line_log_walk(struct rev_info *rev);
+
 #endif
-- 
1.7.1.577.g36cf0.dirty
