From: Jakub Narebski <jnareb@gmail.com>
Subject: gitweb: Version independent mod_perl woes
Date: Thu, 21 Dec 2006 18:07:53 +0100
Message-ID: <200612211807.54668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 21 18:05:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxRM9-0005iS-Je
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 18:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWLURFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 12:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422978AbWLURFR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 12:05:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:36827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422985AbWLURFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 12:05:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2705864uga
        for <git@vger.kernel.org>; Thu, 21 Dec 2006 09:05:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fykjN+5WKYIGTzL+l2QFceFWSDx4UkUGU5x+45XSuslc3hPHvZtwf+wxOKVVGCDEJ2onIfcZ6/bsG5RtNqpCdwCOaZJMWMre4zUAMsuLx6wHeVOCpYG9fRi7D1gLfmXn/bebZFE362ATn6fKBW8Dl3fUuRGy1xtK+NwUQr2U5Bw=
Received: by 10.67.97.18 with SMTP id z18mr11175048ugl.1166720714395;
        Thu, 21 Dec 2006 09:05:14 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id 54sm14356415ugp.2006.12.21.09.05.13;
        Thu, 21 Dec 2006 09:05:14 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35073>

I try to make gitweb run under mod_perl without need to set up CGI
environmental variables, and without need to parse headers. I try to do
this in such a way that one will be able to run gitweb under mod_cgi
(as an ordinary CGI script), under mod_perl 1.0 Apache::registry and
under mod_perl 2.0 ModPerl::Registry without changes.

I'm trying to do the first part (running without need for SetupEnv),
but I'm encountering some strange errors and I'm stumped.

I have taken the version independent initialization from
  http://perl.apache.org/docs/2.0/user/porting/porting.html#Making_Code_Conditional_on_Running_mod_perl_Version

-- >8 --
# Set the constant MP_GEN to 0 if mod_perl is not available,
# to 1 if running under mod_perl 1.0
# and 2 for mod_perl 2.0
use constant MP_GEN => $ENV{'MOD_PERL'}
	? { ( exists $ENV{'MOD_PERL_API_VERSION'} and 
	      $ENV{'MOD_PERL_API_VERSION'} >= 2 ) ? 2 : 1 }
	: 0;

# use appropriate mod_perl modules (conditional use)
BEGIN {
	if (MP_GEN == 2) {
		require Apache2::RequestRec;
		require Apache2::ServerRec;
		require Apache2::Response;
		require Apache2::Const;
		import Apache2::RequestRec;
		import Apache2::ServerRec;
		Apache2::Const->import(-compile => qw(:common :http));
	} elsif (MP_GEN == 1) {
		require Apache;
		require Apache::Constants;
		import Apache;
		Apache::Constants->import(qw(:common :http));
	}
}

# mod_perl request
my $r;
$r = shift @_ if MP_GEN;
-- >8 --

Then later I try to use mod_perl rather than $ENV{'SERVER_NAME'}

-- >8 --
# name of your site or organization to appear in page titles
# replace this with something more descriptive for clearer bookmarks
our $site_name = "++GITWEB_SITENAME++"
                 || (($r ? $r->server()->server_hostname() : $ENV{'SERVER_NAME'})
                     || "Untitled") . " Git";
-- >8 --

but I'm encountering the following error:

  Can't locate object method "server_hostname" via package "Apache2::ServerRec"
  at /var/www/perl/gitweb/gitweb.cgi line 83.

What is strange from time to time it _works_.


Can anyone tell me what I'm doing wrong?
-- 
Jakub Narebski
Poland
