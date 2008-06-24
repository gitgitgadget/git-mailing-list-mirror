From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH v7] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 24 Jun 2008 04:18:53 +0200
Message-ID: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com>
References: <4860556F.5060206@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 04:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy8k-0007IA-Tk
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbYFXCTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbYFXCTG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:19:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:51605 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbYFXCTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:19:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1097269fgg.17
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=MdwEjbqPy7j571nVrve5fVi4OgbbS1kq8jb9hBIEOLE=;
        b=RXCnSMVnM6mjrKowNbJ1c+3zsfjMvdVBmbZiBk+oypRDLySLVm20mAxstGWsf4kXqw
         5cJ3BsG7ze9QiYCp0SRxg19OOGzzCojRBRReqv6Tvt381XWUWY3j1AADDFsWn7VxGHVM
         KDvWxnSzGfPumOjKn+vTqNBJTlKHKhq5QQ2Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=sGNP8wA/RbAJToz3hgpQwFs3XjpzUs+01ImhOQ06s4eFwkQNCUtoNwTlY4kYInUi6v
         8fo8rL4IREF8szcppQVC8RyeyBeu5ynF0QU7jn2b2dM8mVDd2ZhclDggt9qcPaccKkF7
         pLoOm0/hfcHz2XcK02qY5fqmgFsp8Yz1iJ8zE=
Received: by 10.86.72.15 with SMTP id u15mr1548199fga.29.1214273937946;
        Mon, 23 Jun 2008 19:18:57 -0700 (PDT)
Received: from fly ( [91.33.198.167])
        by mx.google.com with ESMTPS id 3sm10892861fge.3.2008.06.23.19.18.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 19:18:57 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KAy7R-00011h-CN; Tue, 24 Jun 2008 04:18:53 +0200
X-Mailer: git-send-email 1.5.6.109.g0c85.dirty
In-Reply-To: <4860556F.5060206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85981>

This test uses Test::WWW::Mechanize::CGI to check gitweb's output.  It
also uses HTML::Lint, XML::Parser, and Archive::Tar (if present, each)
to validate the HTML/XML/tgz output, and checks all links on the
tested pages if --long-tests is given.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changes since v6:

- Removed GITPERL again.

- Added some basic tests for the page contents of blob and blob_plain
  views.

- Incorporated Jakub's suggestions (see parent posts); in particular
  blame and feed views *do* get spidered now in --long-tests mode, but
  the spider tests are marked as TODO and thus don't cause the test
  suite to fail.

- Some minor (internal) changes: @files only contains blobs, not
  trees; improved the logic that avoids checking pages twice; die if
  test.pl is run directly rather than from the shell script.

 t/t9503-gitweb-Mechanize.sh |  132 +++++++++++++++
 t/t9503/test.pl             |  378 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 510 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503-gitweb-Mechanize.sh
 create mode 100755 t/t9503/test.pl

diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
new file mode 100755
index 0000000..6f7168e
--- /dev/null
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Jakub Narebski
+# Copyright (c) 2008 Lea Wiemann
+#
+
+# This test supports the --long-tests option.
+
+# This test only runs on Perl 5.8 and later versions, since
+# Test::WWW::Mechanize::CGI requires Perl 5.8.
+
+test_description='gitweb tests (using WWW::Mechanize)
+
+This test uses Test::WWW::Mechanize::CGI to test gitweb.'
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
+# gitweb configuration for tests
+
+our \$version = "current";
+our \$GIT = "$GIT_EXEC_PATH/git";
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
+our %feature;
+\$feature{'blame'}{'default'} = [1];
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
+test_external \
+	'test gitweb output' \
+	perl ../t9503/test.pl
+
+test_done
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
new file mode 100755
index 0000000..872dbfd
--- /dev/null
+++ b/t/t9503/test.pl
@@ -0,0 +1,378 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+# This test supports the --long-tests option.
+
+use warnings;
+use strict;
+
+use Cwd qw(abs_path);
+use File::Spec;
+use File::Temp;
+
+use Test::More qw(no_plan);
+use Test::WWW::Mechanize::CGI;
+
+die "this must be run by calling the t/t*.sh shell script(s)\n"
+    if Cwd->cwd !~ /trash directory$/;
+
+our $long_tests = $ENV{GIT_TEST_LONG}; # "our" so we can use "local $long_tests"
+
+eval { require Archive::Tar; };
+my $archive_tar_installed = !$@
+    or diag('Archive::Tar is not installed; no tests for valid snapshots');
+
+eval { require HTML::Lint; };
+my $html_lint_installed = !$@
+    or diag('HTML::Lint is not installed; no HTML validation tests');
+
+eval { require XML::Parser; };
+my $xml_parser_installed = !$@
+    or diag('XML::Parser is not installed; no tests for well-formed XML');
+
+sub rev_parse {
+	my $name = shift;
+	chomp(my $hash = `git rev-parse $name 2> /dev/null`);
+	$hash or undef;
+}
+
+sub get_type {
+	my $name = shift;
+	chomp(my $type = `git cat-file -t $name 2> /dev/null`);
+	$type or undef;
+}
+
+my @revisions = split /\s/, `git-rev-list --first-parent HEAD`;
+chomp(my @heads = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/heads`);
+chomp(my @tags = map { (split('/', $_))[2] } `git-for-each-ref --sort=-committerdate refs/tags`);
+chomp(my @root_entries = `git-ls-tree --name-only HEAD`);
+my @files = grep { get_type("HEAD:$_") eq 'blob' } @root_entries or die;
+
+my $gitweb = abs_path(File::Spec->catfile('..', '..', 'gitweb', 'gitweb.cgi'));
+
+# This subroutine was copied (and modified to work with blanks in the
+# application path) from WWW::Mechanize::CGI 0.3, which is licensed
+# 'under the same terms as perl itself' and thus GPL compatible.
+# http://rt.cpan.org/Ticket/Display.html?id=36654
+my $cgi = sub {
+	# Use exec, not the shell, to support embedded whitespace in
+	# the path to gitweb.cgi.
+	my $status = system $gitweb $gitweb;
+	my $value  = $status >> 8;
+
+	croak( qq/Failed to execute application '$gitweb'. Reason: '$!'/ )
+	    if ( $status == -1 );
+	croak( qq/Application '$gitweb' exited with value: $value/ )
+	    if ( $value > 0 );
+};
+
+my $mech = new Test::WWW::Mechanize::CGI;
+$mech->cgi($cgi);
+# On some systems(?) it's necessary to have %ENV here, otherwise the
+# CGI process won't get *any* of the current environment variables
+# (not even PATH, etc.)
+$mech->env(%ENV,
+	   GITWEB_CONFIG => $ENV{'GITWEB_CONFIG'},
+	   SCRIPT_FILENAME => $gitweb,
+	   $mech->env);
+
+# import config, predeclaring config variables
+our $site_name;
+require_ok($ENV{'GITWEB_CONFIG'})
+	or diag('Could not load gitweb config; some tests would fail');
+
+# Perform non-recursive checks on the current page, but do not check
+# the status code.
+my %verified_uris;
+sub _verify_page {
+	my ($uri, $fragment) = split '#', $mech->uri;
+	$mech->content_like(qr/(name|id)="$fragment"/,
+			    "[auto] fragment #$fragment exists ($uri)")
+	    if $fragment;
+
+	return 1 if $verified_uris{$uri};
+	$verified_uris{$uri} = 1;
+
+	# Internal errors yield 200 but cause gitweb.cgi to exit with
+	# non-zero exit code, which Mechanize::CGI translates to 500,
+	# so we don't really need to check for "Software error" here,
+	# provided that the test cases always check the status code.
+	#$mech->content_lacks('<h1>Software error:</h1>') or return 0;
+
+	# Validate.  This is fast, so we can do it even without
+	# $long_tests.
+	$mech->html_lint_ok('[auto] validate HTML') or return 0
+	    if $html_lint_installed && $mech->is_html;
+	my $content_type = $mech->response->header('Content-Type')
+	    or die "$uri does not have a Content-Type header";
+	if ($xml_parser_installed && $content_type =~ /xml/) {
+		eval { XML::Parser->new->parse($mech->content); };
+		ok(!$@, "[auto] check for XML well-formedness ($uri)") or diag($@);
+	}
+	if ($archive_tar_installed && $uri =~ /sf=tgz/) {
+		my $snapshot_file = File::Temp->new;
+		print $snapshot_file $mech->content;
+		close $snapshot_file;
+		my $t = Archive::Tar->new;
+		$t->read($snapshot_file->filename, 1);
+		ok($t->get_files, "[auto] valid tgz snapshot ($uri)");
+	}
+	# WebService::Validator::Feed::W3C would be nice to
+	# use, but it doesn't support direct input (as opposed
+	# to URIs) long enough for our feeds.
+
+	return 1;
+}
+
+# Verify and spider the current page, the latter only if --long-tests
+# (-l) is given.  Do not check the status code of the current page.
+my %spidered_uris;  # pages whose links have been checked
+my %status_checked_uris;  # verified pages whose status is known to be 2xx
+sub check_page {
+	_verify_page or return 0;
+	my $orig_url = $mech->uri;
+	if ($long_tests && !$spidered_uris{$mech->uri} ) {
+		$spidered_uris{$mech->uri} = 1;
+		for my $url (map { $_->url_abs } $mech->followable_links) {
+			if (!$status_checked_uris{$url}) {
+				$status_checked_uris{$url} = 1;
+				$mech->get_ok($url, "[auto] check link ($url)")
+				    or diag("broken link to $url on $orig_url");
+				_verify_page;
+				$mech->back;
+			}
+		}
+	}
+	return 1;
+}
+
+my $baseurl = "http://localhost";
+my ($params, $url, $pagedesc, $status);
+
+# test_page ( <params>, <page_description>, <expected_status> )
+# Example:
+# if (test_page('?p=.git;a=summary', 'repository summary')) {
+#     $mech->...;
+#     $mech->...;
+# }
+#
+# Test that the page can be opened, call _verify_page on it, and
+# return true if there was no test failure.  Also set the global
+# variables $params, $pagedesc, and $url for use in the if block.
+# Optionally pass a third parameter $status to test the HTTP status
+# code of the page (useful for error pages).  You can also pass a full
+# URL instead of just parameters as the first parameter.
+sub test_page {
+	($params, $pagedesc, $status) = @_;
+	$pagedesc = $pagedesc ? " -- $pagedesc" : '';
+	if($params =~ /^$baseurl/) {
+		$url = "$params";
+	} else {
+		$url = "$baseurl$params";
+	}
+	if ($status) {
+		$mech->get($url);
+	} else {
+		$mech->get_ok($url, "get $url$pagedesc") or return 0;
+	}
+	check_page or return 0;
+	if ($status) {
+		return is($mech->status, $status, "getting $url$pagedesc -- yields $status");
+	} else {
+		return 1;
+	}
+}
+
+# follow_link ( \%parms, $pagedesc )
+# Example: follow_link( { text => 'commit' }, 'first commit link')
+# Like test_page, but does not support status code testing.
+sub follow_link {
+	(my $parms, $pagedesc) = @_;
+	unless ($mech->follow_link_ok($parms, "follow link: $pagedesc")) {
+		diag("cannot follow link ($pagedesc) on page " . $mech->uri);
+		return 0;
+	}
+	$url = $mech->uri;
+	return check_page;
+}
+
+if (test_page '', 'project list (implicit)') {
+	$mech->title_like(qr!$site_name!,
+		"title contains $site_name");
+	$mech->content_contains('./t9503-gitweb-Mechanize.sh test repository', 
+		'lists test repository (by description)');
+}
+
+# Test repository summary: implicit, implicit with pathinfo, explicit.
+for my $sumparams ('?p=.git', '/.git', '?p=.git;a=summary') {
+	if (test_page $sumparams, 'repository summary') {
+		$mech->title_like(qr!$site_name.*\.git/summary!,
+				  "title contains $site_name and \".git/summary\"");
+	}
+}
+
+# Search form (on summary page).
+$mech->get_ok('?p=.git', 'get repository summary');
+if ($mech->submit_form_ok( { form_number => 1,
+			     fields => { 's' => 'Initial' }
+			   }, "submit search form (default)")) {
+	check_page;
+	$mech->content_contains('Initial commit',
+				'content contains searched commit');
+}
+
+test_page('?p=non-existent.git', 'non-existent project', 404);
+test_page('?p=.git;a=commit;h=non-existent', 'non-existent commit', 404);
+
+
+# Summary view
+
+# Check short log.  To do: Extract into separate test_short_log
+# function since the short log occurs on several pages.
+$mech->get_ok('?p=.git', 'get repository summary');
+for my $revision (@revisions[0..2]) {
+	for my $link_text qw( commit commitdiff tree snapshot ) {
+		ok($mech->find_link(url_abs_regex => qr/h=$revision/, text => $link_text), "$link_text link for $revision");
+	}
+}
+# Check that branches and tags are highlighted in green and yellow in
+# the shortlog.  We assume here that we are on master, so it should be
+# at the top.
+$mech->content_like(qr{<span [^>]*class="head"[^>]*>master</span>},
+		    'master branch is highlighted in shortlog');
+$mech->content_like(qr{<span [^>]*class="tag"[^>]*>$tags[0]</span>},
+		    "$tags[0] (most recent tag) is highlighted in shortlog");
+
+# Check heads.  (This should be extracted as well.)
+for my $head (@heads) {
+	for my $link_text qw( shortlog log tree ) {
+		ok($mech->find_link(url_abs_regex => qr{h=refs/heads/$head}, text => $link_text), "$link_text link for head '$head'");
+	}
+}
+
+# Check tags (assume we only have tags referring to commits).
+for my $tag (@tags) {
+	my $commit = rev_parse("$tag^{commit}");
+	ok($mech->find_link(url_abs_regex => qr{h=refs/tags/$tag}, text => 'shortlog'),
+	   "shortlog link for tag '$tag'");
+	ok($mech->find_link(url_abs_regex => qr{h=refs/tags/$tag}, text => 'log'),
+	   "log link for tag '$tag'");
+	ok($mech->find_link(url_abs_regex => qr{h=$commit}, text => 'commit'),
+	   "commit link for tag '$tag'");
+	# To do: Test tag link for tag objects.
+	# Why don't we have tree + snapshot links?
+}
+
+
+# RSS/Atom/OPML view
+# Simply retrieve and verify well-formedness, but don't spider.
+$mech->get_ok('?p=.git;a=atom', 'Atom feed') and _verify_page;
+$mech->get_ok('?p=.git;a=rss', 'RSS feed') and _verify_page;
+TODO: {
+	# Now spider -- but there are broken links.
+	# http://mid.gmane.org/485EB333.5070108@gmail.com
+	local $TODO = "fix broken links in Atom/RSS feeds";
+	test_page('?p=.git;a=atom', 'Atom feed');
+	test_page('?p=.git;a=rss', 'RSS feed');
+}
+test_page('?a=opml', 'OPML outline');
+
+
+# Commit view
+if (test_page('?p=.git;a=commit;h=master')) {
+	ok($mech->find_link(url_abs_regex => qr/a=tree/),
+	   "tree link on commit page ($url)");
+	$mech->content_like(qr/A U Thor/, "author mentioned on commit page ($url)");
+}
+
+
+# Commitdiff view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text_regex => qr/file added/i }, 'commit with added file') &&
+    follow_link( { text => 'commitdiff' }, 'commitdiff')) {
+	$mech->content_like(qr/new file with mode/, "commitdiff has diffstat ($url)");
+	$mech->content_like(qr/new file mode/, "commitdiff has diff ($url)");
+}
+
+
+# Tree view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'first tree link on page')) {
+	for my $file (@files) {
+		my $file_hash = rev_parse("HEAD:$file");
+		ok($mech->find_link(text => $file), "'$file' listed (and linked) in tree view ($url)");
+		for my $link_text qw( blob blame history raw ) {
+			my $link = $mech->find_link(url_abs_regex => qr/[^a-z]f=$file(;|$)/,
+						    text => $link_text);
+			ok($link, "'$file' file has $link_text link in tree view ($url)");
+		}
+	}
+	# To do: write tests for subtrees.  (Need to set up subtrees
+	# in t9503-gitweb-Mechanize.sh.)
+}
+
+
+# Blame view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'first tree link on page')) {
+	for my $blame_link ($mech->find_all_links(text => 'blame')) {
+		my $url = $blame_link->url;
+		$mech->get_ok($url, "get $url -- blame link on tree view")
+		    and _verify_page;
+		$mech->content_like(qr/A U Thor/,
+				    "author mentioned on blame page");
+		TODO: {
+			# Now spider -- but there are broken links.
+			# http://mid.gmane.org/485EC621.7090101@gmail.com
+			local $TODO = "fix broken links in certain blame views";
+			check_page;
+		}
+	}
+}
+
+
+# History view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'first tree link on page')) {
+	for my $history_link ($mech->find_all_links(text => 'history')) {
+		test_page($history_link->url, "follow history link from tree view");
+		# To do: Expand.
+	}
+}
+
+
+# Blob view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'first tree link on page')) {
+	for my $file (@files) {
+		if (follow_link( { text => $file, url_abs_regex => qr/a=blob/ },
+				 "\"$file\" (blob) entry on tree view")) {
+			chomp(my $first_line_regex = (`cat "$file"`)[0]);
+			$first_line_regex =~ s/ / |&nbsp;/g;
+			# Hope that the first line doesn't contain any
+			# HTML-escapable character.
+			$mech->content_like(qr/$first_line_regex/,
+					    "blob view contains first line of file ($url)");
+			$mech->back;
+		}
+	}
+}
+
+
+# Raw (blob_plain) view
+if ($mech->get_ok('?p=.git', 'get repository summary') &&
+    follow_link( { text => 'tree' }, 'first tree link on page')) {
+	for my $file (@files) {
+		if (follow_link( { text => 'raw', url_abs_regex => qr/[^a-z]f=$file(;|$)/ },
+				 "raw (blob_plain) entry for \"$file\" in tree view")) {
+			chomp(my $last_line = (`cat "$file"`)[-1]);
+			$mech->content_contains(
+				$last_line, "blob_plain view contains last line of file");
+			$mech->back;
+		}
+	}
+}
+
+
+1;
+__END__
-- 
1.5.6.109.g0c85.dirty
