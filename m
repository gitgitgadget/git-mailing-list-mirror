From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 3/5] Documentation: add caveats about I/O buffering for check-{attr,ignore}
Date: Thu, 11 Apr 2013 02:59:33 +0100
Message-ID: <1365645575-11428-3-git-send-email-git@adamspiers.org>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 03:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6nh-0007GP-3A
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 03:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935798Ab3DKB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 21:59:40 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58204 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3DKB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 21:59:39 -0400
Received: from localhost (5.c.4.3.a.a.9.7.2.0.8.9.d.e.c.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:bced:9802:79aa:34c5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id EEB4D58EB0
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 02:59:37 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.347.g37e0606
In-Reply-To: <1365645575-11428-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220801>

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
index 854e4d0..4014d28 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -66,6 +66,11 @@ are also used instead of colons and hard tabs:
 <source> <NULL> <linenum> <NULL> <pattern> <NULL> <pathname> <NULL>
 
 
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
1.8.2.1.347.g37e0606
