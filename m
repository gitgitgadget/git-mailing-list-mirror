From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 20:59:26 -0500
Message-ID: <20150113015925.GE18986@peff.net>
References: <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:59:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqlW-0005WT-W3
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbAMB71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:59:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:33614 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752583AbbAMB70 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:59:26 -0500
Received: (qmail 19280 invoked by uid 102); 13 Jan 2015 01:59:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:59:26 -0600
Received: (qmail 22742 invoked by uid 107); 13 Jan 2015 01:59:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:59:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:59:26 -0500
Content-Disposition: inline
In-Reply-To: <20150113015427.GA5497@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262320>

From: Lukas Fleischer <git@cryptocrack.de>

The helper functions prepare_final() and prepare_initial() return a
pointer to a string that is a member of an object in the revs->pending
array. This array is later rebuilt when running prepare_revision_walk()
which potentially transforms the pointer target into a bogus string. Fix
this by maintaining a copy of the original string.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..0374fe8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2390,7 +2390,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	return commit;
 }
 
-static const char *prepare_final(struct scoreboard *sb)
+static char *prepare_final(struct scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2415,10 +2415,10 @@ static const char *prepare_final(struct scoreboard *sb)
 		sb->final = (struct commit *) obj;
 		final_commit_name = revs->pending.objects[i].name;
 	}
-	return final_commit_name;
+	return xstrdup_or_null(final_commit_name);
 }
 
-static const char *prepare_initial(struct scoreboard *sb)
+static char *prepare_initial(struct scoreboard *sb)
 {
 	int i;
 	const char *final_commit_name = NULL;
@@ -2445,7 +2445,7 @@ static const char *prepare_initial(struct scoreboard *sb)
 	}
 	if (!final_commit_name)
 		die("No commit to dig down to?");
-	return final_commit_name;
+	return xstrdup(final_commit_name);
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
@@ -2489,7 +2489,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	const char *final_commit_name = NULL;
+	char *final_commit_name = NULL;
 	enum object_type type;
 
 	static struct string_list range_list;
@@ -2786,6 +2786,8 @@ parse_done:
 
 	assign_blame(&sb, opt);
 
+	free(final_commit_name);
+
 	if (incremental)
 		return 0;
 
-- 
2.2.1.425.g441bb3c
