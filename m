From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 10/22] Hook line history into cmd_log, ensuring a topo-ordered walk
Date: Sat, 24 Jul 2010 23:13:42 +0800
Message-ID: <1279984434-28933-11-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRX-0001lN-7N
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab0GXPPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553Ab0GXPPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:01 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CZ+ZG2nIi1ds9oler4QEpqGTZOedabXSrqgoz78IiUE=;
        b=k1F3yl60kmVB9yILnEV9xq8Ip2Kc67mP1ImgIPagtCDCcmLL4ldqJjkm4O+lYJXWNl
         7jsBh6hh/ZB5CqSb/krQ3i83d9SWPxFsH6H4pPiog+jmXhMqIve0UnX3BKIek4mD0Eef
         05SM+w1DZidaG3UcxQ3XYA7mOeTLy5HcH6c5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RxsSLT44j2ie74fIwulxdQmzA2+EZR/yF5pLHjaPsYVHiL1MbSexRK4VUNIRlQbt9L
         ORYaRrMWnkhKqgrFmDO5IUDNz26qPN2IntbIkV+FOnYFRPW794xxaI2ud+ap+i63lpZX
         +dKLEsr2X7mAleRHLjCG0GTOVWTk+gGe8U/zs=
Received: by 10.142.194.15 with SMTP id r15mr5939221wff.276.1279984500746;
        Sat, 24 Jul 2010 08:15:00 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.14.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151642>

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
1.7.0.2.273.gc2413.dirty
