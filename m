From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH/RFC] More friendly message when locking the index fails.
Date: Wed,  4 Feb 2009 10:58:25 +0100
Message-ID: <1233741505-24020-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqljsma99t.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 11:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUeea-0002E2-KQ
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 11:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbZBDKFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 05:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBDKFS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 05:05:18 -0500
Received: from imag.imag.fr ([129.88.30.1]:40122 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbZBDKFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 05:05:17 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n149wdxI015493
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Feb 2009 10:58:40 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUeWX-0007XD-9z; Wed, 04 Feb 2009 10:58:25 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUeWX-0006HM-7k; Wed, 04 Feb 2009 10:58:25 +0100
X-Mailer: git-send-email 1.6.1.2.322.g01114.dirty
In-Reply-To: <vpqljsma99t.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Feb 2009 10:58:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108331>

Just saying that index.lock exists doesn't tell the user _what_ to do
to fix the problem. We should give an indication that it's normally
safe to delete index.lock after making sure git isn't running here.
---
> I'll write a FAQ entry on the wiki with answers, and that would
> probably be a good idea to give indication to the user directly in the
> error message too, otherwise, the problem can be blocking for
> beginners.

Something along the lines of this patch maybe?

 builtin-update-index.c |   11 +++++++++--
 lockfile.c             |    9 ++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5604977..ab8ab8f 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -742,8 +742,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_flags & REFRESH_QUIET)
 				exit(128);
-			die("unable to create '%s.lock': %s",
-			    get_index_file(), strerror(lock_error));
+			if (lock_error == EEXIST) {
+				die("Unable to create '%s.lock': %s\n"
+				    "This probably means a git process crashed in this repository earlier.\n"
+				    "Make sure no other git process is running and remove the file manually.",
+				    get_index_file(), strerror(lock_error));
+			} else {
+				die("Unable to create '%s.lock': %s",
+				    get_index_file(), strerror(lock_error));
+			}
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
diff --git a/lockfile.c b/lockfile.c
index 021c337..bb59f7e 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -159,7 +159,14 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		die("unable to create '%s.lock': %s", path, strerror(errno));
+		if (errno == EEXIST) {
+			die("Unable to create '%s.lock': %s\n"
+			    "This probably means a git process crashed in this repository earlier.\n"
+			    "Make sure no other git process is running and remove the file manually.",
+			    path, strerror(errno));
+		} else {
+			die("Unable to create '%s.lock': %s", path, strerror(errno));
+		}
 	return fd;
 }
 
-- 
1.6.1.2.322.g01114.dirty
