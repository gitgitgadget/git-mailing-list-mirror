From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Get ciabot configuration from git variables.
Date: Wed, 22 Aug 2012 06:52:30 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20120822105230.GA30382@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 22 13:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T48h1-0002w0-2H
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 13:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab2HVLBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 07:01:41 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:57321
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab2HVLBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 07:01:38 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2012 07:01:38 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 72BF5420EF; Wed, 22 Aug 2012 06:52:30 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204009>

These changes remove all need to modify the ciabot scripts for installation.
Instead, per-project configuration can be dome via variables in a [ciabot]
section of the config file.

Also, correct for the new server address.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 contrib/ciabot/ciabot.py |  161 +++++++++++++++++++++++++---------------------
 contrib/ciabot/ciabot.sh |  117 +++++++++++++++++++--------------
 2 files changed, 158 insertions(+), 120 deletions(-)

diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
index 9775dff..8ce04eb 100755
--- a/contrib/ciabot/ciabot.py
+++ b/contrib/ciabot/ciabot.py
@@ -11,43 +11,41 @@
 #
 # This script is meant to be run either in a post-commit hook or in an
 # update hook.  If there's nothing unusual about your hosting setup,
-# you can specify the project name with a -p option and avoid having
-# to modify this script.  Try it with -n to see the notification mail
-# dumped to stdout and verify that it looks sane. With -V it dumps its
-# version and exits.
+# you can specify the project name and repo with config variables and
+# avoid having to modify this script.  Try it with -n to see the
+# notification mail dumped to stdout and verify that it looks
+# sane. With -V it dumps its version and exits.
 #
-# In post-commit, run it without arguments (other than possibly a -p
-# option). It will query for current HEAD and the latest commit ID to
-# get the information it needs.
+# In post-commit, run it without arguments. It will query for
+# current HEAD and the latest commit ID to get the information it
+# needs.
 #
 # In update, call it with a refname followed by a list of commits:
-# You want to reverse the order git rev-list emits becxause it lists
+# You want to reverse the order git rev-list emits because it lists
 # from most recent to oldest.
 #
 # /path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
 #
-# Note: this script uses mail, not XML-RPC, in order to avoid stalling
-# until timeout when the CIA XML-RPC server is down.
+# Configuration variables affecting this script:
+# ciabot.project = name of the project (required)
+# ciabot.repo = name of the project repo for gitweb/cgit purposes
+# ciabot.xmlrpc  = if true (default), ship notifications via XML-RPC
+# ciabot.revformat = format in which the revision is shown
 #
-
-#
-# The project as known to CIA. You will either want to change this
-# or invoke the script with a -p option to set it.
+# The ciabot.repo value defaults to ciabot.project lowercased.
 #
-project=None
-
+# The revformat variable may have the following values
+# raw -> full hex ID of commit
+# short -> first 12 chars of hex ID
+# describe = -> describe relative to last tag, falling back to short
+# The default is 'describe'.
 #
-# You may not need to change these:
+# Note: the CIA project now says only XML-RPC is reliable, so
+# we default to that.
 #
-import os, sys, commands, socket, urllib
-
-# Name of the repository.
-# You can hardwire this to make the script faster.
-repo = os.path.basename(os.getcwd())
 
-# Fully-qualified domain name of this host.
-# You can hardwire this to make the script faster.
-host = socket.getfqdn()
+import os, sys, commands, socket, urllib
+from xml.sax.saxutils import escape
 
 # Changeset URL prefix for your repo: when the commit ID is appended
 # to this, it should point at a CGI that will display the commit
@@ -72,7 +70,7 @@ xml = '''\
 <message>
   <generator>
     <name>CIA Python client for Git</name>
-    <version>%(gitver)s</version>
+    <version>%(version)s</version>
     <url>%(generator)s</url>
   </generator>
   <source>
@@ -98,19 +96,18 @@ xml = '''\
 # No user-serviceable parts below this line:
 #
 
-# Addresses for the e-mail. The from address is a dummy, since CIA
-# will never reply to this mail.
-fromaddr = "CIABOT-NOREPLY@" + host
-toaddr = "cia@cia.navi.cx"
+# Where to ship e-mail notifications.
+toaddr = "cia@cia.vc"
 
 # Identify the generator script.
 # Should only change when the script itself gets a new home and maintainer.
-generator="http://www.catb.org/~esr/ciabot.py"
+generator = "http://www.catb.org/~esr/ciabot.py"
+version = "3.5"
 
 def do(command):
     return commands.getstatusoutput(command)[1]
 
