From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 5/5] Documentation: add caveats about I/O buffering for check-{attr,ignore}
Date: Thu, 11 Apr 2013 13:05:13 +0100
Message-ID: <1365681913-7059-5-git-send-email-git@adamspiers.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 14:05:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGFz-0002ks-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935328Ab3DKMFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:05:32 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59033 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935118Ab3DKMFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:05:18 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 13F8958EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:05:18 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.342.gfa7285d
In-Reply-To: <1365681913-7059-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220852>

check-attr and check-ignore have the potential to deadlock callers
which do not read back the output in real-time.  For example, if a
caller writes N paths out and then reads N lines back in, it risks
becoming blocked on write() to check-*, and check-* is blocked on
write back to the caller.  Somebody has to buffer; the pipe buffers
provide some leeway, but they are limited.

Thanks to Peff for pointing this out:

    http://article.gmane.org/gmane.comp.version-control.git/220534

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/git-check-attr.txt   |  5 +++++
 Documentation/git-check-ignore.txt |  5 +++++
 Documentation/git.txt              | 16 +++++++++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 5abdbaa..a7be80d 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -56,6 +56,11 @@ being queried and <info> can be either:
 'set';;		when the attribute is defined as true.
 <value>;;	when a value has been assigned to the attribute.
 
+Buffering happens as documented under the `GIT_FLUSH` option in
+linkgit:git[1].  The caller is responsible for avoiding deadlocks
+caused by overfilling an input buffer or reading from an empty output
+buffer.
+
 EXAMPLES
 --------
 
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 7e3cabc..8e1f7ab 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -81,6 +81,11 @@ not.  (Without this option, it would be impossible to tell whether the
 absence of output for a given file meant that it didn't match any
 pattern, or that the output hadn't been generated yet.)
 
+Buffering happens as documented under the `GIT_FLUSH` option in
+linkgit:git[1].  The caller is responsible for avoiding deadlocks
+caused by overfilling an input buffer or reading from an empty output
+buffer.
+
 EXIT STATUS
 -----------
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6a875f2..eecdb15 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -808,13 +808,15 @@ for further details.
 
 'GIT_FLUSH'::
 	If this environment variable is set to "1", then commands such
-	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-	and 'git whatchanged' will force a flush of the output stream
-	after each commit-oriented record have been flushed.   If this
-	variable is set to "0", the output of these commands will be done
-	using completely buffered I/O.   If this environment variable is
-	not set, Git will choose buffered or record-oriented flushing
-	based on whether stdout appears to be redirected to a file or not.
+	as 'git blame' (in incremental mode), 'git rev-list', 'git
+	log', 'git check-attr', 'git check-ignore', and 'git
+	whatchanged' will force a flush of the output stream after
+	each commit-oriented record have been flushed.  If this
+	variable is set to "0", the output of these commands will be
+	done using completely buffered I/O.  If this environment
+	variable is not set, Git will choose buffered or
+	record-oriented flushing based on whether stdout appears to be
+	redirected to a file or not.
 
 'GIT_TRACE'::
 	If this variable is set to "1", "2" or "true" (comparison
-- 
1.8.2.1.342.gfa7285d
