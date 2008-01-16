From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Make 'git fsck' complain about non-commit branches
Date: Tue, 15 Jan 2008 16:34:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151618300.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwFc-0005CD-Ey
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbYAPAe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbYAPAe7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:34:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57316 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751590AbYAPAe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 19:34:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0YIrW000347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 16:34:19 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G0YHRr011445;
	Tue, 15 Jan 2008 16:34:18 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70585>


Since having non-commits in branches is a no-no, and just means you cannot 
commit on them, let's make fsck tell you when a branch is bad.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 builtin-fsck.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 8876d34..6fc9525 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -555,20 +555,23 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 	return 0;
 }
 
+static int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
+}
+
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
 
-	obj = lookup_object(sha1);
+	obj = parse_object(sha1);
 	if (!obj) {
-		if (has_sha1_file(sha1)) {
-			default_refs++;
-			return 0; /* it is in a pack */
-		}
 		error("%s: invalid sha1 pointer %s", refname, sha1_to_hex(sha1));
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
+	if (obj->type != OBJ_COMMIT && is_branch(refname))
+		error("%s: not a commit", refname);
 	default_refs++;
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
