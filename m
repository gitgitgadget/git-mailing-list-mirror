From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 4/6] gitweb: Prepare for mod_perl specific support
Date: Thu, 28 Dec 2006 00:04:32 +0100
Message-ID: <200612280004.32728.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzikc-0002G6-50
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWL1ADp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWL1ADo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:55827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964830AbWL1ADk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021262uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kwq9ELSd6U73cGQd1AgoH6DzvWJqLCORU7ShsYXaClu+kb7lWJf9HsT9HXK8YW+VP9piFc/KbReSPrgNOTizIe0C60Y+YHyhxyMtuCqBdVsb7m9Lt9VKND/8TtlrsJiiWj/hc7L8JtnqsXtVkoLJBcVf1JK7GNSqGKyD9EMiptk=
Received: by 10.66.216.20 with SMTP id o20mr19263218ugg.1167264219318;
        Wed, 27 Dec 2006 16:03:39 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.38;
        Wed, 27 Dec 2006 16:03:39 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35491>

Prepare gitweb for mod_perl specific support in CGI compatibility mode
(Apache::Registry/ModPerl::Registry or Apache::PerlRun/ModPerl::PerlRun)
by storing request (an argument to a handler) in $r variable, for later
use.

The idea is to have gitweb run as CGI script, under mod_perl 1.0 and under
mod_perl 2.0 without modifications, while being able to make use of mod_perl
capabilities.

Define MP_GEN constant and set it to 0 if mod_perl is not available,
to 1 if running under mod_perl 1.0, and 2 for mod_perl 2.0. It is later used
in BEGIN block to load appropriate mod_perl modules; for now the one
in which request is defined, and the one with status and HTTP constants.
Based on "Porting Apache:: Perl Modules from mod_perl 1.0 to 2.0" document
  http://perl.apache.org/docs/2.0/user/porting/porting.html
chapter "Making Code Conditional on Running mod_perl Version".

Use "if (MP_GEN)" for checking if gitweb is run under mod_perl; later
on we will use "if ($r)" for that.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
A bit of RFC, because I'm not sure if "my $r" or "our $r" should be
used (in script which makes use of subroutines; under Registry those
would end as nested subroutines).

Perhaps we should import everything?

 gitweb/gitweb.perl |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3888563..9983e9e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,10 +18,36 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
+# Set the constant MP_GEN to 0 if mod_perl is not available,
+# to 1 if running under mod_perl 1.0
+# and 2 for mod_perl 2.0
+use constant {
+	MP_GEN => ($ENV{'MOD_PERL'}
+	           ? ( exists $ENV{'MOD_PERL_API_VERSION'} and 
+	                      $ENV{'MOD_PERL_API_VERSION'} >= 2 ) ? 2 : 1
+	           : 0),
+};
+
 BEGIN {
-	CGI->compile() if $ENV{MOD_PERL};
+	# use appropriate mod_perl modules (conditional use)
+	if (MP_GEN == 2) {
+		require Apache2::RequestRec;
+		require Apache2::Const;
+		Apache2::Const->import(-compile => qw(:common :http));
+	} elsif (MP_GEN == 1) {
+		require Apache;
+		require Apache::Constants;
+		Apache::Constants->import(qw(:common :http));
+	}
+
+	# precompile CGI for mod_perl
+	CGI->compile() if MP_GEN;
 }
 
+# mod_perl request
+my $r;
+$r = shift @_ if MP_GEN;
+
 our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
-- 
1.4.4.3
