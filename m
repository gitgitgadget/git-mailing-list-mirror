From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 2/3] add new Git::Repo API
Date: Fri, 11 Jul 2008 03:11:05 +0200
Message-ID: <1215738665-5153-1-git-send-email-LeWiemann@gmail.com>
References: <4876B223.4070707@gmail.com>
Cc: John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 03:12:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH7Bp-0002uJ-Cq
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 03:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbYGKBLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 21:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbYGKBLt
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 21:11:49 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:32329 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbYGKBLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 21:11:48 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1800629ywe.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 18:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=r4vgY+foXN9lz60RenNc6vj2VOPxaCMHNT7tAKdA7AM=;
        b=u+lRmEY94G8XSrZTSA7Nrvuit/cbIDvWEjW+lwZylBn5TUiXy3at4nwcng2JZHU7J3
         MxFEsh8v0MRRB/6Q+q9PTwah/12hIA3vYwIYIWQlQw3x5qWpzpBxvBIOk7ufiMn/wx6f
         BjMfUrgeJoifn0OsaLHgTMinmBfwaJyM36tvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=h3avj4rNbhm1KEXkKvATUpCpWu6gAyXn3n0RMKP6EwE69UGbyfeDjuNSWw6zHyNw+Z
         ca9c267EfUaB2MTjpJbgaf3pHPk+MESeFuHIJdJiOzLJnu5HGzdclw8DV8SVBU0GhZgn
         bCrKu+g3StlBL4Qc2Ksbm+U+0e6ufPCe/JrdM=
Received: by 10.114.52.1 with SMTP id z1mr12804847waz.42.1215738697959;
        Thu, 10 Jul 2008 18:11:37 -0700 (PDT)
Received: from fly ( [91.33.220.178])
        by mx.google.com with ESMTPS id l12sm1085823fgb.6.2008.07.10.18.11.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 18:11:37 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KH7A9-0001LT-C9; Fri, 11 Jul 2008 03:11:05 +0200
X-Mailer: git-send-email 1.5.6.2.456.g63fc0
In-Reply-To: <4876B223.4070707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88070>

This also adds the Git::Commit and Git::Tag classes, which are used by
Git::Repo, the Git::Object base class, and the Git::RepoRoot helper
factory class.
---
Here's some elaboration on why I didn't use or extend Git.pm.

Please note before starting a reply to this: This is not an argument;
I'm just explaining why I implemented it the way I did.  So please
don't try to argue with me about what I should or should have done.
I'm not going to refactor Git::Repo to use Git.pm or vice versa; it's
really a much more non-trivial task than you might think at first
glance.

Anyways, the following bullet points are my reasons for not extending
Git.pm:

- Git.pm doesn't do what I want: It's designed to provide access to
  working copies.  Extending it to have more repository-access
  functions might have resulted in a mess.

  Some long-term thoughts on this issue: I don't think Git.pm's design
  approach is sensible: It tries to do (a) WC access, (b) repo access,
  and (c) frontend error handling (with sensible error messages).
  Those things should really be separated; e.g. one could write a
  Git::WC class that *has* a Git::Repo instance (since every working
  copy has a repository associated with it); so you can use $wc =
  Git::WC->new to access the working copy, and $wc->repo to access its
  repository.  Git.pm will obviously have to stay since a few git
  commands use it, but I'd probably let it die a slow death, and
  (cleanly!) copy functionality to a Git::WC module (and perhaps a
  Git::Frontend module) in the long run.

