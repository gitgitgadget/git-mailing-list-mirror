From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 4/8] Extract Git::SVN::Migration from git-svn.
Date: Thu, 26 Jul 2012 17:26:03 -0700
Message-ID: <1343348767-86446-5-git-send-email-schwern@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 02:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuYOc-0004ZF-5T
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 02:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2G0A0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 20:26:51 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33201 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2G0A0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 20:26:45 -0400
Received: by gglu4 with SMTP id u4so2631279ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LiZ+Bn1Ii0udJGqubOPbJI6ZbHU2Hk3MMXHj4ERnRvk=;
        b=NM7MIhRh0NrlagH4mXivdBP2zu7/ZMxzi/d2JZ33PG0ebR6R1wH6VTlSe4CO5up5Jb
         IKl3EPMG1aTpBPTaVmePdG+sShKAxoBOFTngldBp8n7S38TBl5B7npJI9aHA9OOJYAOg
         d/van9SQnf2MzzuBAOkCYTB1N65IicSEJtk3VEFe4c28746ivu5gXHUwsZBBjxQK3P3L
         BG7Pii77dkdvhpWr36m7B7Q9tExGyDeWDvEdr88fIVxO8ZLAK+RNUtmCkL1EPIjIq8QG
         WztNAfyoQVHhgAaoUpQhLe4cbmiDBhQ1hts+4+wlL0Ab8NzLwPhlw/coAo0bqHZAOVKp
         XLrQ==
Received: by 10.66.84.130 with SMTP id z2mr1105201pay.77.1343348804386;
        Thu, 26 Jul 2012 17:26:44 -0700 (PDT)
Received: from localhost.localdomain (c-76-105-239-160.hsd1.or.comcast.net. [76.105.239.160])
        by mx.google.com with ESMTPS id jz4sm692556pbc.17.2012.07.26.17.26.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 17:26:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
In-Reply-To: <1343348767-86446-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202328>

From: "Michael G. Schwern" <schwern@pobox.com>

Straight cut & paste.
---
 git-svn.perl              | 258 +---------------------------------------------
 perl/Git/SVN/Migration.pm | 258 ++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile             |   1 +
 t/Git-SVN/00compile.t     |   3 +-
 4 files changed, 262 insertions(+), 258 deletions(-)
 create mode 100644 perl/Git/SVN/Migration.pm

diff --git a/git-svn.perl b/git-svn.perl
index db60984..3741e2e 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -12,6 +12,7 @@ $VERSION = '@@GIT_VERSION@@';
 
 use Git::SVN;
 use Git::SVN::Log;
