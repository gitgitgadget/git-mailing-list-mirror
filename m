From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-branch: highlight current remote branches with an asterisk
Date: Mon,  9 Feb 2009 18:32:06 -0500
Message-ID: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 00:33:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWfdG-0007xx-Ms
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 00:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbZBIXcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 18:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbZBIXcM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 18:32:12 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:41841 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbZBIXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 18:32:10 -0500
Received: by yx-out-2324.google.com with SMTP id 8so114515yxm.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 15:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=diN7vJl0E7rYbDWcuAgRjb4G7Wvim/1DlgF41nMdVvs=;
        b=kkhFPlSi5A4ogpICSYB/avcZdOth7nyjNWSY6FAwM0WnhAAgB33TVzqUveLYANwUXP
         XJtvWJ8qbbhMPiZTEVuibUfkPwwYWhXa9kBTjsX8j7JAk/EyEEAn/8irJ1k1zkb3kvwT
         J6uEY/b3O0BE2Kwq4x6t7bB42iIaOScdO4TNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=x+V2g0+nfyPyho0E86iAp8c6EfwjbR7e/byChB7yQOqTT1bFsp6+IGyVKVvlDw2w5N
         l1s4PgsR7mio1EF7hOw9BI6s0sCAcguVzQ79PIRMyPGkfkChoEWHsyWZwzErg/mkBKjX
         wfpDPEG9qLV1DCP0HKZQRLjXxvnYhwNPAXlD4=
Received: by 10.64.193.1 with SMTP id q1mr2775136qbf.16.1234222328943;
        Mon, 09 Feb 2009 15:32:08 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id k30sm11886260qba.11.2009.02.09.15.32.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 15:32:08 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.354.ge44a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109161>

Teach git branch -{r,a} how to interpret remote HEADs and highlight the
corresponding remote branch with an asterisk, instead of showing literal
"<remote_name>/HEAD".

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
git branch -r before patch:
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo

git branch -r after patch:
  origin/html
  origin/maint
  origin/man
* origin/master
  origin/next
  origin/pu
  origin/todo

The coloring for the current remote branch remains red, not green like
the current local branch.

I think it's an improvement. :)

 builtin-branch.c |   41 ++++++++++++++++++++++++++++++-----------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 56a1971..62558a7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -15,6 +15,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
 
 static const char * const builtin_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -190,9 +191,19 @@ struct ref_list {
 	int index, alloc, maxwidth;
 	struct ref_item *list;
 	struct commit_list *with_commit;
+	struct string_list *remote_heads;
 	int kinds;
 };
 
+static void add_to_remote_heads(struct string_list *remote_heads, const char *head) {
+	unsigned char sha1[20];
+	int flag;
+	const char *refname = resolve_ref(head, sha1, 0, &flag);
+	if (refname && (flag & REF_ISSYMREF) &&
+	    !prefixcmp(refname, "refs/remotes/"))
+		string_list_insert(refname + 13, remote_heads);
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
@@ -223,6 +234,13 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	/* Handle remote HEAD */
+	if (kind == REF_REMOTE_BRANCH && ((len = strlen(refname)) > 5) &&
+	    !strcmp(refname + len - 5, "/HEAD")) {
+		add_to_remote_heads(ref_list->remote_heads, refname - 13);
+		return 0;
+	}
+
 	if (merge_filter != NO_FILTER)
 		add_pending_object(&ref_list->revs,
 				   (struct object *)commit, refname);
@@ -294,8 +312,8 @@ static int matches_merge_filter(struct commit *commit)
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 			   int abbrev, int current)
 {
-	char c;
-	int color;
+	char c = ' ';
+	int color = COLOR_BRANCH_PLAIN, current_color = COLOR_BRANCH_CURRENT;
 	struct commit *commit = item->commit;
 
 	if (!matches_merge_filter(commit))
@@ -306,17 +324,13 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = COLOR_BRANCH_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
-		color = COLOR_BRANCH_REMOTE;
-		break;
-	default:
-		color = COLOR_BRANCH_PLAIN;
+		color = current_color = COLOR_BRANCH_REMOTE;
 		break;
 	}
 
-	c = ' ';
 	if (current) {
 		c = '*';
-		color = COLOR_BRANCH_CURRENT;
+		color = current_color;
 	}
 
 	if (verbose) {
@@ -364,10 +378,12 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	int i;
 	struct ref_list ref_list;
 	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	struct string_list remote_heads = { NULL, 0, 0, 1};
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
 	ref_list.with_commit = with_commit;
+	ref_list.remote_heads = &remote_heads;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	for_each_ref(append_ref, &ref_list);
@@ -399,13 +415,16 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	}
 
 	for (i = 0; i < ref_list.index; i++) {
-		int current = !detached &&
+		int current = (!detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
+			!strcmp(ref_list.list[i].name, head)) ||
+			(ref_list.list[i].kind == REF_REMOTE_BRANCH &&
+			string_list_has_string(&remote_heads,
+			                       ref_list.list[i].name));
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
 			       abbrev, current);
 	}
-
+	string_list_clear(&remote_heads, 0);
 	free_ref_list(&ref_list);
 }
 
-- 
1.6.1.2.354.ge44a2
