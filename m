From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv4 3/3] git-instaweb: Add support for running gitweb via 'plackup'
Date: Fri, 28 May 2010 21:11:25 +0200
Message-ID: <1275073885-26537-4-git-send-email-jnareb@gmail.com>
References: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 21:10:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI4wO-0000eN-FP
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 21:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab0E1TJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 15:09:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0E1TJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 15:09:44 -0400
Received: by mail-fx0-f46.google.com with SMTP id 10so1005565fxm.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QCN+w9qHMTdJ6vbldY6lN7BaDxiOamQIlNmUyMbdmp0=;
        b=ug1ieYlzLsEB6JDOyIt0oNbgYNYEJ1y9tTIamrZYEcMly29ad+C4pW6JiBm6bI7bhe
         uGE0Fdee3Z5+mBEJFsmA3DTrjWqulcoZ7LLkMZ0jtygdE2X1wVBWRRNPrZgAJAXn60JH
         cwaEB/I7rcfV70H78x9UzzXvrIoKg6jRM91Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ooihzt09nBzPH7MUu/U5nAJfmqmqrxLIp6aw4tOmnjsreUO/Y8ZDwsfvMifcZ23IV+
         rowFOX+9FpmaYT9hUIVIR3S86PbVL1/U5A/38WgfKzjBdJ0q1cw3sMSZzcjwzDmF09f5
         YUNlhEQ45Kqmy2jSsvQNfTVTkIBEz0ljrt7gs=
Received: by 10.223.4.217 with SMTP id 25mr802563fas.60.1275073782824;
        Fri, 28 May 2010 12:09:42 -0700 (PDT)
Received: from localhost.localdomain (abwk209.neoplus.adsl.tpnet.pl [83.8.234.209])
        by mx.google.com with ESMTPS id 13sm13023723fad.7.2010.05.28.12.09.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 12:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1275073885-26537-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147934>

PSGI is an interface between Perl web applications and web servers, and
Plack is a Perl module and toolkit that contains PSGI middleware, helpers
and adapters to web servers; see http://plackperl.org

PSGI and Plack are inspired by Python's WSGI and Ruby's Rack (and
probably JavaScript's Jack/JSGI).

Plack core distribution includes HTTP::Server::PSGI, a reference PSGI
standalone web server implementation.  'plackup' is a command line
launcher to run PSGI applications from command line, connecting web
app to a web server via Plack::Runner module.  By default it uses
HTTP::Server::PSGI as a web server.

git-instaweb generates gitweb.psgi wrapper (in $GIT_DIR/gitweb).  This
wrapper uses Plack::App::WrapCGI to compile gitweb.cgi (which is a CGI
script) into a PSGI application using CGI::Compile and CGI::Emulate::PSGI.
git-instaweb then runs this wrapper, using by default HTTP::Server::PSGI
standalone Perl server, via Plack::Runner.

The configuration for 'plackup' is currently embedded in generated
gitweb.psgi wrapper, instead of using httpd.conf ($conf).


To run git-instaweb with '--httpd=plackup', you need to have instaled
Plack core, CGI::Emulate::PSGI, CGI::Compile.  Those modules have to be
available for Perl scripts (which can be done for example by setting
PERL5LIB environment variable).  This is currently not documented.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Differences from previous version (v3):
* resolve_full_httpd sets also $httpd_only, in addition to $full_httpd
* httpd_is_ready is moved to separate patch, earlier in series
* gitweb.psgi now includes (probably unnecessary) mimetype mapping
* gitweb.psgi puts access.log and error.log in $httpd_only subdirectory,
  like the rest of web servers (after 3rd patch by Pavan Kumar Sunkara)
* gitweb.psgi logs in error.log also build time warnings
* root dir in gitweb.psgi  for gitweb.cgi and for static files is $root,
  not $fqgitdir/gitweb (after 4th patch by Pavan Kumar Sunkara)

http://thread.gmane.org/gmane.comp.version-control.git/147337/focus=147415

 Documentation/git-instaweb.txt |    2 +-
 git-instaweb.sh                |  159 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 3 deletions(-)

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
index dc8478f..8b6b02e 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -50,6 +50,12 @@ resolve_full_httpd () {
 			httpd="$httpd -f"
 		fi
 		;;
+	*plackup*)
+		# server is started by running via generated gitweb.psgi in $fqgitdir/gitweb
+		full_httpd="$fqgitdir/gitweb/gitweb.psgi"
+		httpd_only="${httpd%% *}" # cut on first space
+		return
+		;;
 	esac
 
 	httpd_only="$(echo $httpd | cut -f1 -d' ')"
@@ -87,8 +93,8 @@ start_httpd () {
 
 	# don't quote $full_httpd, there can be arguments to it (-f)
 	case "$httpd" in
-	*mongoose*)
-		#The mongoose server doesn't have a daemon mode so we'll have to fork it
+	*mongoose*|*plackup*)
+		#These servers don't have a daemon mode so we'll have to fork it
 		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=$!
@@ -390,6 +396,152 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
 EOF
 }
 
