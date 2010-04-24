From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Add custom error handler using die_error
Date: Sat, 24 Apr 2010 16:00:04 +0200
Message-ID: <20100424135627.30511.70847.stgit@localhost.localdomain>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 16:00:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fuT-0003of-FS
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 16:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0DXOAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 10:00:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45271 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0DXOAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 10:00:33 -0400
Received: by wyg36 with SMTP id 36so401443wyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 07:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Ap1V0YxBfK7zrhTlWsbIvGVmJoD1NBktybSKDh1zy/M=;
        b=ZgUIyYaTcuf3lJAaSfR/RZXh5PKMkcXPmHIRsjtjSK9XGTGPLhmo/QWtzWv5bFKhnH
         hL20E/wa0jDjrdWYNNLXw5eHYM7R50iar9hQ3T0jQ0HDIlzS6EpDBWVd0SYBvlkxkfnn
         eXIhoxDW4GD1huKEWKq0+q9ut5qh9dClgGKug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=iR68xI+Yjy6BYGW/yDMKmPJIb6+X3P22M5t1oKKPblsgHCFZAMOhMTx7jVkcBq4Q//
         TQy2wLouTnYN2msuH+GuLnHCfTN7/LaJYV0EbrOQpmVh8rJauUPY40cA3muQmzI2e/v3
         VU9/TOhsYjmvw/yLyYkbj81eRTelIqrqWTWBI=
Received: by 10.216.88.16 with SMTP id z16mr1852670wee.126.1272117631252;
        Sat, 24 Apr 2010 07:00:31 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id z3sm5474290wbs.10.2010.04.24.07.00.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 07:00:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3OE04hv031096;
	Sat, 24 Apr 2010 16:00:14 +0200
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145679>

Change the default message for errors (for fatalsToBrowser) to use
die_error() subroutine.  This way errors (and explicitely calling 'die
MESSAGE') would generate 'Internal Server Error' error message.

Note that call to set_message is intentionally not put in BEGIN block;
we set error handler to use die_error() only after we are sure that we
can use it, after all needed variables are set.

Due to the fact that error handler set via set_message() subroutine
from CGI::Carp (in the fatalsToBrowser case) is called after HTTP
headers were already printed (with exception of MOD_PERL), gitweb
cannot return 'Status: 500 Internal Server Error'.

Thanks to the fact that die_error() no longer uses 'exit', errors
would be logged by CGI::Carp, independent on whether default error
handler is used, or handle_errors_html which uses die_error is used.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Because of the fact that with CGI::Carp::set_message and die_error
you cannot return proper HTTP status code, I have decided that
caching engine needs support for custom error handler anyway, a la
'on_get_error' and 'on_set_error' in CHI.

With this patch most error messages, from fatal errors in gitweb or
Perl, should get look of the rest of gitweb.  This is good idea even
without caching support.

 gitweb/gitweb.perl |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ed92dca..e579c14 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -11,7 +11,7 @@ use strict;
 use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
-use CGI::Carp qw(fatalsToBrowser);
+use CGI::Carp qw(fatalsToBrowser set_message);
 use Encode;
 use Fcntl ':mode';
 use File::Find qw();
@@ -952,6 +952,21 @@ if ($git_avatar eq 'gravatar') {
 	$git_avatar = '';
 }
 
+# custom error handler: 'die <message>' is Internal Server Error
+sub handle_errors_html {
+	my $msg = shift; # it is already HTML escaped
+
+	# to avoid infinite loop where error occurs in die_error,
+	# change handler to default handler, disabling handle_errors_html
+	set_message("Error occured when inside die_error:\n$msg");
+
+	# you cannot jump out of die_error when called as error handler;
+	# the subroutine set via CGI::Carp::set_message is called _after_
+	# HTTP headers are already written, so it cannot write them itself
+	die_error(undef, undef, $msg, -error_handler => 1, -no_http_header => 1);
+}
+set_message(\&handle_errors_html);
+
 # dispatch
 if (!defined $action) {
 	if (defined $hash) {
@@ -3167,6 +3182,7 @@ sub blob_contenttype {
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
+	my %opts = @_;
 
 	my $title = "$site_name";
 	if (defined $project) {
@@ -3194,7 +3210,8 @@ sub git_header_html {
 		$content_type = 'text/html';
 	}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
-	                   -status=> $status, -expires => $expires);
+	                   -status=> $status, -expires => $expires)
+		unless ($opts{'-no_http_headers'});
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
@@ -3411,6 +3428,7 @@ sub die_error {
 	my $status = shift || 500;
 	my $error = esc_html(shift) || "Internal Server Error";
 	my $extra = shift;
+	my %opts = @_;
 
 	my %http_responses = (
 		400 => '400 Bad Request',
@@ -3419,7 +3437,7 @@ sub die_error {
 		500 => '500 Internal Server Error',
 		503 => '503 Service Unavailable',
 	);
-	git_header_html($http_responses{$status});
+	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
 <div class="page_body">
 <br /><br />
@@ -3433,7 +3451,8 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_GITWEB;
+	goto DONE_GITWEB
+		unless ($opts{'-error_handler'});
 }
 
 ## ----------------------------------------------------------------------
