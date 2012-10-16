From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] refs: lock symref that is to be deleted, not its target
Date: Tue, 16 Oct 2012 12:22:15 +0200
Message-ID: <507D3557.1090006@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@suse.cz>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO4I8-0004vD-HG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 12:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab2JPKWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 06:22:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:44554 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2JPKWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 06:22:17 -0400
Received: from [192.168.2.105] (p4FFDBE50.dip.t-dialin.net [79.253.190.80])
	by india601.server4you.de (Postfix) with ESMTPSA id 3E31B77;
	Tue, 16 Oct 2012 12:22:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121005 Thunderbird/16.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <507D315E.8040101@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207810>

When delete_ref is called on a symref then it locks its target and then
either deletes the target or the symref, depending on whether the flag
REF_NODEREF was set in the parameter delopt.

Instead, simply pass the flag to lock_ref_sha1_basic, which will then
either lock the target or the symref, and delete the locked ref.

This reimplements part of eca35a25 (Fix git branch -m for symrefs.).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Independent patch, kind of related.

 refs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index da74a2b..9d1685b 100644
--- a/refs.c
+++ b/refs.c
@@ -1753,26 +1753,18 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	struct ref_lock *lock;
 	int err, i = 0, ret = 0, flag = 0;
 
-	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
+	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
 	if (!lock)
 		return 1;
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
-		const char *path;
-
-		if (!(delopt & REF_NODEREF)) {
-			i = strlen(lock->lk->filename) - 5; /* .lock */
-			lock->lk->filename[i] = 0;
-			path = lock->lk->filename;
-		} else {
-			path = git_path("%s", refname);
-		}
-		err = unlink_or_warn(path);
+		i = strlen(lock->lk->filename) - 5; /* .lock */
+		lock->lk->filename[i] = 0;
+		err = unlink_or_warn(lock->lk->filename);
 		if (err && errno != ENOENT)
 			ret = 1;
 
-		if (!(delopt & REF_NODEREF))
-			lock->lk->filename[i] = '.';
+		lock->lk->filename[i] = '.';
 	}
 	/* removing the loose one could have resurrected an earlier
 	 * packed one.  Also, if it was not loose we need to repack
-- 
1.7.12
