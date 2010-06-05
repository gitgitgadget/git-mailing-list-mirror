From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Run in FastCGI mode if gitweb script has .fcgi extension
Date: Sat,  5 Jun 2010 23:11:18 +0200
Message-ID: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 23:09:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL0c8-0000mf-H7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731Ab0FEVJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 17:09:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64499 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658Ab0FEVJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 17:09:01 -0400
Received: by fxm8 with SMTP id 8so1392005fxm.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dQtTKCBWMiJEucBeuLMLASClLZKWCeG7NVM1n8PA3PY=;
        b=x+T2qNRjf5+j8BA9mAH/HJyywjmrCfboF/rrsAA7Ug5OPrms1QMtTP858unhSuvB13
         oc+a/boTIdxQiQJcSWcrE8AoiTG/kDpQvPyu+BqULA2S9e2O7bevZEjYGKEA3WyEpTKP
         p3h02vk1jZ784ztsEaFvLRUScj0CX8I1hN5S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EHTh016aPa5ZJlIPJrjYDgj01GeJ7obB6I+k6sdRvesc1g2Zk+ZLsgYlYHG1YZJsLF
         ukAyJuwWp4qtvpUFTJIHIpI7Z7zO7kwU2rPOzKamzEy3rumMFISfljrE1W4JW3xHiLzY
         k+XyKH17of/ZDXWhWNB9OAC9XfUSv1CIJ8T94=
Received: by 10.223.64.194 with SMTP id f2mr13447464fai.2.1275772139524;
        Sat, 05 Jun 2010 14:08:59 -0700 (PDT)
Received: from localhost.localdomain (aehn204.neoplus.adsl.tpnet.pl [79.186.195.204])
        by mx.google.com with ESMTPS id y12sm11953192faj.5.2010.06.05.14.08.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 14:08:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148494>

If the name of the script ($SCRIPT_NAME or $SCRIPT_FILENAME CGI
environment variable, or __FILE__ literal) ends with '.fcgi'
extension, run gitweb in FastCGI mode, as if it was run with
'--fastcgi' / '--fcgi' option.

This is intended for easy deploying gitweb using FastCGI
interface.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is based on a0446e7 commit (gitweb: Add support for
FastCGI, using CGI::Fast, 2010-05-07), currently in 'next' 
(from 'jn/gitweb-fastcgi' branch).

I have not actually tested that it runs as FastCGI script.

Now to run gitweb using FastCGI, all one has to do is to rename it
from gitweb.cgi to gitweb.fcgi.  And of course configure web server
to run it using FastCGI interface.

 gitweb/gitweb.perl |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c42c16f..47ef993 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1056,19 +1056,24 @@ our $is_last_request = sub { 1 };
 our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
 our $CGI = 'CGI';
 our $cgi;
+sub configure_as_fcgi {
+	require CGI::Fast;
+	our $CGI = 'CGI::Fast';
+
+	my $request_number = 0;
+	# let each child service 100 requests
+	our $is_last_request = sub { ++$request_number > 100 };
+}
 sub evaluate_argv {
+	my $script_name = $ENV{'SCRIPT_NAME'} || $ENV{'SCRIPT_FILENAME'} || __FILE__;
+	configure_as_fcgi()
+		if $script_name =~ /\.fcgi$/;
+
 	return unless (@ARGV);
 
 	require Getopt::Long;
 	Getopt::Long::GetOptions(
-		'fastcgi|fcgi|f' => sub {
-			require CGI::Fast;
-			our $CGI = 'CGI::Fast';
-
-			my $request_number = 0;
-			# let each child service 100 requests
-			our $is_last_request = sub { ++$request_number > 100 };
-		},
+		'fastcgi|fcgi|f' => \&configure_as_fcgi,
 		'nproc|n=i' => sub {
 			my ($arg, $val) = @_;
 			return unless eval { require FCGI::ProcManager; 1; };
-- 
1.7.0.1
