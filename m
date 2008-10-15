From: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
Subject: [PATCH] Preserve file permissions on git-reflog expire
Date: Wed, 15 Oct 2008 14:34:58 -0300
Organization: DATACOM
Message-ID: <48F629C2.70203@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 19:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqAIE-0004qV-CT
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 19:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYJORfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 13:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYJORfD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 13:35:03 -0400
Received: from mail.datacom-telematica.com.br ([200.213.13.18]:43803 "EHLO
	mail.datacom-telematica.com.br" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671AbYJORfB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 13:35:01 -0400
Received: by mail.datacom-telematica.com.br (Postfix, from userid 65)
	id BE6CA2ACD5; Wed, 15 Oct 2008 14:34:57 -0300 (BRST)
Received: from [10.1.3.11] (unknown [10.1.3.11])
	by mail.datacom-telematica.com.br (Postfix) with ESMTP id 573E62ACD4;
	Wed, 15 Oct 2008 14:34:57 -0300 (BRST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98291>

Preserve file permissions on git-reflog expire to avoid problems with shared repositories and git-gc.

Signed-off-by: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>

---

This small patch fixes a bug with shared repositories and git-reflog expire.
If you have a shared repository created with git-init --shared, several users can push to it.
Once you run git-gc (which calls git-reflog expire) on the shared repository, the reflogs files are recreated with umask permissions, which defaults to 644 (with no group write). Since then, users receive the following error when trying to push:

samuel@erdinger:~/myrepo$ git push 
Counting objects: 5, done.
Compressing objects: 100% (3/3), done.
Unpacking objects: 100% (3/3), done.
Writing objects: 100% (3/3), 295 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
error: Unable to append to logs/refs/heads/master: Permission denied 
To /remote/myrepo/
! [remote rejected] master -> master (failed to write)
error: failed to push some refs to '/remote/myrepo/' 

This patch avoid this error preserving the permissions on reflog files.

 builtin-reflog.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 6b3667e..92a0d53 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -265,6 +265,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct cmd_reflog_expire_cb *cmd = cb_data;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
+	struct stat filestat;
 	char *log_file, *newlog_path = NULL;
 	int status = 0;
 
@@ -303,6 +304,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 			status |= error("Couldn't write %s",
 				lock->lk->filename);
 			unlink(newlog_path);
+		} else if (stat(log_file, &filestat)){
+			status |= error("unable to read permissions of %s", log_file);
+		} else if (chmod(newlog_path, filestat.st_mode)){
+			status |= error("cannot set permissions of %s", newlog_path);
 		} else if (rename(newlog_path, log_file)) {
 			status |= error("cannot rename %s to %s",
 					newlog_path, log_file);
-- 
1.6.0.2.532.g84ed4c.dirty