+use Git::SVN::Migration;
 use Git::SVN::Utils qw(fatal can_compress);
 
 use Git qw(
@@ -2042,263 +2043,6 @@ sub gc_directory {
 }
 
 
-package Git::SVN::Migration;
-# these version numbers do NOT correspond to actual version numbers
-# of git nor git-svn.  They are just relative.
-#
-# v0 layout: .git/$id/info/url, refs/heads/$id-HEAD
-#
-# v1 layout: .git/$id/info/url, refs/remotes/$id
-#
-# v2 layout: .git/svn/$id/info/url, refs/remotes/$id
-#
-# v3 layout: .git/svn/$id, refs/remotes/$id
-#            - info/url may remain for backwards compatibility
-#            - this is what we migrate up to this layout automatically,
-#            - this will be used by git svn init on single branches
-# v3.1 layout (auto migrated):
-#            - .rev_db => .rev_db.$UUID, .rev_db will remain as a symlink
-#              for backwards compatibility
-#
-# v4 layout: .git/svn/$repo_id/$id, refs/remotes/$repo_id/$id
-#            - this is only created for newly multi-init-ed
-#              repositories.  Similar in spirit to the
-#              --use-separate-remotes option in git-clone (now default)
-#            - we do not automatically migrate to this (following
-#              the example set by core git)
-#
-# v5 layout: .rev_db.$UUID => .rev_map.$UUID
-#            - newer, more-efficient format that uses 24-bytes per record
-#              with no filler space.
-#            - use xxd -c24 < .rev_map.$UUID to view and debug
-#            - This is a one-way migration, repositories updated to the
-#              new format will not be able to use old git-svn without
-#              rebuilding the .rev_db.  Rebuilding the rev_db is not
-#              possible if noMetadata or useSvmProps are set; but should
-#              be no problem for users that use the (sensible) defaults.
-use strict;
-use warnings;
-use Carp qw/croak/;
-use File::Path qw/mkpath/;
-use File::Basename qw/dirname basename/;
-
-our $_minimize;
-use Git qw(
-	command
-	command_noisy
-	command_output_pipe
-	command_close_pipe
-);
-
-sub migrate_from_v0 {
-	my $git_dir = $ENV{GIT_DIR};
-	return undef unless -d $git_dir;
-	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
-	my $migrated = 0;
-	while (<$fh>) {
-		chomp;
-		my ($id, $orig_ref) = ($_, $_);
-		next unless $id =~ s#^refs/heads/(.+)-HEAD$#$1#;
-		next unless -f "$git_dir/$id/info/url";
-		my $new_ref = "refs/remotes/$id";
-		if (::verify_ref("$new_ref^0")) {
-			print STDERR "W: $orig_ref is probably an old ",
-			             "branch used by an ancient version of ",
-				     "git-svn.\n",
-				     "However, $new_ref also exists.\n",
-				     "We will not be able ",
-				     "to use this branch until this ",
-				     "ambiguity is resolved.\n";
-			next;
-		}
-		print STDERR "Migrating from v0 layout...\n" if !$migrated;
-		print STDERR "Renaming ref: $orig_ref => $new_ref\n";
-		command_noisy('update-ref', $new_ref, $orig_ref);
-		command_noisy('update-ref', '-d', $orig_ref, $orig_ref);
-		$migrated++;
-	}
-	command_close_pipe($fh, $ctx);
-	print STDERR "Done migrating from v0 layout...\n" if $migrated;
-	$migrated;
-}
-
-sub migrate_from_v1 {
-	my $git_dir = $ENV{GIT_DIR};
-	my $migrated = 0;
-	return $migrated unless -d $git_dir;
-	my $svn_dir = "$git_dir/svn";
-
-	# just in case somebody used 'svn' as their $id at some point...
-	return $migrated if -d $svn_dir && ! -f "$svn_dir/info/url";
-
-	print STDERR "Migrating from a git-svn v1 layout...\n";
-	mkpath([$svn_dir]);
-	print STDERR "Data from a previous version of git-svn exists, but\n\t",
-	             "$svn_dir\n\t(required for this version ",
-	             "($::VERSION) of git-svn) does not exist.\n";
-	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
-	while (<$fh>) {
-		my $x = $_;
-		next unless $x =~ s#^refs/remotes/##;
-		chomp $x;
-		next unless -f "$git_dir/$x/info/url";
-		my $u = eval { ::file_to_s("$git_dir/$x/info/url") };
-		next unless $u;
-		my $dn = dirname("$git_dir/svn/$x");
-		mkpath([$dn]) unless -d $dn;
-		if ($x eq 'svn') { # they used 'svn' as GIT_SVN_ID:
-			mkpath(["$git_dir/svn/svn"]);
-			print STDERR " - $git_dir/$x/info => ",
-			                "$git_dir/svn/$x/info\n";
-			rename "$git_dir/$x/info", "$git_dir/svn/$x/info" or
-			       croak "$!: $x";
-			# don't worry too much about these, they probably
-			# don't exist with repos this old (save for index,
-			# and we can easily regenerate that)
-			foreach my $f (qw/unhandled.log index .rev_db/) {
-				rename "$git_dir/$x/$f", "$git_dir/svn/$x/$f";
-			}
-		} else {
-			print STDERR " - $git_dir/$x => $git_dir/svn/$x\n";
-			rename "$git_dir/$x", "$git_dir/svn/$x" or
-			       croak "$!: $x";
-		}
-		$migrated++;
-	}
-	command_close_pipe($fh, $ctx);
-	print STDERR "Done migrating from a git-svn v1 layout\n";
-	$migrated;
-}
-
-sub read_old_urls {
-	my ($l_map, $pfx, $path) = @_;
-	my @dir;
-	foreach (<$path/*>) {
-		if (-r "$_/info/url") {
-			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
-			my $ref_id = $pfx . basename $_;
-			my $url = ::file_to_s("$_/info/url");
-			$l_map->{$ref_id} = $url;
-		} elsif (-d $_) {
-			push @dir, $_;
-		}
-	}
-	foreach (@dir) {
-		my $x = $_;
-		$x =~ s!^\Q$ENV{GIT_DIR}\E/svn/!!o;
-		read_old_urls($l_map, $x, $_);
-	}
-}
-
-sub migrate_from_v2 {
-	my @cfg = command(qw/config -l/);
-	return if grep /^svn-remote\..+\.url=/, @cfg;
-	my %l_map;
-	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
-	my $migrated = 0;
-
-	require Git::SVN;
-	foreach my $ref_id (sort keys %l_map) {
-		eval { Git::SVN->init($l_map{$ref_id}, '', undef, $ref_id) };
-		if ($@) {
-			Git::SVN->init($l_map{$ref_id}, '', $ref_id, $ref_id);
-		}
-		$migrated++;
-	}
-	$migrated;
-}
-
-sub minimize_connections {
-	require Git::SVN;
-	require Git::SVN::Ra;
-
-	my $r = Git::SVN::read_all_remotes();
-	my $new_urls = {};
-	my $root_repos = {};
-	foreach my $repo_id (keys %$r) {
-		my $url = $r->{$repo_id}->{url} or next;
-		my $fetch = $r->{$repo_id}->{fetch} or next;
-		my $ra = Git::SVN::Ra->new($url);
-
-		# skip existing cases where we already connect to the root
-		if (($ra->{url} eq $ra->{repos_root}) ||
-		    ($ra->{repos_root} eq $repo_id)) {
-			$root_repos->{$ra->{url}} = $repo_id;
-			next;
-		}
-
-		my $root_ra = Git::SVN::Ra->new($ra->{repos_root});
-		my $root_path = $ra->{url};
-		$root_path =~ s#^\Q$ra->{repos_root}\E(/|$)##;
-		foreach my $path (keys %$fetch) {
-			my $ref_id = $fetch->{$path};
-			my $gs = Git::SVN->new($ref_id, $repo_id, $path);
-
-			# make sure we can read when connecting to
-			# a higher level of a repository
-			my ($last_rev, undef) = $gs->last_rev_commit;
-			if (!defined $last_rev) {
-				$last_rev = eval {
-					$root_ra->get_latest_revnum;
-				};
-				next if $@;
-			}
-			my $new = $root_path;
-			$new .= length $path ? "/$path" : '';
-			eval {
-				$root_ra->get_log([$new], $last_rev, $last_rev,
-			                          0, 0, 1, sub { });
-			};
-			next if $@;
-			$new_urls->{$ra->{repos_root}}->{$new} =
-			        { ref_id => $ref_id,
-				  old_repo_id => $repo_id,
-				  old_path => $path };
-		}
-	}
-
-	my @emptied;
-	foreach my $url (keys %$new_urls) {
-		# see if we can re-use an existing [svn-remote "repo_id"]
-		# instead of creating a(n ugly) new section:
-		my $repo_id = $root_repos->{$url} || $url;
-
-		my $fetch = $new_urls->{$url};
-		foreach my $path (keys %$fetch) {
-			my $x = $fetch->{$path};
-			Git::SVN->init($url, $path, $repo_id, $x->{ref_id});
-			my $pfx = "svn-remote.$x->{old_repo_id}";
-
-			my $old_fetch = quotemeta("$x->{old_path}:".
-			                          "$x->{ref_id}");
-			command_noisy(qw/config --unset/,
-			              "$pfx.fetch", '^'. $old_fetch . '$');
-			delete $r->{$x->{old_repo_id}}->
-			       {fetch}->{$x->{old_path}};
-			if (!keys %{$r->{$x->{old_repo_id}}->{fetch}}) {
-				command_noisy(qw/config --unset/,
-				              "$pfx.url");
-				push @emptied, $x->{old_repo_id}
-			}
-		}
-	}
-	if (@emptied) {
-		my $file = $ENV{GIT_CONFIG} || "$ENV{GIT_DIR}/config";
-		print STDERR <<EOF;
-The following [svn-remote] sections in your config file ($file) are empty
-and can be safely removed:
-EOF
-		print STDERR "[svn-remote \"$_\"]\n" foreach @emptied;
-	}
-}
-
-sub migration_check {
-	migrate_from_v0();
-	migrate_from_v1();
-	migrate_from_v2();
-	minimize_connections() if $_minimize;
-}
-
 package Git::IndexInfo;
 use strict;
 use warnings;
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
new file mode 100644
index 0000000..75d7429
--- /dev/null
+++ b/perl/Git/SVN/Migration.pm
@@ -0,0 +1,258 @@
+package Git::SVN::Migration;
+# these version numbers do NOT correspond to actual version numbers
+# of git nor git-svn.  They are just relative.
+#
+# v0 layout: .git/$id/info/url, refs/heads/$id-HEAD
+#
+# v1 layout: .git/$id/info/url, refs/remotes/$id
+#
+# v2 layout: .git/svn/$id/info/url, refs/remotes/$id
+#
+# v3 layout: .git/svn/$id, refs/remotes/$id
+#            - info/url may remain for backwards compatibility
+#            - this is what we migrate up to this layout automatically,
+#            - this will be used by git svn init on single branches
+# v3.1 layout (auto migrated):
+#            - .rev_db => .rev_db.$UUID, .rev_db will remain as a symlink
+#              for backwards compatibility
+#
+# v4 layout: .git/svn/$repo_id/$id, refs/remotes/$repo_id/$id
+#            - this is only created for newly multi-init-ed
+#              repositories.  Similar in spirit to the
+#              --use-separate-remotes option in git-clone (now default)
+#            - we do not automatically migrate to this (following
+#              the example set by core git)
+#
+# v5 layout: .rev_db.$UUID => .rev_map.$UUID
+#            - newer, more-efficient format that uses 24-bytes per record
+#              with no filler space.
+#            - use xxd -c24 < .rev_map.$UUID to view and debug
+#            - This is a one-way migration, repositories updated to the
+#              new format will not be able to use old git-svn without
+#              rebuilding the .rev_db.  Rebuilding the rev_db is not
+#              possible if noMetadata or useSvmProps are set; but should
+#              be no problem for users that use the (sensible) defaults.
+use strict;
+use warnings;
+use Carp qw/croak/;
+use File::Path qw/mkpath/;
+use File::Basename qw/dirname basename/;
+
+our $_minimize;
+use Git qw(
+	command
+	command_noisy
+	command_output_pipe
+	command_close_pipe
+);
+
+sub migrate_from_v0 {
+	my $git_dir = $ENV{GIT_DIR};
+	return undef unless -d $git_dir;
+	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
+	my $migrated = 0;
+	while (<$fh>) {
+		chomp;
+		my ($id, $orig_ref) = ($_, $_);
+		next unless $id =~ s#^refs/heads/(.+)-HEAD$#$1#;
+		next unless -f "$git_dir/$id/info/url";
+		my $new_ref = "refs/remotes/$id";
+		if (::verify_ref("$new_ref^0")) {
+			print STDERR "W: $orig_ref is probably an old ",
+			             "branch used by an ancient version of ",
+				     "git-svn.\n",
+				     "However, $new_ref also exists.\n",
+				     "We will not be able ",
+				     "to use this branch until this ",
+				     "ambiguity is resolved.\n";
+			next;
+		}
+		print STDERR "Migrating from v0 layout...\n" if !$migrated;
+		print STDERR "Renaming ref: $orig_ref => $new_ref\n";
+		command_noisy('update-ref', $new_ref, $orig_ref);
+		command_noisy('update-ref', '-d', $orig_ref, $orig_ref);
+		$migrated++;
+	}
+	command_close_pipe($fh, $ctx);
+	print STDERR "Done migrating from v0 layout...\n" if $migrated;
+	$migrated;
+}
+
+sub migrate_from_v1 {
+	my $git_dir = $ENV{GIT_DIR};
+	my $migrated = 0;
+	return $migrated unless -d $git_dir;
+	my $svn_dir = "$git_dir/svn";
+
+	# just in case somebody used 'svn' as their $id at some point...
+	return $migrated if -d $svn_dir && ! -f "$svn_dir/info/url";
+
+	print STDERR "Migrating from a git-svn v1 layout...\n";
+	mkpath([$svn_dir]);
+	print STDERR "Data from a previous version of git-svn exists, but\n\t",
+	             "$svn_dir\n\t(required for this version ",
+	             "($::VERSION) of git-svn) does not exist.\n";
+	my ($fh, $ctx) = command_output_pipe(qw/rev-parse --symbolic --all/);
+	while (<$fh>) {
+		my $x = $_;
+		next unless $x =~ s#^refs/remotes/##;
+		chomp $x;
+		next unless -f "$git_dir/$x/info/url";
+		my $u = eval { ::file_to_s("$git_dir/$x/info/url") };
+		next unless $u;
+		my $dn = dirname("$git_dir/svn/$x");
+		mkpath([$dn]) unless -d $dn;
+		if ($x eq 'svn') { # they used 'svn' as GIT_SVN_ID:
+			mkpath(["$git_dir/svn/svn"]);
+			print STDERR " - $git_dir/$x/info => ",
+			                "$git_dir/svn/$x/info\n";
+			rename "$git_dir/$x/info", "$git_dir/svn/$x/info" or
+			       croak "$!: $x";
+			# don't worry too much about these, they probably
+			# don't exist with repos this old (save for index,
+			# and we can easily regenerate that)
+			foreach my $f (qw/unhandled.log index .rev_db/) {
+				rename "$git_dir/$x/$f", "$git_dir/svn/$x/$f";
+			}
+		} else {
+			print STDERR " - $git_dir/$x => $git_dir/svn/$x\n";
+			rename "$git_dir/$x", "$git_dir/svn/$x" or
+			       croak "$!: $x";
+		}
+		$migrated++;
+	}
+	command_close_pipe($fh, $ctx);
+	print STDERR "Done migrating from a git-svn v1 layout\n";
+	$migrated;
+}
+
+sub read_old_urls {
+	my ($l_map, $pfx, $path) = @_;
+	my @dir;
+	foreach (<$path/*>) {
+		if (-r "$_/info/url") {
+			$pfx .= '/' if $pfx && $pfx !~ m!/$!;
+			my $ref_id = $pfx . basename $_;
+			my $url = ::file_to_s("$_/info/url");
+			$l_map->{$ref_id} = $url;
+		} elsif (-d $_) {
+			push @dir, $_;
+		}
+	}
+	foreach (@dir) {
+		my $x = $_;
+		$x =~ s!^\Q$ENV{GIT_DIR}\E/svn/!!o;
+		read_old_urls($l_map, $x, $_);
+	}
+}
+
+sub migrate_from_v2 {
+	my @cfg = command(qw/config -l/);
+	return if grep /^svn-remote\..+\.url=/, @cfg;
+	my %l_map;
+	read_old_urls(\%l_map, '', "$ENV{GIT_DIR}/svn");
+	my $migrated = 0;
+
+	require Git::SVN;
+	foreach my $ref_id (sort keys %l_map) {
+		eval { Git::SVN->init($l_map{$ref_id}, '', undef, $ref_id) };
+		if ($@) {
+			Git::SVN->init($l_map{$ref_id}, '', $ref_id, $ref_id);
+		}
+		$migrated++;
+	}
+	$migrated;
+}
+
+sub minimize_connections {
+	require Git::SVN;
+	require Git::SVN::Ra;
+
+	my $r = Git::SVN::read_all_remotes();
+	my $new_urls = {};
+	my $root_repos = {};
+	foreach my $repo_id (keys %$r) {
+		my $url = $r->{$repo_id}->{url} or next;
+		my $fetch = $r->{$repo_id}->{fetch} or next;
+		my $ra = Git::SVN::Ra->new($url);
+
+		# skip existing cases where we already connect to the root
+		if (($ra->{url} eq $ra->{repos_root}) ||
+		    ($ra->{repos_root} eq $repo_id)) {
+			$root_repos->{$ra->{url}} = $repo_id;
+			next;
+		}
+
+		my $root_ra = Git::SVN::Ra->new($ra->{repos_root});
+		my $root_path = $ra->{url};
+		$root_path =~ s#^\Q$ra->{repos_root}\E(/|$)##;
+		foreach my $path (keys %$fetch) {
+			my $ref_id = $fetch->{$path};
+			my $gs = Git::SVN->new($ref_id, $repo_id, $path);
+
+			# make sure we can read when connecting to
+			# a higher level of a repository
+			my ($last_rev, undef) = $gs->last_rev_commit;
+			if (!defined $last_rev) {
+				$last_rev = eval {
+					$root_ra->get_latest_revnum;
+				};
+				next if $@;
+			}
+			my $new = $root_path;
+			$new .= length $path ? "/$path" : '';
+			eval {
+				$root_ra->get_log([$new], $last_rev, $last_rev,
+			                          0, 0, 1, sub { });
+			};
+			next if $@;
+			$new_urls->{$ra->{repos_root}}->{$new} =
+			        { ref_id => $ref_id,
+				  old_repo_id => $repo_id,
+				  old_path => $path };
+		}
+	}
+
+	my @emptied;
+	foreach my $url (keys %$new_urls) {
+		# see if we can re-use an existing [svn-remote "repo_id"]
+		# instead of creating a(n ugly) new section:
+		my $repo_id = $root_repos->{$url} || $url;
+
+		my $fetch = $new_urls->{$url};
+		foreach my $path (keys %$fetch) {
+			my $x = $fetch->{$path};
+			Git::SVN->init($url, $path, $repo_id, $x->{ref_id});
+			my $pfx = "svn-remote.$x->{old_repo_id}";
+
+			my $old_fetch = quotemeta("$x->{old_path}:".
+			                          "$x->{ref_id}");
+			command_noisy(qw/config --unset/,
+			              "$pfx.fetch", '^'. $old_fetch . '$');
+			delete $r->{$x->{old_repo_id}}->
+			       {fetch}->{$x->{old_path}};
+			if (!keys %{$r->{$x->{old_repo_id}}->{fetch}}) {
+				command_noisy(qw/config --unset/,
+				              "$pfx.url");
+				push @emptied, $x->{old_repo_id}
+			}
+		}
+	}
+	if (@emptied) {
+		my $file = $ENV{GIT_CONFIG} || "$ENV{GIT_DIR}/config";
+		print STDERR <<EOF;
+The following [svn-remote] sections in your config file ($file) are empty
+and can be safely removed:
+EOF
+		print STDERR "[svn-remote \"$_\"]\n" foreach @emptied;
+	}
+}
+
+sub migration_check {
+	migrate_from_v0();
+	migrate_from_v1();
+	migrate_from_v2();
+	minimize_connections() if $_minimize;
+}
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 8493d76..ff83848 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -31,6 +31,7 @@ modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
 modules += Git/SVN/Editor
 modules += Git/SVN/Log
+modules += Git/SVN/Migration
 modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
diff --git a/t/Git-SVN/00compile.t b/t/Git-SVN/00compile.t
index 37626f4..1307b65 100644
--- a/t/Git-SVN/00compile.t
+++ b/t/Git-SVN/00compile.t
@@ -3,9 +3,10 @@
 use strict;
 use warnings;
 
-use Test::More tests => 4;
+use Test::More tests => 5;
 
 require_ok 'Git::SVN';
 require_ok 'Git::SVN::Utils';
 require_ok 'Git::SVN::Ra';
 require_ok 'Git::SVN::Log';
+require_ok 'Git::SVN::Migration';
-- 
1.7.11.1
