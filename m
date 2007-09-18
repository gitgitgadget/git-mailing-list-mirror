From: mike@csa.net (mike dalessio)
Subject: [PATCH] instaweb: added support Ruby's WEBrick server
Date: Tue, 18 Sep 2007 08:16:34 -0400 (EDT)
Message-ID: <20070918121634.E8EFF814635@cyrano>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org, mike@csa.net, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Sep 18 14:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXc0P-00080z-3N
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841AbXIRMQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755604AbXIRMQg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:16:36 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:60056 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbXIRMQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:16:36 -0400
Received: from cyrano (ool-44c1f12b.dyn.optonline.net [68.193.241.43])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0JOK0061RCRNCSC0@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Tue, 18 Sep 2007 08:16:35 -0400 (EDT)
Received: by cyrano (Postfix, from userid 1001)	id E8EFF814635; Tue,
 18 Sep 2007 08:16:34 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58592>

running the webrick server with git requires Ruby and Ruby's YAML and
Webrick libraries (both of which come standard with Ruby). nice for
single-user standalone invocations.

the --httpd=webrick option generates a ruby script on the fly to read
httpd.conf options and invoke the web server via library call. this
script is placed in the .git/gitweb directory. it also generates a
shell script in a feeble attempt to invoke ruby in a portable manner,
which assumes that 'ruby' is in the user's $PATH.

Signed-off-by: Mike Dalessio <mike@csa.net>
---
 Documentation/git-instaweb.txt |    3 +-
 git-instaweb.sh                |   44 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index cec60ee..914fc4c 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -27,7 +27,8 @@ OPTIONS
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
-	Currently, lighttpd and apache2 are the only supported servers.
+	Currently, lighttpd, apache2 and webrick are the only supported
+	servers.
 	(Default: lighttpd)
 
 -m|--module-path::
diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..803a754 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -37,7 +37,9 @@ start_httpd () {
 	else
 		# many httpds are installed in /usr/sbin or /usr/local/sbin
 		# these days and those are not in most users $PATHs
-		for i in /usr/local/sbin /usr/sbin
+		# in addition, we may have generated a server script
+		# in $fqgitdir/gitweb.
+		for i in /usr/local/sbin /usr/sbin $fqgitdir/gitweb
 		do
 			if test -x "$i/$httpd_only"
 			then
@@ -137,6 +139,43 @@ GIT_DIR="$fqgitdir"
 export GIT_EXEC_PATH GIT_DIR
 
 
+webrick_conf () {
+	# generate a standalone server script in $fqgitdir/gitweb.
+	cat > "$fqgitdir/gitweb/$httpd.rb" <<EOF
+require 'webrick'
+require 'yaml'
+options = YAML::load_file(ARGV[0])
+options[:StartCallback] = proc do
+  File.open(options[:PidFile],"w") do |f|
+    f.puts Process.pid
+  end
+end
+options[:ServerType] = WEBrick::Daemon
+server = WEBrick::HTTPServer.new(options)
+['INT', 'TERM'].each do |signal|
+  trap(signal) {server.shutdown}
+end
+server.start
+EOF
+	# generate a shell script to invoke the above ruby script,
+	# which assumes _ruby_ is in the user's $PATH. that's _one_
+	# portable way to run ruby, which could be installed anywhere,
+	# really.
+	cat > "$fqgitdir/gitweb/$httpd" <<EOF
+#! /bin/sh
+ruby $fqgitdir/gitweb/$httpd.rb \$*
+EOF
+	chmod +x "$fqgitdir/gitweb/$httpd"
+
+	cat > "$conf" <<EOF
+:Port: $port
+:DocumentRoot: "$fqgitdir/gitweb"
+:DirectoryIndex: ["gitweb.cgi"]
+:PidFile: "$fqgitdir/pid"
+EOF
+	test "$local" = true && echo ':BindAddress: "127.0.0.1"' >> "$conf"
+}
+
 lighttpd_conf () {
 	cat > "$conf" <<EOF
 server.document-root = "$fqgitdir/gitweb"
@@ -237,6 +276,9 @@ case "$httpd" in
 *apache2*)
 	apache2_conf
 	;;
+webrick)
+	webrick_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
-- 
1.5.2.5
