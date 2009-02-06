From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] More friendly message when locking the index fails.
Date: Fri,  6 Feb 2009 15:36:06 +0100
Message-ID: <1233930966-17022-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqljsma99t.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 06 15:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRvI-0001zE-Ic
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbZBFOly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbZBFOlx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:41:53 -0500
Received: from imag.imag.fr ([129.88.30.1]:50819 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbZBFOlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:41:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n16Ea7v9004633
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Feb 2009 15:36:07 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LVRoM-0000qp-LR; Fri, 06 Feb 2009 15:36:06 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LVRoM-0004R5-JB; Fri, 06 Feb 2009 15:36:06 +0100
X-Mailer: git-send-email 1.6.1.2.351.g032a4.dirty
In-Reply-To: <vpqljsma99t.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 Feb 2009 15:36:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108719>

Just saying that index.lock exists doesn't tell the user _what_ to do
to fix the problem. We should give an indication that it's normally
safe to delete index.lock after making sure git isn't running here.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sverre Rabbelier <srabbelier@gmail.com> writes:

> How about "If no other git process is currently running, this probably
> means...." instead? E.g., sometimes I run 'git commit' in one terminal
> window, and then switch to another before committing (to review the
> diff for example), which would cause an index.lock file to be present
> validly.

Right, here's an updated version.

 builtin-update-index.c |   12 ++++++++++--
 lockfile.c             |   10 +++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5604977..23b97db 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -742,8 +742,16 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (newfd < 0) {
 			if (refresh_flags & REFRESH_QUIET)
 				exit(128);
-			die("unable to create '%s.lock': %s",
-			    get_index_file(), strerror(lock_error));
+			if (lock_error == EEXIST) {
+				die("Unable to create '%s.lock': %s.\n\n"
+				    "If no other git process is currently running, this probably means a\n"
+				    "git process crashed in this repository earlier. Make sure no other git\n"
+				    "process is running and remove the file manually to continue.",
+				    get_index_file(), strerror(lock_error));
+			} else {
+				die("Unable to create '%s.lock': %s",
+				    get_index_file(), strerror(lock_error));
+			}
 		}
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
diff --git a/lockfile.c b/lockfile.c
index 021c337..9bde859 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -159,7 +159,15 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
 	int fd = lock_file(lk, path, flags);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
-		die("unable to create '%s.lock': %s", path, strerror(errno));
+		if (errno == EEXIST) {
+			die("Unable to create '%s.lock': %s.\n\n"
+			    "If no other git process is currently running, this probably means a\n"
+			    "git process crashed in this repository earlier. Make sure no other git\n"
+			    "process is running and remove the file manually to continue.",
+			    path, strerror(errno));
+		} else {
+			die("Unable to create '%s.lock': %s", path, strerror(errno));
+		}
 	return fd;
 }
 
-- 
1.6.1.2.351.g032a4.dirty