-def report(refname, merged):
+def report(refname, merged, xmlrpc=True):
     "Generate a commit notification to be reported to CIA"
 
     # Try to tinyfy a reference to a web view for this commit.
@@ -121,32 +118,27 @@ def report(refname, merged):
 
     branch = os.path.basename(refname)
 
-    # Compute a shortnane for the revision
-    rev = do("git describe '"+ merged +"' 2>/dev/null") or merged[:12]
-
-    # Extract the neta-information for the commit
-    rawcommit = do("git cat-file commit " + merged)
+    # Compute a description for the revision
+    if revformat == 'raw':
+        rev = merged
+    elif revformat == 'short':
+        rev = ''
+    else: # revformat == 'describe'
+        rev = do("git describe %s 2>/dev/null" % merged)
+    if not rev:
+        rev = merged[:12]
+
+    # Extract the meta-information for the commit
     files=do("git diff-tree -r --name-only '"+ merged +"' | sed -e '1d' -e 's-.*-<file>&</file>-'")
-    inheader = True
-    headers = {}
-    logmsg = ""
-    for line in rawcommit.split("\n"):
-        if inheader:
-            if line:
-                fields = line.split()
-                headers[fields[0]] = " ".join(fields[1:])
-            else:
-                inheader = False
-        else:
-            logmsg = line
-            break
-    (author, ts) = headers["author"].split(">")
+    metainfo = do("git log -1 '--pretty=format:%an <%ae>%n%at%n%s' " + merged)
+    (author, ts, logmsg) = metainfo.split("\n")
+    logmsg = escape(logmsg)
 
-    # This discards the part of the authors addrsss after @.
-    # Might be bnicece to ship the full email address, if not
+    # This discards the part of the author's address after @.
+    # Might be be nice to ship the full email address, if not
     # for spammers' address harvesters - getting this wrong
     # would make the freenode #commits channel into harvester heaven.
-    author = author.replace("<", "").split("@")[0].split()[-1]
+    author = escape(author.replace("<", "").split("@")[0].split()[-1])
 
     # This ignores the timezone.  Not clear what to do with it...
     ts = ts.strip().split()[0]
@@ -155,8 +147,7 @@ def report(refname, merged):
     context.update(globals())
 
     out = xml % context
-
-    message = '''\
+    mail = '''\
 Message-ID: <%(merged)s.%(author)s@%(project)s>
 From: %(fromaddr)s
 To: %(toaddr)s
