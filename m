From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH] blame.c: fix garbled error message
Date: Sat, 10 Jan 2015 22:33:21 +0100
Message-ID: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 22:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA3lU-000755-Ft
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 22:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbbAJVkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 16:40:04 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:4863 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbAJVkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 16:40:04 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Jan 2015 16:40:03 EST
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id fad4c9e6;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sat, 10 Jan 2015 22:33:22 +0100 (CET)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262272>

The helper functions prepare_final() and prepare_initial() return a
pointer to a string that is a member of an object in the revs->pending
array. This array is later rebuilt when running prepare_revision_walk()
which potentially transforms the pointer target into a bogus string. Fix
this by maintaining a copy of the original string.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
The bug manifests when running `git blame HEAD^ -- nonexistent.file`.

Note that I could have reduced code churn a little by moving the
xstrdup() invocations to the call sites. However, I think that the
return value of these functions should not depend on the consistency of
a volatile data structure. On the other hand, you might also argue that
there currently are only two call sites and that the functions are
marked static, so if you prefer the less intrusive version, please let
me know.

 builtin/blame.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..34d6f4f 100644
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
+	return xstrdup(final_commit_name);
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
2.2.1
