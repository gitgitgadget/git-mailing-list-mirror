From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test gitweb output
Date: Sat, 14 Jun 2008 14:47:27 +0200
Message-ID: <200806141447.28052.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 14:48:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7VBJ-0002vi-FT
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 14:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbYFNMrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 08:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYFNMrh
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 08:47:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:26438 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbYFNMrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 08:47:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2526769fkq.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rlwbFR6Sw/M+syuIvGSzfxHkPifD6rH+rO0FsVXVgXg=;
        b=G4g3t+B/9jjWgZx7FwyVn4C+jawCP/C9SJ1QnFnIPP4nBLpZu3qoJxtmykVtlZOvNQ
         pVtCpCfpQuRkPbAh7doq+K069Ql/xBkyRC0mIGYi2kJUubn5J1SADUEse472AuPVJIYB
         Zh2fdkzKtj1xCZNaHu/9OFoKROZ6Ers8dY2Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=A5/CJM6ZDbc8KpMhnLSlFmEeMbnLkWZTLAdzfX+dV3DjliRxzdTWQRlhmcXIlAFz1o
         NuzeSETudA/519zRf7noEJQ47/IUomCmpLFypjGTdMzYSGOb4FAQjMnPhbQDgNRWITsn
         Bas338lFCzSEgHzZDfQ0l+TPFJUDTmwzxzN+c=
Received: by 10.78.177.3 with SMTP id z3mr1671186hue.12.1213447653737;
        Sat, 14 Jun 2008 05:47:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.60])
        by mx.google.com with ESMTPS id 3sm2518467hud.45.2008.06.14.05.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 05:47:32 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85012>

This test uses Perl module Test::WWW::Mechanize::CGI to check
gitweb output, using HTML::Lint (if present) to validate HTML.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Review, review, review!

