From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC v2] gitweb: Run in FastCGI mode if gitweb script has .fcgi extension
Date: Sun, 6 Jun 2010 22:09:49 +0200
Message-ID: <201006062209.53176.jnareb@gmail.com>
References: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 22:10:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLMAu-0007Qk-9r
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 22:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab0FFUKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 16:10:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59875 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0FFUKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 16:10:07 -0400
Received: by bwz11 with SMTP id 11so791409bwz.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KMWHOzLlybhZC09B/MT8uOdSO4dhGFbni0rwQSZwLeo=;
        b=fKSbZvhjr3I/apx5/5A+t6KpI7CQEaWDR73zANMNp/K/VbiTyVyrl6XdvQ/YY13fce
         7nV2U5cgA/M2unN5JNJB8edE17pIaUdI5Ozu5CfiUldrhbd5+lWz2FdVR10u3ZkrkGJn
         FeH9hP8znW0CF4kkL1vj8rZi5Mft5Z9hG6qMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pB5FX2pMHIFGXTH1CODtyQmZbBGKUtaDx0L6B1PhCdnpdQEc8YUvRR3bOQBkc5u5sb
         PE9DUnEghgZQ6Yg9dzEzC44A42eEE7+d2DOkEAhVVXVjShZy6jsTeaxclhSQKhBQC5e7
         Z3oyL0wt6YDlYeGoc15ThgH6s/Uw11VDkf5oI=
Received: by 10.204.83.29 with SMTP id d29mr5892195bkl.130.1275855005093;
        Sun, 06 Jun 2010 13:10:05 -0700 (PDT)
Received: from [192.168.1.15] (abwd128.neoplus.adsl.tpnet.pl [83.8.227.128])
        by mx.google.com with ESMTPS id v3sm16183747bkz.10.2010.06.06.13.10.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 13:10:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275772278-14709-1-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148539>

If the name of the script ($SCRIPT_NAME or $SCRIPT_FILENAME CGI
environment variable, or __FILE__ literal) ends with '.fcgi'
extension, run gitweb in FastCGI mode, as if it was run with
'--fastcgi' / '--fcgi' option.

This is intended for easy deploying of gitweb using FastCGI
interface.

Includes update to gitweb/INSTALL.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch differs from previous version only in that it now includes
change to gitweb/INSTALL.  Can anyone check if the information stated
there is correct?

This patch is based on a0446e7 commit (gitweb: Add support for
FastCGI, using CGI::Fast, 2010-05-07), currently in 'next' 
(from 'jn/gitweb-fastcgi' branch).

I have not actually tested that it runs as FastCGI script.

 gitweb/INSTALL     |   28 ++++++++++++++++++++++++++++
 gitweb/gitweb.perl |   21 +++++++++++++--------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index d484d76..617c9f4 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -230,12 +230,26 @@ $projects_list variable in gitweb config):
 	perl -- /var/www/cgi-bin/gitweb.cgi
 
 
+Running gitweb using FastCGI interface
+--------------------------------------
+
+To run gitweb as FastCGI script (using FastCGI interface), rather than
+plain CGI script, you need to either pass '--fastcgi' or '--fcgi' parameter
+to gitweb script, or rename it to 'gitweb.fcgi' (to end with '.fcgi'
+extension).  To run gitweb using FastCGI interface you need CGI::Fast
+and FCGI Perl modules installed.
+
+You can also pass '--nproc=<n>' parameter to gitweb script to configure how
+many FCGI::ProcManager processes to use.
+
+
 Requirements
 ------------
 
  - Core git tools
  - Perl
  - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
+   To run gitweb using FastCGI interface CGI::Fast and FCGI are needed.
  - web server
 
 
@@ -272,3 +286,17 @@ See also "Webserver configuration" section in README file for gitweb
 	    Order allow,deny
 	    Allow from all
 	</Directory>
+
+- Apache2, gitweb installed as 'gitweb.fcgi' FastCGI script,
+  under /var/www/fcgi-bin/
+
+	LoadModule fcgid_module modules/mod_fcgid.so
+
+	Alias /fcgi-bin "/var/www/fcgi-bin"
+
+	<Directory "/var/www/fcgi-bin">
+	    SetHandler fcgid-script
+	    Options +ExecCGI
+	    Order allow,deny
+	    Allow from all
+	</Directory>
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
