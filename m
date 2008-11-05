From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] gitweb: Fix mod_perl support.
Date: Thu, 6 Nov 2008 01:10:07 +0300
Organization: HOME
Message-ID: <200811060110.07965.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 23:14:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxqdP-0001ht-2F
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 23:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYKEWML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 17:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYKEWMK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 17:12:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:33436 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYKEWMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 17:12:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so149516fgg.17
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QGO5ocSDwYGTyPjMupr56uAfYu4XWvgdyltAAPKV4U4=;
        b=d77b81VMZeo0qT9HAK9nLCA/u6KOkxOb8/8rgFI0yOgKCwUBwtIKulXhmKxRVETLM7
         M1DdeU2JWdHTffPzQxbS2GwPXKmBd1bHpiqUqY3JrN3JdtkeeK6U1W/NQTM1BNRMwtH3
         scCmQe2N5+71om53HFeXKknmcVcaR0J9U+lOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=DNPkH54ONH3TfmEXRqgirI56cG6jMpLL+LyoT0SekFBQdDvoxTPB60IxM84i7eS+z/
         +37tMbXdIrj4w1Dkq+Ihxt4T+f0YxS4Av7Kz+SeON3zWL+rXrCpqNu5z8IeQPRo3NQwg
         HyspId7RRkwIOzzmEY4z0J+0bOEVzLt5UVtAs=
Received: by 10.181.199.6 with SMTP id b6mr431590bkq.137.1225923125193;
        Wed, 05 Nov 2008 14:12:05 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d13sm732975fka.19.2008.11.05.14.12.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Nov 2008 14:12:03 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100190>

ModPerl::Registry precompiles scripts by wrapping them
in a subroutine. This causes ordinary subroutines of the
script to become nested, and warnings appear:

gitweb.cgi: Variable "$path_info" will not stay shared

This warning means that $path_info was declared as 'my',
and thus according to the perl evaluation rules all nested
subroutines will retain a reference to the instance of the
variable used in the first invocation of the master script.

When the script (i.e. the master meta-subroutine) is executed
the second time, it will use a new instance, so the logic
breaks. To avoid this it is necessary to declare all global
variables as 'our', which places them at the package level.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitweb/gitweb.perl |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c5254af..2174d4a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -30,7 +30,7 @@ our $my_uri = $cgi->url(-absolute => 1);
 # if we're called with PATH_INFO, we have to strip that
 # from the URL to find our real URL
 # we make $path_info global because it's also used later on
-my $path_info = $ENV{"PATH_INFO"};
+our $path_info = $ENV{"PATH_INFO"};
 if ($path_info) {
 	$my_url =~ s,\Q$path_info\E$,,;
 	$my_uri =~ s,\Q$path_info\E$,,;
@@ -436,7 +436,7 @@ $projects_list ||= $projectroot;
 # together during validation: this allows subsequent uses (e.g. href()) to be
 # agnostic of the parameter origin
 
-my %input_params = ();
+our %input_params = ();
 
 # input parameters are stored with the long parameter name as key. This will
 # also be used in the href subroutine to convert parameters to their CGI
@@ -446,7 +446,7 @@ my %input_params = ();
 # XXX: Warning: If you touch this, check the search form for updating,
 # too.
 
-my @cgi_param_mapping = (
+our @cgi_param_mapping = (
 	project => "p",
 	action => "a",
 	file_name => "f",
@@ -463,10 +463,10 @@ my @cgi_param_mapping = (
 	extra_options => "opt",
 	search_use_regexp => "sr",
 );
-my %cgi_param_mapping = @cgi_param_mapping;
+our %cgi_param_mapping = @cgi_param_mapping;
 
 # we will also need to know the possible actions, for validation
-my %actions = (
+our %actions = (
 	"blame" => \&git_blame,
 	"blobdiff" => \&git_blobdiff,
 	"blobdiff_plain" => \&git_blobdiff_plain,
@@ -498,7 +498,7 @@ my %actions = (
 
 # finally, we have the hash of allowed extra_options for the commands that
 # allow them
-my %allowed_options = (
+our %allowed_options = (
 	"--no-merges" => [ qw(rss atom log shortlog history) ],
 );
 
-- 
tg: (933bb3a..) t/misc/mod-perl-fix (depends on: vanilla/master)
