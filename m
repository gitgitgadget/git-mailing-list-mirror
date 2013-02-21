From: Sergey Segeev <gurugray@yandex.ru>
Subject: [PATCH] archive: let remote clients get reachable commits
Date: Thu, 21 Feb 2013 18:24:03 +0400
Message-ID: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
Cc: Sergey Segeev <gurugray@yandex.ru>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 15:31:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8XAv-0004p9-Va
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 15:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab3BUOaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 09:30:39 -0500
Received: from forward3h.mail.yandex.net ([84.201.187.148]:54708 "EHLO
	forward3h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3BUOai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 09:30:38 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2013 09:30:38 EST
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
	by forward3h.mail.yandex.net (Yandex) with ESMTP id 51F16136170D;
	Thu, 21 Feb 2013 18:24:08 +0400 (MSK)
Received: from smtp2h.mail.yandex.net (localhost [127.0.0.1])
	by smtp2h.mail.yandex.net (Yandex) with ESMTP id D2B5E17002A6;
	Thu, 21 Feb 2013 18:24:07 +0400 (MSK)
Received: from dhcp-202-119-wifi.yandex.net (dhcp-202-119-wifi.yandex.net [213.180.202.119])
	by smtp2h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id O3QKj1or-O7QWQ3JE;
	Thu, 21 Feb 2013 18:24:07 +0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1361456647;
	bh=cEwavfebOXKvAUYEnONSb+7dTstMsSe2XOAxYTJUvng=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	b=ZOS5AW/RG7CCpBUMvKGh9USgK1Tdhw6Ju17nHh+ymC1BdSm8wbp3u37Vesg9X557I
	 zMiGvT9fKSqPN4UG44JLBA6O17RqEbC22NaMaCwZhkuT3nLjwp0D3cXLbFjRCvEQRv
	 CEePVk6NmogCA7l6RDKdQ7z+gKPa16HQUGBb1ft8=
X-Mailer: git-send-email 1.8.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216775>

Some time we need to get valid commit without a ref but with proper
tree-ish, now we can't do that.

This patch allow upload-archive's to use reachability checking
rather than checking that is a ref. This means a remote client can
fetch a tip of any valid sha1 or tree-ish.
---
 archive.c           | 24 +++++++++++++-----------
 t/t5000-tar-tree.sh |  2 ++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/archive.c b/archive.c
index 93e00bb..0a48985 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "refs.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -241,6 +242,13 @@ static void parse_pathspec_arg(const char **pathspec,
 	}
 }
 
+static int check_reachable(const char *refname, const unsigned char *sha1,
+		int flag, void *cb_data)
+{
+
+	return in_merge_bases(cb_data, lookup_commit_reference_gently(sha1, 1));
+}
+
 static void parse_treeish_arg(const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
@@ -252,22 +260,16 @@ static void parse_treeish_arg(const char **argv,
 	const struct commit *commit;
 	unsigned char sha1[20];
 
-	/* Remotes are only allowed to fetch actual refs */
-	if (remote) {
-		char *ref = NULL;
-		const char *colon = strchr(name, ':');
-		int refnamelen = colon ? colon - name : strlen(name);
-
-		if (!dwim_ref(name, refnamelen, sha1, &ref))
-			die("no such ref: %.*s", refnamelen, name);
-		free(ref);
-	}
-
 	if (get_sha1(name, sha1))
 		die("Not a valid object name");
 
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
+
+		/* Remotes are only allowed to fetch actual objects */
+		if (remote && !for_each_ref(check_reachable, (void *)commit))
+			die("Not a valid object name");
+
 		commit_sha1 = commit->object.sha1;
 		archive_time = commit->date;
 	} else {
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e7c240f..fc35406 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -194,6 +194,8 @@ test_expect_success 'clients cannot access unreachable commits' '
 	sha1=`git rev-parse HEAD` &&
 	git reset --hard HEAD^ &&
 	git archive $sha1 >remote.tar &&
+	git archive --remote=. $sha1 >remote.tar &&
+	git tag -d unreachable &&
 	test_must_fail git archive --remote=. $sha1 >remote.tar
 '
 
-- 
1.8.1.4
