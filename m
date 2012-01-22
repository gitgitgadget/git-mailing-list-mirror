From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH git-remote-bzr] Adapt to new semantics of remote-helper
 "import" command
Date: Sat, 21 Jan 2012 23:46:57 -0600
Message-ID: <20120122054657.GA25103@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Poirier <spoirier@rlnx.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 06:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoqH8-0000BT-UA
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 06:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab2AVFrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jan 2012 00:47:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab2AVFrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2012 00:47:08 -0500
Received: by yhoo21 with SMTP id o21so873246yho.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 21:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=SIei+gptbJESXvJE2IU8GBzAib5nuWUc8uxMrMyF1ao=;
        b=Qjlu98IPxhav8irtexTOnMCH/XExQC+DkXixo7LZ+FQ6iiQoxm4RWVNQUi725qxStY
         l9+6vGeT8VeljjxQetNkNHdcLDfsyQDVP4E+tWRCSvuDpC6VC9nV/WpGFU+3B4uzF1ob
         +3lB+08byyfTnTNPlzg/z7rFsCzT+kKxxIb74=
Received: by 10.236.115.201 with SMTP id e49mr5046561yhh.89.1327211227783;
        Sat, 21 Jan 2012 21:47:07 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id r68sm14350835yhm.18.2012.01.21.21.47.06
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 21:47:06 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188945>

Git 1.7.7 (commit 9504bc9d, "transport-helper: change import
semantics", 2011-07-16) incompatibly changed the interface of the
"import" capability.

Before, git would always send a single import command, which the
remote helper would respond to with a fast-import stream, terminated
by end of file, meaning there was no way to fetch multiple refs in one
connection.  Nowadays, git instead sends a sequence of import lines:

	import refs/heads/foo
	import refs/heads/bar

terminated by a blank line.  The helper is to respond with a
fast-import stream terminated by the "done" command and process
further commands until another blank line indicates the end of the
command stream.
---
Hi Simon and Gabriel,

Here's a rough patch against git://github.com/lelutin/git-remote-bzr.git
master.

Without this patch, whenever I try to use "git clone bzr::<something>",
after doing all the work it removes the resulting repo and exits with
status 141 (SIGPIPE).  Maybe the transport-helper should mask SIGPIPE
when writing the final newline to avoid that.

I'd have prefered to write a patch for remote-bzr that works with
older versions of git fast-import, too, but it wasn't obvious how.
Hints welcome.

BTW, would you mind if I sent a patch to include git-remote-bzr in
git.git under contrib/?

Thanks for git remote-bzr!  I'd be happy for any thoughts you have.

Ciao,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/176002/focus=176606

 README.rst     |    2 +-
 git-remote-bzr |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/README.rst b/README.rst
index 3eb3e476..f4dbbeb2 100644
--- a/README.rst
+++ b/README.rst
@@ -34,7 +34,7 @@ Relevant bug reports
 Requirements
 ------------
 
-- git 1.6.6 or later
+- git 1.7.7 or later
 - python 2.5 +
 - bzr 2.x
 - bzr-fastimport
diff --git a/git-remote-bzr b/git-remote-bzr
index 1e3a05f9..501fffe3 100755
--- a/git-remote-bzr
+++ b/git-remote-bzr
@@ -49,7 +49,7 @@ def do_list(repo, args):
     print  # end list
 
 
-def do_import(repo, args):
+def import_one_ref(repo, args):
     """Import a fast-import stream that is exported from Bazaar."""
     if len(args) != 1:
         die("Import needs exactly one ref")
@@ -65,6 +65,23 @@ def do_import(repo, args):
     if bzrp.wait():
         die("'bzr fast-export' returned unexpectedly with code %d",
             bzrp.returncode)
+    print "done"
+
+
+def do_import(repo,args):
+    import_one_ref(repo, args)
+
+    cmdline = True
+    while cmdline:
+        cmdline = next_command()
+        if not cmdline:
+            # Return to main processing loop
+            return True
+        cmd = cmdline.pop(0)
+        if cmd != "import":
+            warn("Unexpected command %s during import" % cmd)
+            return False
+        import_one_ref(repo, cmdline)
 
 
 def do_push(repo, args):
@@ -123,8 +140,8 @@ def sanitize(value):
     return value
 
 
-def read_one_line(repo):
-    """Read and process one command."""
+def next_command():
+    """Read one command."""
     line = sys.stdin.readline()
 
     cmdline = line
@@ -138,6 +155,16 @@ def read_one_line(repo):
         # Blank line means we're about to quit
         return False
 
+    return cmdline
+
+
+def read_one_line(repo):
+    """Read and process one command."""
+    cmdline = next_command()
+
+    if not cmdline:
+        return False
+
     cmd = cmdline.pop(0)
     debug("Got command '%s' with args '%s'", cmd, ' '.join(cmdline))
 
-- 
1.7.9.rc2