- It would have needed refactoring and more features.

  - For example, the Error module should be removed (and normal die
    and eval should be used instead).  At some point when I was trying
    to debug it through gitweb, Git.pm would error out somewhere and I
    would randomly get either a blank page (usually) or an error page
    (rarely).  I suspect that this is because of the Error module or
    some strange interaction with another.  (Besides, Error is not in
    the Perl distribution, so it would be an unnecessary dependency
    for gitweb; the only one as far as I can see.)

  - Also, I needed something like max_exit_code and a custom path to
    the git binary; adding max_exit_code would have been non-trivial.

  Now I'm all in favor of re-using existing code, but refactoring
  Git.pm would have taken *much* longer than simply writing a new
  module.  I'm working on caching for gitweb, not on implementing the
  next great Perl API for Git.  (And Git::Repo isn't great, FTR.)

- It's buggy and untested.  Neither of these is a problem by itself,
  but the combination is deadly.  E.g. I was trying to refactor the
  'repository' constructor (to be able to do instantaneous
  instantiation) and stumbled upon a missing semicolon that rendered
  the surrounding code syntactically correct but obviously buggy (line
  214 on master).  Adding a semicolon there seemed to cause other
  errors, and given that (a) I don't understand what the code does and
  no test or comment tells me what it should, and (b) it doesn't work
  (or maybe it half-works?), I lost all my confidence that I could do
  anything resembling a (behavior-preserving) refactoring on that
  code.

  I might have been able to work with this particular problem, but
  such a problem (buggy and completely untested code) are indicative
  that the rest of the code might bear similar surprises.

- It's overly lengthy, and it's a lot of code for not much
  functionality.  Git.pm has 1200 LOC, with a large stack of tiny
  subroutines to handle pipes, and a complicated error handling
  system.  I can make out ~400 lines of actual Git functionality, plus
  a 100-lines constructor (all including documentation).  The part of
  Git::Repo that overlaps with Git.pm (in terms of duplicate
  functionality) seems to be in the range of 150-200 lines, and it's
  mostly pipe-handling.  That's not a whole lot.

- When I decided I didn't want to use Git.pm, it took me 2-3 hours to
  replicate the functionality in Git.pm that I needed; it would have
  taken me *much* longer to extend Git.pm to do what I want.  Again,
  I'm not working on the next great Git Perl API.

So where do we go with Git.pm and Git::Repo?  I would suggest that
they both stay.

Thus we'd have two APIs (both of them obviously incomplete).  If
there's enough objection to having two competing official APIs, I'll
be happy to move Git::Repo to the gitweb directory, and make it a
gitweb-specific thing (though it's not gitweb-specific at all in terms
of functionality); I really don't care, as my goal is to get caching
for gitweb working.  Again, if you're bothered by the fact that
there's duplicate functionality at all, please don't complain, but
send patches to reconcile the APIs; I will not take care of that
myself, since it's a very much non-trivial task.

Unrelatedly, should I add copyright notices at the bottom of each perl
module so they are displayed in the perldoc/man pages?  I'm not
generally a fan of such notices, since they tend to establish code
ownership, but if it's desired I can add them.

So, here's the Git::Repo (and friends) API, plus tests of course: ;-)

 perl/Git/Commit.pm       |  163 +++++++++++++++++++
 perl/Git/Object.pm       |   81 ++++++++++
 perl/Git/Repo.pm         |  397 ++++++++++++++++++++++++++++++++++++++++++++++
 perl/Git/RepoRoot.pm     |  103 ++++++++++++
 perl/Git/Tag.pm          |  155 ++++++++++++++++++
 perl/Makefile            |    1 +
 perl/Makefile.PL         |   10 +-
 t/t9710-perl-git-repo.sh |   49 ++++++
 t/t9710/test.pl          |  165 +++++++++++++++++++
 9 files changed, 1123 insertions(+), 1 deletions(-)
 create mode 100644 perl/Git/Commit.pm
 create mode 100644 perl/Git/Object.pm
 create mode 100644 perl/Git/Repo.pm
 create mode 100644 perl/Git/RepoRoot.pm
 create mode 100644 perl/Git/Tag.pm
 create mode 100755 t/t9710-perl-git-repo.sh
 create mode 100755 t/t9710/test.pl

diff --git a/perl/Git/Commit.pm b/perl/Git/Commit.pm
new file mode 100644
index 0000000..a9bc304
--- /dev/null
+++ b/perl/Git/Commit.pm
@@ -0,0 +1,163 @@
+=head1 NAME
+
+Git::Commit - Object-oriented interface to Git commit objects.
+
+=cut
+
+use strict;
+use warnings;
+
+
+package Git::Commit;
+
+use base qw(Git::Object);
+
+use constant _MESSAGE => 'M';
+use constant _ENCODING => 'E';
+use constant _TREE => 'T';
+use constant _PARENTS => 'P';
+use constant _AUTHOR => 'A';
+use constant _COMMITTER => 'C';
+
+
+# Keep documentation in one place to save space.
+
+=head1 METHODS
+
+=over
+
+=item $commit = Git::Commit->new($repo, $sha1)
+
+Return a new Git::Commit instance for a commit object with $sha1 in
+repository $repo.
+
+Calls to this method are free, since it does not check whether $sha1
+exists and has the right type.  However, accessing any of the commit
+object's properties will fail if $sha1 is not a valid commit object.
+
+Note that $sha1 must be the SHA1 of a commit object; tag objects are
+not dereferenced.
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=item $obj->sha1
+
+Return the SHA1 of this commit object.
+
+=item $commit->tree
+
+Return the tree this commit object refers to.
+
+=item $commit->parents
+
+Return a list of zero or more parent commit objects.  Note that commit
+objects stringify to their respective SHA1s, so you can alternatively
+treat this as a list of SHA1 strings.
+
+=item $commit->authors
+
+Return the author string of this commit object.
+
+=item $commit->committer
+
+Return the committer string of this commit object.
+
+=item $commit->message
+
+Return the undecoded commit message of this commit object.
+
+=item $commit->encoding
+
+Return the encoding header of the commit object.
+
+=back
+
+=cut
+
+
+sub tree {
+	my $self = shift;
+	$self->_load;
+	$self->{_TREE()};
+}
+
+sub parents {
+	my $self = shift;
+	$self->_load;
+	map { ref($self)->new($self->repo, $_) } @{$self->{_PARENTS()}};
+}
+
+sub author {
+	my $self = shift;
+	$self->_load;
+	$self->{_AUTHOR()} or '';
+}
+
+sub committer {
+	my $self = shift;
+	$self->_load;
+	$self->{_COMMITTER()} or '';
+}
+
+sub message {
+	my $self = shift;
+	$self->_load;
+	$self->{_MESSAGE()};
+}
+
+sub encoding {
+	my $self = shift;
+	$self->_load;
+	$self->{_ENCODING()};
+}
+
+# Auxiliary method to load (and parse) the commit object from the
+# repository if it hasn't already been loaded.
+
+sub _load {
+	my($self, $raw_text) = shift;
+	return if defined $self->{_MESSAGE()};  # already loaded
+
+	my $sha1 = $self->sha1;
+	if (!defined $raw_text) {
+		# Retrieve from the repository.
+		(my $type, $raw_text) = $self->repo->cat_file($sha1);
+		die "$sha1 is a $type object (expected a commit object)"
+		    unless $type eq 'commit';
+	}
+
+	(my $header, $self->{_MESSAGE()}) = split "\n\n", $raw_text, 2;
+	# Parse header.
+	for my $line (split "\n", $header) {
+		local $/ = "\n"; # for chomp
+		chomp($line);
+		my($key, $value) = split ' ', $line, 2;
+		if ($key eq 'tree') {
+			$self->{_TREE()} = $value;
+		} elsif ($key eq 'parent') {
+			push @{$self->{_PARENTS()}}, $value;
+		} elsif ($key eq 'author') {
+			$self->{_AUTHOR()} = $value;
+		} elsif ($key eq 'committer') {
+			$self->{_COMMITTER()} = $value;
+		} elsif ($key eq 'encoding') {
+			$self->{_ENCODING()} = $value;
+		} else {
+			die "unrecognized commit header $key";
+		}
+	}
+	undef;
+}
+
+
+=head1 NOTES
+
+You will usually want to call $repo->get_commit($sha1) instead of
+instantiating this class directly; see L<Git::Repo>.
+
+=cut
+
+
+1;
diff --git a/perl/Git/Object.pm b/perl/Git/Object.pm
new file mode 100644
index 0000000..a5126f9
--- /dev/null
+++ b/perl/Git/Object.pm
@@ -0,0 +1,81 @@
+=head1 NAME
+
+Git::Object - Object-oriented interface to Git objects (base class).
+
+=head1 DESCRIPTION
+
+Git::Object is a base class that provides access to commit, tag and
+(unimplemented) tree objects.  See L<Git::Commit> and L<Git::Tag>.
+
+Objects are loaded lazily, and hence instantiation is free.  Objects
+stringify to their SHA1s.
+
+=cut
+
+
+use strict;
+use warnings;
+
+
+package Git::Object;
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw();
+
+use overload
+    '""' => \&stringify;
+
+# Hash indices:
+use constant _REPO => 'R';
+use constant _SHA1 => 'H';
+
+=head1 METHODS
+
+=over
+
+=item Git::Object->new($repo, $sha1)
+
+Return a new Git::Object instance for the object with $sha1 in the
+repository $repo (a Git::Repo instance).
+
+Note that this method does not check whether the object exists in the
+repository.  Trying to accessing its properties through a subclass
+will fail if the object doesn't exist, however.
+
+=cut
+
+sub new {
+	my($class, $repo, $sha1) = @_;
+	die "$repo is not a Git::Repo instance" unless $repo->isa('Git::Repo');
+	my $self = {_REPO() => $repo, _SHA1() => $sha1};
+	return bless $self, $class;
+}
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=cut
+
+sub repo {
+	shift->{_REPO()}
+}
+
+=item $obj->sha1
+
+Return the SHA1 of this object.
+
+=cut
+
+sub sha1 {
+	shift->{_SHA1()}
+}
+
+sub stringify {
+	shift->{_SHA1()}
+}
+
+
+1;
diff --git a/perl/Git/Repo.pm b/perl/Git/Repo.pm
new file mode 100644
index 0000000..5a4c7e0
--- /dev/null
+++ b/perl/Git/Repo.pm
@@ -0,0 +1,397 @@
+=head1 NAME
+
+Git::Repo - Read-only access to the Git repositories.
+
+WARNING: This module is in active development -- do not use it in any
+production code as the API may change at any time.
+
+=head1 SYNOPSIS
+
+  use Git::Repo;
+
+  my $repo = Git::Repo->new(
+      directory => '/path/to/repository.git',
+      git_binary => '/usr/bin/git');
+  my ($sha1, $type, $size) = $repo->get_sha1('HEAD');
+  print "Last log message:\n\n" . $repo->get_commit($sha1)->message;
+
+=cut
+
+
+use strict;
+use warnings;
+use 5.006002;
+
+
+package Git::Repo;
+
+use Git::Tag;
+use Git::Commit;
+
+use IPC::Open2 qw(open2);
+use IO::Handle;
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw(assert_sha1 assert_opts);
+
+# Auxiliary subroutines
+
+sub assert_opts {
+	die "must have an even number of arguments for named options"
+	    unless $#_ % 2;
+}
+
+sub assert_sha1 {
+	my $sha1 = shift;
+	die "'$sha1' is not a SHA1 (need to use get_sha1?)"
+	    unless $sha1 && $sha1 =~ /^[a-f0-9]{40}$/;
+}
+
+
+=head1 METHODS
+
+=head2 Instantiation and basic methods
+
+=over
+
+=item $repo = Git::Repo->new(%opts)
+
+Return a new Git::Repo object.  The following options are supported:
+
+=over
+
+=item 'directory'
+
+The directory of the repository (mandatory).
+
+Note that this option is working-copy agnostic; you need to
+instantiate it with the working copy's .git directory as the
+'directory' option.
+
+=item 'git_binary'
+
+The name or full path of the git binary (default: 'git').
+
+=back
+
+Calling this method is free, since it does not check whether the
+repository exists.  Trying to access the repository through one of the
+instance methods will fail if it doesn't exist though.
+
+Examples:
+
+    $repo = Git::Repo->new(directory => '/path/to/repository.git');
+    $repo = Git::Repo->new(directory => '/path/to/working_copy/.git');
+
+=cut
+
+sub new {
+	my $class = shift;
+	assert_opts(@_);
+	my $self = {@_};
+	bless $self, $class;
+	die 'no directory given' unless $self->{directory};
+	return $self;
+}
+
+=item $repo->repo_dir
+
+Return the directory of the repository (.../.git in case of a working
+copy).
+
+=cut
+
+sub repo_dir {
+	shift->{directory}
+}
+
+=item $repo->git_binary
+
+Return the name of or path to the git binary (used with exec).
+
+=cut
+
+sub git_binary {
+	shift->{git_binary}
+}
+
+=item $repo->version
+
+Return the output of 'git --version', with /^git version / stripped.
+
+This method does not require the repository to exist.
+
+=cut
+
+sub version{
+	my $self = shift;
+	chomp(my $version = $self->cmd_output(cmd => ['--version']));
+	$version =~ s/^git version //;  # be permissive if this does not match
+	return $version;
+}
+
+
+=back
+
+=head2 Calling the Git binary
+
+=over
+
+=item $repo->cmd_output(%opts)
+
+Return the output of the given git command as a string, or as a list
+of lines in array context.  Valid options are:
+
+=over
+
+=item 'cmd'
+
+An arrayref of arguments to pass to git (mandatory).
+
+=item 'max_exit_code'
+
+Die if the exit code of the git binary is greater than
+C<max_exit_code> (default: 0).
+
+=back
+
+Example:
+
+    $output = $repo->cmd_output(cmd => ['show', 'HEAD'])
+
+=cut
+
+# To do: According to Git.pm, this might not work with ActiveState
+# Perl on Win 32.  Need to check or wait for reports.
+
+sub cmd_output {
+	my $self = shift;
+	assert_opts @_;
+	my %opts = @_;
+	# We don't support string-commands here unless someone makes a
+	# case for them -- they are too dangerous.
+	die 'cmd parameter must be array' unless ref($opts{cmd}) eq 'ARRAY';
+	my @cmd = ($self->_get_git_cmd, @{$opts{cmd}});
+	open my $fh, '-|', @cmd or die 'cannot open pipe: ' . join(" ", @cmd);
+	local $/;
+	my $output = <$fh>;
+	if (not close $fh) {
+		if ($!) {
+			# Close failed.  Git.pm says it is OK to not
+			# die here, but doesn't provide an example.
+			# Let's die here for now.
+			die "error closing pipe ($!): " . join(' ', @cmd);
+		}
+		my $exit_code = $? >> 8;
+		die "Command died with exit code $exit_code: " . join(" ", @cmd)
+		    if $exit_code > ($opts{max_exit_code} || 0);
+	}
+	return $output;
+}
+
+=item $repo->get_bidi_pipe(%opts)
+
+Open a new bidirectional pipe and return its STDIN and STDOUT file
+handles.  Valid options are:
+
+=over
+
+=item 'cmd'
+
+An arrayref of arguments to pass to git (mandatory).
+
+=item 'reuse'
+
+If true, reuse a previously opened pipe with the same command line and
+whose C<reuse> option was true (default: false).
+
+=back
+
+=cut
+
+sub get_bidi_pipe {
+	my $self = shift;
+	assert_opts @_;
+	my %opts = @_;
+	die 'missing or empty cmd option' unless $opts{cmd} and @{$opts{cmd}};
+	my ($stdin, $stdout);
+	my $cmd_str = join ' ', @{$opts{cmd}};  # key for reusing pipes
+	if ($opts{reuse}) {
+		my $pair = $self->{bidi_pipes}->{$cmd_str};
+		return @$pair if $pair;
+	}
+	my @cmd = ($self->_get_git_cmd, @{$opts{cmd}});
+	open2($stdout, $stdin, @cmd)
+	    or die 'cannot open pipe';
+	if ($opts{reuse}) {
+		$self->{bidi_pipes}->{$cmd_str} = [$stdin, $stdout];
+	}
+	return ($stdin, $stdout);
+}
+
+# Return the first items of the git command line, for instance
+# qw(/usr/bin/git --git-dir=/path/to/repo.git).
+sub _get_git_cmd {
+	my $self = shift;
+	return ($self->git_binary || 'git', '--git-dir=' . $self->repo_dir);
+}
+
+
+=back
+
+=head2 Inspecting the Repository
+
+=over
+
+=item $repo->get_sha1($extended_object_identifier)
+
+Look up the object identified by $extended_object_identifier and
+return its SHA1 hash in scalar context or its ($sha1, $type, $size) in
+list context, or undef or () if the lookup failed, where $type is one
+of 'tag', 'commit', 'tree', or 'blob'.
+
+See L<git-rev-parse(1)>, section "Specifying Revisions", for the
+syntax of the $extended_object_identifier string.
+
+Note that even if you pass a SHA1 hash, its existence is still
+checked, and this method returns undef or () if it doesn't exist in
+the repository.
+
+=cut
+
+sub get_sha1 {
+	my ($self, $object_id) = @_;
+	die 'no object identifier given' unless $object_id;
+	die 'object identifier must not contain newlines' if $object_id =~ /\n/;
+	my ($in, $out) = $self->get_bidi_pipe(
+		cmd => ['cat-file','--batch-check'], reuse => 1);
+	print $in "$object_id\n" or die 'cannot write to pipe';
+	local $/ = "\n";
+	my $output = <$out>;
+	die 'no output from pipe' unless $output;
+	chomp $output;
+	return if $output =~ /missing$/;
+	my ($sha1, $type, $size) =
+	    ($output =~ /^([0-9a-f]{40}) ([a-z]+) ([0-9]+)$/)
+	    or die "invalid response: $output";
+	return wantarray ? ($sha1, $type, $size) : $sha1;
+}
+
+=item $repo->cat_file($sha1)
+
+Return the ($type, $content) of the object identified by $sha1, or die
+if no such object exists in the repository.
+
+Note that you may want to use the higher-level methods get_commit and
+get_tag instead.
+
+=cut
+
+# Possible to-do items: Add optional $file_handle parameter.  Guard
+# against getting huge blobs back when we don't expect it (for
+# instance, we could limit the size and send SIGPIPE to git if we get
+# a blob that is too large).
+
+sub cat_file {
+	my ($self, $sha1) = @_;
+	assert_sha1($sha1);
+
+	my ($in, $out) = $self->get_bidi_pipe(
+		cmd => ['cat-file','--batch'], reuse => 1);
+	print $in "$sha1\n" or die 'cannot write to pipe';
+	my ($ret_sha1, $type, $size) = split ' ', $out->getline;
+	die "'$sha1' not found" if $type eq 'missing';
+	$out->read(my $content, $size);
+	$out->getline;  # eat trailing newline
+	return wantarray ? ($type, $content) : $content;
+}
+
+=item $repo->get_commit($commit_sha1)
+
+Return a new L<Git::Commit> instance referring to the commit object
+with SHA1 $commit_sha1.
+
+=cut
+
+sub get_commit {
+	my ($self, $sha1) = @_;
+	assert_sha1($sha1);
+	return Git::Commit->new($self, $sha1);
+}
+
+=item $repo->get_tag($tag_sha1)
+
+Return a new L<Git::Tag> instance referring to the tag object with SHA1
+$tag_sha1.
+
+=cut
+
+sub get_tag {
+	my ($self, $sha1) = @_;
+	assert_sha1($sha1);
+	return Git::Tag->new($self, $sha1);
+}
+
+=item $repo->get_path($tree_sha1, $file_sha1)
+
+Return the path of the tree or blob identified by $file_sha1 in the
+tree identified by $tree_sha1, or undef if the tree or blob does not
+exist in the given tree.
+
+=cut
+
+sub get_path {
+	my ($self, $tree, $file_sha1) = @_;
+	assert_sha1($tree, $file_sha1);
+	my @lines = split "\n", $self->cmd_output(cmd => ['ls-tree', '-r', '-t', $tree]);
+	for (@lines) {
+		if (/^[0-9]+ [a-z]+ $file_sha1\t(.+)$/) {
+			return $1;
+		}
+	}
+	return undef;
+}
+
+=item $repo->get_refs
+
+=item $repo->get_refs($pattern)
+
+Return an arrayref of [$sha1, $object_type, $ref_name] triples.  If
+$pattern is given, only refs matching the pattern are returned; see
+L<git-for-each-ref(1)> for details.
+
+=cut
+
+sub get_refs {
+	my ($self, $pattern) = @_;
+
+	return [ map [ split ], split("\n", $self->cmd_output(
+			 cmd => [ 'for-each-ref',
+				  defined $pattern ? $pattern : () ])) ];
+}
+
+=item $repo->name_rev($committish_sha1, $tags_only = 0)
+
+Return a symbolic name for the commit identified by $committish_sha1,
+or undef if no name can be found; see L<git-name-rev(1)> for details.
+If $tags_only is true, no branch names are used to name the commit.
+
+=cut
+
+sub name_rev {
+	my ($self, $sha1, $tags_only) = @_;
+	assert_sha1($sha1);
+
+	# Note that we cannot use a bidi pipe here since name git
+	# name-rev --stdin has an excessively high start-up time.
+	# http://thread.gmane.org/gmane.comp.version-control.git/85531
+	chomp(my $name = $self->cmd_output(
+		      cmd => [ 'name-rev', $tags_only ? '--tags' : (),
+			 '--name-only', $sha1 ]));
+	return $name eq 'undefined' ? undef : $name;
+}
+
+
+1;
diff --git a/perl/Git/RepoRoot.pm b/perl/Git/RepoRoot.pm
new file mode 100644
index 0000000..12e1836
--- /dev/null
+++ b/perl/Git/RepoRoot.pm
@@ -0,0 +1,103 @@
+=head1 NAME
+
+Git::RepoRoot - A factory class representing a root directory
+containing Git repositories.
+
+=head1 DESCRIPTION
+
+Git::RepoRoot is a factory class to create L<Git::Repo> instances that
+are located under a common root directory.  It also allows for
+specifying options that all Git::Repo instances will be created with.
+
+Using Git::RepoRoot to create Git::Repo instances is entirely
+optional, but can be more convenient than instantiating them directly.
+
+=cut
+
+
+use strict;
+use warnings;
+
+
+package Git::RepoRoot;
+
+use File::Spec;
+
+use Git::Repo;
+
+use base qw(Exporter);
+
+our @EXPORT = qw();
+our @EXPORT_OK = qw();
+
+=head1 METHODS
+
+=over
+
+=item $repo_root = Git::RepoRoot->new(%opts)
+
+Return a new Git::RepoRoot object.  The following options are
+supported:
+
+=over
+
+=item 'directory'
+
+The directory holding all repositories.
+
+=back
+
+All other options will be passed through to Git::Repo->new.
+
+Example:
+
+    $repo_root = Git::RepoRoot->new(directory => '/pub/git',
+                                    git_binary => '/usr/bin/git'q);
+
+=cut
+
+sub new {
+	my $class = shift;
+	Git::Repo::assert_opts(@_);
+	my $self = {@_};
+	bless $self, $class;
+	die 'no root directory given' unless $self->{directory};
+	return $self;
+}
+
+=item $repo_root->repo(%opts)
+
+Return a new L<Git::Repo> object.  The following options are
+supported:
+
+=over
+
+=item 'directory'
+
+The path of the repository relative to the repository root.
+
+=item 'repo_class'
+
+The Repo class to instantiate (default: 'Git::Repo').
+
+=back
+
+All other options are passed through to Git::Repo.
+
+=cut
+
+sub repo {
+	my $self = shift;
+	Git::Repo::assert_opts(@_);
+	my %opts = (%$self, @_);
+	die 'no directory given' unless $opts{directory};
+	# not technically necessary, but to guard against errors in the caller:
+	die "you passed an absolute path ($opts{directory})"
+	    if $opts{directory} =~ m!^/!;
+	my $repo_class = delete $opts{repo_class} || 'Git::Repo';
+	$opts{directory} = File::Spec->catfile($self->{directory}, $opts{directory});
+	return $repo_class->new(%opts);
+}
+
+
+1;
diff --git a/perl/Git/Tag.pm b/perl/Git/Tag.pm
new file mode 100644
index 0000000..4e0549b
--- /dev/null
+++ b/perl/Git/Tag.pm
@@ -0,0 +1,155 @@
+=head1 NAME
+
+Git::Tag - Object-oriented interface to Git tag objects.
+
+=cut
+
+use strict;
+use warnings;
+
+
+package Git::Tag;
+
+use base qw(Git::Object);
+
+use constant _MESSAGE => 'M';
+use constant _ENCODING => 'E';
+use constant _TAGGER => 'A';
+use constant _TAG => 'T';
+use constant _TYPE => 'Y';
+use constant _OBJECT => 'O';
+
+
+# Keep documentation in one place to save space.
+
+=head1 METHODS
+
+=over
+
+=item $tag = Git::Tag->new($repo, $sha1)
+
+Return a new Git::Tag instance for a tag object with $sha1 in
+repository $repo.
+
+Calls to this method are free, since it does not check whether $sha1
+exists and has the right type.  However, accessing any of the tag
+object's properties will fail if $sha1 is not a valid tag object.
+
+=item $obj->repo
+
+Return the Git::Repo instance this object was instantiated with.
+
+=item $obj->sha1
+
+Return the SHA1 of this tag object.
+
+=item $tag->object
+
+Return the SHA1 string of the object referenced by this tag .
+
+=item $tag->type
+
+Return the type of the referenced object, as claimed by the tag
+object.  This is usually 'commit', but can be any of 'tag', 'commit',
+'tree', or 'blob'.
+
+=item $tag->tagger
+
+Return the tagger string of this tag object.
+
+=item $tag->message
+
+Return the undecoded tag message of this tag object.
+
+=item $tag->encoding
+
+Return the encoding header of the tag object.
+
+=back
+
+=cut
+
+
+sub object {
+	my $self = shift;
+	$self->_load;
+	$self->{_OBJECT()};
+}
+
+sub type {
+	my $self = shift;
+	$self->_load;
+	$self->{_TYPE()} or '';
+}
+
+sub tag {
+	my $self = shift;
+	$self->_load;
+	$self->{_TAG()};
+}
+
+sub tagger {
+	my $self = shift;
+	$self->_load;
+	$self->{_TAGGER()} or '';
+}
+
+sub message {
+	my $self = shift;
+	$self->_load;
+	$self->{_MESSAGE()};
+}
+
+sub encoding {
+	my $self = shift;
+	$self->_load;
+	$self->{_ENCODING()};
+}
+
+# Auxiliary method to load (and parse) the tag object from the
+# repository if it hasn't already been loaded.
+
+sub _load {
+	my($self, $raw_text) = shift;
+	return if defined $self->{_MESSAGE()};  # already loaded
+
+	my $sha1 = $self->sha1;
+	if (!defined $raw_text) {
+		(my $type, $raw_text) = $self->repo->cat_file($sha1);
+		die "$sha1 is a $type object (expected a tag object)"
+		    unless $type eq 'tag';
+	}
+
+	(my $header, $self->{_MESSAGE()}) = split "\n\n", $raw_text, 2;
+	# Parse header.
+	for my $line (split "\n", $header) {
+		local $/ = "\n"; # for chomp
+		chomp($line);
+		my($key, $value) = split ' ', $line, 2;
+		if ($key eq 'object') {
+			$self->{_OBJECT()} = $value;
+		} elsif ($key eq 'type') {
+			$self->{_TYPE()} = $value;
+		} elsif ($key eq 'tag') {
+			$self->{_TAG()} = $value;
+		} elsif ($key eq 'tagger') {
+			$self->{_TAGGER()} = $value;
+		} elsif ($key eq 'encoding') {
+			$self->{_ENCODING()} = $value;
+		} else {
+			die "unrecognized tag header $key";
+		}
+	}
+	undef;
+}
+
+
+=head1 NOTES
+
+You will usually want to call $repo->get_tag($sha1) instead of
+instantiating this class directly; see L<Git::Repo>.
+
+=cut
+
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 5e079ad..a70e78a 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -27,6 +27,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo install: >> $@
 	echo '	mkdir -p $(instdir_SQ)' >> $@
 	echo '	$(RM) $(instdir_SQ)/Git.pm; cp Git.pm $(instdir_SQ)' >> $@
+	echo '	mkdir -p $(instdir_SQ)/Git; $(RM) $(instdir_SQ)/Git/*.pm; cp Git/*.pm $(instdir_SQ)/Git' >> $@
 	echo '	$(RM) $(instdir_SQ)/Error.pm; \
 	cp private-Error.pm $(instdir_SQ)/Error.pm' >> $@
 	echo instlibdir: >> $@
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..6c62160 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -8,7 +8,15 @@ instlibdir:
 MAKE_FRAG
 }
 
