From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 7/8] Turn on canonicalization on newly minted URLs.
Date: Sat, 28 Jul 2012 02:47:51 -0700
Message-ID: <1343468872-72133-8-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3dv-0005QI-6C
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab2G1Jsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42332 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab2G1JsL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503059pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wJx5V0nt80Ac3ETvpFpXVSBUZuuMG4KLi3e4hHSRmgg=;
        b=SL0dwBDWa8i36Jzyg82ZIPwBjJ3bj2y5ZJ8+XFV/gHwAFDsOrJXnNG+GcstyPYt6vH
         AtHLtjiNcM90eau52Sa3FSt6dlZCK5iyV2BX/1QhQGt1Gbii5VGklYbeZK2rh1y+uwlH
         +z4DMCvgkhsNKF9b9hFRsmhtweZfTGpwcgMD6PepYzEZh5iJB1I4HXWpYuUuVBo0vmV4
         LQHQrc7fXwPTukSNmADnK+LqzQL8xniMIfa3SGOmt/GbJtlmmYouo+KToIykIpRJvz/l
         lZeJL4EGino2BkucxbALfvbxjqFqcOsq883EFEG2/qz1pery3nOhldBk++V2nG4y3VjF
         vasQ==
Received: by 10.68.219.166 with SMTP id pp6mr20421332pbc.35.1343468891324;
        Sat, 28 Jul 2012 02:48:11 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202424>

From: "Michael G. Schwern" <schwern@pobox.com>

Go through all the spots that use the new add_path_to_url() to
make a new URL and canonicalize them.

* copyfrom_path has to be canonicalized else find_parent_branch
  will get confused

* due to the `canonicalize_url($full_url) ne $full_url)` line of
  logic in gs_do_switch(), $full_url is left alone until after.

At this point SVN 1.7 passes except for 3 tests in
t9100-git-svn-basic.sh that look like an SVN bug to do with
symlinks.
---
 perl/Git/SVN.pm    | 19 ++++++++++++++-----
 perl/Git/SVN/Ra.pm |  9 ++++++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 22bf207..e5f7acc 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -362,6 +362,8 @@ sub init_remote_config {
 sub find_by_url { # repos_root and, path are optional
 	my ($class, $full_url, $repos_root, $path) = @_;
 
+	$full_url = canonicalize_url($full_url);
+
 	return undef unless defined $full_url;
 	remove_username($full_url);
 	remove_username($repos_root) if defined $repos_root;
@@ -400,6 +402,11 @@ sub find_by_url { # repos_root and, path are optional
 			}
 			$p =~ s#^\Q$z\E(?:/|$)#$prefix# or next;
 		}
+
+		# remote fetch paths are not URI escaped.  Decode ours
+		# so they match
+		$p = uri_decode($p);
+
 		foreach my $f (keys %$fetch) {
 			next if $f ne $p;
 			return Git::SVN->new($fetch->{$f}, $repo_id, $f);
@@ -934,18 +941,18 @@ sub rewrite_uuid {
 sub metadata_url {
 	my ($self) = @_;
 	my $url = $self->rewrite_root || $self->url;
-	return add_path_to_url( $url, $self->path );
+	return canonicalize_url( add_path_to_url( $url, $self->path ) );
 }
 
 sub full_url {
 	my ($self) = @_;
-	return add_path_to_url( $self->url, $self->path );
+	return canonicalize_url( add_path_to_url( $self->url, $self->path ) );
 }
 
 sub full_pushurl {
 	my ($self) = @_;
 	if ($self->{pushurl}) {
-		return add_path_to_url( $self->{pushurl}, $self->path );
+		return canonicalize_url( add_path_to_url( $self->{pushurl}, $self->path ) );
 	} else {
 		return $self->full_url;
 	}
@@ -1113,7 +1120,7 @@ sub find_parent_branch {
 	my $r = $i->{copyfrom_rev};
 	my $repos_root = $self->ra->{repos_root};
 	my $url = $self->ra->url;
-	my $new_url = add_path_to_url( $url, $branch_from );
+	my $new_url = canonicalize_url( add_path_to_url( $url, $branch_from ) );
 	print STDERR  "Found possible branch point: ",
 	              "$new_url => ", $self->full_url, ", $r\n"
 	              unless $::_q > 1;
@@ -1869,7 +1876,9 @@ sub make_log_entry {
 		$email ||= "$author\@$uuid";
 		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
-		my $full_url = add_path_to_url( $self->svnsync->{url}, $self->path );
+		my $full_url = canonicalize_url(
+			add_path_to_url( $self->svnsync->{url}, $self->path )
+		);
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 788e642..29b46e8 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -5,6 +5,7 @@ use warnings;
 use SVN::Client;
 use Git::SVN::Utils qw(
 	canonicalize_url
+	canonicalize_path
 	add_path_to_url
 );
 
@@ -102,6 +103,7 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
+
 	my $self = SVN::Ra->new(url => $url, auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
@@ -200,6 +202,7 @@ sub get_log {
 				qw/copyfrom_path copyfrom_rev action/;
 			if ($s{'copyfrom_path'}) {
 				$s{'copyfrom_path'} =~ s/$prefix_regex//;
+				$s{'copyfrom_path'} = canonicalize_path($s{'copyfrom_path'});
 			}
 			$_[0]{$p} = \%s;
 		}
@@ -303,7 +306,11 @@ sub gs_do_switch {
 		$ra = Git::SVN::Ra->new($full_url);
 		$ra_invalid = 1;
 	} elsif ($old_url ne $full_url) {
-		SVN::_Ra::svn_ra_reparent($self->{session}, $full_url, $pool);
+		SVN::_Ra::svn_ra_reparent(
+			$self->{session},
+			canonicalize_url($full_url),
+			$pool
+		);
 		$self->url($full_url);
 		$reparented = 1;
 	}
-- 
1.7.11.3
