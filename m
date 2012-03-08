From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 6/5] gitweb.psgi: Use installed static files, if they are available
Date: Thu,  8 Mar 2012 15:06:06 +0100
Message-ID: <1331215566-11637-1-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 15:06:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dz6-0005Vj-Be
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 15:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2CHOGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 09:06:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41764 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab2CHOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 09:06:19 -0500
Received: by eaaq12 with SMTP id q12so154246eaa.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 06:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5V3TDSgqWR+fxmbXiGK1di15Kh8zwjCEVwhSksuyTos=;
        b=dcWOf/Lv9nCwgz21+QQaPLvHopUyN6BprTDrJCgc3l9oyyR9uFa/v9RayPp+qjff/D
         8KqCgm2iy1jeCjJDc5AdDevfZxgEEPik9QutPBZvee7VLU5TluiR6y59QPIIA9LptAcp
         QRQvafRAXw7zZbfeM+ARICSA1cHsjz5UBvZMUoeQXQ3suDpQUZvgL0czXDeLwfDqm9mp
         f/zw4cjCTvOMEsuZAoMnbVyhZmkh940ao0oLPJ2pEN3s6dxvKbTFfQyc94tUgijlwR7M
         s+/Qy4qDlxfQFErjT8/42gstUrXhcmLiYHHgHexfTBn+nTW1o2kicwAt98OQ7s9UwDe+
         1CJg==
Received: by 10.14.98.133 with SMTP id v5mr2266911eef.95.1331215577800;
        Thu, 08 Mar 2012 06:06:17 -0800 (PST)
Received: from localhost.localdomain (abwr173.neoplus.adsl.tpnet.pl. [83.8.241.173])
        by mx.google.com with ESMTPS id d54sm6419771eei.9.2012.03.08.06.06.16
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 06:06:17 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192605>

When gitweb is running as PSGI app, it must itself take care of
serving static files: stylesheets, script, images that are required
to render gitweb output.

This commit makes gitweb (in PSGI mode) use installed static files
from $(gitwebstaticdir) if such directory exists.  Before this commit
gitweb served static files from 'static/' directory relative to
position of gitweb script itself (to __DIR__).

This allows to use gitweb in PSGI mode even if static files are
installed to non-standard place.

Note that mechanism of serving is slightly different: the one with
__DIR__ uses Plack::Middleware::Static, while the installdir one uses
URLMap-ped set of Plack::App::File.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This probably would have to be reworked, so that using Plack::Middleware::Static
is preferred over set of Plack::App::File (which I think is slightly slower).

 gitweb/Makefile    |    7 +++++--
 gitweb/gitweb.perl |   38 ++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 549e7dc..6f673ff 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -13,6 +13,8 @@ all::
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 gitwebdir ?= /var/www/cgi-bin
+gitwebstaticdir ?= $(gitwebdir)/static
+gitweblibdir ?= $(gitwebdir)/lib
 
 RM ?= rm -f
 INSTALL ?= install
@@ -58,8 +60,8 @@ PERL_PATH  ?= /usr/bin/perl
 # Shell quote;
 bindir_SQ = $(subst ','\'',$(bindir))#'
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
-gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
-gitweblibdir_SQ = $(subst ','\'',$(gitwebdir)/lib)#'
+gitwebstaticdir_SQ = $(subst ','\'',$(gitwebstaticdir))#'
+gitweblibdir_SQ = $(subst ','\'',$(gitweblibdir))#'
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
 PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
 DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
@@ -130,6 +132,7 @@ GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEBSTATICDIR++|$(gitwebstaticdir)|g' \
 	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
 	-e 's|++GITWEB_CONFIG_COMMON++|$(GITWEB_CONFIG_COMMON)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6bd7b08..f871090 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1271,9 +1271,10 @@ sub to_psgi_app {
 }
 
 sub build_psgi_app {
-	require Plack::Builder;
-	require Plack::Middleware::Static;
-
+	# gitweb currently doesn't work with $SIG{CHLD} set to 'IGNORE',
+	# because it uses 'close $fd or die...' on piped filehandle $fh
+	# (which causes the parent process to wait for child to finish).
+	# this middleware is enabled only if $SIG{CHLD} is 'IGNORE'.
 	my $sigchld_mw = sub {
 		my $app = shift;
 		sub {
@@ -1288,14 +1289,35 @@ sub build_psgi_app {
 	# note: Plack::Builder DSL (builder, enable_if, enable) won't work
 	# with "require Plack::Builder" outside BEGIN section.
 	my $app = to_psgi_app();
-	$app = Plack::Middleware::Static->wrap($app,
-		path => qr{(?:^|/)static/.*\.(?:js|css|png)$},
-		root => __DIR__,
-		encoding => 'utf-8', # encoding for 'text/plain' files
-	);
 	$app = $sigchld_mw->($app)
 		if (defined $SIG{'CHLD'} && $SIG{'CHLD'} eq 'IGNORE');
 
+	if (-d "++GITWEBSTATICDIR++") {
+		require Plack::App::URLMap;
+		require Plack::App::File;
+
+		my $urlmap = Plack::App::URLMap->new();
+		$urlmap->map("/" => $app);
+		foreach my $static_url (@stylesheets, $stylesheet, $logo, $favicon, $javascript) {
+			next if (!defined $static_url || $static_url eq "");
+
+			(my $static_file = $static_url) =~ s!^.*/!!; # basename
+			$static_file = "++GITWEBSTATICDIR++/$static_file";
+			$urlmap->map($static_url => Plack::App::File->new(file => $static_file));
+		}
+		$app = $urlmap->to_app();
+
+	} else {
+		require Plack::Middleware::Static;
+
+		$app = Plack::Middleware::Static->wrap($app,
+			path => qr{(?:^|/)static/.*\.(?:js|css|png)$},
+			root => __DIR__,
+			encoding => 'utf-8', # encoding for 'text/plain' files
+		);
+
+	}
+
 	return $app;
 }
 
-- 
1.7.9
