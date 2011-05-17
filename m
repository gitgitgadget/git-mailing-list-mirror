From: Ray Chen <rchen@cs.umd.edu>
Subject: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Tue, 17 May 2011 18:00:35 -0400
Message-ID: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
Cc: Eric Wong <normalperson@yhbt.net>, Ray Chen <rchen@cs.umd.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 00:00:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMSJr-0001x9-7b
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab1EQWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 18:00:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49328 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab1EQWAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 18:00:39 -0400
Received: by qwk3 with SMTP id 3so499238qwk.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=yQL6qeQWmrDYka9RioJDymXJJgGgMwDGpLWVITCaG3U=;
        b=aqxlY8ytOHaVq+BS+RgTH7i/3AcpcXhGXbhD6Pru3VodkpTPHIEAGxzi/Qv9FqL76h
         b/vfpHXReKDVom1sVLlUpvZK5hoptMJaUEFANGvIEDR9E977mg9IwevYiHOYp9cIIMO7
         wzyaCmXImz3QDNblUXf/hEA8c+jpo6uhTcEZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=GxZTBqLLgKf9ibzwZKTeQrS4zJLPm02b7GnjEg3aNA6Eqo4KF8TDN8HqD4ISKtrKH8
         EIREV0Llj8TivPDKv8egJ7WVBbsmL0/VSqV+hEVFHWZZln1XlW9fJU+R9c1I/XXYbGdZ
         pXRi0cVR0Oo16IzBi41esGS5/UFhFXk9TwO4o=
Received: by 10.224.76.76 with SMTP id b12mr878445qak.330.1305669639085;
        Tue, 17 May 2011 15:00:39 -0700 (PDT)
Received: from localhost.localdomain (c-76-21-241-143.hsd1.md.comcast.net [76.21.241.143])
        by mx.google.com with ESMTPS id m13sm564084qcu.40.2011.05.17.15.00.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 May 2011 15:00:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173827>

Adds the --preserve-empty-dirs flag to the clone and fetch operations that
will detect empty SVN directories, and create a placeholder file within them.
This allows "empty" directories to exist in the history of a Git repository.

Also adds the --placeholder-file flag to control the name of any placeholder
files created.  Default value is ".gitignore".

Signed-off-by: Ray Chen <rchen@cs.umd.edu>
---

I needed this functionality when I was migrating a repository from SVN to
Git.  It seems well known that Git only tracks files, not directories, so
any revision I checked out would be missing the empty directories that
existed in the SVN repository.

My knowledge of SVN is limited, so I'm not sure how correct this patch is.
I created a little test SVN repo, and `git svn clone --preserve-empty-dirs`
did the right thing, but that's hardly a complete test.

Specifically, I experimentally noticed that my patch worked with lines 4532
and 4533 commented out.  I'm not sure what problems might occur when adding
a file Git without associated SVN properties.

Finally, I added the --preserve-empty-dirs and --placeholder-file only to
the clone and fetch operations.  Is that appropriate?  The functionality
is really only applicable to full migrations.  I'm not sure that the fetch
operation should have it.

 git-svn.perl |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0fd2fd2..64a4607 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -89,6 +89,7 @@ my ($_stdin, $_help, $_edit,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag, $_merge_info);
 $Git::SVN::_follow_parent = 1;
+$SVN::Git::Fetcher::_placeholder_filename = ".gitignore";
 $_q ||= 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
