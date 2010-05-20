From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 (RFC)] git-instaweb: Add support for running gitweb via 'plackup'
Date: Thu, 20 May 2010 13:56:24 +0200
Message-ID: <1274356584-2400-1-git-send-email-jnareb@gmail.com>
References: <201005192252.49461.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 13:57:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF4Mz-0000x2-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 13:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab0ETL4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 07:56:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab0ETL4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 07:56:51 -0400
Received: by fxm10 with SMTP id 10so3439104fxm.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=br6xua03jVFQGTLUq2D0hllJAVgVBqZHGxlkUaYebAo=;
        b=uf5KSKF7V046thRvsDYe/oA8+f+kZ3C9wQ3aKyKW+calYg7FRVjvGl5sCex2yQOn9A
         ngjLyXtUrsCmiIw9XBTAKdiNv/Eb85Vtbj+zJX7vVRygUADW3nAuIChs8PZsR6z7cudH
         CvSx1tnHTMtdygtOpHuZAZYMKw1/8wY191I9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MPR+VtGwubOjWor1ECl84+0MzpKgXzUs/3Rx59ZivooKgkGsMhgoUZO/dXlmhe/ZRS
         ktiw22jxU1T978D5SUuZ6Qvxj6PUouWtFoyrg8nVb8NwmBvVVcBx1uK9LxPPxQT8W/GX
         npIuhxi4LzlEgsO6/9UnAQ/rW7QH8C0myuYlw=
Received: by 10.87.40.32 with SMTP id s32mr1596828fgj.21.1274356610091;
        Thu, 20 May 2010 04:56:50 -0700 (PDT)
Received: from localhost.localdomain (abwt81.neoplus.adsl.tpnet.pl [83.8.243.81])
        by mx.google.com with ESMTPS id 22sm12601942fkq.17.2010.05.20.04.56.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 04:56:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <201005192252.49461.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147384>

PSGI is an interface between Perl web applications and web servers, and
Plack is a Perl module and toolkit that contains PSGI middleware, helpers
and adapters to web servers; see http://plackperl.org

PSGI and Plack are inspired by Python's WSGI and Ruby's Rack.

Plack core distribution includes HTTP::Server::PSGI, a reference PSGI
standalone web server implementation.  plackup is a command line launcher
to run PSGI applications from command line, connecting web app to a web
server via Plack::Runner module.  By default it uses HTTP::Server::PSGI
as a web server.

git-instaweb generates gitweb.psgi wrapper (in $GIT_DIR/gitweb).  This
wrapper uses Plack::App::WrapCGI to compile gitweb.cgi (which is a CGI
script) into a PSGI application using CGI::Compile and CGI::Emulate::PSGI.
git-instaweb then runs this wrapper, using by default HTTP::Server::PSGI
standalone Perl server.

The configuration for 'plackup' is currently embedded in generated
gitweb.psgi wrapper, instead of using httpd.conf ($conf).


To run git-instaweb with '--httpd=plackup', you need to have instaled
Plack core, CGI::Emulate::PSGI, CGI::Compile.  Those modules have to be
available for Perl scripts (which can be done for example by setting
PERL5LIB environment variable).  This is currently not documented.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It lives^W works!  I have added 'httpd_is_ready' function, which
ensures that server is fully started before running web browser.
Currently it is non-trivial only for '--httpd=plackup'.


Currently gitweb.psgi wrapper uses Perl she-bang line, and
Plack::Runner module (if gitweb.psgi is run as a standalone script) to
configure used PSGI server in a server-agnostic way.

Attempts which didn't work or wouldn't work:

* Configuring plackup via command line options, i.e. setting $httpd
  to e.g.

     httpd="plackup --port=$port --host=127.0.0.1"

  But this wouldn't preserve options across server restart.

* Using

    #!/usr/bin/env plackup --port=$port --host=127.0.0.1

  as a she-bang line for gitweb.psgi wrapper.  It doesn't work because
  (in most cases) system passes everything after interpreter name as
  a _single_ option; in this case it would try to run

    /usr/bin/env 'plackup --port=$port --host=127.0.0.1' ...

  It also requires for plackup to be in $PATH.

