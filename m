From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/3] Fix indexing error during "diff -r/"
Date: Wed, 24 May 2006 08:06:58 +0200
Message-ID: <20060524060658.GB1490@diana.vm.bytemark.co.uk>
References: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=fixed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 08:07:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FimWT-0000U9-6Y
	for gcvg-git@gmane.org; Wed, 24 May 2006 08:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWEXGHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 02:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbWEXGHB
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 02:07:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:13832 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932606AbWEXGHA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 02:07:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FimWI-0000OZ-00; Wed, 24 May 2006 07:06:58 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060524060537.GA1173@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20667>

The string indexing when decoding the -r argument for diff made an
implicit assumption that the revision string was at least two
characters long, which broke on the simple invocation "diff -r/".
---

 stgit/commands/diff.py |    8 ++++----
 stgit/utils.py         |    6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index d765784..caa3c5b 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -56,11 +56,11 @@ def func(parser, options, args):
         rev_list_len = len(rev_list)
         if rev_list_len == 1:
             rev = rev_list[0]
-            if rev[-1] == '/':
+            if rev.endswith('/'):
                 # the whole patch
-                rev = rev[:-1]
-                if rev[-1] == '/':
-                    rev = rev[:-1]
+                rev = strip_suffix('/', rev)
+                if rev.endswith('/'):
+                    rev = strip_suffix('/', rev)
                 rev1 = rev + '//bottom'
                 rev2 = rev + '//top'
             else:
diff --git a/stgit/utils.py b/stgit/utils.py
index ed6e43c..67431ec 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -109,6 +109,12 @@ def strip_prefix(prefix, string):
     assert string.startswith(prefix)
     return string[len(prefix):]
 
+def strip_suffix(suffix, string):
+    """Return string, without the suffix. Blow up if string doesn't
+    end with suffix."""
+    assert string.endswith(suffix)
+    return string[:-len(suffix)]
+
 def remove_dirs(basedir, dirs):
     """Starting at join(basedir, dirs), remove the directory if empty,
     and try the same with its parent, until we find a nonempty
