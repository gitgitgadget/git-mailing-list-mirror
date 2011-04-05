From: Eric Blake <eblake@redhat.com>
Subject: [PATCHv3 2/2] Documentation: enhance gitignore whitelist example
Date: Tue,  5 Apr 2011 16:17:58 -0600
Message-ID: <1302041878-24426-2-git-send-email-eblake@redhat.com>
References: <1302041878-24426-1-git-send-email-eblake@redhat.com>
Cc: eblake@redhat.com, j6t@kdbg.org, jrnieder@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 00:18:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7EZl-0003eE-T1
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab1DEWSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:18:13 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:59233
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752329Ab1DEWSM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 18:18:12 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id TyGK1g00316LCl054yJDnj; Tue, 05 Apr 2011 22:18:13 +0000
Received: from office.redhat.com ([24.10.251.25])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id TyJ01g00n0ZdyUg3SyJCVa; Tue, 05 Apr 2011 22:18:13 +0000
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1302041878-24426-1-git-send-email-eblake@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170927>

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

CC: Jonathan Nieder <jrnieder@gmail.com>
CC: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

v3: split out fnmatch tweaks, don't tweak specification of patterns
or existing examples but instead add an entirely new example, make
the example use a deeper hierarchy

 Documentation/gitignore.txt |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 9b1e5e1..e1ad234 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -139,6 +139,44 @@ EXAMPLES
     [...]
 --------------------------------------------------------------

+It is possible to ignore most of a hierarchy, while still
+white-listing a single file, by ignoring multiple files then using a
+negation pattern for the file in question.  However, this requires
+ignoring files and not directories, since no patterns are ever matched
+inside of an ignored directory.  For nested files, it requires several
+iterations of refined patterns.
+
+--------------------------------------------------------------
+    $ git status
+    [...]
+    # Untracked files:
+    [...]
+    #       Documentation/build/file
+    #       build/file
+    #       build/foo/baz
+    #       build/foo/other
+    [...]
+    $ cat .gitignore
+    # Use anchoring, since `build' would ignore Documentation/build.
+    # Do not ignore the directory itself, ...
+    # /build/
+    # rather ignore files in the top-level build directory, ...
+    /build/*
+    # but permit child directories, ...
+    !/build/*/
+    # then ignore all nested files, ...
+    /build/*/*
+    # and finally white-list the special file
+    !/build/foo/baz
+    $ git status
+    [...]
+    # Untracked files:
+    [...]
+    #       Documentation/build/file
+    #       build/foo/baz
+    [...]
+--------------------------------------------------------------
+
 Another example:

 --------------------------------------------------------------
-- 
1.7.4
