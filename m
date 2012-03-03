From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 3/5] gitweb: Enable running gitweb as PSGI app, via CGI::Emulate::PSGI
Date: Sat,  3 Mar 2012 18:57:01 +0100
Message-ID: <1330797423-22926-4-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCx-00031I-Vq
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab2CCR5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:22 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41045 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab2CCR5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:15 -0500
Received: by eekc41 with SMTP id c41so981386eek.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:14 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.133.198 as permitted sender) client-ip=10.14.133.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.133.198 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.133.198])
        by 10.14.133.198 with SMTP id q46mr8237102eei.64.1330797434129 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QxG5PnT9mQlGcvh8hl8tBg0H+luPBWxd4XxU3swCzzg=;
        b=NRpD098skKpYmgMl2Cb0z6wb/Igg1py6FEknqGCEP64fEjdgVvL+if0eDFwD3NqcBP
         dXmiP8lSPayHd2VxmWTy0XktsQZPmoERwYgN7Pl7AkJ9H9Kv+BLCURwgp5s426TB7X9J
         k9nCt8Ce2GmnW23qDfaqokM0JLtxxY5w2OJaNTHXSgJht7yhgOpTx8edqusxkNYTWULY
         90p6LXcezWS+1qzVOySIIrGrdglF8dd0tf9ik6GMgDtd2B5HXkhLFvBRcw8+VDb3ZNnk
         vD3s/AlRL2wY03Q9iCnbU66kcL2/FD/qleLH/jumtb1nygRqZLnEOyR28Y+j1g5qRdLP
         2cCg==
Received: by 10.14.133.198 with SMTP id q46mr6303449eei.64.1330797433749;
        Sat, 03 Mar 2012 09:57:13 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.12
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:13 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192123>

This commit makes it possible to run gitweb as a PSGI application
(see http://plackperl.org), using any of PSGI web servers.  This
includes ability to run gitweb from command line via Plack::Runner
module; just run "./gitweb.cgi --psgi" and point web browser
to http://0:5000

Gitweb uses CGI mode by default; to trigger PSGI mode one must either
pass `--psgi` or `--plackup` option to gitweb script, or the script
must be run with *.psgi filename (either copy/rename script, or make
symlink ending with *.psgi e.g. gitweb.psgi).

Besides running gitweb itself, converting its run_request() from CGI
to PSGI via CGI::Emulate::PSGI, gitweb as PSGI app also serves static
files: scripts, stylesheets and images via Plack::Middleware::Static.
Currently it assumes that positions and URLs of those assets are left
at their default values, namely that URLs end with "/static/<file>",
and that files can be found in "static/" directory relative to the
gitweb script itself.  This assumption should be relaxed in future.

Currently "git instaweb --httpd=plackup" doesn't (yet!) use this newly
introduced feature: it is left for future commit.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The major part of this series.

"./gitweb.cgi --psgi" runs web server on http://0:5000/

 Documentation/gitweb.txt |   16 +++++++++
 gitweb/INSTALL           |    3 ++
 gitweb/README            |   13 ++++++--
 gitweb/gitweb.perl       |   80 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index 605a085..157903b 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -473,6 +473,22 @@ With that configuration the full path to browse repositories would be:
 
   http://server/gitweb
 
+As PSGI using plackup
+~~~~~~~~~~~~~~~~~~~~~
+Gitweb can run as PSGI app (via emulation with *CGI::Emulate::PSGI*(3pm)).
+First you need to rename, copy or symlink gitweb.cgi to gitweb.psgi.
+You can run gitweb as a PSGI application from 'plackup' command line
+utility, using any *PSGI*(3) web server (see http://plackperl.org for
+a list), for example:
+
+    $ plackup --server HTTP::Server::Simple --port 8080 \
+      --host 127.0.0.1 gitweb.psgi
+
+With that configuration the full path to browse repositories would be:
+
+  http://127.0.0.1:8080/
+
+See *plackup*(1) manpage for more details.
 
 ADVANCED WEB SERVER SETUP
 -------------------------
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 6d45406..9f55ab4 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -36,6 +36,9 @@ Requirements
 The following optional Perl modules are required for extra features
  - Digest::MD5 - for gravatar support
  - CGI::Fast and FCGI - for running gitweb as FastCGI script
+ - CGI::Emulate::PSGI, Plack::Builder, Plack::Middleware::Static
+   for running gitweb as PSGI application, and Plack::Runner to
+   make it runnable as a standalone script
  - HTML::TagCloud - for fancy tag cloud in project list view
  - HTTP::Date or Time::ParseDate - to support If-Modified-Since for feeds
 
diff --git a/gitweb/README b/gitweb/README
index 6da4778..a435f9b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -56,9 +56,16 @@ See also gitweb.conf(5) manpage.
 Web server configuration
 ------------------------
 Gitweb can be run as CGI script, as legacy mod_perl application (using
-ModPerl::Registry), and as FastCGI script.  You can find some simple examples
-in "Example web server configuration" section in INSTALL file for gitweb (in
-gitweb/INSTALL).
+ModPerl::Registry), as FastCGI script, and as PSGI application.  You
+can find some simple examples in "Example web server configuration"
+section in INSTALL file for gitweb (in gitweb/INSTALL).
+
+Note that to run as FastCGI script gitweb must be run with *.fcgi
+extension or with `--fastcgi` / `--fcgi` parameter on command line.
+To run as PSGI application gitweb must be run with *.psgi extension,
+or with `--psgi` / `--plackup` parameter on command line, or from
+PSGI web server which sets 'PLACK_ENV' or 'PLACK_SERVER' environment
+variable.
 
 See "Webserver configuration" and "Advanced web server setup" sections in
 gitweb(1) manpage.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 22efec2..0dbdd15 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1221,16 +1221,22 @@ sub configure_as_fcgi {
 	# let each child service 100 requests
 	our $is_last_request = sub { ++$request_number > 100 };
 }
