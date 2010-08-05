From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 10/18] Hook line history into cmd_log, ensuring a topo-ordered walk
Date: Fri,  6 Aug 2010 00:11:49 +0800
Message-ID: <1281024717-7855-11-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35H-0001XF-Jm
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933588Ab0HEQNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57614 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933449Ab0HEQNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:11 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so2533376pzk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=83l7/C+8J3ArRGKooN01dyRwS5/+plV/FcUvWKlNtLc=;
        b=odsgAUrpsBJ8pAcMPidFUsNHLxI89NcL+C+dwEzQ0pAa/17pBPqb3U9D8HXL+H+++P
         6Q6Y+27+k922H8sIqasVBRZq3TTckFntyWReAlYWvH2f05STTJmZpvHse4FyAB2rx9TK
         c8K+7BlwWlrA4vpO5gOwLFj/jPFb5vAXVtJWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SErJqGc8iUkrYmUJC+299supReUNJ9UkxrRA7jDtYbyi0wQdgPOD7PKRffEx4UlwqX
         Tprn3n8A6AK4AQqar/ybDt4dG+3XB0vh120/U340iyV19NDXDXz6X8HuGJ+ZktJl9Ebn
         4JXqx/nDzNOPCvLkhYQN4JlGbessMH4DPmI+E=
Received: by 10.142.156.14 with SMTP id d14mr9360139wfe.2.1281024791438;
        Thu, 05 Aug 2010 09:13:11 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152675>

To correctly track the line ranges over several branches,
we must make sure that we have processed all children before
reaching the commit itself.

Thus we introduce a first pass in cmd_line_log that runs
prepare_revision_walk to achieve the topological ordering.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    5 ++++-
 line.c        |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h        |    2 ++
 revision.c    |    6 ++++++
 4 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 84d781e..0aa982b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -616,7 +616,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_walk(&rev);
+	if (rev.line_level_traverse)
+		return cmd_line_log_walk(&rev);
+	else
+		return cmd_log_walk(&rev);
 }
 
 /* format-patch */
diff --git a/line.c b/line.c
index bd63d99..c17659a 100644
--- a/line.c
+++ b/line.c
@@ -1232,3 +1232,57 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
+		list->item->object.flags &= ~(RANGE_UPDATE | EVIL_MERGE | NEED_PRINT);
+		list = list->next;
+	}
+
+	list = rev->commits;
+	while (list) {
+		struct commit_list *need_free = list;
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
+		free(need_free);
+	}
+
+	return 0;
+}
+
diff --git a/line.h b/line.h
index 7563536..3f5c827 100644
--- a/line.h
+++ b/line.h
@@ -134,4 +134,6 @@ extern struct diff_line_range *lookup_line_range(struct rev_info *revs,
 const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 		void *data, long lines, long begin, long *ret);
 
+extern int cmd_line_log_walk(struct rev_info *rev);
+
 #endif
diff --git a/revision.c b/revision.c
index 7e82efd..25c9a94 100644
--- a/revision.c
+++ b/revision.c
@@ -1637,6 +1637,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
+
+	if (revs->line_level_traverse) {
+		revs->limited = 1;
+		revs->topo_order = 1;
+	}
+
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
-- 
1.7.2.20.g388bbb
