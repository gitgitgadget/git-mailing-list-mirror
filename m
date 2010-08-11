From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 10/17] Hook line history into cmd_log, ensuring a topo-ordered walk
Date: Wed, 11 Aug 2010 23:03:35 +0800
Message-ID: <1281539022-31616-11-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCrx-0005GU-IT
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677Ab0HKPFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:21 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62685 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab0HKPFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:20 -0400
Received: by pvg2 with SMTP id 2so75417pvg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OfFX2rcasT0C4/OYJMxL04L6I1mv4Fm9CPcAV7vBpxA=;
        b=UhvhD5XPYlW2xBswVOpZKIPBQfcc+VnnikxDtYecHwvO9hAYkSzHdeuDLj+bWQ5V4m
         aikpl1+lvDSe0vLEaKQK6/kA61HZ3B/Zhfbjg2OwuPfa8xnxSsvPKMc4l/hDGhF5vQBp
         VHF4DAgtHwpx6dIsJuHiXbrlsHTfG/c0Bdb+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qyprFrzDDtIzSwThgyFlsy222KhAy7aSeoVkn+MzM5mEcSs6RYWcUMfzvVX14eAEja
         fnycIpBuNG3fGZkSES+gWUR1kQy0k0OrY7yZW+t9JX4t8DuTiCDtKlBje9PWVwD9aX2a
         XFbpOuyBjFz2fLYT9f1yHDU+Zt9cXwH9ZlrFk=
Received: by 10.114.204.7 with SMTP id b7mr22142479wag.124.1281539120439;
        Wed, 11 Aug 2010 08:05:20 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153248>

To correctly track the line ranges over several branches,
we must make sure that we have processed all children before
reaching the commit itself.

Thus we introduce a first pass in cmd_line_log that runs
prepare_revision_walk to achieve the topological ordering.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    5 ++++-
 line.c        |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h        |    2 ++
 revision.c    |    6 ++++++
 4 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7c5111..637bcea 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -615,7 +615,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
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
index d50c0e8..c0cb599 100644
--- a/line.c
+++ b/line.c
@@ -1244,3 +1244,55 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
+		if (commit->object.flags & RANGE_UPDATE)
+			assign_parents_range(rev, commit);
+
+		if (commit->object.flags & NEED_PRINT)
+			line_log_flush(rev, commit);
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
index e03eff0..202130f 100644
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
1.7.2.19.g79e5d
