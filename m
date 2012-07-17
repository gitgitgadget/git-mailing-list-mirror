From: Michael G Schwern <schwern@pobox.com>
Subject: Extract Git classes from git-svn (5/10) (was Re: Fix git-svn tests
 for SVN 1.7.5.)
Date: Tue, 17 Jul 2012 16:14:22 -0700
Message-ID: <5005F1CE.7010207@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005B5EE.3050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 01:14:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrGyM-0004Bf-03
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab2GQXOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 19:14:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755078Ab2GQXOY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 19:14:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD4784EF;
	Tue, 17 Jul 2012 19:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=uATqe5eeDrdp
	AWwvmk6+v+6peHM=; b=YiP15/rSjAcAe272Tl4AaBo2TahBVl63Su2Ca6KBd9Vr
	TANsDLTnoFx5Y47sraJ1475GjZ9IYg8Ca8foEcuHiJORET74BNd8EnKsQlimSBhc
	zieGFKHBXqiF5NLs5toeelAT0zdhMCdT2GNfFzxUPojpTF3sJdd/wpiR0J/ggVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MgqJpR
	2xtZGpiuQftLFOFz9q55XifvZ+8t3TqNGgodI1maDayk4GaaQa1cIzeM01VJyoVp
	39zWECWZrAf3/zySRTOQbp7YzOPE3zp8K9xhnzP6vCo/ntT5cTDAql4o6EgLsODS
	7e67IUu4gcaK2qfrIANdbIgScQWppM027JiXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991C384EE;
	Tue, 17 Jul 2012 19:14:23 -0400 (EDT)
Received: from windhund.local (unknown [67.23.204.5]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 572ED84EC; Tue, 17 Jul
 2012 19:14:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:13.0)
 Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <5005B5EE.3050704@pobox.com>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 250CF6DC-D065-11E1-B7B4-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201630>

>From ab67ab421dbfd248b9a198b8cc1cd9944ba6178d Mon Sep 17 00:00:00 2001
From: "Michael G. Schwern" <schwern@pobox.com>
Date: Tue, 17 Jul 2012 15:46:44 -0700
Subject: [PATCH 06/11] Move Git::SVN::Migration into its own file.

Just a straight cut & paste, the fixes come next commit.
---
 git-svn.perl              | 246 ---------------------------------------------
 perl/Git/SVN/Migration.pm | 247 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 246 deletions(-)
 create mode 100644 perl/Git/SVN/Migration.pm

diff --git a/git-svn.perl b/git-svn.perl
index 7c8ca49..f2bf759 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2043,252 +2043,6 @@ sub gc_directory {
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
-use vars qw/$_minimize/;
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
index 0000000..082a788
--- /dev/null
+++ b/perl/Git/SVN/Migration.pm
@@ -0,0 +1,247 @@
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
+use vars qw/$_minimize/;
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
-- 
1.7.11.1
