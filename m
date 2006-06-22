From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] [RFC] Introduce Git.pm
Date: Thu, 22 Jun 2006 02:35:46 +0200
Message-ID: <20060622003546.17760.23089.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 02:41:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtDG2-0000AD-J3
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 02:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWFVAlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 20:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWFVAlP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 20:41:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20630 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751534AbWFVAlP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 20:41:15 -0400
Received: (qmail 17798 invoked from network); 22 Jun 2006 02:35:46 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 22 Jun 2006 02:35:46 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22292>

This patch introduces a very basic and barebone Git.pm module
with a sketch of how the generic interface would look like;
most functions are missing, but this should give some good base.
I will expand it in the next days.

Most desirable now is proper error reporting, generic_in() for feeding
input to Git commands and the repository() constructor doing some poking
with git-rev-parse to get the git directory and subdirectory prefix.
Those three are basically the prerequisities for converting git-mv.

Currently Git.pm just wraps up exec()s of Git commands, but even that
is not trivial to get right and various Git perl scripts do it in
various inconsistent ways. And things will get much more interesting
when we get to XS-izing libgit.

This adds the Git.pm, integrates it to the build system and as an example
converts the git-fmt-merge-msg.perl script to it (the result is not very
impressive since its advantage is not quite apparent in this one, but I
just picked up the simplest Git user around).

This is mostly to show up what I have so far and gather some comments
on the general shapes of the interface; I guess in the current shape
of the API it's suitable for pu at best, but that's not my call.

My current working state is available all the time at

	http://pasky.or.cz/~xpasky/git-perl/Git.pm

and an irregularily updated API documentation is at

	http://pasky.or.cz/~xpasky/git-perl/Git.html

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile               |   13 ++
 git-fmt-merge-msg.perl |    9 +-
 perl/Git.pm            |  284 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL       |   14 ++
 4 files changed, 314 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0887945..59eca6d 100644
--- a/Makefile
+++ b/Makefile
@@ -479,7 +479,8 @@ ### Build rules
 
 all: $(ALL_PROGRAMS) $(BUILT_INS) git$X gitk
 
-all:
+all: perl/Makefile
+	$(MAKE) -C perl
 	$(MAKE) -C templates
 
 strip: $(PROGRAMS) git$X
@@ -511,7 +512,7 @@ common-cmds.h: Documentation/git-*.txt
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
 	rm -f $@ $@+
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $@.perl >$@+
 	chmod +x $@+
@@ -599,6 +600,9 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
+perl/Makefile:	perl/Git.pm perl/Makefile.PL
+	(cd perl && $(PERL_PATH) Makefile.PL PREFIX="$(prefix)")
+
 doc:
 	$(MAKE) -C Documentation all
 
@@ -618,6 +622,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 	@FLAGS='$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
 		echo 1>&2 "    * new build flags or prefix"; \
+		echo 1>&2 "    * $$FLAGS != `cat GIT-CFLAGS 2>/dev/null`"; \
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
@@ -654,6 +659,7 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates install
+	$(MAKE) -C perl install
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	$(INSTALL) $(PYMODULES) '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
@@ -721,7 +727,8 @@ clean:
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	rm -f $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
-	$(MAKE) -C templates clean
+	[ ! -e perl/Makefile ] || $(MAKE) -C perl/ clean
+	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS
 
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
index 5986e54..a2da46e 100755
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -6,6 +6,9 @@ # Read .git/FETCH_HEAD and make a human 
 # by grouping branches and tags together to form a single line.
 
 use strict;
+use Git;
+
+my $repo = Git->repository();
 
 my @src;
 my %src;
