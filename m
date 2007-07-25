From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Enable transparent compression form HTTP output
Date: Wed, 25 Jul 2007 20:39:43 +0200
Message-ID: <200707252039.44312.jnareb@gmail.com>
References: <513314.51284.qm@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 23:32:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDoSq-0004B1-Sb
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 23:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089AbXGYVcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 17:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757656AbXGYVcI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 17:32:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36415 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbXGYVcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 17:32:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so426153ugf
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 14:32:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JlXIm28oLLTErtR2180/fGgZlTnu5BIDrkTVxSdzupHXya1nrlupHgEorfmbLMRyBZWrNMsrT+qza8dKas8T3e1DRAC5YKkN8e4NZ3JnLQXOawg8StURAWjBLa0bKAF17hs5E8MXYH7yKODynyjYZRrvArosuY++SllfUaxlGOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UGsvqNwSP8n2biYapKbWj8heI/7M7EgYB9XD0M7i0pvPCr+BiBBVQxx++4ahT5XabPCYf2eywo15E2vy5BTiPePz6sdmWFGYbJKktk6QsIVfpJp7LZ/ov9Zyu2Rx/crDO964A/N0f+1KCimHC2vSE0IhaycM+vPEpk77RVhfu0w=
Received: by 10.86.76.16 with SMTP id y16mr726589fga.1185399123668;
        Wed, 25 Jul 2007 14:32:03 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j12sm1481442fkf.2007.07.25.14.31.59
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 14:32:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <513314.51284.qm@web31813.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53723>

Check if PerlIO::gzip is available, and if it is make it possible to
enable (via 'compression' %feature) transparent compression of HTML
output.  Error messages and any non-HTML output are excluded from
transparent compression.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 19 July 2007, Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > Luben Tuikov wrote:
> > 
> > > I wouldn't mind an improvement in the snapshot area of gitweb.
> > > I wasn't really happy with the snapshot feature as it was originally
> > > implemented, as it would generate a tar file with ".tar.bz2"
> > > name extension, but the file was NOT bz2, and I had to always
> > > manually rename, bz2, and rename back.
> > 
> > This was a *bug*, but it is now corrected (in 9aa17573). Gitweb used 
> > Content-Encoding, which is meant for _transparent_ compression.
> 
> Yeah, that's what I suspected, since there was nothing obviously
> wrong with the code.

And _this_ patch adds support for true, intentional transparent
compression.

 gitweb/gitweb.perl |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0acd0ca..d48a193 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -20,8 +20,12 @@ binmode STDOUT, ':utf8';
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
+
+	eval { require PerlIO::gzip; }; # needed for transparent compression
 }
 
+our $enable_transparent_compression = !! $PerlIO::gzip::VERSION;
+
 our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
@@ -238,6 +242,22 @@ our %feature = (
 		'override' => 0,
 		'default' => [1]},
 
+	# Enable transparent compression, for now only for HTML output;
+	# this reduces network bandwidth at the cost of CPU usage.
+	# You need to have PerlIO::gzip for that, and browser has to accept
+	# (via Accept-Encoding: HTTP request header) 'gzip' encoding.
+	# Transparent compression is not used for error messages.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'compression'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'compression'}{'override'} = 1;
+	# and in project config gitweb.compression = 0|1;
+	'compression' => {
+		'sub' => \&feature_compression,
+		'override' => 0,
+		'default' => [0]},
+
 	# Make gitweb use an alternative format of the URLs which can be
 	# more readable and natural-looking: project name is embedded
 	# directly in the path and the query string contains other
@@ -336,6 +356,18 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+sub feature_compression {
+	my ($val) = git_get_project_config('compression', '--bool');
+
+	if ($val eq 'true') {
+		return (1);
+	} elsif ($val eq 'false') {
+		return (0);
+	}
+
+	return ($_[0]);
+}
+
 # checking HEAD file with -e is fragile if the repository was
 # initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
 # and then pruned.
@@ -2238,9 +2270,24 @@ sub git_header_html {
 	} else {
 		$content_type = 'text/html';
 	}
+	# transparent compression has to be supported, enabled, and accepted
+	# explicitely by UA; note that qvalue of 0 means "not acceptable."
+	my %content_encoding = ();
+	if ($enable_transparent_compression &&
+	    gitweb_check_feature('compression') &&
+	    defined $cgi->http('HTTP_ACCEPT_ENCODING') &&
+	    $cgi->http('HTTP_ACCEPT_ENCODING') =~ m/(^|,|;|\s)gzip(,|;|\s|$)/ &&
+	    $cgi->http('HTTP_ACCEPT_ENCODING') !~ m/(^|,|;|\s)gzip\s*;q=0(,|\s|$)/) {
+		%content_encoding = (-content_encoding => 'gzip');
+	}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
+	                   %content_encoding,
 	                   -status=> $status, -expires => $expires);
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
+	if (%content_encoding) {
+		# implies $enable_transparent_compression
+		binmode STDOUT, ':gzip';
+	}
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -2375,6 +2422,7 @@ sub die_error {
 	my $status = shift || "403 Forbidden";
 	my $error = shift || "Malformed query, file missing or permission denied";
 
+	$enable_transparent_compression = 0;
 	git_header_html($status);
 	print <<EOF;
 <div class="page_body">
-- 
1.5.2.4
