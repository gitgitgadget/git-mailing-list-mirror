Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 28056 invoked by uid 111); 2 Oct 2008 15:13:38 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 02 Oct 2008 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbYJBPNY (ORCPT <rfc822;peff@peff.net>);
	Thu, 2 Oct 2008 11:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYJBPNX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:13:23 -0400
Received: from [212.249.11.140] ([212.249.11.140]:46504 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753401AbYJBPNW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:13:22 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 3B0262AC954; Thu,  2 Oct 2008 17:13:02 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <petr.baudis@novartis.com>
Subject: [PATCH] gitweb: Support for tag clouds
Date:	Thu,  2 Oct 2008 17:13:02 +0200
Message-Id: <1222960382-11619-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <"<1222957505-5150-1-git-send-email-pasky@suse.cz>">
References: <"<1222957505-5150-1-git-send-email-pasky@suse.cz>">
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The "Content tags" (nothing to do with usual Git tags!) are free-form
strings that are attached to random projects and displayed in the
well-known Web2.0-ish tag cloud above project list.

The feature will make use of HTML::TagCloud if available, but will
still display (less pretty) list of tags in case the module is not
installed.

The tagging itself is not done by gitweb - user-provided external
helper CGI needs to be provided; one example is the tagproj.cgi
of Girocco. This functionality might get integrated to gitweb
in the future.

The tags are stored one-per-file in ctags/ subdirectory. The reason
they are not stored in the project config file is that you usually
want to give anyone (even CGI scripts) permission to create new tags
and they are non-essential information, and thus you would make
the ctags/ subdirectory world-writable.

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---
 gitweb/gitweb.perl |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bd8124a..5ba094e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -275,6 +275,24 @@ our %feature = (
 	'forks' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Allow gitweb scan project content tags described in ctags/
+	# of project repository, and display the popular Web 2.0-ish
+	# "tag cloud" near the project list. Note that this is something
+	# COMPLETELY different from the normal Git tags.
+
+	# gitweb by itself can show existing tags, but it does not handle
+	# tagging itself; you need an external application for that.
+	# For an example script, check Girocco's cgi/tagproj.cgi.
+	# You may want to install the HTML::TagCloud Perl module to get
+	# a pretty tag cloud instead of just a list of tags.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'ctags'}{'default'} = ['path_to_tag_script'];
+	# Project specific override is not supported.
+	'ctags' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_check_feature {
@@ -1755,6 +1773,67 @@ sub git_get_project_description {
 	return $descr;
 }
 
+sub git_get_project_ctags {
+	my $path = shift;
+	my $ctags = {};
+
+	$git_dir = "$projectroot/$path";
+	foreach (<$git_dir/ctags/*>) {
+		open CT, $_ or next;
+		my $val = <CT>;
+		chomp $val;
+		close CT;
+		my $ctag = $_; $ctag =~ s#.*/##;
+		$ctags->{$ctag} = $val;
+	}
+	$ctags;
+}
+
+sub git_populate_project_tagcloud {
+	my $ctags = shift;
+
+	# First, merge different-cased tags; tags vote on casing
+	my %ctags_lc;
+	foreach (keys %$ctags) {
+		$ctags_lc{lc $_}->{count} += $ctags->{$_};
+		if (not $ctags_lc{lc $_}->{topcount}
+		    or $ctags_lc{lc $_}->{topcount} < $ctags->{$_}) {
+			$ctags_lc{lc $_}->{topcount} = $ctags->{$_};
+			$ctags_lc{lc $_}->{topname} = $_;
+		}
+	}
+
+	my $cloud;
+	if (eval { require HTML::TagCloud; 1; }) {
+		$cloud = HTML::TagCloud->new;
+		foreach (sort keys %ctags_lc) {
+			# Pad the title with spaces so that the cloud looks
+			# less crammed.
+			my $title = $ctags_lc{$_}->{topname};
+			$title =~ s/ /&nbsp;/g;
+			$title =~ s/^/&nbsp;/g;
+			$title =~ s/$/&nbsp;/g;
+			$cloud->add($title, $home_link."?by_tag=".$_, $ctags_lc{$_}->{count});
+		}
+	} else {
+		$cloud = \%ctags_lc;
+	}
+	$cloud;
+}
+
+sub git_show_project_tagcloud {
+	my ($cloud, $count) = @_;
+	print STDERR ref($cloud)."..\n";
+	if (ref $cloud eq 'HTML::TagCloud') {
+		return $cloud->html_and_css($count);
+	} else {
+		my @tags = sort { $cloud->{$a}->{count} <=> $cloud->{$b}->{count} } keys %$cloud;
+		return '<p align="center">' . join (', ', map {
+			"<a href=\"$home_link?by_tag=$_\">$cloud->{$_}->{topname}</a>"
+		} splice(@tags, 0, $count)) . '</p>';
+	}
+}
+
 sub git_get_project_url_list {
 	my $path = shift;
 
@@ -3573,6 +3652,7 @@ sub fill_project_list_info {
 	my ($projlist, $check_forks) = @_;
 	my @projects;
 
+	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
 		my (@activity) = git_get_last_activity($pr->{'path'});
@@ -3599,6 +3679,7 @@ sub fill_project_list_info {
 				$pr->{'forks'} = 0;
 			}
 		}
+		$show_ctags and $pr->{'ctags'} = git_get_project_ctags($pr->{'path'});
 		push @projects, $pr;
 	}
 
@@ -3645,6 +3726,18 @@ sub git_project_list_body {
 	$from = 0 unless defined $from;
 	$to = $#projects if (!defined $to || $#projects < $to);
 
+	my $show_ctags = gitweb_check_feature('ctags');
+	if ($show_ctags) {
+		my %ctags;
+		foreach my $p (@projects) {
+			foreach my $ct (keys %{$p->{'ctags'}}) {
+				$ctags{$ct} += $p->{'ctags'}->{$ct};
+			}
+		}
+		my $cloud = git_populate_project_tagcloud(\%ctags);
+		print git_show_project_tagcloud($cloud, 64);
+	}
+
 	print "<table class=\"project_list\">\n";
 	unless ($no_header) {
 		print "<tr>\n";
@@ -3663,8 +3756,10 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 	my $alternate = 1;
+	my $tagfilter = $cgi->param('by_tag');
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
+		next if $tagfilter and $show_ctags and not grep { lc $_ eq lc $tagfilter } keys %{$pr->{'ctags'}};
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -4086,6 +4181,20 @@ sub git_summary {
 		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
 	}
+
+	# Tag cloud
+	my $show_ctags = (gitweb_check_feature('ctags'))[0];
+	if ($show_ctags) {
+		my $ctags = git_get_project_ctags($project);
+		my $cloud = git_populate_project_tagcloud($ctags);
+		print "<tr id=\"metadata_ctags\"><td>Content tags:<br />";
+		print "</td>\n<td>" unless %$ctags;
+		print "<form action=\"$show_ctags\" method=\"post\"><input type=\"hidden\" name=\"p\" value=\"$project\" />Add: <input type=\"text\" name=\"t\" size=\"8\" /></form>";
+		print "</td>\n<td>" if %$ctags;
+		print git_show_project_tagcloud($cloud, 48);
+		print "</td></tr>";
+	}
+
 	print "</table>\n";
 
 	if (-s "$projectroot/$project/README.html") {
-- 
tg: (c5a1246..) t/tagcloud/tagcloud (depends on: vanilla/master t/summary/css-metadata)