@@ -165,25 +156,40 @@ Subject: DeliverXML
 
 %(out)s''' % locals()
 
-    return message
+    if xmlrpc:
+        return out
+    else:
+        return mail
 
 if __name__ == "__main__":
     import getopt
 
+    # Get all config variables
+    revformat = do("git config --get ciabot.revformat")
+    project = do("git config --get ciabot.project")
+    repo = do("git config --get ciabot.repo")
+    xmlrpc = do("git config --get ciabot.xmlrpc")
+    xmlrpc = not (xmlrpc and xmlrpc == "false")
+
+    host = socket.getfqdn()
+    fromaddr = "CIABOT-NOREPLY@" + host
+
     try:
-        (options, arguments) = getopt.getopt(sys.argv[1:], "np:V")
+        (options, arguments) = getopt.getopt(sys.argv[1:], "np:xV")
     except getopt.GetoptError, msg:
         print "ciabot.py: " + str(msg)
         raise SystemExit, 1
 
-    mailit = True
+    notify = True
     for (switch, val) in options:
         if switch == '-p':
             project = val
         elif switch == '-n':
-            mailit = False
+            notify = False
+        elif switch == '-x':
+            xmlrpc = True
         elif switch == '-V':
-            print "ciabot.py: version 3.2"
+            print "ciabot.py: version", version
             sys.exit(0)
 
     # Cough and die if user has not specified a project
@@ -191,8 +197,8 @@ if __name__ == "__main__":
         sys.stderr.write("ciabot.py: no project specified, bailing out.\n")
         sys.exit(1)
 
-    # We'll need the git version number.
-    gitver = do("git --version").split()[0]
+    if not repo:
+        repo = project.lower()
 
     urlprefix = urlprefix % globals()
 
@@ -205,18 +211,29 @@ if __name__ == "__main__":
         refname = arguments[0]
         merges = arguments[1:]
 
-    if mailit:
-        import smtplib
-        server = smtplib.SMTP('localhost')
+    if notify:
+        if xmlrpc:
+            import xmlrpclib
+            server = xmlrpclib.Server('http://cia.vc/RPC2');
+        else:
+            import smtplib
+            server = smtplib.SMTP('localhost')
 
     for merged in merges:
-        message = report(refname, merged)
-        if mailit:
-            server.sendmail(fromaddr, [toaddr], message)
-        else:
+        message = report(refname, merged, xmlrpc)
+        if not notify:
             print message
+        elif xmlrpc:
+            try:
+                # RPC server is flaky, this can fail due to timeout.
+                server.hub.deliver(message)
+            except socket.error, e:
+                sys.stderr.write("%s\n" % e)
+        else:
+            server.sendmail(fromaddr, [toaddr], message)
 
-    if mailit:
-        server.quit()
+    if notify:
+        if not xmlrpc:
+            server.quit()
 
 #End
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
index eb87bba..39afb47 100755
--- a/contrib/ciabot/ciabot.sh
+++ b/contrib/ciabot/ciabot.sh
@@ -3,6 +3,8 @@
 # Copyright (c) 2006 Fernando J. Pereda <ferdy@gentoo.org>
 # Copyright (c) 2008 Natanael Copa <natanael.copa@gmail.com>
 # Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
+# Assistance and review by Petr Baudis, author of ciabot.pl,
+# is gratefully acknowledged.
 #
 # This is a version 3.x of ciabot.sh; use -V to find the exact
 # version.  Versions 1 and 2 were shipped in 2006 and 2008 and are not
@@ -11,6 +13,7 @@
 # Note: This script should be considered obsolete.
 # There is a faster, better-documented rewrite in Python: find it as ciabot.py
 # Use this only if your hosting site forbids Python hooks.
+# It requires: git(1), hostname(1), cut(1), sendmail(1), and wget(1).
 #
 # Originally based on Git ciabot.pl by Petr Baudis.
 # This script contains porcelain and porcelain byproducts.
@@ -19,14 +22,14 @@
 #
 # This script is meant to be run either in a post-commit hook or in an
 # update hook.  If there's nothing unusual about your hosting setup,
-# you can specify the project name with a -p option and avoid having
-# to modify this script.  Try it with -n first to see the notification
-# mail dumped to stdout and verify that it looks sane.  Use -V to dump
-# the version and exit.
+# you can specify the project name and repo with config variables and
+# avoid having to modify this script.  Try it with -n to see the
+# notification mail dumped to stdout and verify that it looks
+# sane. With -V it dumps its version and exits.
 #
-# In post-commit, run it without arguments (other than possibly a -p
-# option). It will query for current HEAD and the latest commit ID to
-# get the information it needs.
+# In post-commit, run it without arguments. It will query for
+# current HEAD and the latest commit ID to get the information it
+# needs.
 #
 # In update, you have to call it once per merged commit:
 #
@@ -34,33 +37,54 @@
 #       oldhead=$2
 #       newhead=$3
 #       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
-#               /path/to/ciabot.bash ${refname} ${merged}
+#               /path/to/ciabot.sh ${refname} ${merged}
 #       done
 #
-# The reason for the tac call ids that git rev-list emits commits from
+# The reason for the tac call is that git rev-list emits commits from
 # most recent to least - better to ship notifactions from oldest to newest.
 #
-# Note: this script uses mail, not XML-RPC, in order to avoid stalling
-# until timeout when the CIA XML-RPC server is down.
+# Configuration variables affecting this script:
+# ciabot.project = name of the project (makes -p option unnecessary)
+# ciabot.repo = name of the project repo for gitweb/cgit purposes
+# ciabot.revformat = format in which the revision is shown
 #
-
-#
-# The project as known to CIA. You will either want to change this
-# or set the project name with a -p option.
+# The ciabot.repo defaults to ciabot.project lowercased.
 #
-project=
-
+# The revformat variable may have the following values
+# raw -> full hex ID of commit
+# short -> first 12 chars of hex ID
+# describe = -> describe relative to last tag, falling back to short
+# The default is 'describe'.
 #
-# You may not need to change these:
+# Note: the shell ancestors of this script used mail, not XML-RPC, in
+# order to avoid stalling until timeout when the CIA XML-RPC server is
+# down. It is unknown whether this is still an issue in 2010, but
+# XML-RPC would be annoying to do from sh in any case. (XML-RPC does
+# have the advantage that it guarantees notification of multiple commits
+# shpped from an update in their actual order.)
 #
 
-# Name of the repository.
-# You can hardwire this to make the script faster.
-repo="`basename ${PWD}`"
+# The project as known to CIA. You can also hardwire this or set it with a
+# -p option.
+project=$(git config --get ciabot.project)
+
+# Name of the repo for gitweb/cgit purposes
+repo=$(git config --get ciabot.repo)
+[ -z $repo] && repo=$(echo "${project}" | tr '[A-Z]' '[a-z]')
+
+# What revision format do we want in the summary?
+revformat=$(git config --get ciabot.revformat)
 
-# Fully qualified domain name of the repo host.
-# You can hardwire this to make the script faster.
-host=`hostname --fqdn`
+# Fully qualified domain name of the repo host.  You can hardwire this
+# to make the script faster. The -f option works under Linux and FreeBSD,
+# but not OpenBSD and NetBSD. But under OpenBSD and NetBSD,
+# hostname without options gives the FQDN.
+if hostname -f >/dev/null 2>&1
+then
+    hostname=`hostname -f`
+else
+    hostname=`hostname`
+fi
 
 # Changeset URL prefix for your repo: when the commit ID is appended
 # to this, it should point at a CGI that will display the commit
@@ -73,13 +97,14 @@ urlprefix="http://${host}/cgi-bin/cgit.cgi/${repo}/commit/?id="
 # You probably will not need to change the following:
 #
 
-# Identify the script. Should change only when the script itself
-# gets a new home and maintainer.
+# Identify the script. The 'generator' variable should change only
+# when the script itself gets a new home and maintainer.
 generator="http://www.catb.org/~esr/ciabot/ciabot.sh"
+version=3.4
 
 # Addresses for the e-mail
-from="CIABOT-NOREPLY@${host}"
-to="cia@cia.navi.cx"
+from="CIABOT-NOREPLY@${hostname}"
+to="cia@cia.vc"
 
 # SMTP client to use - may need to edit the absolute pathname for your system
 sendmail="sendmail -t -f ${from}"
@@ -95,9 +120,9 @@ mode=mailit
 while getopts pnV opt
 do
     case $opt in
-	p) project=$2; shift ; shift ;;
+        p) project=$2; shift ; shift ;;
 	n) mode=dumpit; shift ;;
-	V) echo "ciabot.sh: version 3.2"; exit 0; shift ;;
+	V) echo "ciabot.sh: version $version"; exit 0; shift ;;
     esac
 done
 
@@ -128,33 +153,29 @@ fi
 
 refname=${refname##refs/heads/}
 
-gitver=$(git --version)
-gitver=${gitver##* }
+case $revformat in
+raw) rev=$merged ;;
+short) rev='' ;;
+*) rev=$(git describe ${merged} 2>/dev/null) ;;
+esac
+[ -z ${rev} ] && rev=$(echo "$merged" | cut -c 1-12)
 
-rev=$(git describe ${merged} 2>/dev/null)
-# ${merged:0:12} was the only bashism left in the 2008 version of this
-# script, according to checkbashisms.  Replace it with ${merged} here
-# because it was just a fallback anyway, and it's worth accepting a
-# longer fallback for faster execution and removing the bash
-# dependency.
-[ -z ${rev} ] && rev=${merged}
-
-# This discards the part of the author's address after @.
+# We discard the part of the author's address after @.
 # Might be nice to ship the full email address, if not
 # for spammers' address harvesters - getting this wrong
 # would make the freenode #commits channel into harvester heaven.
-rawcommit=$(git cat-file commit ${merged})
-author=$(echo "$rawcommit" | sed -n -e '/^author .*<\([^@]*\).*$/s--\1-p')
-logmessage=$(echo "$rawcommit" | sed -e '1,/^$/d' | head -n 1)
-logmessage=$(echo "$logmessage" | sed 's/\&/&amp\;/g; s/</&lt\;/g; s/>/&gt\;/g')
-ts=$(echo "$rawcommit" | sed -n -e '/^author .*> \([0-9]\+\).*$/s--\1-p')
+author=$(git log -1 '--pretty=format:%an <%ae>' $merged)
+author=$(echo "$author" | sed -n -e '/^.*<\([^@]*\).*$/s--\1-p')
+
+logmessage=$(git log -1 '--pretty=format:%s' $merged)
+ts=$(git log -1 '--pretty=format:%at' $merged)
 files=$(git diff-tree -r --name-only ${merged} | sed -e '1d' -e 's-.*-<file>&</file>-')
 
 out="
 <message>
   <generator>
     <name>CIA Shell client for Git</name>
-    <version>${gitver}</version>
+    <version>${version}</version>
     <url>${generator}</url>
   </generator>
   <source>
@@ -167,7 +188,7 @@ out="
       <author>${author}</author>
       <revision>${rev}</revision>
       <files>
-	${files}
+        ${files}
       </files>
       <log>${logmessage} ${url}</log>
       <url>${url}</url>
-- 
1.7.9.5


-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
