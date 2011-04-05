From: Eric Blake <eblake@redhat.com>
Subject: [PATCHv2] Documentation: enhance gitignore whitelist example
Date: Tue,  5 Apr 2011 15:06:23 -0600
Message-ID: <1302037583-19289-1-git-send-email-eblake@redhat.com>
Cc: eblake@redhat.com, j6t@kdbg.org, jrnieder@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 23:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7DXz-0001gl-6j
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab1DEVMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 17:12:18 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:52764 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754017Ab1DEVMS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 17:12:18 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 17:12:18 EDT
Received: from omta10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id Tx0G1g0050cQ2SLA6x6btf; Tue, 05 Apr 2011 21:06:35 +0000
Received: from office.redhat.com ([24.10.251.25])
	by omta10.emeryville.ca.mail.comcast.net with comcast
	id Tx6W1g01A0ZdyUg8Wx6acu; Tue, 05 Apr 2011 21:06:35 +0000
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170915>

I was trying to whitelist a single file pattern in a directory
that I was otherwise content to ignore, but when I tried:

  /m4/
  !/m4/virt-*.m4

then 'git add' kept warning me that I had to use -f.  I finally
figured out that ignoring a directory is much different than ignoring
all files in a directory, when it comes to later negation patterns:

  /m4/*
  !/m4/virt-*.m4

Improving the documentation will help others learn from my mistake.

Signed-off-by: Eric Blake <eblake@redhat.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
CC: Johannes Sixt <j6t@kdbg.org>
---

v2: incorporate helpful comments from Junio

 Documentation/gitignore.txt |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..0955931 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -70,7 +70,11 @@ PATTERN FORMAT
  - An optional prefix '!' which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   override lower precedence patterns sources.  However, since
+   directory patterns prevent searching for any files below
+   that directory, if it is desirable to whitelist a single
+   file in a directory, you should first exclude all files in
+   the directory rather than the directory itself.

  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
@@ -87,7 +91,8 @@ PATTERN FORMAT

  - Otherwise, git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
+   wildcards in the pattern will not match a / in the pathname,
+   and do not ignore files with a leading . in the pathname.
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
@@ -116,8 +121,11 @@ EXAMPLES
     [...]
     # Untracked files:
     [...]
+    #       Documentation/build
     #       Documentation/foo.html
     #       Documentation/gitignore.html
+    #       build/log
+    #       build/.file
     #       file.o
     #       lib.a
     #       src/internal.o
@@ -125,19 +133,28 @@ EXAMPLES
     $ cat .git/info/exclude
     # ignore objects and archives, anywhere in the tree.
     *.[oa]
+    # ignore files in the immediate child directory build,...
+    /build/*
+    # ... except for the log.
+    !/build/log
     $ cat Documentation/.gitignore
-    # ignore generated html files,
+    # ignore generated html files,...
     *.html
-    # except foo.html which is maintained by hand
+    # ... except foo.html which is maintained by hand
     !foo.html
     $ git status
     [...]
     # Untracked files:
     [...]
+    #       Documentation/build
     #       Documentation/foo.html
+    #       build/log
     [...]
 --------------------------------------------------------------

+Note that using `!/build/log' works with an earlier `/build/*' but
+would have no effect if there were an earlier `/build/'.
+
 Another example:

 --------------------------------------------------------------
-- 
1.7.4
