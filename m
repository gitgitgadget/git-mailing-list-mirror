X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Sun, 17 Dec 2006 20:52:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 19:52:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34703>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw23u-0001Yo-Ab for gcvg-git@gmane.org; Sun, 17 Dec
 2006 20:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750997AbWLQTwh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 14:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWLQTwh
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 14:52:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:47753 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1750994AbWLQTwg
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 14:52:36 -0500
Received: (qmail invoked by alias); 17 Dec 2006 19:52:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 17 Dec 2006 20:52:35 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


When checking which tags to fetch, the old code used to call
git-show-ref --verify for _each_ remote tag. Since reading even
packed refs is not a cheap operation when there are a lot of
local refs, the code became quite slow.

This fixes it by teaching git-show-ref to filter out valid
(i.e. locally stored) refs from stdin, when passing the parameter
--filter-invalid to git-show-ref, and feeding it lines in the
form 'sha1 refname'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	Since this option is purely for use in git-fetch, I did not even
	bother documenting it.

	This patch would have been so much cleaner if git-fetch was written
	in C... But since it accumulated so many functions by now, I see
	not much chance for that (at least in the near future).

	In very unscientific tests, a single read_packed_refs() in the 
	lilypond repo took 0.1 seconds. Yep, that's 1/10th second. So, the 
	while loop in git-fetch took more than 10 seconds for 107 tags.

 builtin-show-ref.c |   28 +++++++++++++++++++++++++++-
 git-fetch.sh       |    2 +-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index f6929d9..c0b55c1 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -2,8 +2,9 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
+#include "path-list.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*]";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] | --filter-invalid < ref-list";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
 	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
@@ -86,6 +87,29 @@ match:
 	return 0;
 }
 
+static int add_valid(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+{
+	struct path_list *list = (struct path_list *)cbdata;
+	path_list_insert(refname, list);
+	return 0;
+}
+
+static int filter_invalid()
+{
+	static struct path_list valid_refs = { NULL, 0, 0, 0 };
+	char buf[1024];
+
+	for_each_ref(add_valid, &valid_refs);
+	while (fgets(buf, sizeof(buf), stdin)) {
+		int len = strlen(buf);
+		if (len > 0 && buf[len - 1] == '\n')
+			buf[--len] = '\0';
+		if (len < 41 || !path_list_has_path(&valid_refs, buf + 41))
+			printf("%s\n", buf);
+	}
+	return 0;
+}
+
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -153,6 +177,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			heads_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--filter-invalid"))
+			return filter_invalid();
 		usage(show_ref_usage);
 	}
 	if (verify) {
diff --git a/git-fetch.sh b/git-fetch.sh
index 3feba32..d1c00db 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -474,9 +474,9 @@ case "$no_tags$tags" in
 		echo "$ls_remote_result" |
 		sed -n	-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)^{}$|\1 \2|p' \
 			-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)$|\1 \2|p' |
+		git-show-ref --filter-invalid |
 		while read sha1 name
 		do
-			git-show-ref --verify --quiet -- "$name" && continue
 			git-check-ref-format "$name" || {
 				echo >&2 "warning: tag ${name} ignored"
 				continue
-- 
1.4.4.1.g3c2a-dirty