* Using

    #!$PLACKUP --port=$port --host=127.0.0.1

  as a she-bang line for gitweb.psgi wrapper, after finding full path
  to 'plackup' and putting it in $PLACKUP variable (similar to $PERL).
  It doesn't work because (in most cases) system passes everything
  after interpreter name as a _single_ option; in this case it would
  try to run

    /path/to/plackup '--port=$port --host=127.0.0.1' ...

  Well, it would work if git-instaweb is run without '--local'... 

 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |   71 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index a1f17df..2c3c4d2 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -29,7 +29,7 @@ OPTIONS
 	The HTTP daemon command-line that will be executed.
 	Command-line options may be specified here, and the
 	configuration file will be added at the end of the command-line.
-	Currently apache2, lighttpd, mongoose and webrick are supported.
+	Currently apache2, lighttpd, mongoose, plackup and webrick are supported.
 	(Default: lighttpd)
 
 -m::
diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..f69cb71 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -46,6 +46,13 @@ resolve_full_httpd () {
 			httpd="$httpd -f"
 		fi
 		;;
+	*plackup*)
+		# 'plackup must be in $PATH of user, currently
+		# server is started by running via generated gitweb.psgi in $fqgitdir/gitweb
+		bind=
+		full_httpd="$fqgitdir/gitweb/gitweb.psgi"
+		return
+		;;
 	esac
 
 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
@@ -83,9 +90,9 @@ start_httpd () {
 
 	# don't quote $full_httpd, there can be arguments to it (-f)
 	case "$httpd" in
-	*mongoose*)
-		#The mongoose server doesn't have a daemon mode so we'll have to fork it
-		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
+	*mongoose*|*plackup*)
+		#The mongoose server and plackup don't have a daemon mode so we'll have to fork it
+		$full_httpd "$fqgitdir/gitweb/httpd.conf" 2>"$fqgitdir/error_log" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=$!
 
@@ -112,6 +119,21 @@ stop_httpd () {
 	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
 }
 
+httpd_is_ready () {
+	case "$httpd" in
+	*plackup*)
+		echo -n "Waiting for '$httpd' to start"
+		while ! grep 'Accepting connections' "$fqgitdir/error_log" >/dev/null 2>&1
+		do
+			sleep 1
+			echo -n "."
+		done
+		echo " (done)"
+		;;
+	esac
+	true
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -370,6 +392,42 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
 EOF
 }
 
+plackup_conf () {
+	cat > "$fqgitdir/gitweb/gitweb.psgi" <<GITWEB_PSGI_EOF
+#!$PERL
+
+# gitweb - simple web interface to track changes in git repositories
+#          PSGI wrapper (see http://plackperl.org)
+
+use strict;
+
+use Plack::Builder;
+use Plack::App::WrapCGI;
+use CGI::Emulate::PSGI 0.07; # minimum version required to work with gitweb
+
+my \$app = builder {
+	# serve static files, i.e. stylesheet, images, script
+	enable 'Static',
+		path => sub { m!\.(js|css|png)\$! && s!^/gitweb/!! },
+		root => "$fqgitdir/gitweb/";
+	# convert CGI application to PSGI app
+	Plack::App::WrapCGI->new(script => "$fqgitdir/gitweb/gitweb.cgi")->to_app;
+};
+
+# make it runnable as standalone app, like via plackup
+if (__FILE__ eq \$0) {
+	require Plack::Runner;
+
+	my \$runner = Plack::Runner->new();
+	\$runner->parse_options(qw(--port $port),
+	                       "$local" ? qw(--host 127.0.0.1) : ());
+	\$runner->run(\$app);
+}
+GITWEB_PSGI_EOF
+
+	chmod a+x "$fqgitdir/gitweb/gitweb.psgi"
+	rm -f "$fqgitdir/gitweb/gitweb.psgi.tmp" "$conf"
+}
 
 script='
 s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
@@ -419,6 +477,9 @@ webrick)
 *mongoose*)
 	mongoose_conf
 	;;
+*plackup*)
+	plackup_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
@@ -429,7 +490,7 @@ start_httpd
 url=http://127.0.0.1:$port
 
 if test -n "$browser"; then
-	git web--browse -b "$browser" $url || echo $url
+	httpd_is_ready && git web--browse -b "$browser" $url || echo $url
 else
-	git web--browse -c "instaweb.browser" $url || echo $url
+	httpd_is_ready && git web--browse -c "instaweb.browser" $url || echo $url
 fi
-- 
1.7.0.1