@@ -28,12 +31,12 @@ sub andjoin {
 }
 
 sub repoconfig {
-	my ($val) = qx{git-repo-config --get merge.summary};
+	my ($val) = $repo->generic_oneline('repo-config', '--get', 'merge.summary');
 	return $val;
 }
 
 sub current_branch {
-	my ($bra) = qx{git-symbolic-ref HEAD};
+	my ($bra) = $repo->generic_oneline('symbolic-ref', 'HEAD');
 	chomp($bra);
 	$bra =~ s|^refs/heads/||;
 	if ($bra ne 'master') {
@@ -47,7 +50,7 @@ sub current_branch {
 sub shortlog {
 	my ($tip) = @_;
 	my @result;
-	foreach ( qx{git-log --no-merges --topo-order --pretty=oneline $tip ^HEAD} ) {
+	foreach ($repo->generic('log', '--no-merges', '--topo-order', '--pretty=oneline', $tip, '^HEAD')) {
 		s/^[0-9a-f]{40}\s+//;
 		push @result, $_;
 	}
diff --git a/perl/Git.pm b/perl/Git.pm
new file mode 100644
index 0000000..2f968c5
--- /dev/null
+++ b/perl/Git.pm
@@ -0,0 +1,284 @@
+=head1 NAME
+
+Git - Perl interface to the Git version control system
+
+=cut
+
+
+package Git;
+
+use strict;
+
+use vars qw ($VERSION @ISA @EXPORT @EXPORT_OK);
+
+# Totally unstable API.
+$VERSION = "0.0.1";
+
+
+=head1 SYNOPSIS
+
+  use Git;
+
+  my $version = Git::generic_oneval('version');
+
+  Git::generic_vocal('update-server-info');
+
+  my $repo = Git->repository (Directory => '/srv/git/cogito.git');
+
+
+  my @revs = $repo->generic('rev-list', '--since=last monday', '--all');
+
+  my $fh = $repo->generic('rev-list', '--since=last monday', '--all');
+  my $lastrev = <$fh>; chomp $lastrev;
+  close $fh;
+
+  my $lastrev = $repo->generic_oneval('rev-list', '--all');
+
+=cut
+
+
+require Exporter;
+
+@ISA = qw(Exporter);
+
+@EXPORT = qw();
+
+# Methods which can be called as standalone functions as well:
+@EXPORT_OK = qw(generic generic_oneval generic_vocal);
+
+
+=head1 DESCRIPTION
+
+This module provides Perl scripts easy way to interface the Git version control
+system. The modules have an easy and well-tested way to call arbitrary Git
+commands; in the future, the interface will also provide specialized methods
+for doing easily operations which are not totally trivial to do over the generic
+interface.
+
+While some commands can be executed outside of any context (e.g. 'version'
+or 'init-db'), most operations require a repository context, which in practice
+means getting an instance of the Git object using the repository() constructor.
+(In the future, we will also get a new_repository() constructor.) All commands
+called as methods of the object are then executed in the context of the
+repository.
+
+TODO: In the future, we might also do
+
+	my $subdir = $repo->subdir('Documentation');
+	# Gets called in the subdirectory context:
+	$subdir->generic('status');
+
+	my $remoterepo = $repo->remote_repository (name => 'cogito', branch => 'master');
+	$remoterepo ||= Git->remote_repository ('http://git.or.cz/cogito.git/');
+	my @refs = $remoterepo->refs();
+
+So far, all functions just die if anything goes wrong. If you don't want that,
+make appropriate provisions to catch the possible deaths. Better error recovery
+mechanisms will be provided in the future.
+
+Currently, the module merely wraps calls to external Git tools. In the future,
+it will provide a much faster way to interact with Git by linking directly
+to libgit. This should be completely opaque to the user, though (performance
+increate nonwithstanding).
+
+=cut
+
+
+use IPC::Open3;
+
+
+=head1 CONSTRUCTORS
+
+=over 4
+
+=item repository ( OPTIONS )
+
+=item repository ( DIRECTORY )
+
+=item repository ()
+
+Construct a new repository object.
+C<OPTIONS> are passed in a hash like fashion, using key and value pairs.
+Possible options are:
+
+B<Repository> - Path to the Git repository.
+
+B<WorkingCopy> - Path to the associated working copy; not strictly required
+as many commands will happily crunch on a bare repository.
+
+B<Directory> - Path to the Git working directory in its usual setup. This
+is just for convenient setting of both C<Repository> and C<WorkingCopy>
+at once: If the directory as a C<.git> subdirectory, C<Repository> is pointed
+to the subdirectory and the directory is assumed to be the working copy.
+If the directory does not have the subdirectory, C<WorkingCopy> is left
+undefined and C<Repository> is pointed to the directory itself.
+
+You should not use both C<Directory> and either of C<Repository> and
+C<WorkingCopy> - the results of that are undefined.
+
+Alternatively, a directory path may be passed as a single scalar argument
+to the constructor; it is equivalent to setting only the C<Directory> option
+field.
+
+Calling the constructor with no options whatsoever is equivalent to
+calling it with C<< Directory => '.' >>.
+
+=cut
+
+sub repository {
+	my $class = shift;
+	my @args = @_;
+	my %opts = ();
+	my $self;
+
+	if (defined $args[0]) {
+		if ($#args % 2 != 1) {
+			# Not a hash.
+			$#args == 0 or die "Git::repository(): bad usage";
+			%opts = (Directory => $args[0]);
+		} else {
+			%opts = @args;
+		}
+
+		if ($opts{Directory}) {
+			-d $opts{Directory} or die "Git::repository($opts{Directory}): $!";
+			if (-d $opts{Directory}."/.git") {
+				# TODO: Might make this more clever
+				$opts{WorkingCopy} = $opts{Directory};
+				$opts{Repository} = $opts{Directory}."/.git";
+			} else {
+				$opts{Repository} = $opts{Directory};
+			}
+			delete $opts{Directory};
+		}
+	}
+
+	$self = { opts => \%opts };
+	bless $self, $class;
+}
+
+
+=back
+
+=head1 METHODS
+
+=over 4
+
+=item generic ( COMMAND [, ARGUMENTS... ] )
+
+Execute the given Git C<COMMAND> (specify it without the 'git-'
+prefix), optionally with the specified extra C<ARGUMENTS>. The method can be
+called without any instance or on a specified Git repository.
+
+In scalar context, it returns a filehandle containing the command output.
+
+In array context, it returns an array containing lines printed to the
+command's stdout.
+
+In both cases, the command's stdin and stderr are the same as the caller's.
+
+=cut
+
+sub generic {
+	my ($self, $cmd, @args) = _maybe_self(@_);
+
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or die "bad command: $cmd";
+
+	my $pid = open(my $fh, "-|");
+	if ($pid < 0) {
+		die "generic($cmd, @args) open: $!";
+	} elsif ($pid == 0) {
+		_do_exec($self, $cmd, @args);
+	}
+
+	return $fh unless wantarray;
+
+	my @lines = <$fh>;
+	close $fh;
+	chomp @lines;
+	return @lines;
+}
+
+=item generic_oneline ( COMMAND [, ARGUMENTS... ] )
+
+Execute the given C<COMMAND> in the same way as generic()
+does but always return a scalar string containing the first line
+of the command's standard output.
+
+=cut
+
+sub generic_oneline {
+	my $fh = generic(@_);
+	my $line = <$fh>;
+	close $fh;
+	chomp $line;
+	return $line;
+}
+
+=item generic_vocal ( COMMAND [, ARGUMENTS... ] )
+
+Execute the given C<COMMAND> in the same way as generic() does but does not
+capture the command output - the standard output is not redirected and goes
+to the standard output of the caller application.
+
+While the method is called generic_vocal(), you might want to as well use
+it for the most silent Git commands which you know will never pollute your
+stdout but you want to avoid the overhead of the pipe setup when calling them.
+
+The function returns only after the command has finished running.
+
+=cut
+
+sub generic_vocal {
+	my ($self, $cmd, @args) = _maybe_self(@_);
+
+	$cmd =~ /^[a-z0-9A-Z_-]+$/ or die "bad command: $cmd";
+
+	my $pid = fork;
+	if ($pid < 0) {
+		die "generic_vocal($cmd, @args) fork: $!";
+	} elsif ($pid == 0) {
+		_do_exec($self, $cmd, @args);
+	}
+	waitpid($pid, 0);
+}
+
+
+=back
+
+=head1 TODO
+
+This is still fairly crude. Repository objects not yet supported.
+We need some good way to report errors back except just dying.
+
+=head1 COPYRIGHT
+
+Copyright 2006 by Petr Baudis E<lt>pasky@suse.czE<gt>.
+
+This module is free software; it may be used, copied, modified
+and distributed under the terms of the GNU General Public Licence,
+either version 2, or (at your option) any later version.
+
+=cut
+
+
+# Takes raw method argument list and returns ($obj, @args) in case
+# the method was called upon an instance and (undef, @args) if
+# it was called directly.
+sub _maybe_self {
+	# This breaks inheritance. Oh well.
+	ref $_[0] eq 'Git' ? @_ : (undef, @_);
+}
+
+# When already in the subprocess, set up the appropriate state
+# for the given repository and execute the git command.
+sub _do_exec {
+	my ($self, @args) = @_;
+	if ($self) {
+		$self->{opts}->{Repository} and $ENV{'GIT_DIR'} = $self->{opts}->{Repository};
+		$self->{opts}->{WorkingCopy} and chdir($self->{opts}->{WorkingCopy});
+	}
+	exec ('git', @args) or die "Git exec: $!";
+}
+
+1; # Famous final words
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
new file mode 100644
index 0000000..703ea98
--- /dev/null
+++ b/perl/Makefile.PL
@@ -0,0 +1,14 @@
+use ExtUtils::MakeMaker;
+
+sub MY::postamble {
+	return <<'MAKE_FRAG';
+instlibdir:
+	@echo $(INSTALLSITELIB)
+
+MAKE_FRAG
+}
+
+WriteMakefile(
+	NAME            => 'Git',
+	VERSION_FROM    => 'Git.pm'
+);