-my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
+# Note that when changing %pm, you'll have to remove pm_to_blib rather
+# than the blib directory to .force the .pm files to be re-installed
+# to blib/lib.
+my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm',
+	  'Git/Repo.pm' => '$(INST_LIBDIR)/Git/Repo.pm',
+	  'Git/RepoRoot.pm' => '$(INST_LIBDIR)/Git/RepoRoot.pm',
+	  'Git/Commit.pm' => '$(INST_LIBDIR)/Git/Commit.pm',
+	  'Git/Tag.pm' => '$(INST_LIBDIR)/Git/Tag.pm',
+	  'Git/Object.pm' => '$(INST_LIBDIR)/Git/Object.pm');
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
diff --git a/t/t9710-perl-git-repo.sh b/t/t9710-perl-git-repo.sh
new file mode 100755
index 0000000..ca67b87
--- /dev/null
+++ b/t/t9710-perl-git-repo.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Lea Wiemann
+#
+
+test_description='perl interface (Git/*.pm)'
+. ./test-lib.sh
+
+perl -MTest::More -e 0 2>/dev/null || {
+	say_color skip "Perl Test::More unavailable, skipping test"
+	test_done
+}
+
+# Set up test repository.  Tagging/branching is a little tricky
+# because it needs to stay unambiguous for the name_rev tests.
+
+test_expect_success \
+    'set up test repository' \
+    'echo "test file 1" > file1 &&
+     echo "test file 2" > file2 &&
+     mkdir directory1 &&
+     echo "in directory1" >> directory1/file &&
+     mkdir directory2 &&
+     echo "in directory2" >> directory2/file &&
+     git add . &&
+     git commit -m "first commit" &&
+
+     git tag -a -m "tag message 1" tag-object-1 &&
+
+     echo "changed file 1" > file1 &&
+     git commit -a -m "second commit" &&
+
+     git branch branch-2 &&
+
+     echo "changed file 2" > file2 &&
+     git commit -a -m "third commit" &&
+
+     git tag -a -m "tag message 3" tag-object-3 &&
+     git tag -a -m "indirect tag message 3" indirect-tag-3 tag-object-3 &&
+
+     echo "changed file 1 again" > file1 &&
+     git commit -a -m "fourth commit"
+     '
+
+test_external_without_stderr \
+    'Git::Repo API' \
+    perl ../t9710/test.pl
+
+test_done
diff --git a/t/t9710/test.pl b/t/t9710/test.pl
new file mode 100755
index 0000000..188abba
--- /dev/null
+++ b/t/t9710/test.pl
@@ -0,0 +1,165 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use Test::More qw(no_plan);
+use Test::Exception;
+use Carp::Always;
+
+use Cwd;
+use File::Basename;
+use File::Temp;
+use File::Spec;
+use Data::Dumper; # for debugging
+
+BEGIN { use_ok('Git::Repo') }
+
+our $old_stderr;
+sub discard_stderr {
+	open our $old_stderr, ">&", STDERR or die "cannot save STDERR";
+	close STDERR;
+}
+sub restore_stderr {
+	open STDERR, ">&", $old_stderr or die "cannot restore STDERR";
+}
+
+# set up
+our $repo_dir = "trash directory";
+our $abs_wc_dir = Cwd->cwd;
+die "this must be run by calling the t/t97* shell script(s)\n"
+    if basename(Cwd->cwd) ne $repo_dir;
+ok(our $r = Git::Repo->new(directory => "./.git"), 'open repository');
+sub rev_parse {
+	my $name = shift;
+	chomp(my $sha1 = `git rev-parse $name 2> /dev/null`);
+	$sha1 or undef;
+}
+
+my @revisions = split /\s/, `git-rev-list --first-parent HEAD`;
+my $head = $revisions[0];
+
+# cmd_output
+is($r->cmd_output(cmd => ['cat-file', '-t', 'HEAD']), "commit\n", 'cmd_output: basic');
+discard_stderr;
+dies_ok { $r->cmd_output(cmd => ['bad-cmd']); } 'cmd_output: die on error';
+restore_stderr;
+my $bad_output;
+lives_ok { $bad_output = $r->cmd_output(
+		   cmd => ['rev-parse', '--verify', '--quiet', 'badrev'],
+		   max_exit_code => 1); }
+    'cmd_output: max_error';
+is($bad_output, '', 'cmd_output: return string on non-zero exit');
+# untested: get_bidi_pipe
+
+# get_sha1
+is($r->get_sha1('HEAD'), $head, 'get_sha1: scalar');
+is($r->get_sha1('HEAD'), $head, 'get_sha1: scalar, repeated');
+my($sha1, $type, $head_size) = $r->get_sha1('HEAD');
+is($sha1, $head, 'get_sha1: array (SHA1)');
+is($type, 'commit', 'get_sha1: array (commit)');
+ok($head_size > 0, 'get_sha1: array (size)');
+
+# cat_file
+is_deeply([$r->cat_file($r->get_sha1("$revisions[-1]:file1"))], ['blob', "test file 1\n"], 'cat_file: blob');
+is_deeply([$r->cat_file($r->get_sha1("$revisions[-1]:file1"))], ['blob', "test file 1\n"], 'cat_file: blob, repeated');
+dies_ok { $r->cat_file('0' x 40) } 'cat_file: non-existent sha1';
+
+# get_commit
+isa_ok($r->get_commit($revisions[-1]), 'Git::Commit',
+       'get_commit: returns Git::Commit object');
+
+# get_tag
+isa_ok($r->get_tag($r->get_sha1('tag-object-1')), 'Git::Tag',
+       'get_tag: returns Git::Tag object');
+
+# get_path
+is($r->get_path($head, $r->get_sha1('HEAD:directory1/file')),
+   'directory1/file', 'get_path: file');
+is($r->get_path($head, $r->get_sha1('HEAD:directory1')),
+   'directory1', 'get_path: directory');
+is($r->get_path($head, '0' x 40), undef, 'get_path: nonexistent');
+
+# get_refs
+my @refs = @{$r->get_refs()};
+is((grep { $_->[2] eq 'refs/heads/branch-2' } @refs), 1,
+   'get_refs: branch existence and uniqueness');
+my @branch2_info = @{(grep { $_->[2] eq 'refs/heads/branch-2' } @refs)[0]};
+is_deeply([@branch2_info], [$revisions[-2], 'commit', 'refs/heads/branch-2'],
+	  'get_heads: sub-array contents');
+@refs = @{$r->get_refs('refs/tags')};
+ok(@refs, 'get_refs: pattern');
+is((grep { $_->[2] eq 'refs/heads/branch-2' } @refs), 0, 'get_refs: pattern');
+
+# name_rev
+is($r->name_rev($revisions[-2]), 'branch-2', 'name_rev: branch');
+is($r->name_rev($head, 1), undef, 'name_rev: branch, tags only');
+is($r->name_rev($revisions[-1]), 'tags/tag-object-1^0', 'name_rev: tag object');
+is($r->name_rev($revisions[-1], 1), 'tag-object-1^0', 'name_rev: tag object, tags only');
+
+
+
+# Git::Commmit
+print "# Git::Commit:\n";
+
+BEGIN { use_ok('Git::Commit') }
+
+my $invalid_commit = Git::Commit->new($r, '0' x 40);
+is($invalid_commit->sha1, '0' x 40, 'new, sha1: accept invalid SHA1');
+dies_ok { $invalid_commit->tree } 'die on accessing properties of invalid SHA1s';
+
+$invalid_commit = Git::Commit->new($r, $r->get_sha1('HEAD:')); # tree, not commit
+dies_ok { $invalid_commit->tree } 'die on accessing properties of non-commit objects';
+
+my $c = Git::Commit->new($r, $revisions[-2]);
+is($c->repo, $r, 'repo: basic');
+is($c->sha1, $revisions[-2], 'sha1: basic');
+is($c->{Git::Commit::_PARENTS}, undef,
+   'lazy loading: not loaded after reading SHA1');
+is($c->tree, $r->get_sha1("$revisions[-2]:"), 'tree: basic');
+ok($c->{Git::Commit::_PARENTS}, 'lazy loading: loaded after reading tree');
+is_deeply([$c->parents], [$revisions[-1]], 'parents: basic');
+like($c->author, qr/A U Thor <author\@example.com> [0-9]+ \+0000/, 'author: basic');
+like($c->committer, qr/C O Mitter <committer\@example.com> [0-9]+ \+0000/, 'committer: basic');
+is($c->encoding, undef, 'encoding: undef');
+is($c->message, "second commit\n", 'message: basic');
+is($c, $c->sha1, 'stringify: basic');
+
+# error handling
+dies_ok { Git::Commit->new($r, $r->get_sha1('tag-object-3'))->_load }
+    'new: pass tag SHA1 (dies)';
+dies_ok { Git::Commit->new($r, '0' x 40)->_load }
+    'new: pass invalid SHA1 (dies)';
+
+
+# Git::Tag
+print "# Git::Tag:\n";
+
+BEGIN { use_ok('Git::Tag') }
+
+# We don't test functionality inherited from Git::Object that we
+# already tested in the Git::Commit tests.
+
+my $t = Git::Tag->new($r, $r->get_sha1('tag-object-1'));
+is($t->tag, 'tag-object-1', 'tag: basic');
+is($t->object, $revisions[-1], 'object: basic');
+is($t->type, 'commit', 'tag: type');
+like($t->tagger, qr/C O Mitter <committer\@example.com> [0-9]+ \+0000/, 'tagger: basic');
+is($t->encoding, undef, 'encoding: undef');
+is($t->message, "tag message 1\n", 'message: basic');
+
+# error handling
+dies_ok { Git::Tag->new($r, $head)->_load } 'new: pass commit SHA1 (dies)';
+dies_ok { Git::Tag->new($r, '0' x 40)->_load } 'new: pass invalid SHA1 (dies)';
+
+
+# Git::RepoRoot
+print "# Git::RepoRoot:\n";
+
+BEGIN { use_ok('Git::RepoRoot'); }
+
+my $reporoot = Git::RepoRoot->new(
+	directory => File::Spec->catfile($abs_wc_dir, '..'));
+is($reporoot->repo(directory => File::Spec->catfile($repo_dir, '.git'))
+   ->get_sha1('HEAD'), $head, 'repo: basic');
-- 
1.5.6.2.456.g63fc0
