From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/3] builtin-branch: use strbuf in rename_branch()
Date: Mon, 17 Nov 2008 21:48:37 +0100
Message-ID: <225d83c1ead50340eed97c64fbb8995017bf1ca8.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
 <b3716161b2a3d508ec4306623c5c8889d9367e1d.1226954771.git.vmiklos@frugalware.org>
 <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2B1w-00027S-6H
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 21:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbYKQUrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 15:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbYKQUrh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 15:47:37 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52936 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbYKQUre (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 15:47:34 -0500
Received: from vmobile.example.net (dsl5401C78D.pool.t-online.hu [84.1.199.141])
	by yugo.frugalware.org (Postfix) with ESMTPA id C622F446CD2;
	Mon, 17 Nov 2008 21:47:31 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7E5E419D92C; Mon, 17 Nov 2008 21:48:38 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <5dee4e908190e7a4ed4a693fdf0fb3b3af88fc57.1226954771.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1226954771.git.vmiklos@frugalware.org>
References: <cover.1226954771.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101244>

In case the length of branch name is greather then PATH_MAX-11, we write
to unallocated memory otherwise.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-branch.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index c8a8e2a..494cbac 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -424,42 +424,45 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 
 static void rename_branch(const char *oldname, const char *newname, int force)
 {
-	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
+	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	unsigned char sha1[20];
-	char oldsection[PATH_MAX], newsection[PATH_MAX];
+	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
-		die("Old branchname too long");
+	strbuf_addf(&oldref, "refs/heads/%s", oldname);
 
-	if (check_ref_format(oldref))
-		die("Invalid branch name: %s", oldref);
+	if (check_ref_format(oldref.buf))
+		die("Invalid branch name: %s", oldref.buf);
 
-	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > sizeof(newref))
-		die("New branchname too long");
+	strbuf_addf(&newref, "refs/heads/%s", newname);
 
-	if (check_ref_format(newref))
-		die("Invalid branch name: %s", newref);
+	if (check_ref_format(newref.buf))
+		die("Invalid branch name: %s", newref.buf);
 
-	if (resolve_ref(newref, sha1, 1, NULL) && !force)
+	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
 		die("A branch named '%s' already exists.", newname);
 
-	snprintf(logmsg, sizeof(logmsg), "Branch: renamed %s to %s",
-		 oldref, newref);
+	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+		 oldref.buf, newref.buf);
 
-	if (rename_ref(oldref, newref, logmsg))
+	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die("Branch rename failed");
+	strbuf_release(&logmsg);
 
 	/* no need to pass logmsg here as HEAD didn't really move */
-	if (!strcmp(oldname, head) && create_symref("HEAD", newref, NULL))
+	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL))
 		die("Branch renamed to %s, but HEAD is not updated!", newname);
 
-	snprintf(oldsection, sizeof(oldsection), "branch.%s", oldref + 11);
-	snprintf(newsection, sizeof(newsection), "branch.%s", newref + 11);
-	if (git_config_rename_section(oldsection, newsection) < 0)
+	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
+	strbuf_release(&oldref);
+	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
+	strbuf_release(&newref);
+	if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die("Branch is renamed, but update of config-file failed");
+	strbuf_release(&oldsection);
+	strbuf_release(&newsection);
 }
 
 static int opt_parse_with_commit(const struct option *opt, const char *arg, int unset)
-- 
1.6.0.2
