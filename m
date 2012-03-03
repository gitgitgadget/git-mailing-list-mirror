From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 5/5] git-instaweb: Use new PSGI interface mode of gitweb
Date: Sat,  3 Mar 2012 18:57:03 +0100
Message-ID: <1330797423-22926-6-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCy-00031I-G5
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967Ab2CCR5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:24 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49379 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2CCR5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:16 -0500
Received: by eekc41 with SMTP id c41so981402eek.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:15 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.101.129 as permitted sender) client-ip=10.14.101.129;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.101.129 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.101.129])
        by 10.14.101.129 with SMTP id b1mr8239334eeg.12.1330797435849 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4kZTeIT/4Ak+nF+O1lm1GjeoZDnrYhPkduI38n3k2yc=;
        b=B3FeJm5VMtGIHMmZaIofdtm1X8id4lqNKPfCPg6mak0JeW8wMgLwDU04OmTQgEc7p7
         hX+anHK13TLMtszJLwz5WNzULFuVFpMbQwcKOyNd/Uu+jSjKSJwfeq1IRKEGBPP+R+Wq
         Rsym8gw3vXDOS7GEbFJNiJNHhJou2XwqA+Kcm3lMzLmn/Y9yJSbR2wVNON3mwD4QuqfR
         +6GNQafxw7eOA5idDGUpOkz5RAwXMxdBRq4reDvn3HNMVpdhdCRAcGdVBC19ltkZwhQ2
         viZEZeP9yZWGKfaJtsyOs4DwEvFsrc3Vo5nVyyq2M2WEEpKfVzATxPC/Y+9OVRCEhVV3
         NVQw==
Received: by 10.14.101.129 with SMTP id b1mr6304017eeg.12.1330797435786;
        Sat, 03 Mar 2012 09:57:15 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.14
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:15 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192124>

Now that gitweb supports PSGI interface itself, use it instead of
Plack::App::WrapCGI.

Note that gitweb as PSGI serves static files and ensures correct
handling of SIGCHLD, but the wrapper is still needed for logging,
mimetype handling (probably unnecessary), and selecting host and port.
It is now named gitweb-wrapper.psgi and not gitweb.psgi, though.

The advantage of previous version is that it uses persistent mode
(similar to FastCGI); important if $per_request_config is false or
coderef.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Should make git-instaweb plackup mode better.

 git-instaweb.sh |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 01a1b05..58e142a 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -53,8 +53,8 @@ resolve_full_httpd () {
 		fi
 		;;
 	*plackup*)
-		# server is started by running via generated gitweb.psgi in $fqgitdir/gitweb
-		full_httpd="$fqgitdir/gitweb/gitweb.psgi"
+		# server is started by running via generated gitweb-wrapper.psgi in $fqgitdir/gitweb
+		full_httpd="$fqgitdir/gitweb/gitweb-wrapper.psgi"
 		httpd_only="${httpd%% *}" # cut on first space
 		return
 		;;
@@ -434,7 +434,7 @@ EOF
 plackup_conf () {
 	# generate a standalone 'plackup' server script in $fqgitdir/gitweb
 	# with embedded configuration; it does not use "$conf" file
-	cat > "$fqgitdir/gitweb/gitweb.psgi" <<EOF
+	cat > "$fqgitdir/gitweb/gitweb-wrapper.psgi" <<EOF
 #!$PERL
 
 # gitweb - simple web interface to track changes in git repositories
@@ -445,8 +445,7 @@ use strict;
 use IO::Handle;
 use Plack::MIME;
 use Plack::Builder;
-use Plack::App::WrapCGI;
-use CGI::Emulate::PSGI 0.07; # minimum version required to work with gitweb
+use Plack::Util;
 
 # mimetype mapping (from lighttpd_conf)
 Plack::MIME->add_type(
@@ -538,25 +537,7 @@ my \$app = builder {
 			\$app->(\$env);
 		}
 	};
-	# gitweb currently doesn't work with $SIG{CHLD} set to 'IGNORE',
-	# because it uses 'close $fd or die...' on piped filehandle $fh
-	# (which causes the parent process to wait for child to finish).
-	enable_if { \$SIG{'CHLD'} eq 'IGNORE' } sub {
-		my \$app = shift;
-		sub {
-			my \$env = shift;
-			local \$SIG{'CHLD'} = 'DEFAULT';
-			local \$SIG{'CLD'}  = 'DEFAULT';
-			\$app->(\$env);
-		}
-	};
-	# serve static files, i.e. stylesheet, images, script
-	enable 'Static',
-		path => sub { m!\.(js|css|png)\$! && s!^/gitweb/!! },
-		root => "$root/",
-		encoding => 'utf-8'; # encoding for 'text/plain' files
-	# convert CGI application to PSGI app
-	Plack::App::WrapCGI->new(script => "$root/gitweb.cgi")->to_app;
+	Plack::Util::load_psgi("$root/gitweb.cgi");
 };
 
 # make it runnable as standalone app,
@@ -574,8 +555,8 @@ if (caller) {
 __END__
 EOF
 
-	chmod a+x "$fqgitdir/gitweb/gitweb.psgi"
-	# configuration is embedded in server script file, gitweb.psgi
+	chmod a+x "$fqgitdir/gitweb/gitweb-wrapper.psgi"
+	# configuration is embedded in server script file, gitweb-wrapper.psgi
 	rm -f "$conf"
 }
 
-- 
1.7.9
