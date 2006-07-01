From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH/RFC (updated)] Add git-instaweb, instantly browse the working repo with gitweb
Date: Sat, 1 Jul 2006 15:14:14 -0700
Message-ID: <20060701221414.GA3366@soma>
References: <11513991301372-git-send-email-normalperson@yhbt.net> <7vwtayh56z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwnjQ-0008Qp-UK
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGAWOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWGAWOR
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:14:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:18059 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750735AbWGAWOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 18:14:16 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BFFE07DC021;
	Sat,  1 Jul 2006 15:14:14 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat,  1 Jul 2006 15:14:14 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtayh56z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23067>

I got tired of having to configure gitweb for every repository
I work on.  I sometimes prefer gitweb to standard GUIs like gitk
or gitview; so this lets me automatically configure gitweb to
browse my working repository and also opens my browser to it.

Updates from the original patch:

Added Apache/mod_perl2 compatibility if Dennis Stosberg's gitweb
has been applied, too: <20060621130708.Gcbc6e5c@leonov.stosberg.net>

General cleanups in shell code usage.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Junio C Hamano <junkio@cox.net> wrote:
 > Eric Wong <normalperson@yhbt.net> writes:
 > 
 > > I got tired of having to configure gitweb for every repository
 > > I work on.  I sometimes prefer gitweb to standard GUIs like gitk
 > > or gitview; so this lets me automatically configure gitweb to
 > > browse my working repository and also opens my browser to it.
 > >
 > > Signed-off-by: Eric Wong <normalperson@yhbt.net>
 > 
 > This is cute but I haven't seen much responses to it yet.  Are
 > people uninterested?

 I've found it very useful myself, but I wouldn't have made it if I
 didn't :)  It's somewhat of a strange and alien concept in GUIs, and
 will probably take some getting used to; but I think it can gain users
 quickly because it doesn't rely on any specific toolkits, and can be
 expanded to support more HTTP servers.
 
 If anything, it can also serve as short and simple documentation for
 setting up gitweb.

 .gitignore                     |    1 
 Documentation/git-instaweb.txt |   84 ++++++++++++++
 Makefile                       |   16 +++
 git-instaweb.sh                |  235 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 335 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7b954d5..2bcc604 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,6 +46,7 @@ git-http-push
 git-imap-send
 git-index-pack
 git-init-db
