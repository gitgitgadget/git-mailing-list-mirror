From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: Kill Git.xs for now
Date: Sat, 23 Sep 2006 20:20:47 +0200
Message-ID: <20060923181849.28753.56984.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 20:20:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRC7R-00041K-L0
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWIWSUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWIWSUu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 14:20:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13992 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751397AbWIWSUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 14:20:49 -0400
Received: (qmail 28964 invoked by uid 2001); 23 Sep 2006 20:20:47 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27612>

This patch removes Git.xs from the repository for the time being. This
should hopefully enable Git.pm to finally make its way to master.

Git.xs is not going away forever. When the Git libification makes some
progress, it will hopefully return (but most likely as an optional
component, due to the portability woes) since the performance boosts are
really important for applications like Gitweb or Cogito. It needs to go
away now since it is not really reliable in case you use it for several
repositories in the scope of a single process, and that is not possible
to fix without some either very ugly or very intrusive core changes.

Rest in peace. (While you can.)

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile         |   17 ++-----
 perl/.gitignore  |    3 -
 perl/Git.pm      |   76 ++++---------------------------
 perl/Git.xs      |  134 ------------------------------------------------------
 perl/Makefile.PL |    9 ----
 5 files changed, 15 insertions(+), 224 deletions(-)

diff --git a/Makefile b/Makefile
index dd74908..58848e4 100644
--- a/Makefile
+++ b/Makefile
@@ -116,8 +116,6 @@ PIC_FLAG = -fPIC
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-PERL_CFLAGS =
-PERL_LDFLAGS =
 STRIP ?= strip
 
 prefix = $(HOME)
@@ -158,9 +156,10 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powe
 ### --- END CONFIGURATION SECTION ---
 
 # Those must not be GNU-specific; they are shared with perl/ which may
-# be built by a different compiler.
-BASIC_CFLAGS = $(PERL_CFLAGS)
-BASIC_LDFLAGS = $(PERL_LDFLAGS)
+# be built by a different compiler. (Note that this is an artifact now
+# but it still might be nice to keep that distinction.)
+BASIC_CFLAGS = 
+BASIC_LDFLAGS = 
 
 SCRIPT_SH = \
 	git-bisect.sh git-branch.sh git-checkout.sh \
@@ -784,15 +783,9 @@ XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
 
 
-PERL_DEFINE = $(BASIC_CFLAGS) -DGIT_VERSION='"$(GIT_VERSION)"'
-PERL_DEFINE_SQ = $(subst ','\'',$(PERL_DEFINE))
-PERL_LIBS = $(BASIC_LDFLAGS) $(EXTLIBS)
-PERL_LIBS_SQ = $(subst ','\'',$(PERL_LIBS))
 perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 	(cd perl && $(PERL_PATH) Makefile.PL \
-		PREFIX='$(prefix_SQ)' \
-		DEFINE='$(PERL_DEFINE_SQ)' \
-		LIBS='$(PERL_LIBS_SQ)')
+		PREFIX='$(prefix_SQ)')
 
 doc:
 	$(MAKE) -C Documentation all
diff --git a/perl/.gitignore b/perl/.gitignore
index 6d778f3..e990cae 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,7 +1,4 @@
-Git.bs
-Git.c
 Makefile
 blib
 blibdirs
 pm_to_blib
-ppport.h
diff --git a/perl/Git.pm b/perl/Git.pm
index 9ce9fcd..2b26b65 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -93,9 +93,6 @@ use Carp qw(carp croak); # but croak is 
 use Error qw(:try);
 use Cwd qw(abs_path);
 
-require XSLoader;
-XSLoader::load('Git', $VERSION);
-
 }
 
 
