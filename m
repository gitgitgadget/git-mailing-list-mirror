From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 5/5] Change the rest of the code to use the Git::SVN and Git::SVN::Ra url accessors.
Date: Fri, 27 Jul 2012 13:00:52 -0700
Message-ID: <1343419252-9447-6-git-send-email-schwern@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuqjD-0003Yv-Ex
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab2G0UB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:28 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:51730 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab2G0UBX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:23 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so3624617ghr.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Ia6EaAOkdY3jG4tgZbd2X+cQZHv3ZfzFQ7fYkbyOs8w=;
        b=qOd1FRnXGmUk0V9VhqEKoN3p/2bXBIHU9st3wUr2TyUtTOLHgZ6H2kbNWFY9Dj3KGZ
         xOVGjf/er4zSUm9WJ0YfeoMECA1YBlMLHk6u6OiyCuY7dggH57YfYZflcGDjDPl70md6
         hPmQTh5IJApreFvJT6Dm5QhSUQvqGnyHklb/U7vI5U3/w4U/zbsKWl19DAxcgUgglLwZ
         ingWMonw/uqyYHpv6ntsYalncO4IlvhFOtoXvmbT08ECBCOQLLzRlUywjzFyNfACHoT9
         IwAOF0VHa2EXrjE1oQhe7ZoXhQsw7rRq/gSpDuI5voeTzcD0IwWfn25aop1S/WfjELoM
         UioQ==
Received: by 10.66.78.9 with SMTP id x9mr7658917paw.84.1343419282987;
        Fri, 27 Jul 2012 13:01:22 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202373>

From: "Michael G. Schwern" <schwern@pobox.com>

Note: The structure returned from Git::SVN->read_all_remotes() does not appear to
contain objects, so I'm leaving them alone.

That's everything converted over to the url and path accessors.

No functional change.
---
 git-svn.perl              | 11 ++++++-----
 perl/Git/SVN.pm           | 11 ++++++-----
 perl/Git/SVN/Migration.pm |  6 +++---
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 039623e..de1ddd1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1395,7 +1395,7 @@ sub cmd_commit_diff {
 			fatal("Needed URL or usable git-svn --id in ",
 			      "the command-line\n", $usage);
 		}
-		$url = $gs->{url};
+		$url = $gs->url;
 		$svn_path = $gs->path;
 	}
 	unless (defined $_revision) {
@@ -1663,15 +1663,16 @@ sub complete_url_ls_init {
 			      "and a separate URL is not specified");
 		}
 	}
-	my $url = $ra->{url};
+	my $url = $ra->url;
 	my $gs = Git::SVN->init($url, undef, undef, undef, 1);
 	my $k = "svn-remote.$gs->{repo_id}.url";
 	my $orig_url = eval { command_oneline(qw/config --get/, $k) };
-	if ($orig_url && ($orig_url ne $gs->{url})) {
+	if ($orig_url && ($orig_url ne $gs->url)) {
 		die "$k already set: $orig_url\n",
-		    "wanted to set to: $gs->{url}\n";
+		    "wanted to set to: $gs->url\n";
 	}
-	command_oneline('config', $k, $gs->{url}) unless $orig_url;
+	command_oneline('config', $k, $gs->url) unless $orig_url;
+
 	my $remote_path = $gs->path . "/$repo_path";
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 	$remote_path =~ s#/+#/#g;
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index fc907a0..7913d8f 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -560,7 +560,7 @@ sub _set_svm_vars {
 		# username is of no interest
 		$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1};
 
-		my $replace = $ra->{url};
+		my $replace = $ra->url;
 		$replace .= "/$path" if length $path;
 
 		my $section = "svn-remote.$self->{repo_id}";
@@ -599,16 +599,17 @@ sub _set_svm_vars {
 	$path = $ra->{svn_path};
 	$ra = Git::SVN::Ra->new($ra->{repos_root});
 	while (length $path) {
-		unless ($tried{"$ra->{url}/$path"}) {
+		my $try = $ra->url ."/$path";
+		unless ($tried{$try}) {
 			$ok = $self->read_svm_props($ra, $path, $r);
 			last if $ok;
-			$tried{"$ra->{url}/$path"} = 1;
+			$tried{$try} = 1;
 		}
 		$path =~ s#/?[^/]+$##;
 	}
 	die "Path: '$path' should be ''\n" if $path ne '';
 	$ok ||= $self->read_svm_props($ra, $path, $r);
-	$tried{"$ra->{url}/$path"} = 1;
+	$tried{$ra->url ."/$path"} = 1;
 	if (!$ok) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
 	}
@@ -1108,7 +1109,7 @@ sub find_parent_branch {
 	}
 	my $r = $i->{copyfrom_rev};
 	my $repos_root = $self->ra->{repos_root};
-	my $url = $self->ra->{url};
+	my $url = $self->ra->url;
 	my $new_url = $url . $branch_from;
 	print STDERR  "Found possible branch point: ",
 	              "$new_url => ", $self->full_url, ", $r\n"
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index 75d7429..30daf35 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -177,14 +177,14 @@ sub minimize_connections {
 		my $ra = Git::SVN::Ra->new($url);
 
 		# skip existing cases where we already connect to the root
-		if (($ra->{url} eq $ra->{repos_root}) ||
+		if (($ra->url eq $ra->{repos_root}) ||
 		    ($ra->{repos_root} eq $repo_id)) {
-			$root_repos->{$ra->{url}} = $repo_id;
+			$root_repos->{$ra->url} = $repo_id;
 			next;
 		}
 
 		my $root_ra = Git::SVN::Ra->new($ra->{repos_root});
-		my $root_path = $ra->{url};
+		my $root_path = $ra->url;
 		$root_path =~ s#^\Q$ra->{repos_root}\E(/|$)##;
 		foreach my $path (keys %$fetch) {
 			my $ref_id = $fetch->{$path};
-- 
1.7.11.3
