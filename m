From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Provide some technical documentation for shallow clones
Date: Tue, 20 Mar 2007 03:41:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703200340440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 20 03:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTUHl-000756-96
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 03:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966078AbXCTClN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 22:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966075AbXCTClN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 22:41:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:32810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966079AbXCTClM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 22:41:12 -0400
Received: (qmail invoked by alias); 20 Mar 2007 02:41:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 20 Mar 2007 03:41:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/chHdRknXcJFW+B0W1nNQ2thScQDhuSo5EZf+EcO
	Xb7soywTjYXovi
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42693>


There has not been any work on the shallow stuff lately, so it is hard
to find out what it does, and how. This document describes the ideas
as well as the current problems, and can serve as a starting point for
shallow people.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/technical/shallow.txt |   49 +++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
new file mode 100644
index 0000000..923e0bd
--- /dev/null
+++ b/Documentation/technical/shallow.txt
@@ -0,0 +1,49 @@
+Def.: Shallow commits do have parents, but not in the shallow
+repo, and therefore grafts are introduced pretending that
+these commits have no parents.
+
+The basic idea is to write the SHA1s of shallow commits into
+$GIT_DIR/shallow, and handle its contents like the contents
+of $GIT_DIR/info/grafts (with the difference that shallow
+cannot contain parent information).
+
+This information is stored in a new file instead of grafts, or
+even the config, since the user should not touch that file
+at all (even throughout development of the shallow clone, it
+was never manually edited!).
+
+Each line contains exactly one SHA1. When read, a commit_graft
+will be constructed, which has nr_parent < 0 to make it easier
+to discern from user provided grafts.
+
+Since fsck-objects relies on the library to read the objects,
+it honours shallow commits automatically.
+
+There are some unfinished ends of the whole shallow business:
+
+- maybe we have to force non-thin packs when fetching into a
+  shallow repo (ATM they are forced non-thin). 
+
+- A special handling of a shallow upstream is needed. At some
+  stage, upload-pack has to check if it sends a shallow commit,
+  and it should send that information early (or fail, if the
+  client does not support shallow repositories). There is no
+  support at all for this in this patch series.
+
+- Instead of locking $GIT_DIR/shallow at the start, just
+  the timestamp of it is noted, and when it comes to writing it,
+  a check is performed if the mtime is still the same, dying if
+  it is not.
+
+- It is unclear how "push into/from a shallow repo" should behave.
+
+- If you deepen a history, you'd want to get the tags of the
+  newly stored (but older!) commits. This does not work right now.
+
+To make a shallow clone, you can call "git-clone --depth 20 repo".
+The result contains only commit chains with a length of at most 20.
+It also writes an appropriate $GIT_DIR/shallow.
+
+You can deepen a shallow repository with "git-fetch --depth 20
+repo branch", which will fetch branch from repo, but stop at depth
+20, updating $GIT_DIR/shallow.