+git-instaweb
 git-local-fetch
 git-log
 git-lost-found
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
new file mode 100644
index 0000000..7dd393b
--- /dev/null
+++ b/Documentation/git-instaweb.txt
@@ -0,0 +1,84 @@
+git-instaweb(1)
+===============
+
+NAME
+----
+git-instaweb - instantly browse your working repository in gitweb
+
+SYNOPSIS
+--------
+'git-instaweb' [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
+
+'git-instaweb' [--start] [--stop] [--restart]
+
+DESCRIPTION
+-----------
+A simple script to setup gitweb and a web server for browsing the local
+repository.
+
+OPTIONS
+-------
+
+-l|--local::
+	Only bind the web server to the local IP (127.0.0.1).
+
+-d|--httpd::
+	The HTTP daemon command-line that will be executed.
+	Command-line options may be specified here, and the
+	configuration file will be added at the end of the command-line.
+	Currently, lighttpd and apache2 are the only supported servers.
+	(Default: lighttpd)
+
+-m|--module-path::
+	The module path (only needed if httpd is Apache).
+	(Default: /usr/lib/apache2/modules)
+
+-p|--port::
+	The port number to bind the httpd to.  (Default: 1234)
+
+-b|--browser::
+
+	The web browser command-line to execute to view the gitweb page.
+	If blank, the URL of the gitweb instance will be printed to
+	stdout.  (Default: 'firefox')
+
+--start::
+	Start the httpd instance and exit.  This does not generate
+	any of the configuration files for spawning a new instance.
+
+--stop::
+	Stop the httpd instance and exit.  This does not generate
+	any of the configuration files for spawning a new instance,
+	nor does it close the browser.
+
+--restart::
+	Restart the httpd instance and exit.  This does not generate
+	any of the configuration files for spawning a new instance.
+
+CONFIGURATION
+-------------
+
+You may specify configuration in your .git/config
+
+-----------------------------------------------------------------------
+[instaweb]
+	local = true
+	httpd = apache2 -f
+	port = 4321
+	browser = konqueror
+	modulepath = /usr/lib/apache2/modules
+
+-----------------------------------------------------------------------
+
+Author
+------
+Written by Eric Wong <normalperson@yhbt.net>
+
+Documentation
+--------------
+Documentation by Eric Wong <normalperson@yhbt.net>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index cde619c..83d8922 100644
--- a/Makefile
+++ b/Makefile
@@ -142,7 +142,7 @@ SCRIPT_PYTHON = \
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
-	  git-cherry-pick git-status
+	  git-cherry-pick git-status git-instaweb
 
 # The ones that do not have to link with lcrypto, lz nor xdiff.
 SIMPLE_PROGRAMS = \
@@ -545,6 +545,20 @@ git-status: git-commit
 	cp $< $@+
 	mv $@+ $@
 
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
+	rm -f $@ $@+
+	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
+	    $@.sh | sed \
+	    -e 's|@@GITWEB_CGI@@|#!$(PERL_PATH_SQ)|; T; r gitweb/gitweb.cgi' \
+	    | sed \
+	    -e 's|@@GITWEB_CSS@@||; T; r gitweb/gitweb.css' \
+	    > $@+
+	chmod +x $@+
+	mv $@+ $@
+
 # These can record GIT_VERSION
 git$X git.spec \
 	$(patsubst %.sh,%,$(SCRIPT_SH)) \
diff --git a/git-instaweb.sh b/git-instaweb.sh
new file mode 100755
index 0000000..51067d9
--- /dev/null
+++ b/git-instaweb.sh
@@ -0,0 +1,235 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+USAGE='[--start] [--stop] [--restart]
+  [--local] [--httpd=<httpd>] [--port=<port>] [--browser=<browser>]
+  [--module-path=<path> (for Apache2 only)]'
+
+. git-sh-setup
+
+case "$GIT_DIR" in
+/*)
+	fqgitdir="$GIT_DIR" ;;
+*)
+	fqgitdir="$PWD/$GIT_DIR" ;;
+esac
+
+local="`git repo-config --bool --get instaweb.local`"
+httpd="`git repo-config --get instaweb.httpd`"
+browser="`git repo-config --get instaweb.browser`"
+port=`git repo-config --get instaweb.port`
+module_path="`git repo-config --get instaweb.modulepath`"
+
+conf=$GIT_DIR/gitweb/httpd.conf
+
+# Defaults:
+
+# if installed, it doens't need further configuration (module_path)
+test -z "$httpd" && httpd='lighttpd -f'
+
+# probably the most popular browser among gitweb users
+test -z "$browser" && browser='firefox'
+
+# any untaken local port will do...
+test -z "$port" && port=1234
+
+start_httpd () {
+	httpd_only="`echo $httpd | cut -f1 -d' '`"
+	if test "`expr index $httpd_only /`" -eq '1' || \
+				which $httpd_only >/dev/null
+	then
+		$httpd $fqgitdir/gitweb/httpd.conf
+	else
+		# many httpds are installed in /usr/sbin or /usr/local/sbin
+		# these days and those are not in most users $PATHs
+		for i in /usr/local/sbin /usr/sbin
+		do
+			if test -x "$i/$httpd_only"
+			then
+				# don't quote $httpd, there can be
+				# arguments to it (-f)
+				$i/$httpd "$fqgitdir/gitweb/httpd.conf"
+				return
+			fi
+		done
+	fi
+}
+
+stop_httpd () {
+	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
+}
+
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	--stop|stop)
+		stop_httpd
+		exit 0
+		;;
+	--start|start)
+		start_httpd
+		exit 0
+		;;
+	--restart|restart)
+		stop_httpd
+		start_httpd
+		exit 0
+		;;
+	--local|-l)
+		local=true
+		;;
+	-d|--httpd|--httpd=*)
+		case "$#,$1" in
+		*,*=*)
+			httpd=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			httpd="$2"
+			shift ;;
+		esac
+		;;
+	-b|--browser|--browser=*)
+		case "$#,$1" in
+		*,*=*)
+			browser=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			browser="$2"
+			shift ;;
+		esac
+		;;
+	-p|--port|--port=*)
+		case "$#,$1" in
+		*,*=*)
+			port=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			port="$2"
+			shift ;;
+		esac
+		;;
+	-m|--module-path=*|--module-path)
+		case "$#,$1" in
+		*,*=*)
+			module_path=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			module_path="$2"
+			shift ;;
+		esac
+		;;
+	*)
+		usage
+		;;
+	esac
+	shift
+done
+
+mkdir -p "$GIT_DIR/gitweb/tmp"
+GIT_EXEC_PATH="`git --exec-path`"
+GIT_DIR="$fqgitdir"
+export GIT_EXEC_PATH GIT_DIR
+
+
+lighttpd_conf () {
+	cat > "$conf" <<EOF
+server.document-root = "$fqgitdir/gitweb"
+server.port = $port
+server.modules = ( "mod_cgi" )
+server.indexfiles = ( "gitweb.cgi" )
+server.pid-file = "$fqgitdir/pid"
+cgi.assign = ( ".cgi" => "" )
+mimetype.assign = ( ".css" => "text/css" )
+EOF
+	test "$local" = true && echo 'server.bind = "127.0.0.1"' >> "$conf"
+}
+
+apache2_conf () {
+	test -z "$module_path" && module_path=/usr/lib/apache2/modules
+	mkdir -p "$GIT_DIR/gitweb/logs"
+	bind=
+	test "$local" = true && bind='127.0.0.1:'
+	echo 'text/css css' > $fqgitdir/mime.types
+	cat > "$conf" <<EOF
+ServerRoot "$fqgitdir/gitweb"
+DocumentRoot "$fqgitdir/gitweb"
+PidFile "$fqgitdir/pid"
+Listen $bind$port
+TypesConfig $fqgitdir/mime.types
+DirectoryIndex gitweb.cgi
+EOF
+
+	# check to see if Dennis Stosberg's mod_perl compatibility patch
+	# (<20060621130708.Gcbc6e5c@leonov.stosberg.net>) has been applied
+	if test -f "$module_path/mod_perl.so" && grep '^our $gitbin' \
+				"$GIT_DIR/gitweb/gitweb.cgi" >/dev/null
+	then
+		# favor mod_perl if available
+		cat >> "$conf" <<EOF
+LoadModule perl_module $module_path/mod_perl.so
+PerlPassEnv GIT_DIR
+PerlPassEnv GIT_EXEC_DIR
+<Location /gitweb.cgi>
+	SetHandler perl-script
+	PerlResponseHandler ModPerl::Registry
+	PerlOptions +ParseHeaders
+	Options +ExecCGI
+</Location>
+EOF
+	else
+		# plain-old CGI
+		cat >> "$conf" <<EOF
+LoadModule cgi_module $module_path/mod_cgi.so
+AddHandler cgi-script .cgi
+<Location /gitweb.cgi>
+	Options +ExecCGI
+</Location>
+EOF
+	fi
+}
+
+script='
+s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'`dirname $fqgitdir`'";#;
+s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#;
+s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#;
+s#\(my\|our\) $git_temp =.*#\1 $git_temp = "'$fqgitdir/gitweb/tmp'";#'
+
+gitweb_cgi () {
+	cat > "$1.tmp" <<\EOFGITWEB
+@@GITWEB_CGI@@
+EOFGITWEB
+	sed "$script" "$1.tmp"  > "$1"
+	chmod +x "$1"
+	rm -f "$1.tmp"
+}
+
+gitweb_css () {
+	cat > "$1" <<\EOFGITWEB
+@@GITWEB_CSS@@
+EOFGITWEB
+}
+
+gitweb_cgi $GIT_DIR/gitweb/gitweb.cgi
+gitweb_css $GIT_DIR/gitweb/gitweb.css
+
+case "$httpd" in
+*lighttpd*)
+	lighttpd_conf
+	;;
+*apache2*)
+	apache2_conf
+	;;
+*)
+	echo "Unknown httpd specified: $httpd"
+	exit 1
+	;;
+esac
+
+start_httpd
+test -z "$browser" && browser=echo
+$browser http://127.0.0.1:$port
-- 
1.4.1.rc2.gbf43
