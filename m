From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] log --children
Date: Tue,  4 Oct 2011 10:02:03 -0400
Message-ID: <1317736923-20539-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 16:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB5ZX-0005hh-C6
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 16:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab1JDOCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 10:02:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62058 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab1JDOCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 10:02:08 -0400
Received: by yxl31 with SMTP id 31so500546yxl.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 07:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yoMYuycG5qLN6/TDZxkAoRnurZ2DBW9UTPCBD/Lfb0I=;
        b=MgoOQiQK/+xcXcAXOv2wycemedz9UaJ2v65dOe8+ePNEbAPxaHWxpn9RAqitxwJJ/O
         WKtrmUtbnB126bbP9Pd8B4jj34uYY9A1DgTNsBn5XAphN/lNlhAfDjQCnZRc1Zq6M53I
         Ca4RUK04BkUAKGLcBPosrIUPZj4RoeFbOj+MA=
Received: by 10.236.161.10 with SMTP id v10mr6635529yhk.88.1317736927782;
        Tue, 04 Oct 2011 07:02:07 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id l42sm18526631yhj.12.2011.10.04.07.02.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Oct 2011 07:02:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.3.gaf8e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182770>

Teach git-log to support --children, which was added by f35f5603f4
to the revision machinery, and by 72276a3ecb to rev-list, but
was never added to git-log.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 log-tree.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 24c295ea1d..e7694a3a4c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -165,6 +165,14 @@ static void show_parents(struct commit *commit, int abbrev)
 	}
 }
 
+static void show_children(struct rev_info *opt, struct commit *commit, int abbrev)
+{
+	struct commit_list *p = lookup_decoration(&opt->children, &commit->object);
+	for ( ; p; p = p->next) {
+		printf(" %s", find_unique_abbrev(p->item->object.sha1, abbrev));
+	}
+}
+
 void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	const char *prefix;
@@ -414,6 +422,8 @@ void show_log(struct rev_info *opt)
 		fputs(find_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
+		if (opt->children.name)
+			show_children(opt, commit, abbrev_commit);
 		show_decorations(opt, commit);
 		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
 			putchar('\n');
@@ -473,6 +483,8 @@ void show_log(struct rev_info *opt)
 		      stdout);
 		if (opt->print_parents)
 			show_parents(commit, abbrev_commit);
+		if (opt->children.name)
+			show_children(opt, commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
 			       find_unique_abbrev(parent->object.sha1,
-- 
1.7.7.3.gaf8e
