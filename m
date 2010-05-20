From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCHv3] git-instaweb: Add support for running gitweb via 'plackup'
Date: Thu, 20 May 2010 23:55:38 +0200
Message-ID: <1274392538-29687-1-git-send-email-jnareb@gmail.com>
References: <1274356584-2400-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 23:54:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFDgn-00030i-KK
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 23:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab0ETVxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 17:53:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:17712 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338Ab0ETVxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 17:53:54 -0400
Received: by fg-out-1718.google.com with SMTP id d23so800220fga.1
        for <git@vger.kernel.org>; Thu, 20 May 2010 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6491jm7Rvh9Z4XRtOqKs74QJU7MueU909jLe62VK8U0=;
        b=Bi3wHD+ugC8/Jmh1beB6ydTmTjIGvqi2BlfW/BvefLGekmHwzOeC8Th6ZtSUywIvep
         f2Agabc0GyITzBNsxqH+Q8s0EVWkViiXix5Su50fVBEGjIkUWAs7reDrvoOHz1xOXEoD
         IU94Nm3yMQjFYA8tUXcedUv3savBpE2YjwZT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sUCZvmiVL6ttsY33ZyioIR+Sb736pZPp+GYmLowosGvGkYE19VvIg/COzNExdDpQFC
         c3wxHJlApk9R9IFDjEzJaUS5udEmNvrlDTGkOoI/zHw3sisyJT88HGHON+UxJcttD50U
         1IThJ+7yPw5yIuHYixEVp1zd8tgDFlDz2258s=
Received: by 10.223.21.23 with SMTP id h23mr625795fab.21.1274392432077;
        Thu, 20 May 2010 14:53:52 -0700 (PDT)
Received: from localhost.localdomain (abwt81.neoplus.adsl.tpnet.pl [83.8.243.81])
        by mx.google.com with ESMTPS id 13sm1351112fad.19.2010.05.20.14.53.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 14:53:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1274356584-2400-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147415>

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
This is an RFC because it should be split into three patches:
* a patch which makes git-instaweb remove pid-file after stopping server,
* a patch adding and using httpd_is_ready function,
* finally, a patch adding support for 'plackup' Perl web server.

Also, it somwehat lacks documentation.


Differences from previous version (v2):
* Make 'plackup' / Plack::Runner run in 'deployment' mode, and not in
  default 'development' mode.

* Use generic httpd_is_ready function, which checks if web server is
  available by checking if it connect to INET port $port on localhost.

* Instead of running 'plackup' / Plack::Runner in the default development
  mode, and redirecting its stderr to "$fqgitdir/error_log", use the same
  files for access log and for error log as for other web servers.

* Make if possible to run 'plackup' on HTTP::Server::Simple::PSGI, by
  setting PLACK_SERVER environment variable to HTTP::Server::Simple,
  even though it sets $SIG{CHLD} to 'IGNORE', which would be
  incompatibile with gitweb (see comments in code).

* A few cleanups.


 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |  102 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 5 deletions(-)

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
index f608014..a198bd2 100755
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
@@ -83,8 +90,8 @@ start_httpd () {
 
 	# don't quote $full_httpd, there can be arguments to it (-f)
 	case "$httpd" in
-	*mongoose*)
-		#The mongoose server doesn't have a daemon mode so we'll have to fork it
+	*mongoose*|*plackup*)
+		#The mongoose server and plackup don't have a daemon mode so we'll have to fork it
 		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=$!
@@ -110,6 +117,20 @@ EOF
 
 stop_httpd () {
 	test -f "$fqgitdir/pid" && kill $(cat "$fqgitdir/pid")
+	rm -f "$fqgitdir/pid"
+}
+
+httpd_is_ready () {
+	"$PERL" -MIO::Socket::INET -e "
+local \$| = 1; # turn on autoflush
+exit if (IO::Socket::INET->new('127.0.0.1:$port'));
+print 'Waiting for \'$httpd\' to start ..';
+do {
+	print '.';
+	sleep(1);
+} until (IO::Socket::INET->new('127.0.0.1:$port'));
+print qq! (done)\n!;
+"
 }
 
 while test $# != 0
@@ -370,6 +391,76 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
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
+use IO::Handle;
+use Plack::Builder;
+use Plack::App::WrapCGI;
+use CGI::Emulate::PSGI 0.07; # minimum version required to work with gitweb
+
+
+my \$app = builder {
+	open my \$access_log_fh, '>', "$fqgitdir/gitweb/access.log"
+		or die "Couldn't open access log '$fqgitdir/gitweb/access.log': \$!";
+	open my \$error_log_fh,  '>', "$fqgitdir/gitweb/error.log"
+		or die "Couldn't open error log '$fqgitdir/gitweb/error.log': \$!";
+
+	\$access_log_fh->autoflush(1);
+	\$error_log_fh->autoflush(1);
+
+	# write errors to error.log, access to access.log
+	enable 'AccessLog',
+		format => "combined",
+		logger => sub { print \$access_log_fh @_; };
+	enable sub {
+		my \$app = shift;
+		sub {
+			my \$env = shift;
+			\$env->{'psgi.errors'} = \$error_log_fh;
+			\$app->(\$env);
+		}
+	};
+	# gitweb currently doesn't work with $SIG{CHLD} set to 'IGNORE',
+	# because it uses 'close $fd or die...' on pipe
+	# (which in turn uses wait / waitpid).
+	enable_if { \$SIG{'CHLD'} eq 'IGNORE' } sub {
+		my \$app = shift;
+		sub {
+			my \$env = shift;
+			local \$SIG{'CHLD'} = 'DEFAULT';
+			local \$SIG{'CLD'}  = 'DEFAULT';
+			\$app->(\$env);
+		}
+	};
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
+	\$runner->parse_options(qw(--env deployment --port $port),
+	                       "$local" ? qw(--host 127.0.0.1) : ());
+	\$runner->run(\$app);
+}
+GITWEB_PSGI_EOF
+
+	chmod a+x "$fqgitdir/gitweb/gitweb.psgi"
+	rm -f "$conf"
+}
 
 script='
 s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
@@ -419,6 +510,9 @@ webrick)
 *mongoose*)
 	mongoose_conf
 	;;
+*plackup*)
+	plackup_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
@@ -429,7 +523,7 @@ start_httpd
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
