From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Make builtin-commit.c more careful about parenthood
Date: Tue, 15 Jan 2008 16:12:33 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151608520.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEvuj-0008ES-7C
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYAPANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYAPANY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:13:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34752 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752759AbYAPANX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 19:13:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0CYGk031982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 16:12:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0CXLO010736;
	Tue, 15 Jan 2008 16:12:34 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70581>


When creating the commit object, be a whole lot more careful about making 
sure that the parent lines really are valid parent lines. Check things 
like MERGE_HEAD having proper SHA1 lines in it, and double-check that all 
the parents exist and are actually commits.



---
This is related to the previous patch, in that it is meant to get us 
better error messages and behaviour with a corrupt repository where the 
HEAD is not a proper commit.

 builtin-commit.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6d2ca80..30586a1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -756,6 +756,17 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
+static void add_parent(struct strbuf *sb, const unsigned char *sha1)
+{
+	struct object *obj = parse_object(sha1);
+	const char *parent = sha1_to_hex(sha1);
+	if (!obj)
+		die("Unable to find commit parent %s", parent);
+	if (obj->type != OBJ_COMMIT)
+		die("Parent %s isn't a proper commit", parent);
+	strbuf_addf(sb, "parent %s\n", parent);
+}
+
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	int header_len;
@@ -818,21 +829,24 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			die("could not parse HEAD commit");
 
 		for (c = commit->parents; c; c = c->next)
-			strbuf_addf(&sb, "parent %s\n",
-				      sha1_to_hex(c->item->object.sha1));
+			add_parent(&sb, c->item->object.sha1);
 	} else if (in_merge) {
 		struct strbuf m;
 		FILE *fp;
 
 		reflog_msg = "commit (merge)";
-		strbuf_addf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+		add_parent(&sb, head_sha1);
 		strbuf_init(&m, 0);
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
 			die("could not open %s for reading: %s",
 			    git_path("MERGE_HEAD"), strerror(errno));
-		while (strbuf_getline(&m, fp, '\n') != EOF)
-			strbuf_addf(&sb, "parent %s\n", m.buf);
+		while (strbuf_getline(&m, fp, '\n') != EOF) {
+			unsigned char sha1[20];
+			if (get_sha1_hex(m.buf, sha1) < 0)
+				die("Corrupt MERGE_HEAD file (%s)", m.buf);
+			add_parent(&sb, sha1);
+		}
 		fclose(fp);
 		strbuf_release(&m);
 	} else {
