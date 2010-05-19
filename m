From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] git-instaweb: Add support for running gitweb via 'plackup'
Date: Wed, 19 May 2010 19:31:38 +0200
Message-ID: <1274290298-19245-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 19:31:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEn7d-00049Z-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 19:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab0ESRbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 13:31:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0ESRbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 13:31:51 -0400
Received: by fxm10 with SMTP id 10so2616734fxm.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xlKXTVkas5yH1uZldWE5umX1xxRxz4rwsAUuM01xV44=;
        b=NNLsM6lIiXzLrE8YUoeyyBvE6FHYDtofwWIsFcCoLBtDK7SSE+N9sJMSFoa5tl2PBw
         FptVQ202dxxVjPzlkbLNdWewN6TnCW7b0nfCQC18YvBxtWPkKVOwiRPkLTQmG0iLTbTL
         EMt+F5ViesOIaQOBgv4LWJ7wO3QvvCTQQ/7Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZG1LhRCdzLolQhTqnDytoOqYSrwRs8/UYW27W9X/rXulB/wj7FcLa8lO3yS47z1c03
         YHGnYQAkXHyBRroqZttluwaFTJmp+wu0P4uuLBcf3cKWV14UKeB3s3LuCjqQnN8dyZxr
         hAXWGIIS1rEdtMYMws2hd7OMVPmOQe5VoLwUk=
Received: by 10.223.101.81 with SMTP id b17mr2448277fao.17.1274290309477;
        Wed, 19 May 2010 10:31:49 -0700 (PDT)
Received: from localhost.localdomain (abrz84.neoplus.adsl.tpnet.pl [83.8.119.84])
        by mx.google.com with ESMTPS id 2sm36966639fav.1.2010.05.19.10.31.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 May 2010 10:31:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147337>

PSGI is an interface between Perl web applications and web servers, and
Plack is a Perl module and toolkit that contains PSGI middleware, helpers
and adapters to web servers; see http://plackperl.org

PSGI and Plack are inspired by Python's WSGI and Ruby's Rack.

Plack core distribution includes HTTP::Server::PSGI, a reference PSGI
standalone web server implementation.  plackup is a command line launcher
to run PSGI applications from command line, connecting web app to a web
server; it uses Plack::Runner module.  It uses HTTP::Server::PSGI as a web
server by default.

git-instaweb generates gitweb.psgi wrapper, which uses Plack::App::WrapCGI
to compile a CGI script into a PSGI application using CGI::Compile and
CGI::Emulate::PSGI, and runs it with any PSGI server as a PSGI
application.

To run git-instaweb with '--httpd=plackup', you need to have instaled
Plack core, CGI::Emulate::PSGI, CGI::Compile, and available for a Perl
script (e.g. by setting PERL5LIB environment variable).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Compared to earlier version (only mentioned, but not sent to git
mailing list, if I remember correctly), instead of configuring plackup
from command line (by modifying $httpd variable), the configuration is
embedded in generated gitweb.psgi file.  Also instead of using plackup,
the generated gitweb.psgi is made into standalone app, running server
(so $full_httpd is full path to gitweb.psgi).

RFC is because when when running

  $ ./git-instaweb --httpd=plackup --browser=lynx

I get the following error

  Looking up 127.0.0.1:1234
  Making HTTP connection to 127.0.0.1:1234
  Alert!: Unable to connect to remote host.

  lynx: Can't access startfile http://127.0.0.1:1234/
  http://127.0.0.1:1234

But running 'lynx http://127.0.0.1:1234/' after this works correctly
without problems.  Running './.git/gitweb/gitweb.psgi' doesn't cause
any problems either.  WTF?

HELP!!!

 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |   52 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 4 deletions(-)

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
index f608014..dd82955 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -46,6 +46,13 @@ resolve_full_httpd () {
 			httpd="$httpd -f"
 		fi
 		;;
+	*plackup*)
+		# Plack::Runner etc must be in $PERL5LIB of user, currently
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
 
@@ -370,6 +377,42 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
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
@@ -419,6 +462,9 @@ webrick)
 *mongoose*)
 	mongoose_conf
 	;;
+*plackup*)
+	plackup_conf
+	;;
 *)
 	echo "Unknown httpd specified: $httpd"
 	exit 1
-- 
1.7.0.1
