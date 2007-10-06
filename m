From: mike@csa.net
Subject: [PATCH 2/2] instaweb: support for Ruby's WEBrick server
Date: Sat, 06 Oct 2007 13:29:49 -0400
Message-ID: <1191691789249-git-send-email-mike@csa.net>
References: "7vodfztviv.fsf@gitster.siamese.dyndns.org"
 <11916917892652-git-send-email-mike@csa.net>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Mike Dalessio <mike@csa.net>
To: normalperson@yhbt.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 06 20:00:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeDwi-0001il-6t
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 20:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763472AbXJFR7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 13:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762967AbXJFR7w
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 13:59:52 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:64341 "EHLO
	mta2.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761241AbXJFR7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 13:59:51 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Oct 2007 13:59:51 EDT
Received: from ubuntu704-desktop
 (ool-44c1f12b.dyn.optonline.net [68.193.241.43]) by mta2.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTP id <0JPI00EMM39PYXJ0@mta2.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sat, 06 Oct 2007 13:29:50 -0400 (EDT)
Received: by ubuntu704-desktop (Postfix, from userid 1000)	id EBD0F5C926; Sat,
 06 Oct 2007 13:29:49 -0400 (EDT)
In-reply-to: <11916917892652-git-send-email-mike@csa.net>
In-reply-to: <55e906d58f15c79c61d83ad4c52ef085de8ad736.1191687881.git.mike@csa.net>
Message-id: <cbdd8ea5ab52c45e87319335546ec7c2c06191cd.1191687881.git.mike@csa.net>
X-Mailer: git-send-email 1.5.3.1.47.g88b7d-dirty
X-Antivirus: avast! (VPS 000778-4, 10/05/2007), Outbound message
X-Antivirus-Status: Clean
References: <55e906d58f15c79c61d83ad4c52ef085de8ad736.1191687881.git.mike@csa.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

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
 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index cec60ee..735008c 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -27,7 +27,7 @@ OPTIONS
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
-	Currently, lighttpd and apache2 are the only supported servers.
+	Currently lighttpd, apache2 and webrick are supported.
 	(Default: lighttpd)
 
 -m|--module-path::
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 42d9c34..859be4a 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -139,6 +139,43 @@ GIT_DIR="$fqgitdir"
 export GIT_EXEC_PATH GIT_DIR
 
 
+webrick_conf () {
+	# generate a standalone server script in $fqgitdir/gitweb.
+	cat >"$fqgitdir/gitweb/$httpd.rb" <<EOF
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
+	cat >"$fqgitdir/gitweb/$httpd" <<EOF
+#!/bin/sh
+exec ruby "$fqgitdir/gitweb/$httpd.rb" \$*
+EOF
+	chmod +x "$fqgitdir/gitweb/$httpd"
+
+	cat >"$conf" <<EOF
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
@@ -239,6 +276,9 @@ case "$httpd" in
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
