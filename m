From: Jim Meyering <jim@meyering.net>
Subject: an hg-to-git adventure
Date: Tue, 27 Mar 2007 11:43:38 +0200
Message-ID: <87tzw7qawl.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 11:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8Dp-0002yH-Db
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 11:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbXC0Jnl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 05:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXC0Jnl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 05:43:41 -0400
Received: from mx.meyering.net ([82.230.74.64]:45443 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbXC0Jnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 05:43:40 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D0DEC54E85; Tue, 27 Mar 2007 11:43:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43244>

Normally, converting a mercurial repository to git is simple: just
run the hg-to-git script (from git/contrib).  However, the one I did
yesterday was different.

Quick summary:

    I had to hack python not to barf on a delta involving .hg/hgrc,
    and to make hg-to-git work even when there are no files to commit.

Here are the details, in case someone else encounters the same problem.

The trouble with that particular hg repository is that the special file,
.hg/hgrc, is under version control.  Earlier versions of Mercurial allowed
that, but new ones do not, and part of the hg-to-git script runs "hg
update -C N" for each change-set number, N, and that "update" command
fails for any change set that includes a file in the .hg/ admin directory.

The very first change set adds just one file, .hg/hgrc.  Because
that file is in .hg/, "hg update -C 0" would fail with this diagnostic:

  "path contains illegal component: .hg/hgrc"

That looked easy to work around.  Just hack hg not to perform that check.
It turns out this approach is fine, since hg-to-git doesn't use the
explicit file list from mercurial, but rather simply git-commits all
changes brought in by the "hg update".  That means changes to .hg/*
admin files are ignored, which is perfect.  Here's the patch: (obviously,
intended solely for private, temporary use)

diff -r 0ce23256e454 mercurial/util.py
--- a/mercurial/util.py	Sat Mar 24 13:31:43 2007 +0100
+++ b/mercurial/util.py	Mon Mar 26 22:12:12 2007 +0200
@@ -652,10 +652,6 @@ def copyfiles(src, dst, hardlink=None):

 def audit_path(path):
     """Abort if path contains dangerous components"""
-    parts = os.path.normcase(path).split(os.sep)
-    if (os.path.splitdrive(path)[0] or parts[0] in ('.hg', '')
-        or os.pardir in parts):
-        raise Abort(_("path contains illegal component: %s\n") % path)

 def _makelock_file(info, pathname):
     ld = os.open(pathname, os.O_CREAT | os.O_WRONLY | os.O_EXCL)

To my surprise, that did not help.  I'd built and installed
mercurial into its own hierarchy with this command:

  python setup.py install --home=/p/p/hg-2007-03-26.20h24

then added /p/p/hg-2007-03-26.20h24/bin at the front of my PATH.
It turns out that the 2-line "hg" driver script was not using the
just-installed libraries.  So I changed /p/p/hg-2007-03-26.20h24/bin/hg,
inserting these two lines after the #! one:

  import sys
  sys.path.insert(0, "/p/p/hg-2007-03-26.20h24/lib/python")

[there's probably a way to do this with some PYTHON*
 envvar, but I prefer not to rely on envvar settings here ]

And that did the job, in that hg-to-git got past the initial failure.
However, it went only a few lines farther before failing anew, this
time because it tried to extract a substring (an SHA1 checksum) from the
empty string -- that happened because there were no files to git-commit
for that first change set.  The following patch works around that case:

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 37337ff..9fbc1d5 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -218,7 +218,10 @@ for cset in range(int(tip) + 1):

     # retrieve and record the version
     vvv = os.popen('git-show | head -1').read()
-    vvv = vvv[vvv.index(' ') + 1 : ].strip()
+    if vvv:
+        vvv = vvv[vvv.index(' ') + 1 : ].strip()
+    else:
+        vvv = '0';
     print 'record', cset, '->', vvv
     hgvers[str(cset)] = vvv

and once it got past that first change set, hg-to-git (using
the hacked "hg") converted the remaining 431 change sets.

FWIW, I also tried tailor, but it did no better than stock hg-to-git.
It might have worked with the hacked "hg", but I didn't try that.

Bottom line, I now have a git repo, and other conversions should be trivial.
