From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 10/13] map/print ranges along traversing the history topologically
Date: Sun, 11 Jul 2010 14:18:58 +0800
Message-ID: <1278829141-11900-10-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpvC-00025x-6f
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab0GKGVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40135 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0GKGVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1399328pwi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9LEdvhSw3lhoHjtdY+asOjgR09Vd0uUjQ/+y7431Rfo=;
        b=ceKoLU64PmQSwa+MMslZcIR8jZW8zSyXmxZ3FWED4e9JCDSFzmwAJm/7CLJFTXcy+9
         SS71bthZ8zcsBHFvdlWn+ISwiSPfrV4C+snatgnjxVZ1XMEh+evt/Iu3DREzbI2SA2Qv
         Xpxwl/WdC07VwLJ/A4WNJsoyvK44oNXw1xm4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KJ6iGrjeA9BUvK1z2R3TXjRmaQqluwXZe8IygXe2EzuKIM+TlvFc4lgBYnVLxzvzEr
         AdAht+ceeY7c+g5yXtCzr8/kmBL9fh10ka8S5csSx2uskh+ES3OSbb4YlDqVt8ElQlMG
         FhVzQ6ZMU5g42T6nkXEshaurq+Um5DwcKhyeE=
Received: by 10.142.147.7 with SMTP id u7mr14391112wfd.221.1278829301525;
        Sat, 10 Jul 2010 23:21:41 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150752>

Since ranges may change in different branches, we should
make sure we do not pass range to parent until all the
ranges get 'combined' at the commit which is a split commit.
So, topological traversing is necessary.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/log.c |    5 ++++-
 line.c        |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h        |    2 ++
 3 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1e90b03..47b386d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -615,7 +615,10 @@ int cmd_log(int argc, const char **argv, const char *prefix)
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
index 8813376..5c8f77a 100644
--- a/line.c
+++ b/line.c
@@ -1196,3 +1196,57 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
