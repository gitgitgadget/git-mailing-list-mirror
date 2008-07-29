From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] merge-base: die with an error message if not passed a
 commit ref
Date: Tue, 29 Jul 2008 07:42:53 +0200
Message-ID: <20080729074253.b4617027.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:40:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhwc-0008Md-2v
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbYG2FjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYG2FjL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:39:11 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:56985 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbYG2FjL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:39:11 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 5ED1232A774;
	Tue, 29 Jul 2008 07:39:05 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with SMTP id EA1B632A80F;
	Tue, 29 Jul 2008 07:39:04 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90579>

Before this patch "git merge-base" just exited with error code 1
and without an error message in case it was passed a ref to an
object that is not a commit (for example a tree).

This patch makes it "die" in this case with an error message.

While at it, this patch also refactors the code to get the
commit reference from an argument into a new
"get_commit_reference" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-merge-base.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 1cb2925..3382b13 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -22,10 +22,23 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 static const char merge_base_usage[] =
 "git merge-base [--all] <commit-id> <commit-id>";
 
+static struct commit *get_commit_reference(const char *arg)
+{
+	unsigned char revkey[20];
+	struct commit *r;
+
+	if (get_sha1(arg, revkey))
+		die("Not a valid object name %s", arg);
+	r = lookup_commit_reference(revkey);
+	if (!r)
+		die("Not a valid commit name %s", arg);
+
+	return r;
+}
+
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
 	struct commit *rev1, *rev2;
-	unsigned char rev1key[20], rev2key[20];
 	int show_all = 0;
 
 	git_config(git_default_config, NULL);
@@ -40,13 +53,8 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	}
 	if (argc != 3)
 		usage(merge_base_usage);
-	if (get_sha1(argv[1], rev1key))
-		die("Not a valid object name %s", argv[1]);
-	if (get_sha1(argv[2], rev2key))
-		die("Not a valid object name %s", argv[2]);
-	rev1 = lookup_commit_reference(rev1key);
-	rev2 = lookup_commit_reference(rev2key);
-	if (!rev1 || !rev2)
-		return 1;
+	rev1 = get_commit_reference(argv[1]);
+	rev2 = get_commit_reference(argv[2]);
+
 	return show_merge_base(rev1, rev2, show_all);
 }
-- 
1.6.0.rc0.42.g186458.dirty