@@ -134,11 +135,19 @@ my %cmt_opts = ( 'edit|e' => \$_edit,
 my %cmd = (
 	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision,
+			  'preserve-empty-dirs' =>
+				\$SVN::Git::Fetcher::_preserve_empty_dirs,
+			  'placeholder-filename=s' =>
+				\$SVN::Git::Fetcher::_placeholder_filename,
 			  'fetch-all|all' => \$_fetch_all,
 			  'parent|p' => \$_fetch_parent,
 			   %fc_opts } ],
 	clone => [ \&cmd_clone, "Initialize and fetch revisions",
 			{ 'revision|r=s' => \$_revision,
+			  'preserve-empty-dirs' =>
+				\$SVN::Git::Fetcher::_preserve_empty_dirs,
+			  'placeholder-filename=s' =>
+				\$SVN::Git::Fetcher::_placeholder_filename,
 			   %fc_opts, %init_opts } ],
 	init => [ \&cmd_init, "Initialize a repo for tracking" .
 			  " (requires URL argument)",
@@ -4076,12 +4085,12 @@ sub _read_password {
 }
 
 package SVN::Git::Fetcher;
-use vars qw/@ISA/;
+use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename/;
 use strict;
 use warnings;
 use Carp qw/croak/;
+use File::Basename qw/dirname/;
 use IO::File qw//;
-use vars qw/$_ignore_regex/;
 
 # file baton members: path, mode_a, mode_b, pool, fh, blob, base
 sub new {
@@ -4100,6 +4109,7 @@ sub new {
 	$self->{file_prop} = {};
 	$self->{absent_dir} = {};
 	$self->{absent_file} = {};
+	$self->{deleted_gpath} = [];
 	$self->{gii} = $git_svn->tmp_index_do(sub { Git::IndexInfo->new });
 	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	$self;
@@ -4223,6 +4233,7 @@ sub delete_entry {
 		$self->{gii}->remove($gpath);
 		print "\tD\t$gpath\n" unless $::_q;
 	}
+	push @{$self->{deleted_gpath}}, $gpath;
 	$self->{empty}->{$path} = 0;
 	undef;
 }
@@ -4273,6 +4284,7 @@ sub add_directory {
 			chomp;
 			$self->{gii}->remove($_);
 			print "\tD\t$_\n" unless $::_q;
+			push @{$self->{deleted_gpath}}, $gpath;
 		}
 		command_close_pipe($ls, $ctx);
 		$self->{empty}->{$path} = 0;
@@ -4443,12 +4455,87 @@ sub abort_edit {
 
 sub close_edit {
 	my $self = shift;
+
+	if ($_preserve_empty_dirs) {
+		my @empty_dirs;
+
+		# Any entry flagged as empty that also has an associated
+		# dir_prop represents a newly created empty directory.
+		foreach my $i (keys %{$self->{empty}}) {
+			push @empty_dirs, $i if exists $self->{dir_prop}->{$i};
+		}
+
+		# Search for directories that have become empty due subsequent
+		# file deletes.
+		push @empty_dirs, $self->find_empty_directories();
+
+		# Finally, add a placeholder file to each empty directory.
+		$self->add_placeholder_file($_) foreach (@empty_dirs);
+	}
+
 	$self->{git_commit_ok} = 1;
 	$self->{nr} = $self->{gii}->{nr};
 	delete $self->{gii};
 	$self->SUPER::close_edit(@_);
 }
 
+sub find_empty_directories {
+	my ($self) = @_;
+	my @empty_dirs;
+	my %dirs = map { dirname($_) => 1 } @{$self->{deleted_gpath}};
+
+	foreach my $dir (sort keys %dirs) {
+		next if $dir eq ".";
+
+		# If there have been any additions to this directory, there is
+		# no reason to check if it is empty.
+		my $skip_added = 0;
+		foreach my $t (qw/dir_prop file_prop/) {
+			foreach my $path (keys %{ $self->{$t} }) {
+				if (exists $self->{$t}->{dirname($path)}) {
+					$skip_added = 1;
+					last;
+				}
+			}
+			last if $skip_added;
+		}
+		next if $skip_added;
+
+		# Use `git ls-tree` to get the filenames of this directory
+		# that existed prior to this particular commit.
+		my $ls = command('ls-tree', '-z', '--name-only',
+				 $self->{c}, "$dir/");
+		my %files = map { $_ => 1 } split(/\0/, $ls);
+
+		# Remove the filenames that were deleted during this commit.
+		delete $files{$_} foreach (@{$self->{deleted_gpath}});
+
+		# Report the directory if there are no filenames left.
+		push @empty_dirs, $dir unless (scalar %files);
+	}
+	@empty_dirs;
+}
+
+sub add_placeholder_file {
+	my ($self, $dir) = @_;
+	my $path = "$dir/$_placeholder_filename";
+	my $gpath = $self->git_path($path);
+
+	my $fh = $::_repository->temp_acquire($gpath);
+	my $hash = $::_repository->hash_and_insert_object(Git::temp_path($fh));
+	Git::temp_release($fh, 1);
+	$self->{gii}->update('100644', $hash, $gpath) or croak $!;
+
+	# The following two lines don't seem to be necessary, but I'm not
+	# familiar enough with SVN properties to know if correctness is
+	# compromised without them.
+#	$self->{file_prop}->{$path} = $self->{dir_prop}->{$dir};
+#	$self->add_file($path, { 'path' => $dir }, undef, '-1');
+
+	# The directory should no longer be considered empty.
+	delete $self->{empty}->{$dir} if exists $self->{empty}->{$dir};
+}
+
 package SVN::Git::Editor;
 use vars qw/@ISA $_rmdir $_cp_similarity $_find_copies_harder $_rename_limit/;
 use strict;
-- 
1.7.5.1
