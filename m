From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Make the ciabot scripts completely self-configuring in the
 normal case.
Date: Thu, 23 Aug 2012 01:21:53 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20120823052153.GA14585@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 23 07:22:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4PsV-0007IF-Oa
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 07:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab2HWFWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 01:22:39 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34019
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845Ab2HWFWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 01:22:25 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id B1856420EF; Thu, 23 Aug 2012 01:21:53 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204111>

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 contrib/ciabot/INSTALL   |   26 +++++++++++++++++++++-----
 contrib/ciabot/README    |   11 -----------
 contrib/ciabot/ciabot.py |   32 +++++++++++++++++++++-----------
 contrib/ciabot/ciabot.sh |   40 ++++++++++++++++++++++++++++++----------
 4 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/contrib/ciabot/INSTALL b/contrib/ciabot/INSTALL
index dbfd165..428a5b9 100644
--- a/contrib/ciabot/INSTALL
+++ b/contrib/ciabot/INSTALL
@@ -8,22 +8,38 @@ It is no longer necessary to modify the script in order to put it
 in place; in fact, this is now discouraged. It is entirely
 configurable with the following git config variables:
 
-ciabot.project = name of the project (required)
+ciabot.project = name of the project
 ciabot.repo = name of the project repo for gitweb/cgit purposes
-ciabot.xmlrpc  = if true (default), ship notifications via XML-RPC
+ciabot.xmlrpc  = if true, ship notifications via XML-RPC
 ciabot.revformat = format in which the revision is shown
 
-The ciabot.repo value defaults to ciabot.project lowercased.
-
 The revformat variable may have the following values
 raw -> full hex ID of commit
 short -> first 12 chars of hex ID
 describe -> describe relative to last tag, falling back to short
-The default is 'describe'.
+
+ciabot.project defaults to the directory name of the repository toplevel.
+ciabot.repo defaults to ciabot.project lowercased. 
+ciabot.xmlrpc defaults to True
+ciabot.revformat defaults to 'describe'.
+
+This means that in the normal case you need not do any configuration at all,
+however setting ciabot.project will allow the hook to run slightly faster.
 
 Once you've set these variables, try your script with -n to see the
 notification message dumped to stdout and verify that it looks sane.
 
+To live-test these scripts, your project needs to have been registered with
+the CIA site.  Here are the steps:
+
+1. Open an IRC window on irc://freenode/commits or your registered 
+   project IRC channel.  
+
+2. Run ciabot.py and/or ciabot.sh from any directory under git
+   control.
+
+You should see a notification on the channel for your most recent commit.
+
 After verifying correct function, install one of these scripts either
 in a post-commit hook or in an update hook.
 
diff --git a/contrib/ciabot/README b/contrib/ciabot/README
index 9eccca3..2dfe1f9 100644
--- a/contrib/ciabot/README
+++ b/contrib/ciabot/README
@@ -8,15 +8,4 @@ You probably want the Python version; it's faster, more capable, and
 better documented.  The shell version is maintained only as a fallback
 for use on hosting sites that don't permit Python hook scripts.
 
-To test these scripts, your project needs to have been registered with
-the CIA site.  Here are the steps:
-
-1. Open an IRC window on irc://freenode/commits or your registered 
-   project IRC channel.  
-
-2. Run ciabot.py and/or ciabot.sh from any directory under git
-   control, using the -p option to pass in your project name.
-
-You should see a notification on the channel for your most recent commit.
-
 See the file INSTALL for installation instructions.
diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index 8ce04eb..6863fea 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -10,11 +10,9 @@
 # usage: ciabot.py [-V] [-n] [-p projectname]  [refname [commits...]]
 #
 # This script is meant to be run either in a post-commit hook or in an
-# update hook.  If there's nothing unusual about your hosting setup,
-# you can specify the project name and repo with config variables and
-# avoid having to modify this script.  Try it with -n to see the
-# notification mail dumped to stdout and verify that it looks
-# sane. With -V it dumps its version and exits.
+# update hook. Try it with -n to see the notification mail dumped to
+# stdout and verify that it looks sane. With -V it dumps its version
+# and exits.
 #
 # In post-commit, run it without arguments. It will query for
 # current HEAD and the latest commit ID to get the information it
@@ -27,12 +25,17 @@
 # /path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
 #
 # Configuration variables affecting this script:
-# ciabot.project = name of the project (required)
+#
+# ciabot.project = name of the project
 # ciabot.repo = name of the project repo for gitweb/cgit purposes
 # ciabot.xmlrpc  = if true (default), ship notifications via XML-RPC
 # ciabot.revformat = format in which the revision is shown
 #
