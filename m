X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: use do_switch for --follow-parent if the SVN library supports it
Date: Fri, 8 Dec 2006 02:20:17 -0800
Message-ID: <20061208102017.GA30955@soma>
References: <20061205051738.16552.8987.stgit@localhost> <20061205051738.16552.22494.stgit@localhost> <20061205085804.GB27236@soma> <45775E52.90102@vilain.net> <20061207200236.GB8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 10:20:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061207200236.GB8179@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33678>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GscqD-000850-99 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425328AbWLHKUV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425329AbWLHKUU
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:20:20 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47069 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425328AbWLHKUT
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:20:19 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 221FD2DC034; Fri,  8 Dec 2006 02:20:18 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:20:17 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

do_switch works with the SVN Perl bindings after r22312 in the
Subversion trunk.  Since no released version of SVN currently
supports it; we'll just autodetect it and enable its usage
when a user has a recent-enough version of SVN.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
Eric Wong <normalperson@yhbt.net> wrote:
> For the git-svn in master using the delta fetcher; there's no additional
> overhead to fetch properties.  I want to ditch the old non-delta
> fetching code (it's only a mild performance benefit when using local
> repositories) if I could get do_switch() working correctly.

 I don't think I can ditch the old code anytime soon.  I was tempted to
 try using do_diff, but it appears SVN downloads the entire files (using
 get_file) and generates the diffs locally, negating any bandwidth
 saving it would have over the libsvn_fetch_full() path.

 git-svn.perl |   46 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 747daf0..c907eb9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -72,7 +72,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_username, $_config_dir, $_no_auth_cache, $_xfer_delta,
 	$_pager, $_color);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
-my ($_svn_co_url_revs, $_svn_pg_peg_revs);
+my ($_svn_co_url_revs, $_svn_pg_peg_revs, $_svn_can_do_switch);
 my @repo_path_split_cache;
 
 my %fc_opts = ( 'no-ignore-externals' => \$_no_ignore_ext,
@@ -2877,6 +2877,24 @@ sub libsvn_connect {
 	return $ra;
 }
 
+sub libsvn_can_do_switch {
+	unless (defined $_svn_can_do_switch) {
+		my $pool = SVN::Pool->new;
+		my $rep = eval {
+			$SVN->do_switch(1, '', 0, $SVN->{url},
+			                SVN::Delta::Editor->new, $pool);
+		};
+		if ($@) {
+			$_svn_can_do_switch = 0;
+		} else {
+			$rep->abort_report($pool);
+			$_svn_can_do_switch = 1;
+		}
+		$pool->clear;
+	}
+	$_svn_can_do_switch;
+}
+
 sub libsvn_dup_ra {
 	my ($ra) = @_;
 	SVN::Ra->new(map { $_ => $ra->{$_} } qw/config url
@@ -3198,12 +3216,26 @@ sub libsvn_find_parent_branch {
 		unlink $GIT_SVN_INDEX;
 		print STDERR "Found branch parent: ($GIT_SVN) $parent\n";
 		sys(qw/git-read-tree/, $parent);
-		# I can't seem to get do_switch() to work correctly with
-		# the SWIG interface (TypeError when passing switch_url...),
-		# so we'll unconditionally bypass the delta interface here
-		# for now
-		return libsvn_fetch_full($parent, $paths, $rev,
-					$author, $date, $msg);
+		unless (libsvn_can_do_switch()) {
+			return libsvn_fetch_full($parent, $paths, $rev,
+						$author, $date, $msg);
+		}
+		# do_switch works with svn/trunk >= r22312, but that is not
+		# included with SVN 1.4.2 (the latest version at the moment),
+		# so we can't rely on it.
+		my $ra = libsvn_connect("$url/$branch_from");
+		my $ed = SVN::Git::Fetcher->new({c => $parent, q => $_q});
+		my $pool = SVN::Pool->new;
+		my $reporter = $ra->do_switch($rev, '', 1, $SVN->{url},
+		                              $ed, $pool);
+		my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef) : ();
+		$reporter->set_path('', $r0, 0, @lock, $pool);
+		$reporter->finish_report($pool);
+		$pool->clear;
+		unless ($ed->{git_commit_ok}) {
+			die "SVN connection failed somewhere...\n";
+		}
+		return libsvn_log_entry($rev, $author, $date, $msg, [$parent]);
 	}
 	print STDERR "Nope, branch point not imported or unknown\n";
 	return undef;
-- 
