From: Eric Blake <eblake@redhat.com>
Subject: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue,  5 Apr 2011 13:36:54 -0600
Message-ID: <1302032214-11438-1-git-send-email-eblake@redhat.com>
Cc: eblake@redhat.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 21:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7C9R-0004pc-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 21:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1DETmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 15:42:49 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:40713
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752856Ab1DETms (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 15:42:48 -0400
X-Greylist: delayed 340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 15:42:48 EDT
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id TuNQ1g0091c6gX851vd8BF; Tue, 05 Apr 2011 19:37:08 +0000
Received: from office.redhat.com ([24.10.251.25])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id Tvcw1g00F0ZdyUg3jvd3Nt; Tue, 05 Apr 2011 19:37:05 +0000
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170907>

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
---
 Documentation/gitignore.txt |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..2f49989 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -70,7 +70,9 @@ PATTERN FORMAT
  - An optional prefix '!' which negates the pattern; any
    matching file excluded by a previous pattern will become
    included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   override lower precedence patterns sources.  However, a
+   file negation does not override a path that has already
+   been excluded by a directory match.

  - If the pattern ends with a slash, it is removed for the
    purpose of the following description, but it would only find
@@ -87,7 +89,8 @@ PATTERN FORMAT

  - Otherwise, git treats the pattern as a shell glob suitable
    for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
+   wildcards in the pattern will not match a / in the pathname,
+   and do not ignore files with a leading . in the pathname.
    For example, "Documentation/{asterisk}.html" matches
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".
@@ -116,8 +119,11 @@ EXAMPLES
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
@@ -125,6 +131,10 @@ EXAMPLES
     $ cat .git/info/exclude
     # ignore objects and archives, anywhere in the tree.
     *.[oa]
+    # ignore files in the immediate child directory build,
+    /build/*
+    # except for the log.
+    !/build/log
     $ cat Documentation/.gitignore
     # ignore generated html files,
     *.html
@@ -134,10 +144,15 @@ EXAMPLES
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
