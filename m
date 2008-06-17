From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (WIP)] gitweb: Check that RSS, Atom and OPML output is well formed XML
Date: Tue, 17 Jun 2008 09:22:04 +0200
Message-ID: <200806170922.05348.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VX4-000549-RT
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYFQHWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYFQHWO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:22:14 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:22417 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYFQHWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:22:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so1280862and.103
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bYeGrJOQNLwqh+sjYRdLE57JRdOQUaXDJvniS2KzU5M=;
        b=uDmXsae8s4+J2rwKGhGTnlCmPhms+Xwv+jzy/zLrx9jioqRQFyDXnBqmSHfgQfUCm+
         RuplspJurB1y21maO+2IH7pwRT4MeAaWc4+967VogRCwr1T55UcZNvf4z0lYF79IRk2a
         EGw1YlOu2CA/F8NqlS99N2GgModw/KoSDMYv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=iV2sBbiR1HCp03A5UDW3DFGhLm4c777Kaivn57owXa3t8TtWm+DYuMUw9jCKCjiClo
         UgxRzWViAEUJO7aL7aVKvFh29F/oh5GliMloPGoKtYDXyjtUFNSuhdTgEK143mqT7b3y
         tWYzAm2Snwj11uXJMgbmMx59ba0jlhPzA1I3w=
Received: by 10.100.212.6 with SMTP id k6mr9998521ang.142.1213687332320;
        Tue, 17 Jun 2008 00:22:12 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.236.117])
        by mx.google.com with ESMTPS id d34sm12809876and.3.2008.06.17.00.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 00:22:11 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85272>

NOTE: This does not check that RSS and Atom feeds (and OPML outline)
conform to the specification (which might be given as DTD, XSD = XML
Schema, Relax-NG schema,...), only that it parses without errors.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
To check Atom and RSS feeds against specification we could use script
version of W3C Feed Validator (http://validator.w3.org/feed/), or
try to validate against XML Schema (XSD) which is default schema
language for RSS, or against Relax-NG schema which is default schema
language for Atom.

 t/t9503/test.pl             |   75 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/t/t9503/test.pl b/t/t9503/test.pl
index 7d081b9..df981c5 100755
--- a/t/t9503/test.pl
+++ b/t/t9503/test.pl
@@ -7,14 +7,21 @@ use strict;
 
 use Cwd qw(abs_path);
 use File::Spec;
+use XML::Parser;
 use Test::More qw(no_plan);
 use Test::WWW::Mechanize::CGI;
 
-eval { require HTML::Lint };
+eval { require HTML::Lint; };
 my $lint_installed = !$@;
 diag('HTML::Lint is not installed; no HTML validation tests')
 	unless $lint_installed;
 
+eval { require XML::Parser; };
+my $xml_parser_installed = !$@;
+diag('XML::Parser is not installed; no tests for well-formed XML')
+	unless $xml_parser_installed;
+
+
 my $gitweb = File::Spec->catfile('..','..','gitweb','gitweb.perl');
 # the followin two lines of code are workaround for bug in
 # Test::WWW::Mechanize::CGI::cgi_application version up to 0.3
@@ -24,10 +31,17 @@ $gitweb = File::Spec->rel2abs($gitweb);
 $gitweb = Cwd::abs_path($gitweb);
 
 my $mech = new Test::WWW::Mechanize::CGI;
+$mech->env(
+	GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'},
+);
 $mech->cgi_application($gitweb);
-$mech->env(GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'});
 
-# import config, pedeclaring config variables
+my $xml_parser;
+if ($xml_parser_installed) {
+	$xml_parser = new XML::Parser;
+}
+
+# import config, predeclaring config variables
 our $site_name = '';
 require_ok($ENV{'GITWEB_CONFIG'})
 	or diag('Could not load gitweb config; some tests would fail');
@@ -40,7 +54,7 @@ SKIP: {
 		unless $mech->get_ok('http://localhost/', "GET $pagename");
 	$mech->html_lint_ok('page validates') if $lint_installed;
 	$mech->title_like(qr!$site_name!,
-		'title contains $site_name');
+		"title contains $site_name");
 	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
 		'lists test repository (by description)');
 }
@@ -87,5 +101,58 @@ $mech->get('http://localhost/?p=.git;a=commit;h=non-existent');
 like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
 $mech->html_lint_ok('page validates') if $lint_installed;
 
+$pagename = 'HEAD commit in non existent repository';
+$mech->get('http://localhost/?p=non-existent.git;a=commit;h=HEAD');
+like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
+$mech->html_lint_ok('page validates') if $lint_installed;
+
+SKIP: {
+	$pagename = 'test repository RSS feed (default)';
+	$get_ok = $mech->get_ok('http://localhost/?p=.git;a=rss',
+		"GET $pagename");
+	skip "Could not get $pagename", 0 + $xml_parser_installed
+		unless $get_ok;
+
+	if ($xml_parser_installed) {
+		eval {
+			$xml_parser->parse($mech->content());
+		};
+		ok(! $@, "$pagename is well formed XML")
+			or diag($@);
+	}
+}
+
+SKIP: {
+	$pagename = 'test repository Atom feed (default)';
+	$get_ok = $mech->get_ok('http://localhost/?p=.git;a=atom',
+		"GET $pagename");
+	skip "Could not get $pagename", 0 + $xml_parser_installed
+		unless $get_ok;
+
+	if ($xml_parser_installed) {
+		eval {
+			$xml_parser->parse($mech->content());
+		};
+		ok(! $@, "$pagename is well formed XML")
+			or diag($@);
+	}
+}
+
+SKIP: {
+	$pagename = 'list of repositories in OPML format';
+	$get_ok = $mech->get_ok('http://localhost/?a=opml',
+		"GET $pagename");
+	skip "Could not get $pagename", 0 + $xml_parser_installed
+		unless $get_ok;
+
+	if ($xml_parser_installed) {
+		eval {
+			$xml_parser->parse($mech->content());
+		};
+		ok(! $@, "$pagename is well formed XML")
+			or diag($@);
+	}
+}
+
 1;
 __END__
-- 
1.5.5.3