This test requires test_external_without_stderr in t/test-lib.sh by
Lea Wiemann, send to git mailing list in
  [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr
  http://thread.gmane.org/gmane.comp.version-control.git/83415
  Message-Id: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
also present in git://repo.or.cz/git/gitweb-caching.git since commit
(currently) d28d31467db2ec5737948685ade281d5c0704a27.

This is very much work in progress; it uses Test::WWW::Mechanize::CGI 
Perl module (from CPAN), which makes writing tests checking form (but
not requiring exact details) of gitweb output.  The test driver, i.e.
t/t9503-gitweb-Mechanize.sh skips tests if they cannot be done; note
that it assumes that if one jas TWM::CGI module it also has all
modules it depends on (Test::WWW::Mechanize, HTTP::Request::AsCGI,...)
installed.

The alternatives would be to redo work of TWM::CGI using standard or
simply more common modules (LWP::* modules, HTTP::Request::AsCGI), or
(proposed during off-line discussion with Lea Wiemann) to create
expected output documents and diff (compare) literal output.  

The second solution has two disadvantages I can see.  First, it
freezes gitweb output format, making improvements more difficult.
Second, if there is change that invalidates some or all tests vectors,
you would have to regenerate those vectors from actual gitweb output
without having any tests to check this output; it would be quite easy
to put into test vectors errorneous output.

On the other hand current approach means much, much more tests.
It is also bit more challenging, because you have to find invariants
of the output and test that they are fullfilled.


NOTE: Currently test_external_without_stderr fails because when trying
to access URL for non-existent commit gitweb writes to STDERR; it is
not necessarily a bug because it is not written to web server logs (at
least in the case of Apache2).

NOTE!!!: RFC.  Work in progress.  YMMV.  Posted here to have Lea got
at least _some_ tests to check her GSoC work against, and have some
examples how such tests *might* be written (I have nearly next to no
experience in writing tests using Perl test infrastructure, and in
using Mechanize and Test::WWW::Mechanize::CGI).  I would really
appreciate comments from Perl experts here, or at least people with
more Perl experience than me.

 t/t9503-gitweb-Mechanize.sh |  127 +++++++++++++++++++++++++++++++++++++++++++
 t/t9503/test.pl             |   91 +++++++++++++++++++++++++++++++
 2 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..5df22c4
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,127 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jakub Narebski
+#
+
+test_description='gitweb as CGI (using WWW::Mechanize)
+
+This test uses Perl module Test::WWW::Mechanize::CGI to
+check gitweb output, using HTML::Lint to validate HTML.'
+
+# helper functions
+
+safe_chmod () {
+	chmod "$1" "$2" &&
+	if [ "$(git config --get core.filemode)" = false ]
+	then
+		git update-index --chmod="$1" "$2"
+	fi
+}
+
+. ./test-lib.sh
+
+# check if test can be run
+perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, perl version is too old' :
+	test_done
+	exit
+}
+
+perl -MTest::WWW::Mechanize::CGI -e '' >/dev/null 2>&1 || {
+	test_expect_success \
+		'skipping gitweb tests, Test::WWW::Mechanize::CGI not found' :
+	test_done
+	exit
+}
+
+# set up test repository
+test_expect_success 'set up test repository' '
+
+	echo "Not an empty file." > file &&
+	git add file &&
+	test_tick && git commit -a -m "Initial commit." &&
+	git branch b &&
+
+	echo "New file" > new_file &&
+	git add new_file &&
+	test_tick && git commit -a -m "File added." &&
+
+	safe_chmod +x new_file &&
+	test_tick && git commit -a -m "Mode changed." &&
+
+	git mv new_file renamed_file &&
+	test_tick && git commit -a -m "File renamed." &&
+
+	rm renamed_file &&
+	ln -s file renamed_file &&
+	test_tick && git commit -a -m "File to symlink." &&
+	git tag with-symlink &&
+
+	git rm renamed_file &&
+	rm -f renamed_file &&
+	test_tick && git commit -a -m "File removed." &&
+
+	cp file file2 &&
+	git add file2 &&
+	test_tick && git commit -a -m "File copied." &&
+
+	echo "New line" >> file2 &&
+	safe_chmod +x file2 &&
+	test_tick && git commit -a -m "Mode change and modification." &&
+
+	git checkout b &&
+	echo "Branch" >> b &&
+	git add b &&
+	test_tick && git commit -a -m "On branch" &&
+	git checkout master &&
+	test_tick && git pull . b
+'
+
+# set up empty repository
+# TODO!
+
+# set up repositories for gitweb
+# TODO!
+
+# set up gitweb configuration
+safe_pwd="$(perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
+cat >gitweb_config.perl <<EOF
+#!/usr/bin/perl
+
+# gitweb configuration for tests
+
+our \$version = "current";
+our \$GIT = "git";
+our \$projectroot = "$safe_pwd";
+our \$project_maxdepth = 8;
+our \$home_link_str = "projects";
+our \$site_name = "[localhost]";
+our \$site_header = "";
+our \$site_footer = "";
+our \$home_text = "indextext.html";
+our @stylesheets = ("file:///$safe_pwd/../../gitweb/gitweb.css");
+our \$logo = "file:///$safe_pwd/../../gitweb/git-logo.png";
+our \$favicon = "file:///$safe_pwd/../../gitweb/git-favicon.png";
+our \$projects_list = "";
+our \$export_ok = "";
+our \$strict_export = "";
+
+1;
+__END__
+EOF
+
+cat >.git/description <<EOF
+$0 test repository
+EOF
+
+GITWEB_CONFIG="$(pwd)/gitweb_config.perl"
+export GITWEB_CONFIG
+
+# run tests
+
+test_external_without_stderr \
+	'test gitweb output' \
+	perl ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..7d081b9
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,91 @@
+#!/usr/bin/perl
+
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Cwd qw(abs_path);
+use File::Spec;
+use Test::More qw(no_plan);
+use Test::WWW::Mechanize::CGI;
+
+eval { require HTML::Lint };
+my $lint_installed = !$@;
+diag('HTML::Lint is not installed; no HTML validation tests')
+	unless $lint_installed;
+
+my $gitweb = File::Spec->catfile('..','..','gitweb','gitweb.perl');
+# the followin two lines of code are workaround for bug in
+# Test::WWW::Mechanize::CGI::cgi_application version up to 0.3
+# (http://rt.cpan.org/Ticket/Display.html?id=36654)
+# for pathnames with spaces (because of "trash directory")
+$gitweb = File::Spec->rel2abs($gitweb);
+$gitweb = Cwd::abs_path($gitweb);
+
+my $mech = new Test::WWW::Mechanize::CGI;
+$mech->cgi_application($gitweb);
+$mech->env(GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'});
+
+# import config, pedeclaring config variables
+our $site_name = '';
+require_ok($ENV{'GITWEB_CONFIG'})
+	or diag('Could not load gitweb config; some tests would fail');
+
+my $pagename = '';
+my $get_ok;
+SKIP: {
+	$pagename = 'project list (implicit)';
+	skip "Could not get $pagename", 2 + $lint_installed
+		unless $mech->get_ok('http://localhost/', "GET $pagename");
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->title_like(qr!$site_name!,
+		'title contains $site_name');
+	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
+		'lists test repository (by description)');
+}
+
+$mech->get_ok('http://localhost/?p=.git',
+	'GET test repository summary (implicit)');
+$mech->get_ok('http://localhost/.git',
+	'GET test repository summary (implicit, pathinfo)');
+$get_ok = 0;
+SKIP: {
+	$pagename = 'test repository summary (explicit)';
+	$get_ok = $mech->get_ok('http://localhost/?p=.git;a=summary',
+		"GET $pagename");
+	skip "Could not get $pagename", 1 + $lint_installed
+		unless $get_ok;
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->title_like(qr!$site_name.*\.git/summary!,
+		'title contains $site_name and ".git/summary"');
+}
+
+SKIP: {
+	skip "Could not get starting page $pagename", 2 + $lint_installed
+		unless $get_ok;
+	$pagename = 'search test repository (from search form)';
+	$get_ok = $mech->submit_form_ok(
+		{form_number=>1,
+		 fields=> {'s' => 'Initial commit'}
+		},
+		"submit search form (default)");
+	skip "Could not submit search form", 1 + $lint_installed
+		unless $get_ok;
+	$mech->html_lint_ok('page validates') if $lint_installed;
+	$mech->content_contains('Initial commit',
+		'content contains searched text');
+}
+
+$pagename = 'non existent project';
+$mech->get('http://localhost/?p=non-existent.git');
+like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
+$mech->html_lint_ok('page validates') if $lint_installed;
+
+$pagename = 'non existent commit';
+$mech->get('http://localhost/?p=.git;a=commit;h=non-existent');
+like($mech->status, qr/40[0-9]/, "40x status response for $pagename");
+$mech->html_lint_ok('page validates') if $lint_installed;
+
+1;
+__END__
-- 
1.5.5.3