-# The ciabot.repo value defaults to ciabot.project lowercased.
+# ciabot.project defaults to the directory name of the repository toplevel.
+# ciabot.repo defaults to ciabot.project lowercased.
+#
+# This means that in the normal case you need not do any configuration at all,
+# but setting the project name will speed it up slightly.
 #
 # The revformat variable may have the following values
 # raw -> full hex ID of commit
@@ -102,7 +105,7 @@ toaddr = "cia@cia.vc"
 # Identify the generator script.
 # Should only change when the script itself gets a new home and maintainer.
 generator = "http://www.catb.org/~esr/ciabot.py"
-version = "3.5"
+version = "3.6"
 
 def do(command):
     return commands.getstatusoutput(command)[1]
@@ -192,10 +195,17 @@ if __name__ == "__main__":
             print "ciabot.py: version", version
             sys.exit(0)
 
-    # Cough and die if user has not specified a project
+    # The project variable defaults to the name of the repository toplevel. 
     if not project:
-        sys.stderr.write("ciabot.py: no project specified, bailing out.\n")
-        sys.exit(1)
+        here = os.getcwd()
+        while True:
+            if os.path.exists(os.path.join(here, ".git")):
+                project = os.path.basename(here)
+                break
+            elif here == '/':
+                sys.stderr.write("ciabot.py: no .git below root!\n")
+                sys.exit(1)
+            here = os.path.dirname(here)
 
     if not repo:
         repo = project.lower()
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index 39afb47..b5583dc 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -21,11 +21,9 @@
 # usage: ciabot.sh [-V] [-n] [-p projectname] [refname commit]
 #
 # This script is meant to be run either in a post-commit hook or in an
-# update hook.  If there's nothing unusual about your hosting setup,
-# you can specify the project name and repo with config variables and
-# avoid having to modify this script.  Try it with -n to see the
-# notification mail dumped to stdout and verify that it looks
-# sane. With -V it dumps its version and exits.
+# update hook. Try it with -n to see the notification mail dumped to
+# stdout and verify that it looks sane. With -V it dumps its version
+# and exits.
 #
 # In post-commit, run it without arguments. It will query for
 # current HEAD and the latest commit ID to get the information it
@@ -44,11 +42,16 @@
 # most recent to least - better to ship notifactions from oldest to newest.
 #
 # Configuration variables affecting this script:
-# ciabot.project = name of the project (makes -p option unnecessary)
+#
+# ciabot.project = name of the project
 # ciabot.repo = name of the project repo for gitweb/cgit purposes
 # ciabot.revformat = format in which the revision is shown
 #
-# The ciabot.repo defaults to ciabot.project lowercased.
+# ciabot.project defaults to the directory name of the repository toplevel.
+# ciabot.repo defaults to ciabot.project lowercased.
+#
+# This means that in the normal case you need not do any configuration at all,
+# but setting the project name will speed it up slightly.
 #
 # The revformat variable may have the following values
 # raw -> full hex ID of commit
@@ -64,10 +67,27 @@
 # shpped from an update in their actual order.)
 #
 
-# The project as known to CIA. You can also hardwire this or set it with a
-# -p option.
+# The project as known to CIA. You can set this with a -p option,
+# or let it default to the directory name of the repo toplevel.
 project=$(git config --get ciabot.project)
 
+if [ -z $project ]
+then
+    here=`pwd`;
+    while :; do
+	if [ -d $here/.git ]
+	then
+	    project=`basename $here`
+	    break
+	elif [ $here = '/' ]
+	then
+	    echo "ciabot.sh: no .git below root!"
+	    exit 1
+	fi
+	here=`dirname $here`
+    done
+fi
+
 # Name of the repo for gitweb/cgit purposes
 repo=$(git config --get ciabot.repo)
 [ -z $repo] && repo=$(echo "${project}" | tr '[A-Z]' '[a-z]')
@@ -100,7 +120,7 @@ urlprefix="http://${host}/cgi-bin/cgit.cgi/${repo}/commit/?id="
 # Identify the script. The 'generator' variable should change only
 # when the script itself gets a new home and maintainer.
 generator="http://www.catb.org/~esr/ciabot/ciabot.sh"
-version=3.4
+version=3.5
 
 # Addresses for the e-mail
 from="CIABOT-NOREPLY@${hostname}"
-- 
1.7.9.5


-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