@@ -413,12 +410,13 @@ sub command_noisy {
 
 Return the Git version in use.
 
-Implementation of this function is very fast; no external command calls
-are involved.
-
 =cut
 
-# Implemented in Git.xs.
+sub version {
+	my $verstr = command_oneline('--version');
+	$verstr =~ s/^git version //;
+	$verstr;
+}
 
 
 =item exec_path ()
@@ -426,12 +424,9 @@ # Implemented in Git.xs.
 Return path to the Git sub-command executables (the same as
 C<git --exec-path>). Useful mostly only internally.
 
-Implementation of this function is very fast; no external command calls
-are involved.
-
 =cut
 
-# Implemented in Git.xs.
+sub exec_path { command_oneline('--exec-path') }
 
 
 =item repo_path ()
@@ -572,41 +567,21 @@ sub ident_person {
 
 =item hash_object ( TYPE, FILENAME )
 
-=item hash_object ( TYPE, FILEHANDLE )
-
 Compute the SHA1 object id of the given C<FILENAME> (or data waiting in
 C<FILEHANDLE>) considering it is of the C<TYPE> object type (C<blob>,
 C<commit>, C<tree>).
 
-In case of C<FILEHANDLE> passed instead of file name, all the data
-available are read and hashed, and the filehandle is automatically
-closed. The file handle should be freshly opened - if you have already
-read anything from the file handle, the results are undefined (since
-this function works directly with the file descriptor and internal
-PerlIO buffering might have messed things up).
-
 The method can be called without any instance or on a specified Git repository,
 it makes zero difference.
 
 The function returns the SHA1 hash.
 
-Implementation of this function is very fast; no external command calls
-are involved.
-
 =cut
 
+# TODO: Support for passing FILEHANDLE instead of FILENAME
 sub hash_object {
 	my ($self, $type, $file) = _maybe_self(@_);
-
-	# hash_object_* implemented in Git.xs.
-
-	if (ref($file) eq 'GLOB') {
-		my $hash = hash_object_pipe($type, fileno($file));
-		close $file;
-		return $hash;
-	} else {
-		hash_object_file($type, $file);
-	}
+	command_oneline('hash-object', '-t', $type, $file);
 }
 
 
@@ -802,7 +777,7 @@ sub _cmd_exec {
 
 # Execute the given Git command ($_[0]) with arguments ($_[1..])
 # by searching for it at proper places.
-# _execv_git_cmd(), implemented in Git.xs.
+sub _execv_git_cmd { exec('git', @_); }
 
 # Close pipe to a subprocess.
 sub _cmd_close {
@@ -821,39 +796,6 @@ sub _cmd_close {
 }
 
 
-# Trickery for .xs routines: In order to avoid having some horrid
-# C code trying to do stuff with undefs and hashes, we gate all
-# xs calls through the following and in case we are being ran upon
-# an instance call a C part of the gate which will set up the
-# environment properly.
-sub _call_gate {
-	my $xsfunc = shift;
-	my ($self, @args) = _maybe_self(@_);
-
-	if (defined $self) {
-		# XXX: We ignore the WorkingCopy! To properly support
-		# that will require heavy changes in libgit.
-
-		# XXX: And we ignore everything else as well. libgit
-		# at least needs to be extended to let us specify
-		# the $GIT_DIR instead of looking it up in environment.
-		#xs_call_gate($self->{opts}->{Repository});
-	}
-
-	# Having to call throw from the C code is a sure path to insanity.
-	local $SIG{__DIE__} = sub { throw Error::Simple("@_"); };
-	&$xsfunc(@args);
-}
-
-sub AUTOLOAD {
-	my $xsname;
-	our $AUTOLOAD;
-	($xsname = $AUTOLOAD) =~ s/.*:://;
-	throw Error::Simple("&Git::$xsname not defined") if $xsname =~ /^xs_/;
-	$xsname = 'xs_'.$xsname;
-	_call_gate(\&$xsname, @_);
-}
-
 sub DESTROY { }
 
 
diff --git a/perl/Git.xs b/perl/Git.xs
deleted file mode 100644
index 2bbec43..0000000
--- a/perl/Git.xs
+++ /dev/null
@@ -1,134 +0,0 @@
-/* By carefully stacking #includes here (even if WE don't really need them)
- * we strive to make the thing actually compile. Git header files aren't very
- * nice. Perl headers are one of the signs of the coming apocalypse. */
-#include <ctype.h>
-/* Ok, it hasn't been so bad so far. */
-
-/* libgit interface */
-#include "../cache.h"
-#include "../exec_cmd.h"
-
-/* XS and Perl interface */
-#include "EXTERN.h"
-#include "perl.h"
-#include "XSUB.h"
-
-
-static char *
-report_xs(const char *prefix, const char *err, va_list params)
-{
-	static char buf[4096];
-	strcpy(buf, prefix);
-	vsnprintf(buf + strlen(prefix), 4096 - strlen(prefix), err, params);
-	return buf;
-}
-
-static void NORETURN
-die_xs(const char *err, va_list params)
-{
-	char *str;
-	str = report_xs("fatal: ", err, params);
-	croak(str);
-}
-
-static void
-error_xs(const char *err, va_list params)
-{
-	char *str;
-	str = report_xs("error: ", err, params);
-	warn(str);
-}
-
-
-MODULE = Git		PACKAGE = Git
-
-PROTOTYPES: DISABLE
-
-
-BOOT:
-{
-	set_error_routine(error_xs);
-	set_die_routine(die_xs);
-}
-
-
-# /* TODO: xs_call_gate(). See Git.pm. */
-
-
-char *
-xs_version()
-CODE:
-{
-	RETVAL = GIT_VERSION;
-}
-OUTPUT:
-	RETVAL
-
-
-char *
-xs_exec_path()
-CODE:
-{
-	RETVAL = (char *)git_exec_path();
-}
-OUTPUT:
-	RETVAL
-
-
-void
-xs__execv_git_cmd(...)
-CODE:
-{
-	const char **argv;
-	int i;
-
-	argv = malloc(sizeof(const char *) * (items + 1));
-	if (!argv)
-		croak("malloc failed");
-	for (i = 0; i < items; i++)
-		argv[i] = strdup(SvPV_nolen(ST(i)));
-	argv[i] = NULL;
-
-	execv_git_cmd(argv);
-
-	for (i = 0; i < items; i++)
-		if (argv[i])
-			free((char *) argv[i]);
-	free((char **) argv);
-}
-
-char *
-xs_hash_object_pipe(type, fd)
-	char *type;
-	int fd;
-CODE:
-{
-	unsigned char sha1[20];
-
-	if (index_pipe(sha1, fd, type, 0))
-		croak("Unable to hash given filehandle");
-	RETVAL = sha1_to_hex(sha1);
-}
-OUTPUT:
-	RETVAL
-
-char *
-xs_hash_object_file(type, path)
-	char *type;
-	char *path;
-CODE:
-{
-	unsigned char sha1[20];
-	int fd = open(path, O_RDONLY);
-	struct stat st;
-
-	if (fd < 0 ||
-	    fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, 0, type))
-		croak("Unable to hash %s", path);
-	close(fd);
-
-	RETVAL = sha1_to_hex(sha1);
-}
-OUTPUT:
-	RETVAL
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index ef9d82d..de73235 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -3,12 +3,7 @@ use ExtUtils::MakeMaker;
 sub MY::postamble {
 	return <<'MAKE_FRAG';
 instlibdir:
-	@echo '$(INSTALLSITEARCH)'
-
-check:
-	perl -MDevel::PPPort -le 'Devel::PPPort::WriteFile(".ppport.h")' && \
-	perl .ppport.h --compat-version=5.6.0 Git.xs && \
-	rm .ppport.h
+	@echo '$(INSTALLSITELIB)'
 
 MAKE_FRAG
 }
@@ -29,7 +24,5 @@ WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
-	MYEXTLIB        => '../libgit.a',
-	INC             => '-I. -I..',
 	%extra
 );
