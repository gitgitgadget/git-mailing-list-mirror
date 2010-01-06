From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] lockfile: show absolute filename in unable_to_lock_message.
Date: Wed,  6 Jan 2010 18:01:28 +0100
Message-ID: <1262797288-23004-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 18:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZJK-0007wW-1r
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0AFRE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966Ab0AFRE1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:04:27 -0500
Received: from imag.imag.fr ([129.88.30.1]:59661 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab0AFRE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:04:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o06H1VSG012611
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 18:01:31 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSZGF-0007Go-L3; Wed, 06 Jan 2010 18:01:31 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NSZGF-0005zq-K3; Wed, 06 Jan 2010 18:01:31 +0100
X-Mailer: git-send-email 1.6.6.76.gd6b23.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 06 Jan 2010 18:01:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136272>

When calling a git command from a subdirectory and a file locking fails,
the user will get a path relative to the root of the worktree, which is
invalid from the place where the command is ran. Make it easy for the
user to know which file it is.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm writting this because I just got the situation with students:

- Sir, we broke our repository (git commit interrupted violently).
- See, the error message tells you what to do.
- But sir, where is .git/index.lock, we can't find it.

This patch would have solved their problem. OTOH, an absolute path can
be rather long and painfull to read/cut-and-paste. I've tried to show
a path relative to where the command was ran (like
"../../.git/index.lock"), but that's really a painfull to implement
(one has to provide a prefix argument to all the calls to
unable_to_lock_*, and even with this, I didn't find the simple way to
make the relative path (probably exists somewhere in Git since 'git
status' does this). Then I gave up :-(.

 lockfile.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 6851fa5..e31cbc7 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -164,9 +164,10 @@ static char *unable_to_lock_message(const char *path, int err)
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
-		    path, strerror(err));
+			    make_absolute_path(path), strerror(err));
 	} else
-		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
+			    make_absolute_path(path), strerror(err));
 	return strbuf_detach(&buf, NULL);
 }
 
-- 
1.6.6.76.gd6b23.dirty
