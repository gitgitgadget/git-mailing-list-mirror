From: esr@thyrsus.com (Eric Raymond)
Subject: [PATCH] Integrate version 3 ciabot scripts into contrib/.
Date: Fri, 2 Apr 2010 06:10:11 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100402101011.GA6806@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 12:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxdpa-0001vC-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 12:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab0DBKKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 06:10:16 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43922
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392Ab0DBKKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 06:10:13 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id E7F04475FEF; Fri,  2 Apr 2010 06:10:11 -0400 (EDT)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143803>

These have been extensively live-tested in the last week. The version 2
ciabot.sh maintainer has passed the baton to me; ciabot.py is original.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 contrib/ciabot/README    |   12 +++
 contrib/ciabot/ciabot.py |  222 ++++++++++++++++++++++++++++++++++++++++++++++
 contrib/ciabot/ciabot.sh |  192 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 426 insertions(+), 0 deletions(-)
 create mode 100644 contrib/ciabot/README
 create mode 100755 contrib/ciabot/ciabot.py
 create mode 100755 contrib/ciabot/ciabot.sh

diff --git a/contrib/ciabot/README b/contrib/ciabot/README
new file mode 100644
index 0000000..2d8292e
--- /dev/null
+++ b/contrib/ciabot/README
@@ -0,0 +1,12 @@
+These are hook scripts for the CIA notification service at <http://cia.vc/>
+
+They are maintained by Eric S. Raymond <esr@thyrsus.com>.  There is an
+upstream resource page for them at <http://www.catb.org/esr/ciabot/>,
+but they are unlikely to change rapidly.
+
+You probably want the Python version; it's faster, more capable, and 
+better documented.  The shell version is maintained only as a fallback 
+for use on hosting sites that don't permit Python hook scripts.
+
+You will find installation instructions for each script in its comment
+header. 
diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
new file mode 100755
index 0000000..4b795a3
--- /dev/null
+++ b/contrib/ciabot/ciabot.py
@@ -0,0 +1,222 @@
+#!/usr/bin/env python
+# Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
+# Distributed under BSD terms.
+#
+# This script contains porcelain and porcelain byproducts.
+# It's Python because the Python standard libraries avoid portability/security
+# issues raised by callouts in the ancestral Perl and sh scripts.  It should
+# be compatible back to Python 2.1.5
+#
+# usage: ciabot.py [-V] [-n] [-p projectname]  [refname [commits...]]
+#
+# This script is meant to be run either in a post-commit hook or in an
+# update hook.  If there's nothing unusual about your hosting setup,
+# you can specify the project name with a -p option and avoid having
+# to modify this script.  Try it with -n to see the notification mail
+# dumped to stdout and verify that it looks sane. With -V it dumps its
+# version and exits.
+#
+# In post-commit, run it without arguments (other than possibly a -p
+# option). It will query for current HEAD and the latest commit ID to
+# get the information it needs. 
+#
+# In update, call it with a refname followed by a list of commits:
+# You want to reverse the order git rev-list emits becxause it lists
+# from most recent to oldest.
+#
+# /path/to/ciabot.py ${refname} $(git rev-list ${oldhead}..${newhead} | tac)
+#
+# Note: this script uses mail, not XML-RPC, in order to avoid stalling
+# until timeout when the CIA XML-RPC server is down. 
+#
+
+#
+# The project as known to CIA. You will either want to change this
+# or invoke the script with a -p option to set it.
+#
+project=None
+
+#
+# You may not need to change these:
+#
+import os, sys, commands, socket, urllib
+
+# Name of the repository.
+# You can hardwire this to make the script faster.
+repo = os.path.basename(os.getcwd())
+
+# Fully-qualified domain name of this host.
+# You can hardwire this to make the script faster.
+host = socket.getfqdn()
+
+# Changeset URL prefix for your repo: when the commit ID is appended
+# to this, it should point at a CGI that will display the commit
+# through gitweb or something similar. The defaults will probably
+# work if you have a typical gitweb/cgit setup.
+#
+#urlprefix="http://%(host)s/cgi-bin/gitweb.cgi?p=%(repo)s;a=commit;h="
+urlprefix="http://%(host)s/cgi-bin/cgit.cgi/%(repo)s/commit/?id="
+
+# The service used to turn your gitwebbish URL into a tinyurl so it
+# will take up less space on the IRC notification line.
+tinyifier = "http://tinyurl.com/api-create.php?url="
+
+# The template used to generate the XML messages to CIA.  You can make
+# visible changes to the IRC-bot notification lines by hacking this.
+# The default will produce a notfication line that looks like this:
+#
+# ${project}: ${author} ${repo}:${branch} * ${rev} ${files}: ${logmsg} ${url}
+#
+# By omitting $files you can collapse the files part to a single slash.
+xml = '''\
+<message>
+  <generator>
+    <name>CIA Python client for Git</name>
+    <version>%(gitver)s</version>
+    <url>%(generator)s</url>
+  </generator>
+  <source>
+    <project>%(project)s</project>
+    <branch>%(repo)s:%(branch)s</branch>
+  </source>
+  <timestamp>%(ts)s</timestamp>
+  <body>
+    <commit>
+      <author>%(author)s</author>
+      <revision>%(rev)s</revision>
+      <files>
+        %(files)s
+      </files>
+      <log>%(logmsg)s %(url)s</log>
+      <url>%(url)s</url>
+    </commit>
+  </body>
+</message>
+'''
+
+#
+# No user-serviceable parts below this line:
+#
+
+# Addresses for the e-mail. The from address is a dummy, since CIA
+# will never reply to this mail.
+fromaddr = "CIABOT-NOREPLY@" + host
+toaddr = "cia@cia.navi.cx"
+
+# Identify the generator script.
+# Should only change when the script itself gets a new home and maintainer.
+generator="http://www.catb.org/~esr/ciabot.py"
+
+def do(command):
+    return commands.getstatusoutput(command)[1]
+
+def report(refname, merged):
+    "Generate a commit notification to be reported to CIA"
+
+    # Try to tinyfy a reference to a web view for this commit.
+    try:
+        url = open(urllib.urlretrieve(tinyifier + urlprefix + merged)[0]).read()
+    except:
+        url = urlprefix + merged
+
+    branch = os.path.basename(refname)
+
+    # Compute a shortnane for the revision
+    rev = do("git describe ${merged} 2>/dev/null") or merged[:12]
+
+    # Extract the neta-information for the commit
+    rawcommit = do("git cat-file commit " + merged)
+    files=do("git diff-tree -r --name-only '"+ merged +"' | sed -e '1d' -e 's-.*-<file>&</file>-'")
+    inheader = True
+    headers = {}
+    logmsg = ""
+    for line in rawcommit.split("\n"):
+        if inheader:
+            if line:
+                fields = line.split()
+                headers[fields[0]] = " ".join(fields[1:])
+            else:
+                inheader = False
+        else:
+            logmsg = line
+            break
+    (author, ts) = headers["author"].split(">")
+
+    # This discards the part of the authors addrsss after @.
+    # Might be bnicece to ship the full email address, if not
+    # for spammers' address harvesters - getting this wrong
+    # would make the freenode #commits channel into harvester heaven.
+    author = author.replace("<", "").split("@")[0].split()[-1]
+
+    # This ignores the timezone.  Not clear what to do with it...
+    ts = ts.strip().split()[0]
+
+    context = locals()
+    context.update(globals())
+
+    out = xml % context
+
+    message = '''\
+Message-ID: <%(merged)s.%(author)s@%(project)s>
+From: %(fromaddr)s
+To: %(toaddr)s
+Content-type: text/xml
+Subject: DeliverXML
+
+%(out)s''' % locals()
+
+    return message
+
+if __name__ == "__main__":
+    import getopt
+
+    try:
+        (options, arguments) = getopt.getopt(sys.argv[1:], "np:V")
+    except getopt.GetoptError, msg:
+        print "ciabot.py: " + str(msg)
+        raise SystemExit, 1
+
+    mailit = True
+    for (switch, val) in options:
+        if switch == '-p':
+            project = val
+        elif switch == '-n':
+            mailit = False
+        elif switch == '-V':
+            print "ciabot.py: version 3.2"
+            sys.exit(0)
+
+    # Cough and die if user has not specified a project
+    if not project:
+        sys.stderr.write("ciabot.py: no project specified, bailing out.\n")
+        sys.exit(1)
+
+    # We'll need the git version number.
+    gitver = do("git --version").split()[0]
+
+    urlprefix = urlprefix % globals()
+
+    # The script wants a reference to head followed by the list of
+    # commit ID to report about.
+    if len(arguments) == 0:
+        refname = do("git symbolic-ref HEAD 2>/dev/null")
+        merges = [do("git rev-parse HEAD")]
+    else:
+        refname = arguments[0]
+        merges = arguments[1:]
+
+    if mailit:
+        import smtplib
+        server = smtplib.SMTP('localhost')
+
+    for merged in merges:
+        message = report(refname, merged)
+        if mailit:
+            server.sendmail(fromaddr, [toaddr], message)
+        else:
+            print message
+
+    if mailit:
+        server.quit()
+
+#End
diff --git a/contrib/ciabot/ciabot.sh b/contrib/ciabot/ciabot.sh
new file mode 100755
index 0000000..5a80c46
--- /dev/null
+++ b/contrib/ciabot/ciabot.sh
@@ -0,0 +1,192 @@
+#!/bin/sh
+# Distributed under the terms of the GNU General Public License v2
+# Copyright (c) 2006 Fernando J. Pereda <ferdy@gentoo.org>
+# Copyright (c) 2008 Natanael Copa <natanael.copa@gmail.com>
+# Copyright (c) 2010 Eric S. Raymond <esr@thyrsus.com>
+#
+# This is a version 3.x of ciabot.sh; use -V to find the exact
+# version.  Versions 1 and 2 were shipped in 2006 and 2008 and are not
+# version-stamped.  The version 2 maintainer has passed the baton.
+#
+# Note: This script should be considered obsolete.  
+# There is a faster, better-documented rewrite in Python: find it as ciabot.py
+# Use this only if your hosting site forbids Python hooks.
+#
+# Originally based on Git ciabot.pl by Petr Baudis.
+# This script contains porcelain and porcelain byproducts.
+#
+# usage: ciabot.sh [-V] [-n] [-p projectname] [refname commit]
+#
+# This script is meant to be run either in a post-commit hook or in an
+# update hook.  If there's nothing unusual about your hosting setup,
+# you can specify the project name with a -p option and avoid having
+# to modify this script.  Try it with -n first to see the notification
+# mail dumped to stdout and verify that it looks sane.  Use -V to dump
+# the version and exit.
+#
+# In post-commit, run it without arguments (other than possibly a -p
+# option). It will query for current HEAD and the latest commit ID to
+# get the information it needs.
+#
+# In update, you have to call it once per merged commit:
+#
+#       refname=$1
+#       oldhead=$2
+#       newhead=$3
+#       for merged in $(git rev-list ${oldhead}..${newhead} | tac) ; do
+#               /path/to/ciabot.bash ${refname} ${merged}
+#       done
+#
+# The reason for the tac call ids that git rev-list emits commits from
+# most recent to least - better to ship notifactions from oldest to newest.
+#
+# Note: this script uses mail, not XML-RPC, in order to avoid stalling
+# until timeout when the CIA XML-RPC server is down. 
+#
+
+#
+# The project as known to CIA. You will either want to change this
+# or set the project name with a -p option.
+#
+project=
+
+#
+# You may not need to change these:
+#
+
+# Name of the repository.
+# You can hardwire this to make the script faster.
+repo="`basename ${PWD}`"
+
+# Fully qualified domain name of the repo host.
+# You can hardwire this to make the script faster.
+host=`hostname --fqdn`
+
+# Changeset URL prefix for your repo: when the commit ID is appended
+# to this, it should point at a CGI that will display the commit
+# through gitweb or something similar. The defaults will probably
+# work if you have a typical gitweb/cgit setup.
+#urlprefix="http://${host}/cgi-bin/gitweb.cgi?p=${repo};a=commit;h="
+urlprefix="http://${host}/cgi-bin/cgit.cgi/${repo}/commit/?id="
+
+#
+# You probably will not need to change the following:
+#
+
+# Identify the script. Should change only when the script itself 
+# gets a new home and maintainer. 
+generator="http://www.catb.org/~esr/ciabot/ciabot.sh"
+
+# Addresses for the e-mail
+from="CIABOT-NOREPLY@${host}"
+to="cia@cia.navi.cx"
+
+# SMTP client to use - may need to edit the absolute pathname for your system
+sendmail="sendmail -t -f ${from}"
+
+#
+# No user-serviceable parts below this line:
+#
+
+# Should include all places sendmail is likely to lurk. 
+PATH="$PATH:/usr/sbin/"
+
+mode=mailit
+while getopts pnV opt
+do
+    case $opt in
+        p) project=$2; shift ; shift ;;
+	n) mode=dumpit; shift ;;
+	V) echo "ciabot.sh: version 3.2"; exit 0; shift ;;
+    esac
+done
+
+# Cough and die if user has not specified a project
+if [ -z "$project" ]
+then
+    echo "ciabot.sh: no project specified, bailing out." >&2
+    exit 1
+fi
+
+if [ $# -eq 0 ] ; then
+	refname=$(git symbolic-ref HEAD 2>/dev/null)
+	merged=$(git rev-parse HEAD)
+else
+	refname=$1
+	merged=$2
+fi
+
+# This tries to turn your gitwebbish URL into a tinyurl so it will take up
+# less space on the IRC notification line. Some repo sites (I'm looking at
+# you, berlios.de!) forbid wget calls for security reasons.  On these,
+# the code will fall back to the full un-tinyfied URL.
+longurl=${urlprefix}${merged}
+url=$(wget -O - -q http://tinyurl.com/api-create.php?url=${longurl} 2>/dev/null)
+if [ -z "$url" ]; then
+	url="${longurl}"
+fi
+
+refname=${refname##refs/heads/}
+
+gitver=$(git --version)
+gitver=${gitver##* }
+
+rev=$(git describe ${merged} 2>/dev/null)
+# ${merged:0:12} was the only bashism left in the 2008 version of this
+# script, according to checkbashisms.  Replace it with ${merged} here
+# because it was just a fallback anyway, and it's worth accepting a
+# longer fallback for faster execution and removing the bash
+# dependency.
+[ -z ${rev} ] && rev=${merged}
+
+# This discards the part of the author's address after @.
+# Might be nice to ship the full email address, if not
+# for spammers' address harvesters - getting this wrong
+# would make the freenode #commits channel into harvester heaven.
+rawcommit=$(git cat-file commit ${merged})
+author=$(echo "$rawcommit" | sed -n -e '/^author .*<\([^@]*\).*$/s--\1-p')
+logmessage=$(echo "$rawcommit" | sed -e '1,/^$/d' | head -n 1)
+logmessage=$(echo "$logmessage" | sed 's/\&/&amp\;/g; s/</&lt\;/g; s/>/&gt\;/g')
+ts=$(echo "$rawcommit" | sed -n -e '/^author .*> \([0-9]\+\).*$/s--\1-p')
+files=$(git diff-tree -r --name-only ${merged} | sed -e '1d' -e 's-.*-<file>&</file>-')
+
+out="
+<message>
+  <generator>
+    <name>CIA Shell client for Git</name>
+    <version>${gitver}</version>
+    <url>${generator}</url>
+  </generator>
+  <source>
+    <project>${project}</project>
+    <branch>$repo:${refname}</branch>
+  </source>
+  <timestamp>${ts}</timestamp>
+  <body>
+    <commit>
+      <author>${author}</author>
+      <revision>${rev}</revision>
+      <files>
+        ${files}
+      </files>
+      <log>${logmessage} ${url}</log>
+      <url>${url}</url>
+    </commit>
+  </body>
+</message>"
+
+if [ "$mode" = "dumpit" ]
+then
+    sendmail=cat
+fi
+
+${sendmail} << EOM
+Message-ID: <${merged}.${author}@${project}>
+From: ${from}
+To: ${to}
+Content-type: text/xml
+Subject: DeliverXML
+${out}
+EOM
+
+# vim: set tw=70 :
-- 
1.6.3.3


-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