+sub configure_as_psgi {
+	our $CGI = 'PSGI'; # fake
+}
 sub evaluate_argv {
 	my $script_name = $ENV{'SCRIPT_NAME'} || $ENV{'SCRIPT_FILENAME'} || __FILE__;
 	configure_as_fcgi()
 		if $script_name =~ /\.fcgi$/;
+	configure_as_psgi()
+		if $script_name =~ /\.psgi$/;
 
 	return unless (@ARGV);
 
 	require Getopt::Long;
 	Getopt::Long::GetOptions(
 		'fastcgi|fcgi|f' => \&configure_as_fcgi,
+		'psgi|plack'     => \&configure_as_psgi,
 		'nproc|n=i' => sub {
 			my ($arg, $val) = @_;
 			return unless eval { require FCGI::ProcManager; 1; };
@@ -1244,8 +1250,78 @@ sub evaluate_argv {
 	);
 }
 
+# it is very similar to run() subroutine, but it would be hard to
+# extract common code; note that $*_hook variables can be set only
+# for FastCGI, so they are absent here
+sub to_psgi_app {
+	require CGI::Emulate::PSGI;
+
+	our $CGI = 'CGI';
+	our $first_request = 1;
+
+	my $app = CGI::Emulate::PSGI->handler(sub {
+		CGI::initialize_globals();
+		our $cgi = CGI->new();
+
+		run_request();
+
+		$first_request = 0;
+	});
+	return $app;
+}
+
+sub build_psgi_app {
+	require Plack::Builder;
+	require Plack::Middleware::Static;
+
+	my $sigchld_mw = sub {
+		my $app = shift;
+		sub {
+			my $env = shift;
+			local $SIG{'CHLD'} = 'DEFAULT';
+			local $SIG{'CLD'}  = 'DEFAULT';
+			$app->($env);
+		};
+	};
+
+	# you're supposed to "add" middleware from outer to inner.
+	# note: Plack::Builder DSL (builder, enable_if, enable) won't work
+	# with "require Plack::Builder" outside BEGIN section.
+	my $app = to_psgi_app();
+	$app = Plack::Middleware::Static->wrap($app,
+		path => qr{(?:^|/)static/.*\.(?:js|css|png)$},
+		root => __DIR__,
+		encoding => 'utf-8', # encoding for 'text/plain' files
+	);
+	$app = $sigchld_mw->($app)
+		if (defined $SIG{'CHLD'} && $SIG{'CHLD'} eq 'IGNORE');
+
+	return $app;
+}
+
+sub run_psgi_app {
+	my $app = build_psgi_app();
+
+	# make it runnable as standalone app,
+	# like it would be run via 'plackup' utility.
+	# PLACK_ENV is set by plackup etc.
+	if ($ENV{'PLACK_ENV'} || $ENV{'PLACK_SERVER'}) {
+		return $app;
+	}	else {
+		require Plack::Runner;
+
+		my $runner = Plack::Runner->new();
+		$runner->parse_options(qw(--env deployment),
+		                       qw(--host 127.0.0.1));
+		$runner->run($app);
+	}
+}
+
 sub run {
 	evaluate_argv();
+	if ($CGI eq 'PSGI' || $ENV{'PLACK_ENV'} || $ENV{'PLACK_SERVER'}) {
+		return run_psgi_app();
+	}
 
 	$first_request = 1;
 	$pre_listen_hook->()
@@ -1266,12 +1342,12 @@ sub run {
 	}
 }
 
-run();
+our $app = run();
 
 if (defined caller) {
 	# wrapped in a subroutine processing requests,
 	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::WrapCGI
-	return;
+	return $app;
 } else {
 	# pure CGI script, serving single request
 	exit;
-- 
1.7.9
