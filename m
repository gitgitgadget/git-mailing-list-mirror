From: Richard Ipsum <richard.ipsum@codethink.co.uk>
Subject: [PATCH 1/2] contrib: Add git-candidate subcommand
Date: Tue, 10 Nov 2015 12:56:37 +0000
Message-ID: <1447160198-23296-2-git-send-email-richard.ipsum@codethink.co.uk>
References: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
Cc: Richard Ipsum <richard.ipsum@codethink.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 13:57:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw8U0-0000S3-K8
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 13:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbKJM5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 07:57:01 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45321 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbbKJM46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 07:56:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A0C6F4620D7;
	Tue, 10 Nov 2015 12:56:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKK0R1q5+HE8; Tue, 10 Nov 2015 12:56:50 +0000 (GMT)
Received: from salo.dyn.ducie.codethink.co.uk. (salo.dyn.ducie.codethink.co.uk [10.24.1.218])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 32F6C462088;
	Tue, 10 Nov 2015 12:56:50 +0000 (GMT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1447160198-23296-1-git-send-email-richard.ipsum@codethink.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281121>

git-candidate provides candidate review and patch tracking,
allowing distributed comment and review facilities with
all content stored in git.

Signed-off-by: Richard Ipsum <richard.ipsum@codethink.co.uk>
---
 contrib/git-candidate/GitUtils.pm        |  207 +++
 contrib/git-candidate/git-candidate.perl | 2541 ++++++++++++++++++++++++++++++
 2 files changed, 2748 insertions(+)
 create mode 100644 contrib/git-candidate/GitUtils.pm
 create mode 100755 contrib/git-candidate/git-candidate.perl

diff --git a/contrib/git-candidate/GitUtils.pm b/contrib/git-candidate/GitUtils.pm
new file mode 100644
index 0000000..24c9abe
--- /dev/null
+++ b/contrib/git-candidate/GitUtils.pm
@@ -0,0 +1,207 @@
+# Copyright 2015 Codethink Limited
+#
+# GPL v2 (See COPYING)
+
+package GitUtils;
+
+use Exporter 'import';
+use Error qw(:try);
+use Git;
+
+our @EXPORT_OK = qw(require_clean_work_tree git_editor _head_symbolic_ref
+                 _command_input_pipe_capture_output_oneline cat_file
+                 is_object_present is_commit_merged get_head_branch
+                 get_head_commit get_land_for_commit get_sha_at_ref
+                 get_tracking_branch remove_refs inject_json
+                 looks_like_sha validate_kwargs);
+
+use Carp;
+sub validate_kwargs
+{
+    my ($kwargs_ref, @mandatory_args) = @_;
+
+    for my $k (@mandatory_args) {
+        confess "No '$k' provided" unless exists $kwargs_ref->{$k};
+    }
+}
+
+sub looks_like_sha
+{
+    my $x = shift;
+    return $x =~ /[0-9a-z]{40}/;
+}
+
+sub inject_json
+{
+    my ($repo, $json) = @_;
+    my $fh = File::Temp->new();
+
+    print $fh $json;
+    close $fh;
+    my $hash = $repo->hash_and_insert_object($fh->filename);
+
+    return $hash;
+}
+
+sub require_clean_work_tree {
+    my ($repo, $action) = @_;
+    $action //= 'proceed';
+    my $errno = 0;
+
+    try {
+        $repo->command_oneline('diff-files', '--quiet', '--ignore-submodules');
+    }
+    catch Git::Error::Command with {
+        print STDERR "Cannot $action: You have unstaged changes.\n";
+        $errno = 1;
+    };
+
+    try {
+        $repo->command('diff-index', '--cached', '--quiet',
+            '--ignore-submodules', 'HEAD');
+    }
+    catch Git::Error::Command with {
+        if ($errno == 0) {
+            print STDERR "Cannot $action: Your index contains uncommitted changes.\n";
+            $errno = 1;
+        }
+        else {
+            print STDERR "Additonally, your index contains uncommitted changes.\n";
+        }
+    };
+
+    exit 1 if $errno;
+}
+
+sub git_editor
+{
+    my $editor = $ENV{GIT_EDITOR} // `git var GIT_EDITOR`;
+    chomp($editor);
+
+    system($editor, @_);
+}
+
+sub _head_symbolic_ref
+{
+    my $repo = shift;
+    return $repo->command_oneline(['symbolic-ref', 'HEAD'], STDERR => 0);
+}
+
+sub _command_input_pipe_capture_output_oneline
+{
+    my ($repo, $command_input, $command, @arguments) = @_;
+
+    confess "No repo defined" unless defined $repo;
+    confess "No command input defined" unless defined $command_input;
+    confess "No command defined" unless defined $command;
+
+    my ($pid, $pipe_out, $pipe_in, $ctx) = $repo->command_bidi_pipe($command,
+        @arguments);
+    print $pipe_in $command_input;
+    close $pipe_in;
+
+    my $output = readline $pipe_out;
+    chomp($output) if $output;
+
+    $repo->command_close_bidi_pipe($pid, $pipe_out, undef, $ctx);
+
+    return $output;
+}
+
+sub cat_file
+{
+    my ($repo, $sha, $filename, %kwargs) = @_;
+    return $repo->command(['cat-file', '-p',
+        defined $filename ? "$sha:$filename" : "$sha"], %kwargs);
+}
+
+sub is_object_present
+{
+    my ($repo, $sha) = @_;
+
+    return try {
+        my $output = $repo->command_oneline(['cat-file', '-t', $sha],
+            STDERR => 0);
+        return 1;
+    }
+    catch Git::Error::Command with {
+        return 0;
+    };
+}
+
+sub is_commit_merged
+{
+    my ($repo, $what, $where) = @_;
+    my @lines = $repo->command('rev-list', $where);
+    return grep { /$what/ } @lines;
+}
+
+sub get_head_branch
+{
+    my $repo = shift;
+
+    return try {
+        my $symbolic_ref = _head_symbolic_ref($repo);
+        return $repo->command_oneline('for-each-ref',
+            '--format=%(refname:short)', $symbolic_ref);
+    }
+    catch Git::Error::Command with {
+        return undef;
+    };
+}
+
+sub get_head_commit
+{
+    my $repo = shift;
+
+    return try {
+        return $repo->command_oneline('rev-parse', 'HEAD');
+    }
+    catch Git::Error::Command with {
+        return undef;
+    };
+}
+
+sub get_land_for_commit
+{
+    my ($repo, $commit) = @_;
+
+    return try {
+        my $symbolic_ref = _head_symbolic_ref($repo);
+        my $line = $repo->command_oneline('for-each-ref',
+            '--format=%(upstream) %(upstream:short)', $symbolic_ref);
+        my ($unambig, $land) = split(/ /, $line);
+        my $ontop = $repo->command_oneline('merge-base', $commit, $unambig);
+        print "returning hash...";
+        return {ontop => $ontop, landinto => $land};
+    }
+    catch Git::Error::Command with {
+        return undef;
+    };
+}
+
+sub get_sha_at_ref
+{
+    my ($repo, $ref) = @_;
+
+    return $repo->command_oneline('show-ref', '--hash', $ref);
+}
+
+sub get_tracking_branch
+{
+    my ($repo, $branch) = @_;
+
+    return $repo->config("branch.$branch.remote");
+}
+
+sub remove_refs
+{
+    my ($repo, @refs) = @_;
+
+    for my $ref (@refs) {
+        print "ref: $ref\n";
+        $repo->command('update-ref', '-d', $ref);
+    }
+}
+
+1;
diff --git a/contrib/git-candidate/git-candidate.perl b/contrib/git-candidate/git-candidate.perl
new file mode 100755
index 0000000..7660bd0
--- /dev/null
+++ b/contrib/git-candidate/git-candidate.perl
@@ -0,0 +1,2541 @@
+#!/usr/bin/env perl
+#
+# Copyright 2015 Codethink Limited
+#
+# GPL v2 (See COPYING)
+
+use 5.008;
+use strict;
+use warnings;
+use Error qw(:try);
+use Getopt::Long;
+use Git;
+use FindBin;
+use lib "$FindBin::Bin";
+use GitUtils qw(require_clean_work_tree git_editor _head_symbolic_ref
+                 _command_input_pipe_capture_output_oneline cat_file
+                 is_object_present is_commit_merged get_head_branch
+                 get_head_commit get_land_for_commit get_sha_at_ref
+                 get_tracking_branch remove_refs inject_json
+                 looks_like_sha validate_kwargs);
+
+use Hash::Util qw(lock_keys);
+use JSON;
+use File::Temp qw(tempdir);
+use Cwd;
+use POSIX;
+use Carp;
+
+my $DEBUG = $ENV{PR_DEBUG} // 0;
+my $user_checkout;
+
+sub get_repo
+{
+    my %kwargs = @_;
+
+    my $with_user_worktree = $kwargs{with_user_worktree};
+    my $repo = try {
+        # We first run a git command if this succeeds then we're in a git repo
+        Git::command_oneline(['rev-parse'], STDERR => $DEBUG ? undef : 0);
+
+        my $repo;
+        if ($with_user_worktree) {
+            return Git->repository;
+        }
+        else {
+            my $tmpdir = tempdir(CLEANUP => 1);
+
+            mkdir "$tmpdir/.git";
+            $ENV{GIT_INDEX_FILE} = "$tmpdir/.git/index";
+            my $repo = Git->repository(Repository => getcwd . "/.git",
+                                       WorkingCopy => $tmpdir);
+
+            my $gothead = try {
+                $repo->command(['rev-parse', 'HEAD'],
+                               STDERR => $DEBUG ? undef : 0);
+            }
+            catch Git::Error::Command with {
+                print STDERR "Warning: no HEAD " .
+                             "nothing to populate index with.\n" if $DEBUG;
+                return undef;
+            };
+
+            if ($gothead) {
+                $repo->command(['reset', '--hard', 'HEAD'],
+                               STDERR => $DEBUG ? undef : 0); # populate index
+            }
+
+            return $repo;
+        }
+    }
+    catch Git::Error::Command with {
+        return undef;
+    };
+
+    # user_checkout is a global that stores the user's HEAD
+    # prior to the exec of git-candidate, so we can restore the correct
+    # HEAD if we're interrupted.
+    #
+    # user_checkout shall only ever be set once,
+    # by the first call to get_repo.
+    unless (defined $user_checkout) {
+        my $head_branch = get_head_branch($repo);
+        $user_checkout = defined $head_branch ? $head_branch :
+            $repo->command_oneline('rev-parse', 'HEAD');
+    }
+
+    return $repo;
+}
+
+sub catch_sigint
+{
+    if (defined $user_checkout) {
+        my $repo = get_repo;
+        $repo->command(['checkout', $user_checkout],
+            STDERR => $DEBUG ? undef : 0);
+    }
+    exit 1;
+}
+
+$SIG{INT} = \&catch_sigint;
+
+my $MAX_COMMENT_LEN = 512;
+my $REMOTE_REF_PREFIX = 'refs/candidates/remotes';
+my $LOCAL_REF_PREFIX = 'refs/candidates/heads';
+
+my @SUPPORTED_VERSIONS = (0, );
+if (defined $ENV{CANDIDATE_TEST} and $ENV{CANDIDATE_TEST} eq "1") {
+    push @SUPPORTED_VERSIONS, 256;
+}
+
+my $CANDIDATE_VERSION = defined $ENV{CANDIDATE_VERSION} ?
+    $ENV{CANDIDATE_VERSION} + 0 : $SUPPORTED_VERSIONS[-1];
+
+sub debug_print
+{
+    print @_ if $DEBUG;
+}
+
+sub indent_print
+{
+    my %kwargs = @_;
+
+    die "No string provided" unless defined $kwargs{string};
+    die "No indent provided" unless defined $kwargs{indent};
+
+    my $indent = $kwargs{indent};
+    my $string = $kwargs{string};
+
+    my @lines = split(/\n/, $string);
+    for my $line (@lines) {
+        printf("%*s\n", length($line) + $indent, $line);
+    }
+}
+
+package GitFileObject
+{
+    use GitUtils qw(validate_kwargs);
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+        validate_kwargs(\%kwargs, 'objtype', 'repo');
+
+        bless {_mode => $kwargs{mode}, _objtype => $kwargs{objtype},
+               _objsum => $kwargs{objsum}, _path => $kwargs{path},
+               _repo => $kwargs{repo}}, $class;
+    }
+
+    sub    mode { return $_[0]->{_mode};    }
+    sub    path { return $_[0]->{_path};    }
+    sub  objsum { return $_[0]->{_objsum};  }
+    sub objtype { return $_[0]->{_objtype}; }
+
+    sub new_regular_blob
+    {
+        my ($class, %kwargs) = @_;
+        validate_kwargs(\%kwargs, 'repo');
+        my ($repo, $sha, $path) = @kwargs{'repo', 'sha', 'path'};
+
+        my $self = GitFileObject->new(repo => $repo, mode => '100644',
+                                      objtype => 'blob', objsum => $sha,
+                                      path => $path);
+        bless $self, $class;
+    }
+
+    sub new_tree
+    {
+        my ($class, %kwargs) = @_;
+        validate_kwargs(\%kwargs, 'repo');
+        my ($repo, $sha, $path) = @kwargs{'repo', 'sha', 'path'};
+
+        my $self = GitFileObject->new(repo => $repo, mode => '040000',
+                                      objtype => 'tree', objsum => $sha,
+                                      path => $path);
+        bless $self, $class;
+    }
+
+    sub tree_entry
+    {
+        my $self = shift;
+        my ($mode, $objtype, $objsum, $path) = ($self->mode, $self->objtype,
+                                                $self->objsum, $self->path);
+
+        return (defined $mode and defined $objtype
+                and defined $objsum and defined $path) ?
+                    "$mode $objtype $objsum\t$path" : undef;
+    }
+
+    sub set_objsum
+    {
+        my ($self, $objsum) = @_;
+
+        $self->{_objsum} = $objsum;
+    }
+}
+
+package GitCommitObject
+{
+    @GitCommitObject::ISA = 'GitFileObject';
+    use GitUtils qw(cat_file validate_kwargs);
+
+    sub _parse_commit_obj
+    {
+        my ($class, $repo, $sha) = @_;
+
+        my @lines = cat_file($repo, $sha);
+
+        my ($timberline, ) = grep { /^tree/ } @lines;
+        $timberline =~ /^tree ([a-z0-9]+)/;
+        my $tree_sha = $1;
+
+        return $tree_sha;
+    }
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+
+        validate_kwargs(\%kwargs, 'repo');
+
+        my $self = $class->SUPER::new(repo => $kwargs{repo},
+            objtype => 'commit', objsum => $kwargs{sha});
+        $self->{_tree} = $class->_parse_commit_obj($kwargs{repo},
+            $kwargs{sha});
+
+        bless $self, $class;
+    }
+
+    sub tree { return $_[0]->{_tree}; }
+}
+
+package GitTreeObject
+{
+    @GitTreeObject::ISA = 'GitFileObject';
+    use GitUtils qw(cat_file _command_input_pipe_capture_output_oneline
+                    validate_kwargs);
+    use Carp;
+
+    sub debug_print { print @_ if $DEBUG; }
+
+    sub _git_object_factory
+    {
+        my %kwargs = @_;
+        my @mandatory = qw(tree_entry repo);
+        validate_kwargs(\%kwargs, @mandatory);
+        my ($repo, $tree_entry) = @kwargs{'repo', 'tree_entry'};
+
+        debug_print("git_object_factory called on entry '$tree_entry'");
+
+        if ($tree_entry =~ m/^([0-9]+) (blob|tree|commit) ([0-9a-z]+)\t(.*)/) {
+            my ($mode, $type, $sha, $path) = ($1, $2, $3, $4);
+            return $type eq 'tree' ?
+                  GitTreeObject->new(repo => $repo, sha => $sha, path => $path)
+                : GitFileObject->new(repo => $repo, mode => $mode,
+                                     objtype => $type, objsum => $sha,
+                                     path => $path);
+        }
+        else {
+            die "Could not parse tree entry: '$tree_entry'";
+        }
+    }
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+        my @mandatory = ('repo');
+        validate_kwargs(\%kwargs, @mandatory);
+        my ($sha, $path, $repo) = @kwargs{'sha', 'path', 'repo'};
+
+        my $self = $class->SUPER::new_tree(repo => $repo, sha => $sha,
+                                           path => $path);
+        my %children;
+
+        if (defined $sha) {
+            my @tree_entries = cat_file($repo, $sha);
+            %children = map {
+                my $o = _git_object_factory(repo => $repo, tree_entry => $_);
+                $o->path => $o;
+            } @tree_entries;
+        }
+
+        $self->{_children} = \%children;
+        $self->{parent} = undef;
+
+        bless $self, $class;
+    }
+
+    sub add_child
+    {
+        my ($self, $git_file_obj) = @_;
+
+        unless ($git_file_obj->isa('GitFileObject')) {
+            die "Child must be of type 'GitFileObject'";
+        }
+
+        # Do we already have an object with the same path?
+        # If we do then we just need to update the sha in the existing file obj
+        my $objpath = $git_file_obj->path;
+        if (exists $self->{_children}->{$objpath}) {
+            $self->{_children}->{$objpath}->set_objsum($git_file_obj->objsum);
+        }
+        else {
+            $self->{_children}->{$objpath} = $git_file_obj;
+        }
+    }
+
+    sub child_exists
+    {
+        my ($self, $path) = @_;
+        return defined $self->{_children}->{$path};
+    }
+
+    sub get_child
+    {
+        my ($self, $path) = @_;
+
+        my $obj = $self->{_children}->{$path};
+
+        unless (defined $obj) {
+            confess "Tried to get non-existent child at path '$path' from $self";
+        }
+
+        return $obj;
+    }
+
+    sub get_subtree
+    {
+        my ($self, $path) = @_;
+        my $child = $self->get_child($path);
+
+        unless ($child->isa('GitTreeObject')) {
+            die "Child at path '$path' is not a subtree";
+        }
+
+        return $child;
+    }
+
+    sub _make_tree
+    {
+        my ($self, @git_file_objs) = @_;
+
+        my @tree_entries = map { $_->tree_entry } @git_file_objs;
+        my $cmdinput = join("\n", @tree_entries);
+
+        my $treesum = try {
+            return _command_input_pipe_capture_output_oneline($self->{_repo},
+                $cmdinput, 'mktree');
+        }
+        catch Git::Error::Command with {
+            return undef;
+        };
+
+        return $treesum;
+    }
+
+    sub _write_tree
+    {
+        # Write the tree to git, recursively.
+        my $self = shift;
+        my @git_file_objs;
+
+        while (my ($path, $child) = each %{$self->{_children}}) {
+            if ($child->isa('GitTreeObject')) {
+                my $subtree_sum = $child->_write_tree;
+                $child->set_objsum($subtree_sum);
+            }
+
+            push @git_file_objs, $child;
+        }
+
+        my $treesum = $self->_make_tree(@git_file_objs);
+        return $treesum;
+    }
+
+    sub commit
+    {
+        my ($self, %kwargs) = @_;
+        my $commit_msg = $kwargs{commitmsg};
+        my $parentsum = $kwargs{parentsha};
+
+        my $treesum = $self->_write_tree;
+
+        debug_print("parentsum: $parentsum\n") if defined $parentsum;
+
+        my $commitsum = try {
+            if ($parentsum) {
+                return _command_input_pipe_capture_output_oneline(
+                    $self->{_repo}, $commit_msg, 'commit-tree',
+                    '-p', $parentsum, $treesum);
+            }
+            else {
+                return _command_input_pipe_capture_output_oneline(
+                    $self->{_repo}, $commit_msg, 'commit-tree', $treesum);
+            }
+        }
+        catch Git::Error::Command with {
+            return undef;
+        };
+        debug_print("commitsum: $commitsum\n");
+
+        return $commitsum;
+    }
+
+    # Returns a copy of the hash of children,
+    # modifying the result of this hash will not change the children
+    sub get_children
+    {
+        my $self = shift;
+        my %children = %{$self->{_children}};
+        return %children;
+    }
+}
+
+package Candidate
+{
+    use GitUtils qw(looks_like_sha validate_kwargs);
+    use Error qw(:try);
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+        my @kwarg_keys = keys %kwargs;
+
+        my @mandatory = qw(name repo);
+        validate_kwargs(\%kwargs, @mandatory);
+
+        my $self = {};
+        $self->{_name} = $kwargs{name};
+        $self->{_repo} = $kwargs{repo};
+        $self->{_tree} = GitTreeObject->new(repo => $kwargs{repo});
+        bless $self, $class;
+    }
+
+    sub new_from_sha
+    {
+        my ($class, %kwargs) = @_;
+
+        my @mandatory = ('repo', 'sha', 'name', 'ref');
+        validate_kwargs(\%kwargs, @mandatory);
+
+        my $self = {};
+        $self->{_tree} = GitTreeObject->new(repo => $kwargs{repo},
+            sha => GitCommitObject->new(repo => $kwargs{repo},
+                                        sha => $kwargs{sha})->tree
+        );
+
+        $self->{_repo} = $kwargs{repo};
+        $self->{_name} = $kwargs{name};
+        $self->{_sha} = $kwargs{sha};
+        $self->{_ref} = $kwargs{ref};
+        bless $self, $class;
+    }
+
+    sub name   { return $_[0]->{_name};                }
+    sub sha    { return $_[0]->{_sha};                 }
+    sub ref    { return $_[0]->{_ref};                 }
+    sub land   { return $_[0]->get_metadata->landinto; }
+    sub ontop  { return $_[0]->get_metadata->ontop;    }
+
+    sub add_child
+    {
+        my ($self, @args) = @_;
+        return $self->{_tree}->add_child(@args);
+    }
+
+    sub revision_tree_exists
+    {
+        return $_[0]->{_tree}->child_exists('revisions');
+    }
+
+    sub get_revision_tree
+    {
+        return $_[0]->{_tree}->get_subtree('revisions');
+    }
+
+    sub review_tree_exists
+    {
+        return $_[0]->{_tree}->child_exists('reviews');
+    }
+
+    sub get_review_tree
+    {
+        return $_[0]->{_tree}->get_subtree('reviews');
+    }
+
+    sub comment_tree_exists
+    {
+        return $_[0]->{_tree}->child_exists('comments');
+    }
+
+    sub get_comment_tree
+    {
+        return $_[0]->{_tree}->get_subtree('comments');
+    }
+
+    sub get_revision
+    {
+        my ($self, $sha) = @_;
+
+        die "Revision should be a sha" unless looks_like_sha($sha);
+
+        my $revisions = $self->get_revision_tree;
+        my $revision_obj = $revisions->get_child("revision.$sha");
+        my $revision = Revision->new_from_sha(repo => $self->{_repo},
+            sha => $revision_obj->objsum);
+    }
+
+    # Get an array of revisions stored in reverse order of submission
+    # (most recent submission first)
+    sub get_revisions
+    {
+        my $self = shift;
+
+        my @revisions;
+        my $rev = $self->get_revision($self->get_metadata->latestrevision);
+
+        while (1) {
+            push @revisions, $rev;
+            last if !defined $rev->parentrevision;
+            $rev = $self->get_revision($rev->parentrevision);
+        }
+
+        return @revisions;
+    }
+
+    sub revision_exists
+    {
+        my ($self, $revision_sha) = @_;
+
+        return 0 unless $self->revision_tree_exists;
+
+        my %revisions = $self->get_revision_tree->get_children;
+        return exists $revisions{"revision.$revision_sha"};
+    }
+
+    sub get_subtree_for_revision
+    {
+        my ($self, $revision_sha, $path) = @_;
+
+        return undef unless $self->{_tree}->child_exists($path);
+        my $tree = $self->{_tree}->get_child($path);
+
+        return ($tree->child_exists($revision_sha)) ?
+            $tree->get_subtree($revision_sha) : undef;
+    }
+
+    sub get_reviews_for_revision
+    {
+        my ($self, $revision_sha) = @_;
+        my $review_tree = $self->get_subtree_for_revision($revision_sha, 'reviews');
+        return undef unless defined $review_tree;
+        my %review_objs = $review_tree->get_children;
+
+        my @reviews = map { Review->new_from_sha(repo => $self->{_repo},
+                                          sha => $review_objs{$_}->objsum);
+        } keys %review_objs;
+
+        return \@reviews;
+    }
+
+    sub get_comments_for_revision
+    {
+        my ($self, $revision_sha) = @_;
+        return $self->get_subtree_for_revision($revision_sha, 'comments');
+    }
+
+    sub get_metaobj
+    {
+        my $self = shift;
+        return $self->{_tree}->get_child('candidate.meta');
+    }
+
+    sub get_metadata
+    {
+        my $self = shift;
+
+        my $metaobj = $self->get_metaobj;
+
+        return Metadata->new_from_sha(repo => $self->{_repo},
+            sha => $self->get_metaobj->objsum);
+    }
+
+    sub commit
+    {
+        my ($self, %kwargs) = @_;
+
+        return $self->{_tree}->commit(%kwargs);
+    }
+
+    sub get_head_commit_for_revision
+    {
+        my ($self, $revision_sha) = @_;
+
+        my $tree = $self->get_revision_tree;
+        my $revision_obj = $tree->get_child("revision.$revision_sha");
+
+        my $revision = Revision->new_from_sha(repo => $self->{_repo},
+            sha => $revision_obj->objsum);
+        return $revision->headcommit;
+    }
+
+    sub _update_friendly_ref
+    {
+        my ($self, %kwargs) = @_;
+        my @mandatory = ('sha');
+        for my $k (@mandatory) {
+            die "No '$k' provided" unless defined $kwargs{$k};
+        }
+
+        my $suffix = defined $kwargs{suffix} ? "_" . $kwargs{suffix} : '';
+        my $candidate_name = $self->{_name};
+        my $remote = defined $kwargs{remote} ? $kwargs{remote} . "/" : '';
+
+        my $namespace = $self->get_checkout_ref_namespace;
+        $self->{_repo}->command_oneline('update-ref',
+            "refs/$namespace/${remote}${candidate_name}$suffix", $kwargs{sha});
+    }
+
+    sub update_friendly_refs
+    {
+        my ($self, %kwargs) = @_;
+        my $remote = $kwargs{remote};
+
+        my @revisions = $self->get_revisions;
+        my $i = @revisions;
+        $self->_update_friendly_ref(sha => $revisions[0]->headcommit,
+                                    remote => $remote);
+
+        for my $revision (@revisions) {
+            $self->_update_friendly_ref(
+                sha => $revision->headcommit, suffix => "v$i",
+                remote => $remote);
+            $i--;
+        }
+    }
+
+    sub get_checkout_ref_namespace
+    {
+        my $self = shift;
+
+        my $namespace = try {
+            $self->{_repo}->config('candidates.namespace');
+        } catch Git::Error::Command with {
+            return undef
+        };
+
+        # Assume 'candidates' namespace if no namespace defined in config
+        return $namespace // 'candidates';
+    }
+}
+
+sub _no_pr_err
+{
+    my ($pr, $remote) = @_;
+
+    err("No such candidate '$pr'"
+        . (defined $remote ? " on remote '$remote'" : ""));
+}
+
+package MetaBase
+{
+    use GitUtils qw (inject_json cat_file validate_kwargs);
+    use JSON;
+    use Error qw(:try);
+
+    sub load_hash_from_sha
+    {
+        my ($class, $repo, $sha) = @_;
+
+        my $contents = try {
+            return cat_file($repo, $sha, undef);
+        }
+        catch Git::Error::Command with {
+            debug_print("exception caught in load_hash_from_sha\n");
+            return undef;
+        };
+
+        return undef unless defined $contents;
+        return decode_json($contents);
+    }
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+        bless {_sha => $kwargs{sha}}, $class;
+    }
+
+    sub new_from_sha
+    {
+        my ($class, %kwargs) = @_;
+
+        validate_kwargs(\%kwargs, 'repo', 'sha');
+
+        my $repo = $kwargs{repo};
+        my $sha = $kwargs{sha};
+
+        my $self = $class->new(sha => $sha,
+            %{$class->load_hash_from_sha($repo, $sha)});
+        bless $self, $class;
+    }
+
+    sub to_hash
+    {
+        ...
+    }
+
+    sub json
+    {
+        my $self = shift;
+
+        my $j = JSON->new->utf8(1)->pretty(1)->canonical(1);
+        my $json = $j->encode($self->to_hash);
+        return $json;
+    }
+
+    sub hash_and_insert
+    {
+        my ($self, $repo) = @_;
+        return inject_json($repo, $self->json);
+    }
+
+    sub sha { return $_[0]->{_sha}; }
+}
+
+package Comment
+{
+    @Comment::ISA = 'MetaBase';
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+
+        my $self = $class->SUPER::new(%kwargs);
+        $self->{_msg} = $kwargs{msg};
+        $self->{_line} = $kwargs{line};
+        $self->{_author} = $kwargs{author};
+        $self->{_time} = $kwargs{time};
+        $self->{_timezone} = $kwargs{timezone};
+
+        bless $self, $class;
+    }
+
+    sub to_hash
+    {
+        my $self = shift;
+
+        return {
+            msg => $self->{_msg},
+            line => $self->{_line},
+            author => $self->{_author},
+            time => $self->{_time},
+            timezone => $self->{_timezone}
+        };
+    }
+
+    sub         msg { return $_[0]->{_msg};      }
+    sub        line { return $_[0]->{_line};     }
+    sub      author { return $_[0]->{_author};   }
+    sub        time { return $_[0]->{_time};     }  # seconds since epoch
+
+    # hours east of UTC (as a string e.g. BST is +0100, EST is -0500)
+    sub    timezone { return $_[0]->{_timezone}; }
+}
+
+package Review
+{
+    @Review::ISA = 'Comment';
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+
+        return undef if (defined $kwargs{vote}
+            and !($kwargs{vote} =~ /(\+|-)[012]/));
+
+        my $self = $class->SUPER::new(%kwargs);
+        $self->{_vote} = $kwargs{vote};
+        bless $self, $class;
+    }
+
+    sub to_hash
+    {
+        my $self = shift;
+        my $h = $self->SUPER::to_hash;
+        $h->{vote} = $self->{_vote};
+
+        return $h;
+    }
+
+    sub vote { return $_[0]->{_vote}; };
+}
+
+package Revision
+{
+    @Revision::ISA = 'MetaBase';
+    use GitUtils qw(looks_like_sha);
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+
+        my @mandatory = ('headcommit', 'coverletter');
+        for my $k (@mandatory) {
+            die "Invalid revision data $k" unless defined $kwargs{$k};
+        }
+
+        unless (looks_like_sha($kwargs{headcommit})) {
+            die "headcommit should be a sha";
+        }
+
+        my $self = $class->SUPER::new(%kwargs);
+        $self->{_headcommit} = $kwargs{headcommit};
+        $self->{_coverletter} = $kwargs{coverletter};
+        $self->{_parentrevision} = $kwargs{parentrevision};
+
+        bless $self, $class;
+    }
+
+    sub to_hash
+    {
+        my $self = shift;
+
+        return {
+            headcommit => $self->{_headcommit},
+            coverletter => $self->{_coverletter},
+            parentrevision => $self->{_parentrevision},
+        }
+    }
+
+    sub headcommit     { return $_[0]->{_headcommit};     }
+    sub coverletter    { return $_[0]->{_coverletter};    }
+    sub parentrevision { return $_[0]->{_parentrevision}; }
+}
+
+package Metadata
+{
+    @Metadata::ISA = 'MetaBase';
+    use GitUtils qw (looks_like_sha validate_kwargs);
+
+    sub new
+    {
+        my ($class, %kwargs) = @_;
+
+        my @mandatory = ('state', 'landinto', 'ontop',
+                         'latestrevision', 'metadataversion');
+        validate_kwargs(\%kwargs, @mandatory);
+
+        my $self = $class->SUPER::new(%kwargs);
+        $self->{_state} = $self->set_state($kwargs{state});
+        $self->{_landinto} = $kwargs{landinto};
+        $self->{_ontop} = $kwargs{ontop};
+        $self->{_latestrevision} = $kwargs{latestrevision};
+        $self->{_metadataversion} = $kwargs{metadataversion};
+
+        bless $self, $class;
+    }
+
+    sub new_from_sha
+    {
+        my $class = shift;
+        my $self = $class->SUPER::new_from_sha(@_);
+
+        my $n = grep { $self->metadataversion eq $_ } @SUPPORTED_VERSIONS;
+        if ($n == 0) {
+            print STDERR "Cannot load candidate, unsupported version: "
+                . $self->metadataversion . ".\n";
+            exit 1
+        }
+
+        bless $self, $class;
+    }
+
+    sub new_from_candidate_sha
+    {
+        my ($class, %kwargs) = @_;
+
+        die "No repo provided" unless defined $kwargs{repo};
+        die "No sha provided"  unless defined $kwargs{sha};
+
+        my $repo = $kwargs{repo};
+        my $sha = $kwargs{sha};
+        my $metasha = $repo->command_oneline('rev-parse',
+            "$sha:candidate.meta");
+
+        my $self = $class->SUPER::new_from_sha(repo => $repo, sha => $metasha);
+
+        bless $self, $class;
+    }
+
+    sub to_hash
+    {
+        my $self = shift;
+
+        return {
+            state => $self->{_state},
+            landinto => $self->{_landinto},
+            ontop => $self->{_ontop},
+            latestrevision => $self->{_latestrevision},
+            metadataversion => $self->{_metadataversion}
+        };
+    }
+
+    sub state   { return $_[0]->{_state}; }
+    sub landinto { return $_[0]->{_landinto}; }
+    sub ontop { return $_[0]->{_ontop}; }
+    sub latestrevision { return $_[0]->{_latestrevision}; }
+    sub metadataversion { return $_[0]->{_metadataversion}; }
+
+    sub set_latestrevision
+    {
+        my ($self, $revision) = @_;
+
+        die "Revision must be a sha" unless looks_like_sha($revision);
+        $self->{_latestrevision} = $revision;
+    }
+
+    sub set_state
+    {
+        my ($self, $state) = @_;
+
+        my %valid_states = (merged => 1, active => 1);
+
+        unless (exists $valid_states{$state}) {
+            die "'$state' is not a valid state.";
+        }
+
+        $self->{_state} = $state;
+    }
+}
+
+sub err
+{
+    my $msg = shift;
+    print STDERR "$msg\n";
+    exit 1
+}
+
+sub candidate_already_exists
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $name) = @kwargs{'repo', 'name'};
+
+    return try {
+        $repo->command('show-ref', "$LOCAL_REF_PREFIX/${name}__meta");
+        return 1;
+    }
+    catch Git::Error::Command with {
+        return 0;
+    };
+}
+
+sub _pr_revise_edit_msg
+{
+    my $pr = shift;
+
+    my $PR_EDIT_MSG = <<EOF;
+# This message will become the cover letter
+# for the new revision of this candidate.
+# If you do not want to revise the candidate,
+# you should quit the editor without saving the file.
+#
+# Lines starting with '#' will be ignored,
+# and an empty message aborts the comment.
+#
+# Candidate: $pr
+EOF
+}
+
+sub _pr_create_edit_msg
+{
+    my ($pr, $commit, $landinto, $ontop) = @_;
+
+    my $PR_EDIT_MSG = <<EOF;
+
+
+# This message will become the cover letter for your candidate.
+# If you do not want to create the candidate, you should quit the editor
+# without saving the file.
+#
+# Lines starting with '#' will be ignored,
+# and an empty message aborts the comment.
+#
+# This candidate is called: $pr
+# It will be of $commit
+# Against $landinto at $ontop
+#
+EOF
+}
+
+sub file_has_none_whitespace_chars
+{
+    my $filepath = shift;
+
+    open(my $fh, '<', $filepath);
+
+    while (my $line = readline $fh) {
+        return 1 if $line !~ /^#/ and $line =~ /\S/;
+    }
+
+    return 0;
+}
+
+sub prompt_user
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo msg allow_empty_msg);
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $msg, $allow_empty_msg, $preplaced_text) = @kwargs{'repo',
+                                                           'msg',
+                                                           'allow_empty_msg',
+                                                           'preplaced_text'};
+
+    my $editmsg_fh = File::Temp->new(CLEANUP => 1);
+
+    my $presum = $repo->hash_object('blob', $editmsg_fh->filename);
+    if (defined $preplaced_text) {
+        $preplaced_text =~ s/\s+$/\n\n/;
+        print $editmsg_fh $preplaced_text . $msg;
+    }
+    else {
+        print $editmsg_fh $msg;
+    }
+
+    git_editor $editmsg_fh->filename;
+    my $postsum = $repo->hash_object('blob', $editmsg_fh->filename);
+
+    if ($presum eq $postsum) {
+        print STDERR "Message unchanged, aborting.\n";
+        exit 1;
+    }
+
+    if (!$allow_empty_msg and !file_has_none_whitespace_chars($editmsg_fh)) {
+        err("Message contains only whitespace, aborting.");
+    }
+
+    my $s;
+    seek $editmsg_fh, SEEK_SET, 0;
+
+    while (my $line = readline $editmsg_fh) {
+        $s .= $line unless $line =~ /^#/;
+    }
+
+    return $s;
+}
+
+sub get_candidate_refs
+{
+    my %kwargs = @_;
+    my @mandatory = ('repo');
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $name, $suffix, $remote) = @kwargs{'repo', 'name', 'suffix', 'remote'};
+
+    $name //= '[^\/]+';
+
+    my $ref_pattern = defined $remote ?
+        qr/refs\/candidates\/remotes\/(\Q$remote\E)\/${name}__$suffix/ :
+        qr/refs\/candidates\/heads\/${name}__$suffix/;
+
+    my @lines = $repo->command('show-ref');
+    my @matching_refs = grep { /$ref_pattern/ } @lines;
+    my %metarefs;
+
+    for my $ref (@matching_refs) {
+        debug_print("a matching ref: $ref\n");
+        my ($sha, $ref) = split(' ', $ref);
+        $ref =~ /$ref_pattern/;
+        $metarefs{$ref} = {sha => $sha};
+    }
+
+    return \%metarefs;
+}
+
+sub get_candidate_meta_refs
+{
+    my %kwargs = @_;
+    my ($repo, $name, $remote) = @kwargs{'repo', 'name', 'remote'};
+    validate_kwargs(\%kwargs, 'repo');
+
+    return get_candidate_refs(repo => $repo, suffix => 'meta',
+                              name => $name, remote => $remote);
+}
+
+sub get_candidate_anchor_refs
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo');
+    my ($repo, $name, $anchor_suffix, $remote) = @kwargs{'repo', 'name',
+                                                'anchorsuffix', 'remote'};
+    $anchor_suffix //= '';
+
+    return get_candidate_refs(repo => $repo, name => $name,
+                                suffix => "anchor__$anchor_suffix",
+                                remote => $remote);
+}
+
+sub get_candidate_anchor_ref
+{
+    my %kwargs = @_;
+
+    my $h = get_candidate_anchor_refs(%kwargs);
+    my $numof_refs = keys %$h;
+    confess "Multiple refs where only one expected" if $numof_refs > 1;
+    my ($ref, $ref_attrs) = each %$h;
+    return ($ref, $ref_attrs);
+}
+
+sub _name_from_pr_ref
+{
+    my $ref = shift;
+
+    $ref =~ /.*\/(.*)__meta/;
+    my $pr_name = $1;
+    return $pr_name;
+}
+
+sub display_meta_summary
+{
+    my ($metadata, $ref, $remote) = @_;
+
+    unless ($metadata) {
+        print STDERR "Warning: couldn't display summary for pr"
+                     . "with ref $ref\n";
+    }
+
+    my $state = $metadata->{state};
+    my $landinto = $metadata->{landinto};
+
+    my $pr = _name_from_pr_ref($ref);
+
+    $remote = defined $remote ? " ($remote)" : '';
+    print "$pr\t$state\t$landinto$remote\n";
+}
+
+sub find_remote_pr
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'name', 'remote');
+    my ($repo, $pr, $remote) = @kwargs{'repo', 'name', 'remote'};
+
+    my $href = get_candidate_meta_refs(repo => $repo,
+                                    name => $pr, remote => $remote);
+
+    my ($ref, $ref_attrs) = each %$href;
+    return ($ref, $ref_attrs);
+}
+
+sub find_local_pr
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'name');
+    my ($repo, $pr) = @kwargs{'repo', 'name'};
+
+    my $ref = "$LOCAL_REF_PREFIX/${pr}__meta";
+    my $ref_attrs = get_candidate_meta_refs(repo => $repo)->{$ref};
+
+    return undef unless defined $ref_attrs;
+    return ($ref, $ref_attrs);
+}
+
+sub parse_candidate_ref
+{
+    # Candidate refs may be local or remotes,
+    # since candidate names cannot contain a / character
+    # the remote can easily be parsed
+
+    my $ref = shift;
+
+    my $remote;
+    my $candidate_name;
+
+    if ($ref =~ /(?:([\/\w]+)\/)?(\w+(@\w+)?)$/) {
+        $remote = $1;
+        $candidate_name = "$2";
+    }
+    else {
+        err("Invalid candidate ref '$ref'.");
+    }
+
+    return ($remote, $candidate_name);
+}
+
+sub parse_input_name
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $name) = @kwargs{'repo', 'name'};
+
+    my $revision;
+
+    # Assume the latest revision by default
+    # else we will accept @<sha> also @<short-sha>
+    if ($name =~ /^(.*)@(.*)$/) {
+        $name = $1;
+        $revision = $repo->command_oneline('rev-parse', $2);
+
+        unless (looks_like_sha($revision)) {
+            err("Could not parse revision from '$name'.");
+        }
+    }
+
+    return ($name, $revision);
+}
+
+sub maybe_update_ref
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'ref', 'sha');
+    my ($repo, $ref, $sha) = @kwargs{'repo', 'ref', 'sha'};
+
+    if (is_object_present($repo, $ref)) {
+        print STDERR "localise_remote_pr: refusing to update existing ref '$ref' with '$sha'.";
+        return 0;
+    }
+
+    debug_print("Running update-ref on ref $ref for sha $sha");
+    $repo->command('update-ref', $ref, $sha);
+
+    return 1;
+}
+
+sub update_ref
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'ref', 'sha');
+    my ($repo, $ref, $sha) = @kwargs{'repo', 'ref', 'sha'};
+
+    $repo->command('update-ref', $ref, $sha);
+    return 1;
+}
+
+sub localise_anchor_refs
+{
+    my %kwargs = @_;
+    my @mandatory = ('repo', 'local_candidate_name',
+                    'remote_candidate_name', 'remote', 'refs');
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $local_candidate_name, $remote_candidate_name,
+        $remote, $remote_anchor_refs, $ignore_existing) = @kwargs{@mandatory, 'ignore_existing'};
+
+    my $update_fun = $ignore_existing ? \&update_ref : \&maybe_update_ref;
+
+    while (my ($ref, $ref_attrs) = each %$remote_anchor_refs) {
+        my $sha = $ref_attrs->{sha};
+        $ref =~ /$REMOTE_REF_PREFIX\/$remote\/${remote_candidate_name}__anchor__([0-9a-z]{40})/;
+        my $anchor_sha = $1;
+        my $update_complete = $update_fun->(repo => $repo,
+            ref => "$LOCAL_REF_PREFIX/${local_candidate_name}__anchor__${anchor_sha}",
+            sha => $sha);
+
+        return 0 unless $update_complete;
+    }
+
+    return 1;
+}
+
+sub localise_remote_candidate
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo remote_candidate_name remote);
+
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($repo, $remote_pr_name, $remote, $local_pr_name) = @kwargs{'repo',
+                   'remote_candidate_name', 'remote', 'local_candidate_name'};
+    return undef unless (defined $remote_pr_name and defined $remote);
+
+    # if no local pr name provided then
+    # assume the remote pr name as the local pr name
+    $local_pr_name //= $remote_pr_name;
+
+    # Take all pr refs from remote and add them under our local prefix
+    my $remote_meta_refs = get_candidate_meta_refs(repo => $repo,
+        name => $remote_pr_name, remote => $remote);
+    my $remote_anchor_refs = get_candidate_anchor_refs(repo => $repo,
+        name => $remote_pr_name, remote => $remote);
+
+    my $numof_meta_refs = keys %$remote_meta_refs;
+    my $numof_anchor_refs = keys %$remote_anchor_refs;
+
+    unless ($numof_meta_refs > 0 and $numof_anchor_refs > 0) {
+        print STDERR "failed to localise remote pr '$remote_pr_name' at '$remote'\n";
+        return 0;
+    }
+
+    my ($pr_meta_ref, $pr_meta_ref_attrs) = each %$remote_meta_refs;
+    my $pr_meta_sha = $pr_meta_ref_attrs->{sha};
+
+    my $update_complete = maybe_update_ref(repo => $repo,
+        ref => "$LOCAL_REF_PREFIX/${local_pr_name}__meta",
+        sha => $pr_meta_sha);
+
+    $update_complete = localise_anchor_refs(repo => $repo,
+        local_candidate_name => $local_pr_name, remote => $remote,
+        remote_candidate_name => $remote_pr_name, refs => $remote_anchor_refs);
+
+    return 0 unless $update_complete;
+
+    my $metadata = Metadata->new_from_candidate_sha(repo => $repo, sha => $pr_meta_sha);
+    my $revision = Revision->new_from_sha(repo => $repo,
+        sha => $metadata->latestrevision);
+
+    return find_local_pr(repo => $repo, name => $local_pr_name);
+}
+
+sub cmd_list
+{
+    my %kwargs = @_;
+    confess "No 'repo' provided" unless $kwargs{repo};
+    my ($repo, $remote) = @kwargs{'repo', 'remote'};
+    my $metarefs = get_candidate_meta_refs(repo => $repo, remote => $remote);
+
+    my @sorted_refs = sort {
+        my $pr_a = _name_from_pr_ref($a);
+        my $pr_b = _name_from_pr_ref($b);
+        return $pr_a cmp $pr_b;
+    } keys %$metarefs;
+
+    for my $ref (@sorted_refs) {
+        my $ref_attrs = $metarefs->{$ref};
+
+        my $metadata = Metadata->new_from_candidate_sha(repo => $repo,
+            sha => $ref_attrs->{sha});
+
+        my $state = $metadata->state;
+        my $landinto = $metadata->landinto;
+        my $pr = _name_from_pr_ref($ref);
+
+        print "$pr\t$state\t$landinto\n";
+    }
+}
+
+sub validate_candidate_name
+{
+    my $name = shift;
+
+    if ($name =~ /\//) {
+        err("The name of a candidate may not contain a '/'.");
+    }
+}
+
+sub cmd_create
+{
+    my %kwargs = @_;
+    my @mandatory = qw(name land msg allow_empty_msg repo);
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($name, $land, $msg, $allow_empty_msg, $repo) = @kwargs{'name', 'land',
+                                                     'msg', 'allow_empty_msg',
+                                                     'repo'};
+
+    my $ontop = get_sha_at_ref($repo, $land);
+
+    validate_candidate_name($name);
+    if (candidate_already_exists(repo => $repo, name => $name)) {
+        err("A candidate with that name already exists");
+    }
+
+    require_clean_work_tree($repo);
+
+    my $head_commit = get_head_commit($repo);
+    my $cover_letter = defined $msg ? "$msg\n" :
+        prompt_user(repo => $repo,
+                    msg => _pr_create_edit_msg($name, $head_commit,
+                                               $land, $ontop),
+                    allow_empty_msg => $allow_empty_msg);
+
+    my $candidate = Candidate->new(name => $name, repo => $repo);
+    my $revisiontree = GitTreeObject->new(repo => $repo,
+                                          sha => undef, path => 'revisions');
+
+    my $revisionsum = Revision->new(headcommit => $head_commit,
+        coverletter => $cover_letter,
+        parentrevision => undef)->hash_and_insert($repo);
+
+    my $revisionobj = GitFileObject->new_regular_blob(repo => $repo,
+        sha => $revisionsum, path => "revision.$revisionsum");
+    $revisiontree->add_child($revisionobj);
+
+    my $metasum = Metadata->new(state => 'active', landinto => $land,
+        ontop => $ontop,
+        latestrevision => $revisionsum,
+        metadataversion => $CANDIDATE_VERSION)->hash_and_insert($repo);
+    my $metafileobj = GitFileObject->new_regular_blob(repo => $repo,
+                            sha => $metasum, path => 'candidate.meta');
+    $candidate->add_child($metafileobj);
+    $candidate->add_child($revisiontree);
+
+    my $commitsum = $candidate->commit(commitmsg => "Create candidate $name",
+        parentsha => undef);
+
+    $repo->command_oneline('update-ref', '-m', "Creation of candidate $name",
+        "refs/candidates/heads/${name}__meta", $commitsum);
+
+    $repo->command_oneline('update-ref', '-m',
+        "Copying anchor for candidate $name",
+        "refs/candidates/heads/${name}__anchor__$revisionsum", $head_commit);
+
+    $candidate->update_friendly_refs;
+    print "Candidate $name created successfully.\n";
+}
+
+sub is_remote
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'remote');
+
+    my ($repo, $remote) = @kwargs{'repo', 'remote'};
+
+    my @remotes = $repo->command('remote');
+    my $n = grep { $_ eq $remote } @remotes;
+    return $n;
+}
+
+sub cmd_submit
+{
+    my %kwargs = @_;
+    my @mandatory = qw(worktreerepo repo name);
+    for my $k (@mandatory) {
+        die "No '$k' provided" unless defined $kwargs{$k};
+    }
+    my ($worktree_repo, $repo, $pr, $remote, $name) = @kwargs{
+            'worktreerepo', 'repo', 'name', 'remote', 'new_name'};
+
+    unless (is_remote(repo => $repo, remote => $remote)) {
+        err("Failed to submit candidate: '$remote' is not a remote.");
+    }
+
+    # Get our current branch so we can switch back after the rebase
+    my $initial_branch = get_head_branch($repo);
+    unless (defined $initial_branch) {
+        # HEAD is detached, just get the sha
+        $initial_branch = $repo->command_oneline('rev-parse', 'HEAD');
+    }
+
+    my ($pr_meta_ref, $ref_attrs) = find_local_pr(repo => $repo, name => $pr);
+    unless ($pr_meta_ref) {
+        err("candidate '$pr' does not exist");
+    }
+    my $remote_pr_meta_ref = defined $name ?
+        "$LOCAL_REF_PREFIX/${name}__meta" : $pr_meta_ref;
+
+    my $metadata = Metadata->new_from_candidate_sha(repo => $repo,
+        sha => $ref_attrs->{sha});
+    my $latest_revision = $metadata->latestrevision;
+
+    my ($pr_anchor_ref, ) = get_candidate_anchor_ref(repo => $repo, name => $pr,
+        anchorsuffix => $latest_revision);
+    unless ($pr_anchor_ref) {
+        err("Could not find anchor ref for candidate "
+            . "'$pr' revision $latest_revision\n"
+            . "candidate was not submitted.");
+    }
+
+    my $remote_anchor_ref = $pr_anchor_ref;
+    if (defined $name) {
+        $remote_anchor_ref =~ /$LOCAL_REF_PREFIX\/${pr}_anchor__([0-9a-z]{40})/;
+        my $sha = $1;
+        $remote_anchor_ref = "$LOCAL_REF_PREFIX/${name}_anchor__$sha";
+    }
+
+    # candidates must be uniquely named
+    try {
+        # 1. Determine if ref already exists on remote
+        my @remote_refs = $worktree_repo->command('ls-remote',
+                                                  $remote, $pr_meta_ref);
+        my $numof_matching_refs = @remote_refs;
+        if ($numof_matching_refs == 0) {
+            # This candidate hasn't been submitted before,
+            # so we just push and we're done
+            goto "push";
+        }
+
+        # 2. Fetch from $remote's refs/candidates/heads/candidate__meta
+        #    to $REMOTE_REF_PREFIX/<remotename>/candidate__meta
+        #
+        my $remote_ref = "$REMOTE_REF_PREFIX/$remote/${pr}__meta";
+        debug_print("running git fetch $remote $pr_meta_ref:$remote_ref\n");
+        $worktree_repo->command(['fetch', $remote, "$pr_meta_ref:$remote_ref"],
+            STDERR => $DEBUG ? undef : 0);
+
+        # 3. Rebase refs/candidates/heads/candidate__meta
+        #    on top of $REMOTE_REF_PREFIX/<remotename>/candidate__meta
+        #    (this cannot conflict)
+        debug_print("running git rebase $remote_ref $pr_meta_ref\n");
+
+        try {
+            my @rebase_output = $repo->command(
+                ['rebase', $remote_ref, $pr_meta_ref],
+                STDERR => $DEBUG ? undef : 0);
+        }
+        catch Git::Error::Command with {
+            $repo->command(['rebase', '--abort'], STDERR => $DEBUG ? undef : 0);
+            $repo->command(['checkout', $initial_branch], STDERR => $DEBUG ? undef : 0);
+            err("Candidate cannot be submitted.\n"
+                . "The latest revision of '$pr' does not seem to be based\n"
+                . "on the latest revision of '$pr' at remote '$remote'");
+        };
+
+        debug_print("running git update-ref $pr_meta_ref HEAD");
+        $repo->command(['update-ref', $pr_meta_ref, 'HEAD'], STDERR => $DEBUG ? undef : 0);
+
+        # Git rebase will checkout $remote_ref, so we need to switch back
+        # to whatever was checked out before here
+        debug_print("switching back to initial branch");
+        $repo->command(['checkout', $initial_branch], STDERR => $DEBUG ? undef : 0);
+push:
+        # 4. Push refs/candidates/heads/candidate__meta to
+        #    refs/candidates/heads/candidate__meta on the remote
+        #    and refs/candidates/heads/candidate__anchor__$sha to
+        #    refs/candidates/heads/candidate__anchor__$sha on the remote
+        debug_print("running git push $remote $pr_anchor_ref:$remote_anchor_ref\n");
+        $worktree_repo->command('push', $remote, "$pr_anchor_ref:$remote_anchor_ref",
+            "$pr_meta_ref:$remote_pr_meta_ref");
+    }
+    catch Git::Error::Command with {
+        err("Candidate was not submitted.");
+    };
+
+    print "Candidate was submitted successfully.\n";
+}
+
+sub cmd_revise
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($repo, $inputpr, $remote, $msg, $allow_empty_msg) = @kwargs{'repo',
+                                'name', 'remote', 'msg', 'allow_empty_msg'};
+
+    my $candidate = find_candidate(repo => $repo, name => $inputpr,
+                                   remote => $remote);
+    _no_pr_err($inputpr, $remote) unless defined $candidate;
+    my $name = $candidate->name;
+
+    my $head_commit = get_head_commit($repo);
+    my $metadata = $candidate->get_metadata;
+    my $latestrevision = $metadata->latestrevision;
+    my $current_revision = $candidate->get_revision($latestrevision);
+    if ($head_commit eq $current_revision->headcommit) {
+        err("This revision looks the same as the current revision. Exiting.");
+    }
+
+    my $cover_letter = defined $msg ? "$msg\n" :
+        prompt_user(repo => $repo,
+            msg => _pr_revise_edit_msg($name),
+            allow_empty_msg => $allow_empty_msg,
+            preplaced_text => $current_revision->coverletter);
+
+    my $revisionsum = Revision->new(headcommit => $head_commit,
+        coverletter => $cover_letter,
+        parentrevision => $latestrevision)->hash_and_insert($repo);
+    my $revisionobj = GitFileObject->new_regular_blob(repo => $repo,
+                    sha => $revisionsum, path => "revision.$revisionsum");
+
+    my $revisiontree = $candidate->get_revision_tree;
+    $revisiontree->add_child($revisionobj);
+    $metadata->set_latestrevision($revisionsum);
+    my $metasum = $metadata->hash_and_insert($repo);
+    $candidate->get_metaobj->set_objsum($metasum);
+
+    my $commitsum = $candidate->commit(commitmsg => "Revise $name",
+        parentsha => $candidate->sha);
+
+    $repo->command_oneline('update-ref', '-m', "Revision of candidate $name",
+        "refs/candidates/heads/${name}__meta", $commitsum);
+
+    $repo->command_oneline('update-ref', '-m',
+        "Copying anchor for candidate $name",
+        "refs/candidates/heads/${name}__anchor__$revisionsum", $head_commit);
+
+    $candidate->update_friendly_refs;
+
+    print "Candidate " . $candidate->name . " revised successfully.\n";
+}
+
+sub _candidate_review_edit_msg
+{
+    my ($candidate, $revision) = @_;
+
+    my $CANDIDATE_EDIT_MSG = <<EOF;
+
+
+#
+# Review summary for: $candidate (revision $revision)
+# Please enter the review summary for $candidate. Lines starting
+# with '#' will be ignored, and an empty message aborts the comment.
+EOF
+
+    return $CANDIDATE_EDIT_MSG;
+}
+
+sub _pr_comment_edit_msg
+{
+    my ($pr, $revision) = @_;
+
+    my $PR_EDIT_MSG = <<EOF;
+
+
+#
+# Comment for: $pr (revision $revision)
+# Please enter your comment on $pr. Lines starting
+# with '#' will be ignored, and an empty message aborts the comment.
+EOF
+
+    return $PR_EDIT_MSG;
+}
+
+sub merge_remote_candidate_into_local
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name remote local_ref local_ref_attrs);
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $candidate_name, $remote, $local_ref,
+        $local_ref_attrs, $rename) = @kwargs{'repo', 'name', 'remote',
+                                             'local_ref', 'local_ref_attrs',
+                                             'rename'};
+
+    # b. if there's a local version then things are less simple,
+    #    we must perform a merge iff the latest revision of the remote
+    #    candidate_name is a descendant of the latest revision of the local candidate_name
+    #
+    #    if it's not then we refuse to update the local candidate_name and prompt
+    #    for a new name for this candidate_name
+    my ($remote_ref, $remote_ref_attrs) = find_remote_pr(repo => $repo,
+        name => $candidate_name, remote => $remote);
+
+    unless (defined $remote_ref) {
+        err("candidate '$candidate_name' does not exist in remote '$remote'.");
+    }
+
+    # Get the latest revision for the local candidate_name
+    my $local_sha = $local_ref_attrs->{sha};
+    my $local_pr_metadata = Metadata->new_from_candidate_sha(repo => $repo,
+        sha => $local_sha);
+    my $local_latest_revision = $local_pr_metadata->latestrevision;
+    debug_print("local_latest_revision: $local_latest_revision\n");
+
+    # Get the latest revision for the remote candidate_name
+    my $remote_sha = $remote_ref_attrs->{sha};
+    my $remote_pr_metadata = Metadata->new_from_candidate_sha(repo => $repo,
+        sha => $remote_sha);
+    my $remote_latest_revision = $remote_pr_metadata->latestrevision;
+    debug_print("remote_latest_revision: $remote_latest_revision\n");
+    my $remote_candidate = Candidate->new_from_sha(repo => $repo,
+        sha => $remote_sha, name => $candidate_name, ref => $remote_ref);
+    my $remote_revision_tree = $remote_candidate->get_revision_tree;
+
+    unless (defined $remote_revision_tree) {
+        err("Could not build revision tree for candidate '$candidate_name'");
+    }
+
+    my %revision_objs = $remote_revision_tree->get_children;
+    my %revisions;
+    while (my ($path, $revision_obj) = each %revision_objs) {
+        $revisions{$revision_obj->objsum} = Revision->new_from_sha(
+            repo => $repo, sha => $revision_obj->objsum);
+    }
+
+    # a kind of dummy revision with a parent pointing to
+    # the current latest revision...
+    my $rev = Revision->new(headcommit => sprintf("%040s", ''),
+        coverletter => 'dummy',
+        parentrevision => $remote_latest_revision);
+    my $found = 0;
+
+    while (defined $rev->parentrevision) {
+        if ($rev->parentrevision eq $local_latest_revision) {
+            $found = 1;
+            last;
+        }
+
+        $rev = $revisions{$rev->parentrevision};
+    }
+
+    if ($found) {
+        # The remote candidate_name is based off the current local candidate_name,
+        # so merge the remote into the local
+
+        my $original_branch = get_head_branch($repo);
+        unless (defined $original_branch) {
+            # HEAD is detached, just get the sha
+            $original_branch = $repo->command_oneline('rev-parse', 'HEAD');
+        }
+
+        $repo->command(['checkout', $local_ref], STDERR => $DEBUG ? undef : 0);
+        $repo->command(['merge', $remote_ref], STDERR => $DEBUG ? undef : 0);
+        $repo->command(['update-ref', $local_ref, 'HEAD'], STDERR => $DEBUG ? undef : 0);
+        $repo->command(['checkout', $original_branch], STDERR => $DEBUG ? undef : 0);
+
+        my $remote_anchor_refs = get_candidate_anchor_refs(repo => $repo,
+                            name => $candidate_name, remote => $remote);
+
+        my $update_complete = localise_anchor_refs(repo => $repo,
+            ignore_existing => 1,
+            local_candidate_name => $candidate_name, remote => $remote,
+            remote_candidate_name => $candidate_name, refs => $remote_anchor_refs);
+
+        return ($candidate_name,
+                find_local_pr(repo => $repo, name => $candidate_name));
+    }
+    else {
+        # The remote candidate_name isn't related to the current local candidate_name
+        # so get new name from --rename option,
+        # we must error here if the user hasn't specified another name
+        # with --rename
+
+        my $new_candidate_name;
+        if (defined $rename) {
+            $new_candidate_name = $rename;
+        }
+        else {
+            err("A local candidate called '$candidate_name' already exists\n"
+                . "but the candidate '$candidate_name' at '$remote' does not seem "
+                . "to be related to it.\nRun with --rename <name> to "
+                . "localise '$candidate_name' under a new name.");
+        }
+
+        my ($r, ) = find_local_pr(repo => $repo, name => $new_candidate_name);
+
+        validate_candidate_name($new_candidate_name);
+
+        my $is_localised = localise_remote_candidate(
+            remote_candidate_name => $candidate_name, remote => $remote,
+            local_canidate_name => $new_candidate_name);
+
+        return undef unless $is_localised;
+
+        print "candidate '$candidate_name' from '$remote' "
+        . "is now known as '$new_candidate_name' . \n";
+
+        return ($new_candidate_name,
+                find_local_pr(repo => $repo, name => $new_candidate_name));
+    }
+}
+
+sub copy_candidate_from_remote
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name remote);
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $candidate_name, $remote) = @kwargs{@mandatory};
+
+    # a. if there's no local version of this candidate_name,
+    # we just copy the candidate_name from the remote
+
+    my ($ref, $ref_attrs) = find_remote_pr(repo => $repo,
+                                name => $candidate_name, remote => $remote);
+    return undef unless defined $ref;
+
+    ($ref, $ref_attrs) = localise_remote_candidate(repo => $repo,
+        remote_candidate_name => $candidate_name, remote => $remote);
+
+    unless (defined $ref) {
+        err("Failed to localise candidate '$candidate_name' from remote '$remote'");
+    }
+
+    return ($candidate_name, $ref, $ref_attrs);
+}
+
+sub find_candidate
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo', 'name');
+    my ($repo, $candidate_name, $remote, $rename) = @kwargs{'repo', 'name',
+                                                         'remote', 'rename'};
+
+    my ($local_ref, $local_ref_attrs) = find_local_pr(repo => $repo,
+                                                      name => $candidate_name);
+
+    # 1. If we have no remote then things are very simple,
+    # check for the candidate_name locally,
+    # if it doesn't exist then we have no candidate_name, and we're done.
+    unless (defined $remote) {
+        return defined $local_ref_attrs->{sha} ?
+            Candidate->new_from_sha(repo => $repo,
+                sha => $local_ref_attrs->{sha},
+                name => $candidate_name, ref => $local_ref) : undef;
+    }
+
+    # 2. If we have a remote, then, find the candidate from the given remote
+    my ($new_candidate_name, $ref, $ref_attrs) = defined $local_ref ?
+        merge_remote_candidate_into_local(repo => $repo,
+            name => $candidate_name,
+            remote => $remote, local_ref => $local_ref,
+            local_ref_attrs => $local_ref_attrs, rename => $rename) :
+        copy_candidate_from_remote(repo => $repo, name => $candidate_name,
+                                   remote => $remote);
+
+    # 3. We're note quite finished, we also need to set up the "friendly refs"
+    # locally, to allow the user to checkout any revision of this newly
+    # localised candidate.
+    unless (defined $ref_attrs->{sha}) {
+        return undef; # it might just not exist
+    }
+
+    my $candidate = Candidate->new_from_sha(repo => $repo, ref => $ref,
+        name => $new_candidate_name, sha => $ref_attrs->{sha});
+
+    $candidate->update_friendly_refs(remote => $remote);
+    return $candidate;
+}
+
+sub cmd_review
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    for my $k (@mandatory) {
+        die "No '$k' provided" unless defined $kwargs{$k};
+    }
+
+    my ($repo, $unparsed_input_name, $remote, $vote, $msg, $rename,
+        $allow_empty_msg) = @kwargs{'repo', 'name', 'remote', 'vote',
+                                    'msg', 'rename', 'allow_empty_msg'};
+
+    my ($input_name, $revision_sha) = parse_input_name(repo => $repo,
+                                                name => $unparsed_input_name);
+    my $candidate = find_candidate(repo => $repo, name => $input_name,
+        remote => $remote, rename => $rename);
+    _no_pr_err($input_name, $remote) unless defined $candidate;
+    my $name = $candidate->name;
+
+    my $metadata = $candidate->get_metadata;
+    $revision_sha //= $metadata->latestrevision;
+
+    my $comment = defined $msg ? "$msg\n" :
+        prompt_user(repo => $repo,
+            msg => _candidate_review_edit_msg($name, $revision_sha),
+            allow_empty_msg => $allow_empty_msg);
+
+    my $author_name = $repo->config('user.name');
+    my $author_email = $repo->config('user.email');
+
+    my $current_time = time;
+    my $timezone = $repo->get_tz_offset;
+
+    unless ($candidate->revision_exists($revision_sha)) {
+        err("candidate '$name' does not have revision $revision_sha.");
+    }
+
+    my $reviewsum = Review->new(msg => $comment, line => undef,
+        author => "$author_name <$author_email>",
+        time => $current_time, timezone => $timezone,
+        vote => $vote)->hash_and_insert($repo);
+    my $review_file_obj = GitFileObject->new_regular_blob(repo => $repo,
+                             sha => $reviewsum, path => "review.$reviewsum");
+
+    unless ($candidate->review_tree_exists) {
+        $candidate->add_child(
+            GitTreeObject->new(repo => $repo, sha => undef, path => 'reviews'));
+    }
+    my $review_tree = $candidate->get_review_tree;
+
+    unless ($review_tree->child_exists($revision_sha)) {
+        $review_tree->add_child(
+            GitTreeObject->new(repo => $repo, sha => undef, path => $revision_sha));
+    }
+    $review_tree->get_child($revision_sha)->add_child($review_file_obj);
+
+    my $commitsum = $candidate->commit(commitmsg => 'Add review',
+        parentsha => $candidate->sha);
+    unless ($commitsum) {
+        err("Failed to commit review");
+    }
+
+    $repo->command_oneline('update-ref',
+        "refs/candidates/heads/${name}__meta", $commitsum);
+
+    $candidate->update_friendly_refs;
+
+    print "Review added successfully\n";
+}
+
+sub cmd_fetch
+{
+    my %kwargs = @_;
+    my @mandatory =('repo', 'remote');
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($repo, $remote) = @kwargs{'repo', 'remote'};
+
+    unless (is_remote(repo => $repo, remote => $remote)) {
+        err("Failed to fetch candidates: '$remote' is not a remote.");
+    }
+
+    git_cmd_try {
+        my $output = $repo->command('fetch', $remote,
+            "+refs/candidates/heads/*:$REMOTE_REF_PREFIX/$remote/*");
+    } "Failed to fetch candidates";
+
+    # Now for every candidate in $remote, create a ref in refs/heads/$pr_space
+    my $remote_meta_refs = get_candidate_meta_refs(repo => $repo,
+                                                remote => $remote);
+
+    while (my ($ref, $ref_attrs) = each %$remote_meta_refs) {
+        my $name = _name_from_pr_ref($ref);
+        my $metadata = Metadata->new_from_candidate_sha(repo => $repo,
+                                                        sha => $ref);
+        my $revision = Revision->new_from_sha(repo => $repo,
+            sha => $metadata->latestrevision);
+
+        my $candidate = Candidate->new_from_sha(repo => $repo,
+            sha => $ref_attrs->{sha}, name => $name, ref => $ref);
+        $candidate->update_friendly_refs(remote => $remote);
+    }
+}
+
+sub get_comments_from_tree
+{
+    my %kwargs = @_;
+    my @mandatory = ('repo', 'tree', 'path', 'hashref');
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $tree, $path, $hashref) = @kwargs{@mandatory};
+
+    debug_print("in get_comments_from_tree: tree: $tree, path: $path\n");
+
+    my %children = $tree->get_children;
+
+    while (my ($k, $child) = each %children) {
+        debug_print("child: $child\n");
+
+        if ($child->objtype eq 'tree') {
+            get_comments_from_tree(repo => $repo, tree => $child,
+                            path => ($path ? "$path/" : $path) . $child->path,
+                            hashref => $hashref);
+        }
+        elsif ($child->objtype eq 'blob') {
+            $hashref->{$path} //= ();
+            my $c = Comment->new_from_sha(repo => $repo,
+                sha => $child->objsum);
+            debug_print("c: $c\n");
+            push @{$hashref->{$path}}, $c;
+        }
+        else {
+            err('commit obj in the comment tree. this is very unexpected...');
+        }
+    }
+}
+
+sub get_comments_hashref
+{
+    my %kwargs = @_;
+    my @mandatory = ('repo', 'tree');
+    validate_kwargs(\%kwargs, @mandatory);
+    my ($repo, $tree) = @kwargs{'repo', 'tree'};
+
+    my $h = {};
+    get_comments_from_tree(repo => $repo, tree=> $tree,
+                           path => "", hashref => $h);
+    return $h;
+}
+
+sub cmd_status
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($repo, $unparsed_input_pr, $remote) = @kwargs{'repo', 'name', 'remote'};
+
+    my ($pr, $revision) = parse_input_name(repo => $repo,
+                                           name => $unparsed_input_pr);
+    my ($ref, $ref_attrs) = (defined $remote) ?
+        find_remote_pr(repo => $repo, name => $pr, remote => $remote) :
+        find_local_pr(repo => $repo, name => $pr);
+
+    unless (defined $ref) {
+        _no_pr_err($pr, $remote);
+    }
+
+    my $candidate = Candidate->new_from_sha(repo => $repo,
+        sha => $ref_attrs->{sha}, name => $pr, ref => $ref);
+    my $metadata = $candidate->get_metadata;
+    $revision //= $metadata->latestrevision;
+
+    print "Revision: $revision\n";
+
+    my $checkout_ref_namespace = $candidate->get_checkout_ref_namespace;
+    my $p = (defined $remote ? "$remote/" : "") . $pr;
+    print "Ref: $checkout_ref_namespace/$p\n";
+    print "Status: " . $metadata->state . "\n";
+    print "Land: " . $metadata->landinto . "\n";
+
+    my $r = $candidate->get_revision($revision);
+    my $headcommit = $r->headcommit;
+
+    if (defined $r->coverletter) {
+        print "\n";
+        indent_print(string => $r->coverletter, indent => 0);
+        print "\n";
+    }
+
+    my $diff_stat = $repo->command('diff', '--stat',
+        $metadata->ontop, $headcommit);
+    print "$diff_stat\n";
+
+    my $reviews_for_revision = $candidate->get_reviews_for_revision($revision);
+
+    if (defined $reviews_for_revision) {
+        print "-"x80;
+        my @sorted_reviews = sort {
+            $a->time <=> $b->time
+        } @$reviews_for_revision;
+
+        my $numof_reviews = @sorted_reviews;
+        print "\n$numof_reviews " . ($numof_reviews == 1 ? "review" : "reviews") . "\n";
+        print "-"x80 . "\n\n";
+
+        for my $review (@sorted_reviews) {
+            my $author = $review->author;
+            my $vote = $review->vote;
+            my $timezone = $review->timezone;
+
+            indent_print(string => "Author: $author", indent => 4);
+
+            my $datetime = strftime("%a %b %d %H:%M:%S %Y", localtime($review->time));
+            indent_print(string => "Date:   $datetime $timezone", indent => 4);
+            if (defined $review->vote) {
+                indent_print(string => "Vote:   $vote", indent => 4);
+            }
+
+            my $msg = $review->msg;
+            print "\n";
+            indent_print(string => $msg, indent => 4);
+
+            print "\n" . '-'x80 . "\n\n"; # separate reviews
+        }
+    }
+
+    my $comments_for_revision = $candidate->get_comments_for_revision($revision);
+
+    if (defined $comments_for_revision) {
+        print "-"x80;
+        my $comments = get_comments_hashref(repo => $repo,
+                                            tree => $comments_for_revision);
+        my @files = sort { $a cmp $b } keys %$comments;
+
+        my $numof_comments;
+        map { $numof_comments += @{$comments->{$_}} } @files;
+        print "\n$numof_comments " . ($numof_comments == 1 ? "comment" : "comments") . "\n";        print "-"x80 . "\n\n";
+
+        for my $file (@files) {
+            my $cs = $comments->{$file};
+
+            my @comments_on_file = sort { $a->time <=> $b->time } @$cs;
+
+            for my $comment (@comments_on_file) {
+                print "$file:\n";
+                my $datetime = strftime("%a %b %d %H:%M:%S %Y",
+                    localtime($comment->time));
+                my $author = $comment->author;
+                my $timezone = $comment->timezone;
+
+                indent_print(string => "Author: $author", indent => 4);
+                indent_print(string => "Date:   $datetime $timezone", indent => 4);
+                print "\n";
+                indent_print(string => $comment->msg, indent => 4);
+                print "\n" . '-'x80 . "\n\n"; # separate reviews
+            }
+        }
+    }
+}
+
+sub cmd_comment_file
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name file);
+    validate_kwargs(\%kwargs, @mandatory);
+
+    my ($repo, $unparsed_input_name, $file_path, $remote, $msg,
+        $rename, $allow_empty_msg) = @kwargs{'repo', 'name', 'file', 'remote',
+                                          'msg', 'rename', 'allow_empty_msg'};
+
+    my ($input_name, $revision_sha) = parse_input_name(repo => $repo,
+                                                name => $unparsed_input_name);
+    my $candidate = find_candidate(repo => $repo, name => $input_name,
+        remote => $remote, rename => $rename);
+
+    _no_pr_err($input_name, $remote) unless defined $candidate;
+
+    my $name = $candidate->name;
+    my $metadata = $candidate->get_metadata;
+    # If no revision specified then assume latest
+    $revision_sha //= $metadata->latestrevision;
+
+    # Check that this revision actually exists in the candidate tree first >.>
+    unless ($candidate->revision_exists($revision_sha)) {
+        err("candidate '$name' does not have revision $revision_sha.");
+    }
+
+    my $author_name = $repo->config('user.name');
+    err("Could not get 'user.name' from config.") unless defined $author_name;
+
+    my $author_email = $repo->config('user.email');
+    err("Could not get 'user.email' from config.") unless defined $author_email;
+
+    my $current_time = time;
+    err("Could not get current time") unless defined $current_time;
+
+    my $timezone = $repo->get_tz_offset;
+    err("Could not get time zone") unless defined $timezone;
+
+    # We need to have validated the file path argument *before*
+    # we pop open a comment window
+    my $revision = Revision->new_from_sha(repo => $repo, sha => $revision_sha);
+    my $revision_head = $revision->headcommit;
+    my $parent_revision;
+
+    if (defined $revision->parentrevision) {
+        $parent_revision = Revision->new_from_sha(repo => $repo,
+                sha => $revision->parentrevision);
+    }
+
+    my @lines;
+
+    try {
+        @lines = cat_file($repo, $revision_head, $file_path, STDERR => 0);
+    }
+    catch Git::Error::Command with {
+        if (defined $parent_revision) {
+            try {
+                @lines = cat_file($repo, $parent_revision->headcommit,
+                    $file_path, STDERR => 0);
+            }
+            catch Git::Error::Command with {
+                err("No such file '$file_path'");
+            };
+        }
+        else {
+            # Check land
+            try {
+                @lines = cat_file($repo, $candidate->ontop, $file_path, STDERR => 0);
+            }
+            catch Git::Error::Command with {
+                err("No such file '$file_path'");
+            };
+        }
+    };
+
+    my $comment = defined $msg ? "$msg\n" :
+        prompt_user(repo => $repo,
+            msg => _pr_comment_edit_msg($name, $revision_sha),
+            allow_empty_msg => $allow_empty_msg);
+
+    open(my $fh, '<', \$comment);
+    my @comment_lines;
+    # Read comment from stdin (limit comment length)
+    my $count = 0;
+    while (my $line = readline($fh)) {
+        push @comment_lines, $line;
+        last if $count++ >= $MAX_COMMENT_LEN;
+    }
+
+    my $comment_text = join('', @comment_lines);
+    debug_print("comment_text: $comment_text");
+
+    my $comment_line = -1;
+    my $commentsum = Comment->new(msg => $comment_text, line => $comment_line,
+        author => "$author_name <$author_email>", time => $current_time,
+        timezone => $timezone)->hash_and_insert($repo);
+    my $comment_file_obj = GitFileObject->new_regular_blob(repo => $repo,
+                        sha => $commentsum, path => "comment.$commentsum");
+
+    # Construct tree if necessary, and insert comment into it.
+    unless ($candidate->comment_tree_exists) {
+        $candidate->add_child(
+            GitTreeObject->new(repo => $repo, sha => undef, path => 'comments'));
+    }
+    my $commenttree = $candidate->get_comment_tree;
+
+    unless ($commenttree->child_exists($revision_sha)) {
+        $commenttree->add_child(
+            GitTreeObject->new(repo => $repo, sha => undef, path => $revision_sha));
+    }
+    my $comment_subtree = $commenttree->get_child($revision_sha);
+
+    # What if our file is in a directory?
+    # We can either escape the forward-slash
+    # or have a tree for each directory...
+    my $filetree;
+    my $file;
+    my $filetree_parent;
+
+    if ($file_path =~ /.*\/.*/) {
+        # Set up directory trees if needed
+
+        my @components = split('/', $file_path);
+        my $numof_components = @components;
+
+        my @head = @components[0 .. $numof_components - 2];
+        my $tail = $components[-1];
+
+        my $prev = $comment_subtree;
+
+        for my $component (@head) {
+            unless ($prev->child_exists($component)) {
+                $prev->add_child(
+                    GitTreeObject->new(repo => $repo, sha => undef, path => $component));
+            }
+            $prev = $prev->get_child($component);
+        }
+
+        $file = $tail;
+        $filetree_parent = $prev;
+    }
+    else {
+        $file = $file_path;
+        $filetree_parent = $comment_subtree;
+    }
+
+    unless ($filetree_parent->child_exists($file)) {
+        $filetree_parent->add_child(
+            GitTreeObject->new(repo => $repo, sha => undef, path => $file));
+    }
+    $filetree_parent->get_child($file)->add_child($comment_file_obj);
+
+    my $commitsum = $candidate->commit(commitmsg => 'Add comment',
+        parentsha => $candidate->sha);
+
+    unless ($commitsum) {
+        err("Failed to commit comment");
+    }
+
+    $repo->command_oneline('update-ref', '-m', "Add comment",
+        $candidate->ref, $commitsum);
+
+    print "Comment added successfully\n";
+}
+
+sub cmd_show_revisions
+{
+    my %kwargs = @_;
+    my @mandatory = qw(repo name);
+    for my $k (@mandatory) {
+        die "No '$k' provided" unless defined $kwargs{$k};
+    }
+    my ($repo, $pr, $remote) = @kwargs{'repo', 'name', 'remote'};
+
+    my ($ref, $ref_attrs) = defined $remote ?
+        find_remote_pr(repo => $repo, name => $pr, remote => $remote) :
+        find_local_pr(repo => $repo, name => $pr);
+
+    _no_pr_err($pr, $remote) unless defined $ref;
+
+    my $candidate = Candidate->new_from_sha(repo => $repo,
+        sha => $ref_attrs->{sha}, ref => $ref, name => $pr);
+    my @revisions = $candidate->get_revisions;
+    my $numof_revisions = @revisions;
+    for my $rev (@revisions) {
+        print $rev->sha . " (v$numof_revisions)\n";
+        $numof_revisions--;
+    }
+}
+
+sub cmd_remove
+{
+    my %kwargs = @_;
+    my @mandatory = qw(name repo);
+    for my $k (@mandatory) {
+        die "No '$k' provided" unless defined $kwargs{$k};
+    }
+    my ($repo, $name) = @kwargs{'repo', 'name'};
+
+    # All we want to do is remove the refs associated with a candidate
+    my ($ref, $ref_attrs) = find_local_pr(repo => $repo, name => $name);
+
+    _no_pr_err($name, undef) unless defined $ref;
+
+    # The anchors, what are they,
+    # find the revisions, find the anchors
+    my $candidate = Candidate->new_from_sha(repo => $repo,
+        sha => $ref_attrs->{sha}, ref => $ref, name => $name);
+    my @revisions = $candidate->get_revisions;
+    my @anchor_refs = map {
+        my($anchor_ref, ) = get_candidate_anchor_ref(repo => $repo, name => $name,
+                          anchorsuffix => $_->sha);
+        $anchor_ref;
+    } @revisions;
+    remove_refs($repo, @anchor_refs, $ref);
+
+    print "Candidate '$name' removed successfully.\n";
+}
+
+sub cmd_gc_refs
+{
+    my %kwargs = @_;
+    validate_kwargs(\%kwargs, 'repo');
+    my $repo = $kwargs{repo};
+
+    my @remotes = $repo->command('remote');
+
+    my @refs = map {
+        my ($sha, $ref) = split(' ', $_);
+        $ref;
+    } $repo->command('show-ref');
+    my @filtered_refs = grep { /^refs\/candidates\/remotes/ } @refs;
+
+    for my $ref (@filtered_refs) {
+        my @bools = map {
+            my $remote = $_;
+            $ref =~ /^refs\/candidates\/remotes\/$remote/;
+        } @remotes;
+
+        my $any = grep { $_ eq 1 } @bools;
+
+        unless ($any) {
+            print "remove $ref\n" unless $any;
+            $repo->command('update-ref', '-d', $ref);
+        }
+    }
+}
+
+my %usages = (
+    create => [
+        'create CANDIDATE LAND [-m <cover letter>]', 'Create a new candidate'
+    ],
+    revise => [
+        'revise CANDIDATE [-m <cover letter>] [--rename <name>]',
+        'Make a new revision of a candidate'
+    ],
+    review => [
+        'review CANDIDATE [--rename <name>] [--vote -2|-1|-0|+0|+1|+2] [-m <msg>]',
+        'Review a candidate'
+    ],
+    submit => [
+        'submit REMOTE CANDIDATE [NAME]', 'Submit a candidate'
+    ],
+    fetch => [
+        'fetch REMOTE', 'Fetch candidates'
+    ],
+    list => [
+        'list [REMOTE]', 'List candidates along with their status'
+    ],
+    status => [
+        'status CANDIDATE', 'Show status of a candidate'
+    ],
+    'comment-file' => [
+        'comment-file CANDIDATE FILE [--rename <name>] [-m <msg>]',
+        'Comment on a file in a candidate'
+    ],
+    'show-revisions' => [
+        'show-revisions CANDIDATE', 'List revisions (most recent first)'
+    ],
+    remove => [
+        'remove CANDIDATE', 'Remove a candidate'
+    ],
+    'gc-refs' => [
+        'gc-refs', 'Removes any remote candidates that belong to remotes' .
+                    'that no longer exist.'
+    ]
+);
+
+sub usage
+{
+    my $cmd = shift;
+
+    if ($cmd) {
+        my ($usage, ) = @{$usages{$cmd}};
+        print "usage: git candidate " . $usage . "\n";
+    }
+    else {
+        print "usage: git candidate [options] <cmd> [args]\n\n"
+              . "Primary sub-commands are:\n";
+
+        my $max_len = 0;
+
+        my @xs = sort {
+            my ($cmd_a, ) = @$a; my ($cmd_b, ) = @$b;
+            $cmd_a cmp $cmd_b
+        } values %usages;
+
+        for my $x (@xs) {
+            my ($cmd_usage, $cmd_description) = @$x;
+            $max_len = length($cmd_usage) > $max_len ?
+                length($cmd_usage) : $max_len;
+        }
+
+        # There must be max_len + gap padding between usage and description
+        my $gap = 5;
+        for my $x (@xs) {
+            my ($cmd_usage, $cmd_description) = @$x;
+            printf("%*s%s\n", ($max_len + $gap) * -1,
+                $cmd_usage, $cmd_description); # -ve for left-justification
+        }
+    }
+
+    exit 1;
+}
+
+sub git_repo_check
+{
+    my $repo = shift;
+    # Yes I know this is awful
+    unless (defined $repo) {
+        try {
+            Git::command_oneline('rev-parse')
+        }
+        catch Git::Error::Command with {
+            # the rev-parse process prints the desired err msg for us
+            exit 1;
+        };
+    }
+}
+
+sub runcmd {
+    my ($fun, %kwargs) = @_;
+
+    # Perform whatever global checks we need
+    git_repo_check($kwargs{repo});
+
+    $fun->(%kwargs);
+}
+
+my %cmds = (
+    create => sub {
+        my $msg;
+        my $allow_empty_msg;
+        GetOptions("m=s" => \$msg,
+            "allow-empty-message" => \$allow_empty_msg);
+        my $argc = @ARGV;
+        usage('create') unless $argc == 3;
+
+        my ($name, $land) = @ARGV[1, 2];
+        my $repo = get_repo(with_user_worktree => 1);
+
+        runcmd(\&cmd_create, name => $name, land => $land, msg => $msg,
+            allow_empty_msg => $allow_empty_msg, repo => $repo);
+    },
+    list => sub {
+        my $argc = @ARGV;
+        usage('list') unless ($argc == 1 or $argc == 2);
+
+        my $remote = $ARGV[1];
+        my $repo = get_repo;
+
+        runcmd(\&cmd_list, repo => get_repo, remote => $remote);
+    },
+    submit => sub {
+        my $argc = @ARGV;
+        usage('submit') unless ($argc == 3 or $argc == 4);
+
+        my ($cmd, $remote, $name, $new_name) = @ARGV;
+        runcmd(\&cmd_submit, repo => get_repo(with_user_worktree => 0),
+               worktreerepo => get_repo(with_user_worktree => 1),
+               name => $name, remote => $remote, new_name => $new_name);
+    },
+    fetch => sub {
+        my $argc = @ARGV;
+        usage('fetch') unless $argc == 2;
+
+        my $remote = $ARGV[1];
+        # Working tree is required since remotes are stored in .git/config
+        # which is probably not tracked by the repo
+        runcmd(\&cmd_fetch, repo => get_repo(with_user_worktree => 1), remote => $remote);
+    },
+    revise => sub {
+        my $msg;
+        my $allow_empty_msg;
+        GetOptions("m=s" => \$msg,
+            'allow-empty-message' => \$allow_empty_msg);
+        my $argc = @ARGV;
+        usage('revise') unless $argc == 2;
+
+        my ($remote, $name) = parse_candidate_ref($ARGV[1]);
+
+        runcmd(\&cmd_revise, repo => get_repo, name => $name,
+            remote => $remote, msg => $msg,
+            allow_empty_msg => $allow_empty_msg);
+    },
+    review => sub {
+        my $msg;
+        my $vote;
+        my $rename;
+        my $allow_empty_msg;
+        GetOptions("m=s" => \$msg, "vote=s" => \$vote, "rename=s" => \$rename,
+            'allow-empty-message' => \$allow_empty_msg);
+        if (defined $vote and !($vote =~ /(\+|-)[012]/)) {
+            err("Invalid vote option. "
+                . "(a vote must be one of -2, -1, -0, +0, +1, +2)");
+        }
+
+        my $argc = @ARGV;
+        usage('review') unless $argc == 2;
+
+        my ($remote, $name) = parse_candidate_ref($ARGV[1]);
+        runcmd(\&cmd_review, repo => get_repo, name => $name,
+            remote => $remote, vote => $vote, msg => $msg,
+            rename => $rename, allow_empty_msg => $allow_empty_msg);
+    },
+    status => sub {
+        my $argc = @ARGV;
+        usage('status') unless $argc == 2;
+
+        my ($remote, $name) = parse_candidate_ref($ARGV[1]);
+        runcmd(\&cmd_status, repo => get_repo, name => $name,
+            remote => $remote);
+    },
+    'comment-file' => sub {
+        my $msg;
+        my $rename;
+        my $allow_empty_msg;
+        GetOptions("m=s" => \$msg, "rename=s" => \$rename,
+            'allow-empty-message' => \$allow_empty_msg);
+        my $argc = @ARGV;
+        usage('comment-file') unless ($argc == 2 or $argc == 3);
+
+        my ($remote, $name) = parse_candidate_ref($ARGV[1]);
+
+        my $file = $ARGV[2];
+        runcmd(\&cmd_comment_file, name => $name, file => $file,
+            remote => $remote, msg => $msg, rename => $rename,
+            allow_empty_msg => $allow_empty_msg, repo => get_repo);
+    },
+    'show-revisions' => sub {
+        my $argc = @ARGV;
+        usage('show-revisions') unless $argc == 2;
+
+        my ($remote, $name) = parse_candidate_ref($ARGV[1]);
+        runcmd(\&cmd_show_revisions, repo => get_repo, name => $name,
+            remote => $remote);
+    },
+    remove => sub {
+        my $argc = @ARGV;
+        usage('remove') unless ($argc == 2);
+
+        my $name = $ARGV[1];
+        runcmd(\&cmd_remove, repo => get_repo, name => $name);
+    },
+    'gc-refs' => sub { runcmd(\&cmd_gc_refs, repo => get_repo); }
+);
+
+my $argc = @ARGV;
+usage unless $argc >= 1;
+
+my $cmd = $ARGV[0];
+usage unless exists $cmds{$cmd};
+
+$cmds{$cmd}->();
-- 
2.1.4
