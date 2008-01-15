From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Be more careful about updating refs
Date: Tue, 15 Jan 2008 15:50:17 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEvZe-00020v-Vb
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758422AbYAOXvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbYAOXvJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:51:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43265 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753622AbYAOXvH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 18:51:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FNoPFR030951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 15:50:26 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FNoHLp009676;
	Tue, 15 Jan 2008 15:50:21 -0800
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.719 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70578>


This makes write_ref_sha1() more careful: it actually checks the SHA1 of 
the ref it is updating, and refuses to update a ref with an object that it 
cannot find.

Perhaps more importantly, it also refuses to update a branch head with a 
non-commit object. I don't quite know *how* the stable series maintainers 
were able to corrupt their repository to have a HEAD that pointed to a tag 
rather than a commit object, but they did. Which results in a totally 
broken repository that cannot be cloned or committed on.

So make it harder for people to shoot themselves in the foot like that.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I'm signing off on this, but I hope people will double-check this: I 
didn't actually test it very much.

 refs.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 58f6d17..c3ffe03 100644
--- a/refs.c
+++ b/refs.c
@@ -1119,10 +1119,16 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	return 0;
 }
 
+static int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
+}
+
 int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
+	struct object *o;
 
 	if (!lock)
 		return -1;
@@ -1130,6 +1136,19 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return 0;
 	}
+	o = parse_object(sha1);
+	if (!o) {
+		error("Trying to write ref %s with nonexistant object %s",
+			lock->ref_name, sha1_to_hex(sha1));
+		unlock_ref(lock);
+		return -1;
+	}
+	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
+		error("Trying to write non-commit object %s to branch %s",
+			sha1_to_hex(sha1), lock->ref_name);
+		unlock_ref(lock);
+		return -1;
+	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close(lock->lock_fd) < 0) {
