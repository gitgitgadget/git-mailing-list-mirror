From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [PATCH] Add --contains flag to git tag
Date: Tue, 20 Jan 2009 20:37:09 -0500 (EST)
Message-ID: <4448209.246381232501828959.JavaMail.root@scalix.vivisimo.com>
References: <1232501631-21531-3-git-send-email-goulding@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 03:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPSYg-0004dU-03
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 03:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbZAUCJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 21:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZAUCJp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 21:09:45 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:42815 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZAUCJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 21:09:44 -0500
X-Greylist: delayed 1955 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2009 21:09:44 EST
Received: from mail.vivisimo.com (localhost [127.0.0.1])
	by mail.vivisimo.com (Postfix) with ESMTP id 0D4C285244A
	for <git@vger.kernel.org>; Tue, 20 Jan 2009 20:37:09 -0500 (EST)
In-Reply-To: <1232501631-21531-3-git-send-email-goulding@vivisimo.com>
X-Originating-IP: [72.65.210.219]
X-Mailer: Zimbra 5.0.9_GA_2534.RHEL4 (ZimbraWebClient - FF3.0 (Mac)/5.0.9_GA_2534.RHEL4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106557>

Ack - I sent that a bit before I meant to (and before I added patch sequence numbers).

This is a patch that adds a --contains flag to git tag, providing similar functionality as git branch --contains.

Please let me know what else I have inevitably messed up, and I shall endeavor to fix and resubmit. 

-Jake

----- Original Message -----
From: "Jake Goulding" <goulding@vivisimo.com>
To: git@vger.kernel.org
Cc: "Jake Goulding" <goulding@vivisimo.com>
Sent: Tuesday, January 20, 2009 8:33:49 PM GMT -05:00 US/Canada Eastern
Subject: [PATCH] Add --contains flag to git tag

This functions similar to how --contains works for git branch - it
will show all tags that contain the specified commit. Indeed, it uses
the same lookup mechanisms as git branch.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---
 builtin-tag.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index a398499..453ed26 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -26,6 +26,7 @@ static char signingkey[1000];
 struct tag_filter {
 	const char *pattern;
 	int lines;
+	struct commit_list *with_commit;
 };
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
@@ -35,6 +36,15 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 {
 	struct tag_filter *filter = cb_data;
 
+	if (filter->with_commit) {
+		struct commit *commit;
+
+		commit = lookup_commit_reference_gently(sha1, 1);
+		if (!commit)
+			return error("branch '%s' does not point at a commit", refname);
+		if (!has_commit(commit, filter->with_commit))
+			return 0;
+	}
 	if (!fnmatch(filter->pattern, refname, 0)) {
 		int i;
 		unsigned long size;
@@ -79,7 +89,8 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int list_tags(const char *pattern, int lines)
+static int list_tags(const char *pattern, int lines,
+			struct commit_list *with_commit)
 {
 	struct tag_filter filter;
 
@@ -88,6 +99,7 @@ static int list_tags(const char *pattern, int lines)
 
 	filter.pattern = pattern;
 	filter.lines = lines;
+	filter.with_commit = with_commit;
 
 	for_each_tag_ref(show_reference, (void *) &filter);
 
@@ -360,6 +372,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		list = 0, delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
+	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
@@ -378,6 +391,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT_BOOLEAN('f', NULL, &force, "replace the tag if exists"),
+
+		OPT_GROUP("Tag listing options"),
+		{
+			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
+			"print only tags that contain the commit",
+			PARSE_OPT_LASTARG_DEFAULT,
+			parse_opt_with_commit, (intptr_t)"HEAD",
+		},
 		OPT_END()
 	};
 
@@ -402,9 +423,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
 	if (list)
-		return list_tags(argv[0], lines == -1 ? 0 : lines);
+		return list_tags(argv[0], lines == -1 ? 0 : lines,
+				 with_commit);
 	if (lines != -1)
 		die("-n option is only allowed with -l.");
+	if (with_commit)
+		die("--contains option is only allowed with -l.");
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
-- 
1.6.0.6
