From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] gitweb: add a simple wrapper for FCGI support
Date: Wed,  3 Jan 2007 23:49:37 -0800
Message-ID: <11678969781711-git-send-email-normalperson@yhbt.net>
References: <11678969111362-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 08:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2NM7-0007v7-2X
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 08:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbXADHtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 02:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXADHtk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 02:49:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60294 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318AbXADHtj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 02:49:39 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4CE567DC094;
	Wed,  3 Jan 2007 23:49:38 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 23:49:38 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gcafca-dirty
In-Reply-To: <11678969111362-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35921>

The FCGI wrapper is designed to be spawned from the
command-line, and can be backgrounded there.  No
FCGI-specific spawners are necessary.

Since we re-eval gitweb.cgi on every request, I've
quieted warnings for redefined functions.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 .gitignore              |    1 +
 Makefile                |    6 +++++
 gitweb/gitweb-fcgi.perl |   51 +++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl      |    1 +
 4 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 2904f12..700ac4f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -137,6 +137,7 @@ git-whatchanged
 git-write-tree
 git-core-*/?*
 gitweb/gitweb.cgi
+gitweb/gitweb.fcgi
 test-date
 test-delta
 test-dump-cache-tree
diff --git a/Makefile b/Makefile
index fa1a022..3e94def 100644
--- a/Makefile
+++ b/Makefile
@@ -684,6 +684,12 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	chmod +x $@+
 	mv $@+ $@
 
+gitweb/gitweb.fcgi: gitweb/gitweb-fcgi.perl
+	rm -f $@ $@+
+	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' $< >$@+
+	chmod +x $@+
+	mv $@+ $@
+
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
diff --git a/gitweb/gitweb-fcgi.perl b/gitweb/gitweb-fcgi.perl
new file mode 100644
index 0000000..2b7d5bf
--- /dev/null
+++ b/gitweb/gitweb-fcgi.perl
@@ -0,0 +1,51 @@
+#!/usr/bin/perl -w
+use strict;
+use FCGI;
+use CGI;
+use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
+
+sub usage {
+	print STDERR "$0 --fcgi-socket=(path|[host]:port) ",
+	             "--cgi-bin=path\n";
+	exit 1;
+}
+
+my ($fcgi_sock, $cgi_bin);
+GetOptions('fcgi-socket|s=s' => \$fcgi_sock,
+           'cgi-bin|c=s' => \$cgi_bin) or usage();
+
+usage() unless ($fcgi_sock && $cgi_bin);
+
+die "FastCGI socket: $fcgi_sock already exists!\n" if (-S $fcgi_sock);
+die "CGI executable: $cgi_bin does not exist!\n" if (!-f $cgi_bin);
+
+# gitweb will exit, make it throw an exception instead:
+no warnings qw/once/;
+*CORE::GLOBAL::exit = sub { die 'gitweb_exit' };
+use warnings;
+
+# FCGI will erase the current %ENV; so make sure we save this:
+my $gwcfg = $ENV{GITWEB_CONFIG};
+
+my $fcgi_req = FCGI::Request(\*STDIN, \*STDOUT, \*STDERR, \%ENV,
+                             FCGI::OpenSocket($fcgi_sock, 128),
+                             FCGI::FAIL_ACCEPT_ON_INTR);
+while ($fcgi_req->Accept >= 0) {
+	unless ($ENV{PATH_INFO}) {
+		# nginx currently fails to set PATH_INFO,
+		# so we'll do it ourselves
+		my $pi = $ENV{SCRIPT_NAME};
+		$pi =~ s!^/\+!!;
+		$ENV{PATH_INFO} = $pi;
+	}
+	# clear CGI query parameters set inside gitweb so we can reparse
+	# the %ENV fed to us
+	CGI::initialize_globals();
+	$ENV{GITWEB_CONFIG} = $gwcfg if defined $gwcfg;
+	do $cgi_bin;
+	delete $ENV{PATH_INFO};
+}
+
+END {
+	unlink $fcgi_sock if (defined $fcgi_sock && -S $fcgi_sock);
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2179054..4a9189b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -9,6 +9,7 @@
 
 use strict;
 use warnings;
+no warnings qw(redefine); # for FCGI
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
-- 
1.5.0.rc0.gcafca-dirty