+plackup_conf () {
+	# generate a standalone 'plackup' server script in $fqgitdir/gitweb
+	# with embedded configuration; it does not use "$conf" file
+	cat > "$fqgitdir/gitweb/gitweb.psgi" <<EOF
+#!$PERL
+
+# gitweb - simple web interface to track changes in git repositories
+#          PSGI wrapper and server starter (see http://plackperl.org)
+
+use strict;
+
+use IO::Handle;
+use Plack::MIME;
+use Plack::Builder;
+use Plack::App::WrapCGI;
+use CGI::Emulate::PSGI 0.07; # minimum version required to work with gitweb
+
+# mimetype mapping (from lighttpd_conf)
+Plack::MIME->add_type(
+	".pdf"          =>      "application/pdf",
+	".sig"          =>      "application/pgp-signature",
+	".spl"          =>      "application/futuresplash",
+	".class"        =>      "application/octet-stream",
+	".ps"           =>      "application/postscript",
+	".torrent"      =>      "application/x-bittorrent",
+	".dvi"          =>      "application/x-dvi",
+	".gz"           =>      "application/x-gzip",
+	".pac"          =>      "application/x-ns-proxy-autoconfig",
+	".swf"          =>      "application/x-shockwave-flash",
+	".tar.gz"       =>      "application/x-tgz",
+	".tgz"          =>      "application/x-tgz",
+	".tar"          =>      "application/x-tar",
+	".zip"          =>      "application/zip",
+	".mp3"          =>      "audio/mpeg",
+	".m3u"          =>      "audio/x-mpegurl",
+	".wma"          =>      "audio/x-ms-wma",
+	".wax"          =>      "audio/x-ms-wax",
+	".ogg"          =>      "application/ogg",
+	".wav"          =>      "audio/x-wav",
+	".gif"          =>      "image/gif",
+	".jpg"          =>      "image/jpeg",
+	".jpeg"         =>      "image/jpeg",
+	".png"          =>      "image/png",
+	".xbm"          =>      "image/x-xbitmap",
+	".xpm"          =>      "image/x-xpixmap",
+	".xwd"          =>      "image/x-xwindowdump",
+	".css"          =>      "text/css",
+	".html"         =>      "text/html",
+	".htm"          =>      "text/html",
+	".js"           =>      "text/javascript",
+	".asc"          =>      "text/plain",
+	".c"            =>      "text/plain",
+	".cpp"          =>      "text/plain",
+	".log"          =>      "text/plain",
+	".conf"         =>      "text/plain",
+	".text"         =>      "text/plain",
+	".txt"          =>      "text/plain",
+	".dtd"          =>      "text/xml",
+	".xml"          =>      "text/xml",
+	".mpeg"         =>      "video/mpeg",
+	".mpg"          =>      "video/mpeg",
+	".mov"          =>      "video/quicktime",
+	".qt"           =>      "video/quicktime",
+	".avi"          =>      "video/x-msvideo",
+	".asf"          =>      "video/x-ms-asf",
+	".asx"          =>      "video/x-ms-asf",
+	".wmv"          =>      "video/x-ms-wmv",
+	".bz2"          =>      "application/x-bzip",
+	".tbz"          =>      "application/x-bzip-compressed-tar",
+	".tar.bz2"      =>      "application/x-bzip-compressed-tar",
+	""              =>      "text/plain"
+);
+
+my \$app = builder {
+	# to be able to override \$SIG{__WARN__} to log build time warnings
+	use CGI::Carp; # it sets \$SIG{__WARN__} itself
+
+	my \$logdir = "$fqgitdir/gitweb/$httpd_only";
+	open my \$access_log_fh, '>', "\$logdir/access.log"
+		or die "Couldn't open access log '\$logdir/access.log': \$!";
+	open my \$error_log_fh,  '>', "\$logdir/error.log"
+		or die "Couldn't open error log '\$logdir/error.log': \$!";
+
+	\$access_log_fh->autoflush(1);
+	\$error_log_fh->autoflush(1);
+
+	# redirect build time warnings to error.log
+	\$SIG{'__WARN__'} = sub {
+		my \$msg = shift;
+		# timestamp warning like in CGI::Carp::warn
+		my \$stamp = CGI::Carp::stamp();
+		\$msg =~ s/^/\$stamp/gm;
+		print \$error_log_fh \$msg;
+	};
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
+	# because it uses 'close $fd or die...' on piped filehandle $fh
+	# (which causes the parent process to wait for child to finish).
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
+		root => "$root/",
+		encoding => 'utf-8'; # encoding for 'text/plain' files
+	# convert CGI application to PSGI app
+	Plack::App::WrapCGI->new(script => "$root/gitweb.cgi")->to_app;
+};
+
+# make it runnable as standalone app,
+# like it would be run via 'plackup' utility
+if (__FILE__ eq \$0) {
+	require Plack::Runner;
+
+	my \$runner = Plack::Runner->new();
+	\$runner->parse_options(qw(--env deployment --port $port),
+	                       "$local" ? qw(--host 127.0.0.1) : ());
+	\$runner->run(\$app);
+}
+__END__
+EOF
+
+	chmod a+x "$fqgitdir/gitweb/gitweb.psgi"
+	# configuration is embedded in server script file, gitweb.psgi
+	rm -f "$conf"
+}
+
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
 #!/usr/bin/perl
@@ -417,6 +569,9 @@ webrick)
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
