From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 10/13] map/print ranges along traversing the history topologically
Date: Wed, 30 Jun 2010 23:25:23 +0800
Message-ID: <1277911526-12105-10-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:31:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzG7-00026z-Mi
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137Ab0F3PbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:31:08 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42258 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3PbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:31:04 -0400
Received: by pxi8 with SMTP id 8so417258pxi.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GNhLGHHShKhW+yDz6z/AAT9KMnUQ7d8Chhgt8QI6FXI=;
        b=VHvmdflFB/g37IErAzj8t0xGNOS2YZ3GFmfJEinJlKdvRz9cjrsgU+DExoL8qTjfFW
         pk5nCzpQKD/NcGEJ+eKxwHPOhKjvH/+kp87FqPOSqvT+BPlg/pyP4H7A0IbcDCHODhyc
         BTkQ1xzxH37I8IO0xZAhMj/d597L1T1+O4Z08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kMbyvmN5zSb7+C8w1x6zwstE/dthhjvUv2JckIw3CCPYLsDc00gTpMXCFptw5Kt6ZS
         K/p2K11w7MKk7SbVVEItgF+BpzZMIf/YDaddAWyhoI9nhNAlJPjvd04JwSU0+ps0BWuB
         GA5xC/5T4SC9tTYtCBceRS9ebNkI/ktEh3g6U=
Received: by 10.114.186.40 with SMTP id j40mr9964499waf.93.1277911864123;
        Wed, 30 Jun 2010 08:31:04 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.30.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:31:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149973>

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
index d0faf07..f14d54a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -612,7 +612,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
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
index 973eff5..faaa25a 100644
--- a/line.c
+++ b/line.c
@@ -1190,3 +1190,55 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
index 885e985..b293894 100644
--- a/line.h
+++ b/line.h
@@ -128,4 +128,6 @@ extern struct diff_line_range *lookup_line_range(struct rev_info *revs, struct c
 const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 		void *data, long lines, long begin, long *ret);
 
+extern int cmd_line_log_walk(struct rev_info *rev);
+
 #endif
-- 
1.7.0.2.273.gc2413.dirty
