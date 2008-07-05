From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] Move read_revisions_from_stdin from builtin-rev-list.c to revision.c
Date: Sat,  5 Jul 2008 16:40:32 -0400
Message-ID: <1215290434-27694-2-git-send-email-adambrewster@gmail.com>
References: <7vod5crydx.fsf@gitster.siamese.dyndns.org>
 <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 22:42:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFEZt-00068Q-Hy
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYGEUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYGEUkt
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:40:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:50545 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYGEUkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 16:40:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so734747ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5Dm2+2U/rslMtClpSw4M14F6GMgsQwIhSNxu+uFxEhI=;
        b=mEbeH8q1zJ5NeIAlzgIOK5Q90n934Krfi11UjtDTgX+P8NlqtvqnRUGS83DgKO7cJC
         rpqXeO9J2V/QV1EwfvJN/++ZxFZxaQC/HPGh56BS24InSNzBlIYtxbZfn7mBP86SlU+D
         3aPMVWjUwmr8SLmdP45R10V4ba6F6yd6PnpBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PLauaWE5yhhUveRPhGf3KFsTZ+kg/FwWHZLVM+SjP2+Nr4bLUIrJp58xH+QinBTN34
         sr+Js0/aYguk25hT9bAyN4x8wAqvkGQzYIY3ot6UuZyTgNm2ln8L4P4XLTNfNFvpNkc2
         KB9wxxWXBRegJ6OYY5I0DsJZjmwULnduXyz5k=
Received: by 10.150.186.12 with SMTP id j12mr4658184ybf.187.1215290438505;
        Sat, 05 Jul 2008 13:40:38 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 4sm2729651yxd.2.2008.07.05.13.40.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 13:40:36 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id D0A0610499C; Sat,  5 Jul 2008 16:40:34 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215290434-27694-1-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87463>

Some other commands might like to support the --stdin option like
git-rev-list.  Since they don't want to depend on builtin-rev-list, the
function has to be somewhere else.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 builtin-rev-list.c |   17 -----------------
 revision.c         |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)
 mode change 100644 => 100755 builtin-rev-list.c
 mode change 100644 => 100755 revision.c

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
old mode 100644
new mode 100755
index 11a7eae..b4a2c44
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -575,23 +575,6 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
-static void read_revisions_from_stdin(struct rev_info *revs)
-{
-	char line[1000];
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int len = strlen(line);
-		if (len && line[len - 1] == '\n')
-			line[--len] = 0;
-		if (!len)
-			break;
-		if (line[0] == '-')
-			die("options not supported in --stdin mode");
-		if (handle_revision_arg(line, revs, 0, 1))
-			die("bad revision '%s'", line);
-	}
-}
-
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
diff --git a/revision.c b/revision.c
old mode 100644
new mode 100755
index 5a1a948..0191160
--- a/revision.c
+++ b/revision.c
@@ -911,6 +911,23 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	return 0;
 }
 
+void read_revisions_from_stdin(struct rev_info *revs)
+{
+	char line[1000];
+
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		int len = strlen(line);
+		if (len && line[len - 1] == '\n')
+			line[--len] = '\0';
+		if (!len)
+			break;
+		if (line[0] == '-')
+			die("options not supported in --stdin mode");
+		if (handle_revision_arg(line, revs, 0, 1))
+			die("bad revision '%s'", line);
+	}
+}
+
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
 {
 	if (!revs->grep_filter) {
-- 
1.5.5.1.211.g65ea3.dirty
