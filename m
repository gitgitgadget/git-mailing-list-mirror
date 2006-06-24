From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 11/12] Git.pm: Add support for subdirectories inside of working copies
Date: Sat, 24 Jun 2006 04:34:51 +0200
Message-ID: <20060624023451.32751.16021.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftxzl-0006kM-7a
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbWFXCfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933198AbWFXCfc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64919 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933203AbWFXCfb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:31 -0400
Received: (qmail 384 invoked from network); 24 Jun 2006 04:34:51 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:51 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22475>

This patch adds support for subdirectories inside of working copies;
you can specify them in the constructor either as the Directory
option (it will just get autodetected using rev-parse) or explicitly
using the WorkingSubdir option. This makes Git->repository() do the
exact same path setup and repository lookup as the Git porcelain
does.

This patch also introduces repo_path(), wc_path() and wc_subdir()
accessor methods and wc_chdir() mutator.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 perl/Git.pm |  157 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 129 insertions(+), 28 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index e2b66c4..7bbb5be 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -69,20 +69,18 @@ (In the future, we will also get a new_r
 called as methods of the object are then executed in the context of the
 repository.
 
-TODO: In the future, we might also do
+Part of the "repository state" is also information about path to the attached
+working copy (unless you work with a bare repository). You can also navigate
+inside of the working copy using the C<wc_chdir()> method. (Note that
+the repository object is self-contained and will not change working directory
+of your process.)
 
-	my $subdir = $repo->subdir('Documentation');
-	# Gets called in the subdirectory context:
-	$subdir->command('status');
+TODO: In the future, we might also do
 
 	my $remoterepo = $repo->remote_repository (Name => 'cogito', Branch => 'master');
 	$remoterepo ||= Git->remote_repository ('http://git.or.cz/cogito.git/');
 	my @refs = $remoterepo->refs();
 
-So far, all functions just die if anything goes wrong. If you don't want that,
-make appropriate provisions to catch the possible deaths. Better error recovery
-mechanisms will be provided in the future.
-
 Currently, the module merely wraps calls to external Git tools. In the future,
 it will provide a much faster way to interact with Git by linking directly
 to libgit. This should be completely opaque to the user, though (performance
@@ -93,6 +91,7 @@ increate nonwithstanding).
 
 use Carp qw(carp croak); # but croak is bad - throw instead
 use Error qw(:try);
+use Cwd qw(abs_path);
 
 require XSLoader;
 XSLoader::load('Git', $VERSION);
@@ -119,12 +118,17 @@ B<Repository> - Path to the Git reposito
 B<WorkingCopy> - Path to the associated working copy; not strictly required
 as many commands will happily crunch on a bare repository.
 
-B<Directory> - Path to the Git working directory in its usual setup. This
-is just for convenient setting of both C<Repository> and C<WorkingCopy>
-at once: If the directory as a C<.git> subdirectory, C<Repository> is pointed
-to the subdirectory and the directory is assumed to be the working copy.
-If the directory does not have the subdirectory, C<WorkingCopy> is left
-undefined and C<Repository> is pointed to the directory itself.
+B<WorkingSubdir> - Subdirectory in the working copy to work inside.
+Just left undefined if you do not want to limit the scope of operations.
+
+B<Directory> - Path to the Git working directory in its usual setup.
+The C<.git> directory is searched in the directory and all the parent
+directories; if found, C<WorkingCopy> is set to the directory containing
+it and C<Repository> to the C<.git> directory itself. If no C<.git>
+directory was found, the C<Directory> is assumed to be a bare repository,
+C<Repository> is set to point at it and C<WorkingCopy> is left undefined.
+If the C<$GIT_DIR> environment variable is set, things behave as expected
+as well.
 
 You should not use both C<Directory> and either of C<Repository> and
 C<WorkingCopy> - the results of that are undefined.
@@ -134,7 +138,10 @@ to the constructor; it is equivalent to 
 field.
 
 Calling the constructor with no options whatsoever is equivalent to
-calling it with C<< Directory => '.' >>.
+calling it with C<< Directory => '.' >>. In general, if you are building
+a standard porcelain command, simply doing C<< Git->repository() >> should
+do the right thing and setup the object to reflect exactly where the user
+is right now.
 
 =cut
 
@@ -152,18 +159,59 @@ sub repository {
 		} else {
 			%opts = @args;
 		}
+	}
+
+	if (not defined $opts{Repository} and not defined $opts{WorkingCopy}) {
+		$opts{Directory} ||= '.';
+	}
+
+	if ($opts{Directory}) {
+		-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
+
+		my $search = Git->repository(WorkingCopy => $opts{Directory});
+		my $dir;
+		try {
+			$dir = $search->command_oneline(['rev-parse', '--git-dir'],
+			                                STDERR => 0);
+		} catch Git::Error::Command with {
+			$dir = undef;
+		};
 
-		if ($opts{Directory}) {
-			-d $opts{Directory} or throw Error::Simple("Directory not found: $!");
-			if (-d $opts{Directory}."/.git") {
-				# TODO: Might make this more clever
-				$opts{WorkingCopy} = $opts{Directory};
-				$opts{Repository} = $opts{Directory}."/.git";
-			} else {
-				$opts{Repository} = $opts{Directory};
+		if ($dir) {
+			$opts{Repository} = abs_path($dir);
+
+			# If --git-dir went ok, this shouldn't die either.
+			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
+			$dir = abs_path($opts{Directory}) . '/';
+			if ($prefix) {
+				if (substr($dir, -length($prefix)) ne $prefix) {
+					throw Error::Simple("rev-parse confused me - $dir does not have trailing $prefix");
+				}
+				substr($dir, -length($prefix)) = '';
 			}
-			delete $opts{Directory};
+			$opts{WorkingCopy} = $dir;
+			$opts{WorkingSubdir} = $prefix;
+
+		} else {
+			# A bare repository? Let's see...
+			$dir = $opts{Directory};
+
+			unless (-d "$dir/refs" and -d "$dir/objects" and -e "$dir/HEAD") {
+				# Mimick git-rev-parse --git-dir error message:
+				throw Error::Simple('fatal: Not a git repository');
+			}
+			my $search = Git->repository(Repository => $dir);
+			try {
+				$search->command('symbolic-ref', 'HEAD');
+			} catch Git::Error::Command with {
+				# Mimick git-rev-parse --git-dir error message:
+				throw Error::Simple('fatal: Not a git repository');
+			}
+
+			$opts{Repository} = abs_path($dir);
 		}
+
+		delete $opts{Directory};
 	}
 
 	$self = { opts => \%opts };
@@ -256,7 +304,7 @@ sub command_oneline {
 	my ($fh, $ctx) = command_output_pipe(@_);
 
 	my $line = <$fh>;
-	chomp $line;
+	defined $line and chomp $line;
 	try {
 		_cmd_close($fh, $ctx);
 	} catch Git::Error::Command with {
@@ -374,7 +422,7 @@ # Implemented in Git.xs.
 
 =item exec_path ()
 
-Return path to the git sub-command executables (the same as
+Return path to the Git sub-command executables (the same as
 C<git --exec-path>). Useful mostly only internally.
 
 Implementation of this function is very fast; no external command calls
@@ -385,6 +433,58 @@ are involved.
 # Implemented in Git.xs.
 
 
+=item repo_path ()
+
+Return path to the git repository. Must be called on a repository instance.
+
+=cut
+
+sub repo_path { $_[0]->{opts}->{Repository} }
+
+
+=item wc_path ()
+
+Return path to the working copy. Must be called on a repository instance.
+
+=cut
+
+sub wc_path { $_[0]->{opts}->{WorkingCopy} }
+
+
+=item wc_subdir ()
+
+Return path to the subdirectory inside of a working copy. Must be called
+on a repository instance.
+
+=cut
+
+sub wc_subdir { $_[0]->{opts}->{WorkingSubdir} ||= '' }
+
+
+=item wc_chdir ( SUBDIR )
+
+Change the working copy subdirectory to work within. The C<SUBDIR> is
+relative to the working copy root directory (not the current subdirectory).
+Must be called on a repository instance attached to a working copy
+and the directory must exist.
+
+=cut
+
+sub wc_chdir {
+	my ($self, $subdir) = @_;
+
+	$self->wc_path()
+		or throw Error::Simple("bare repository");
+
+	-d $self->wc_path().'/'.$subdir
+		or throw Error::Simple("subdir not found: $!");
+	# Of course we will not "hold" the subdirectory so anyone
+	# can delete it now and we will never know. But at least we tried.
+
+	$self->{opts}->{WorkingSubdir} = $subdir;
+}
+
+
 =item hash_object ( FILENAME [, TYPE ] )
 
 =item hash_object ( FILEHANDLE [, TYPE ] )
@@ -584,8 +684,9 @@ # for the given repository and execute t
 sub _cmd_exec {
 	my ($self, @args) = @_;
 	if ($self) {
-		$self->{opts}->{Repository} and $ENV{'GIT_DIR'} = $self->{opts}->{Repository};
-		$self->{opts}->{WorkingCopy} and chdir($self->{opts}->{WorkingCopy});
+		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
+		$self->wc_path() and chdir($self->wc_path());
+		$self->wc_subdir() and chdir($self->wc_subdir());
 	}
 	_execv_git_cmd(@args);
 	die "exec failed: $!";
