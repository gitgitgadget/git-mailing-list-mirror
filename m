From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 3/4] Attach reflog to commit prior to pretty-printing
Date: Wed, 25 Feb 2009 23:44:06 -0500
Message-ID: <72f44a4e928e675ad11c6764c3231b0e150cd115.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Cc: trast@student.ethz.ch, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 05:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcY8L-0000kl-F0
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 05:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZBZEoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 23:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbZBZEoX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 23:44:23 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:54567 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbZBZEoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 23:44:20 -0500
Received: by yw-out-2324.google.com with SMTP id 5so296096ywh.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:in-reply-to
         :references;
        bh=ej8Y/3C5HpOUiaKgbi0hyLKZGQr39ohTv9ghWAQ2AFE=;
        b=G9wVIrkikR1rM7qz81aVsItQ+ZPJkM6xwIE0e8e5oEiF8gh5PO3vrrrl2fXNOATupu
         7XxUsvDuP6ob2VUEpVsAFw5Z9UoMDm8NX5C6cKzxo+ZB+rtrQ7F7NEpJjrOLcDiDGlDj
         lUkmkAX/7wBmd2zKj5M1M7ojxR8IybHAAe61g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=deu5Fbw6mmz7JvZE9r7EuMoqz/o/ZcNzUSCybIAJVXA58yYG6eu8GSMVp5nAPVH6st
         6A9nFfZNHzju1AOtjIc5dYmHnN2NPoBJwikjEABilbUe4p6A+NnyTL69CD7Q6I6af0LM
         wa38YcC5RFq6TI/xLCtRjPKTsfFFMrcuZDXMo=
Received: by 10.231.20.2 with SMTP id d2mr1347627ibb.37.1235623458085;
        Wed, 25 Feb 2009 20:44:18 -0800 (PST)
Received: from localhost.localdomain (67-194-38-22.wireless.umnet.umich.edu [67.194.38.22])
        by mx.google.com with ESMTPS id s35sm3517319qbs.6.2009.02.25.20.44.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 20:44:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.90.g0753
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
References: <cover.1235622145.git.deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111523>

Use attach_reflog_info just prior to pretty-printing the commit, so the
reflog info may be printed if desired.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
 list-objects.c |    3 +++
 log-tree.c     |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index c8b8375..fd9d23e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "diff.h"
 #include "tree-walk.h"
+#include "reflog-walk.h"
 #include "revision.h"
 #include "list-objects.h"
 
@@ -146,6 +147,8 @@ void traverse_commit_list(struct rev_info *revs,
 
 	while ((commit = get_revision(revs)) != NULL) {
 		process_tree(revs, commit->tree, &objects, NULL, "");
+		if (revs->reflog_info)
+			attach_reflog_info(revs->reflog_info, commit);
 		show_commit(commit);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
diff --git a/log-tree.c b/log-tree.c
index 84a74e5..5ccca0e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -387,6 +387,9 @@ void show_log(struct rev_info *opt)
 	 */
 	if (need_8bit_cte >= 0)
 		need_8bit_cte = has_non_ascii(opt->add_signoff);
+	if (opt->reflog_info) {
+		attach_reflog_info(opt->reflog_info, commit);
+	}
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
 			    abbrev, subject, extra_headers, opt->date_mode,
 			    need_8bit_cte);
-- 
1.6.2.rc0.90.g0753
