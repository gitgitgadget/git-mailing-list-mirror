From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Tue, 1 Jan 2013 12:26:45 -0500
Message-ID: <20130101172645.GA5506@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 18:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq5d1-0008Sy-RY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 18:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab3AAR1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 12:27:32 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56753
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3AAR1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 12:27:30 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 75EA744143; Tue,  1 Jan 2013 12:26:45 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212429>

The combination of git-cvsimport and cvsps had serious problems.
Among these were:

(1) Analysis of branchy repos was buggy in multiple ways in both
    programs, leading to incorrect repo translations.

(2) Even after a correct branch analysis, extra (redundant) fileops
    would often be generated on the new-branch side.

(3) Inability to report more than one tag pointing to the same revision.

(4) Failure in certain cases of clock-skew reported by the t9603 test.

(5) Failure to use commitids for changeset ordering in cases were this
    would have prevented clock skew from causing incorrect grouping.

Problems 2-5 and portions of problem 1 have been solved by a major
rewrite of cvsps (the 3.x release series); it now emits a git
fast-import stream.  Also, the buggy attempt at ancestry-branch
tracking previously invoked by -A has been replaced with a simpler and
better topo analysis.  cvsps is now about 20% smaller than formerly.

All this changed cvsps's interface enough to require a complete
rewrite of git-cvsimport (hence this patch). In the process the code
size of the wrapper script dropped by about x3 and it can now support
alternate conversion engines; the first new engine is cvs2git, with
parsecvs expected to follow shortly if that code proves salvageable.

This patch also removes Michael Haggerty's git-cvsimport tests from
the git tree.  These are actually conversion-engine tests and have been
merged into a larger cvsps test suite, which I intend to spin out into
a general CVS-lifting test that can also be applied to utilities such
as cvs2git and parsecvs.

The following known bug has not been fixed: "If any files were ever "cvs
import"ed more than once (e.g., import of more than one vendor
release) the HEAD contains the wrong content." However, cvsps now
emits a warning in this case. There is also one pathological tagging
case that was successful the former t9602 test that now fails (with
a warning).

I plan to address these problems. This patch at least gets the
cvsps-3.x/git-cvsimport combination to a state that is not too
broken to ship - that is, in all failure cases known to me it
now emits useful warnings rather than silently botching the
import.
---
 Documentation/git-cvsimport.txt                    |  303 +++--
 Makefile                                           |    2 +-
 git-cvsimport.perl                                 | 1177 --------------------
 git-cvsimport.py                                   |  342 ++++++
 t/t9601-cvsimport-vendor-branch.sh                 |   85 --
 t/t9601/cvsroot/.gitattributes                     |    1 -
 t/t9601/cvsroot/CVSROOT/.gitignore                 |    2 -
 t/t9601/cvsroot/module/added-imported.txt,v        |   44 -
 t/t9601/cvsroot/module/imported-anonymously.txt,v  |   42 -
 .../module/imported-modified-imported.txt,v        |   76 --
 t/t9601/cvsroot/module/imported-modified.txt,v     |   59 -
 t/t9601/cvsroot/module/imported-once.txt,v         |   43 -
 t/t9601/cvsroot/module/imported-twice.txt,v        |   60 -
 t/t9602-cvsimport-branches-tags.sh                 |   78 --
 t/t9602/README                                     |   62 --
 t/t9602/cvsroot/.gitattributes                     |    1 -
 t/t9602/cvsroot/CVSROOT/.gitignore                 |    2 -
 t/t9602/cvsroot/module/default,v                   |  102 --
 t/t9602/cvsroot/module/sub1/default,v              |  102 --
 t/t9602/cvsroot/module/sub1/subsubA/default,v      |  101 --
 t/t9602/cvsroot/module/sub1/subsubB/default,v      |  107 --
 .../module/sub2/Attic/branch_B_MIXED_only,v        |   59 -
 t/t9602/cvsroot/module/sub2/default,v              |  102 --
 t/t9602/cvsroot/module/sub2/subsubA/default,v      |  102 --
 t/t9602/cvsroot/module/sub3/default,v              |  102 --
 t/t9603-cvsimport-patchsets.sh                     |   39 -
 t/t9603/cvsroot/.gitattributes                     |    1 -
 t/t9603/cvsroot/CVSROOT/.gitignore                 |    2 -
 t/t9603/cvsroot/module/a,v                         |   74 --
 t/t9603/cvsroot/module/b,v                         |   90 --
 30 files changed, 492 insertions(+), 2870 deletions(-)
 delete mode 100755 git-cvsimport.perl
 create mode 100755 git-cvsimport.py
 delete mode 100755 t/t9601-cvsimport-vendor-branch.sh
 delete mode 100644 t/t9601/cvsroot/.gitattributes
 delete mode 100644 t/t9601/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9601/cvsroot/module/added-imported.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-anonymously.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-modified-imported.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-modified.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-once.txt,v
 delete mode 100644 t/t9601/cvsroot/module/imported-twice.txt,v
 delete mode 100755 t/t9602-cvsimport-branches-tags.sh
 delete mode 100644 t/t9602/README
 delete mode 100644 t/t9602/cvsroot/.gitattributes
 delete mode 100644 t/t9602/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9602/cvsroot/module/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/subsubA/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub1/subsubB/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub2/subsubA/default,v
 delete mode 100644 t/t9602/cvsroot/module/sub3/default,v
 delete mode 100755 t/t9603-cvsimport-patchsets.sh
 delete mode 100644 t/t9603/cvsroot/.gitattributes
 delete mode 100644 t/t9603/cvsroot/CVSROOT/.gitignore
 delete mode 100644 t/t9603/cvsroot/module/a,v
 delete mode 100644 t/t9603/cvsroot/module/b,v

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 98d9881..92da652 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -9,75 +9,78 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
 SYNOPSIS
 --------
 [verse]
-'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
-	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
-	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
-	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [-R] [<CVS_module>]
-
+'git cvsimport' [-A <author-conv-file>] [-b] [-C <git_repository>] 
+              [-d <CVSROOT>] [-h] [-i] [-k] [-p <options-for-engine>] 
+	      [-P <cvsps-output-file>] [-r <remote>] [-R] [-s <subst>] 
+	      [-S <regex>] [-u] [-v] [-z <fuzz>] [<CVS_module>]
 
 DESCRIPTION
 -----------
-Imports a CVS repository into git. It will either create a new
+Imports a CVS repository into git. This tool will either create a new
 repository, or incrementally import into an existing one.
 
-Splitting the CVS log into patch sets is done by 'cvsps'.
-At least version 2.1 is required.
-
-*WARNING:* for certain situations the import leads to incorrect results.
-Please see the section <<issues,ISSUES>> for further reference.
-
-You should *never* do any work of your own on the branches that are
-created by 'git cvsimport'.  By default initial import will create and populate a
-"master" branch from the CVS repository's main branch which you're free
-to work with; after that, you need to 'git merge' incremental imports, or
-any CVS branches, yourself.  It is advisable to specify a named remote via
--r to separate and protect the incoming branches.
-
-If you intend to set up a shared public repository that all developers can
-read/write, or if you want to use linkgit:git-cvsserver[1], then you
-probably want to make a bare clone of the imported repository,
-and use the clone as the shared repository.
-See linkgit:gitcvs-migration[7].
+*WARNING:* The CVS model of version control lends itself to all manner
+of perversities; not all sequences of CVS operations can be translated
+into an import stream, and importing is not guaranteed to produce a
+perfectly accurate representation of CVS history. Please see the
+section on <<issues,engine-specific issues>> for further reference.
 
+git cvsimport will do well at translating CVS repositories with a
+linear or close-to-linear revision history, no merges, and
+well-disciplined tagging practices.  More complex cases will require
+human judgment amplified by a repository-editing tool such as
+http://www.catb.org/~esr/reposurgeon[reposurgeon].
 
 OPTIONS
 -------
--v::
-	Verbosity: let 'cvsimport' report what it is doing.
-
--d <CVSROOT>::
-	The root of the CVS archive. May be local (a simple path) or remote;
-	currently, only the :local:, :ext: and :pserver: access methods
-	are supported. If not given, 'git cvsimport' will try to read it
-	from `CVS/Root`. If no such file exists, it checks for the
-	`CVSROOT` environment variable.
+-A <author-conv-file>::
+	CVS by default uses the Unix username when writing its
+	commit logs. Using this option and an author-conv-file
+	maps the name recorded in CVS to author name, e-mail and
+	optional timezone:
++
+---------
+	exon=Andreas Ericsson <ae@op5.se> +0200
+	spawn=Simon Pawn <spawn@frog-pond.org> -0500
+---------
++
+'git cvsimport' will make it appear as those authors had
+their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
+all along.
++
+For convenience, this data is saved to `$GIT_DIR/cvs-authors`
+each time the '-A' option is provided and read from that same
+file each time 'git cvsimport' is run.
++
+It is not recommended to use this feature if you intend to
+export changes back to CVS again later with
+'git cvsexportcommit'.
 
-<CVS_module>::
-	The CVS module you want to import. Relative to <CVSROOT>.
-	If not given, 'git cvsimport' tries to read it from
-	`CVS/Repository`.
+-b::
+        Create a bare repo. If you intend to set up a shared public
+	repository that all developers can read/write, or if you want
+	to use linkgit:git-cvsserver[1], then you probably want to
+	make a bare clone of the imported repository using this
+	option. See linkgit:gitcvs-migration[7].
 
 -C <target-dir>::
         The git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
--r <remote>::
-	The git remote to import this CVS repository into.
-	Moves all CVS branches into remotes/<remote>/<branch>
-	akin to the way 'git clone' uses 'origin' by default.
+-d <CVSROOT>::
+	The root of the CVS archive. It is only necessary to specify
+	this option if you are running from somewhere other than a 
+	CVS checkout directory; the value is passed to the conversion
+	engine to be interpreted.
 
--o <branch-for-HEAD>::
-	When no remote is specified (via -r) the 'HEAD' branch
-	from CVS is imported to the 'origin' branch within the git
-	repository, as 'HEAD' already has a special meaning for git.
-	When a remote is specified the 'HEAD' branch is named
-	remotes/<remote>/master mirroring 'git clone' behaviour.
-	Use this option if you want to import into a different
-	branch.
-+
-Use '-o master' for continuing an import that was initially done by
-the old cvs2git tool.
+-e <engine>::
+	Splitting the CVS log into patch sets is done by an engine program,
+	which must emit a git fast-import stream to standard output.
+	This option changes the engine used; when given, it must be the
+	first option on the command line.
+
+-h::
+	Print a short usage message and exit.
 
 -i::
 	Import-only: don't perform a checkout after importing.  This option
@@ -89,75 +92,19 @@ the old cvs2git tool.
 	to avoid noisy changesets. Highly recommended, but off by default
 	to preserve compatibility with early imported trees.
 
--u::
-	Convert underscores in tag and branch names to dots.
-
--s <subst>::
-	Substitute the character "/" in branch names with <subst>
-
--p <options-for-cvsps>::
-	Additional options for cvsps.
-	The options '-u' and '-A' are implicit and should not be used here.
-+
-If you need to pass multiple options, separate them with a comma.
-
--z <fuzz>::
-	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
-	cvsps defaults to 300s.
-
 -P <cvsps-output-file>::
-	Instead of calling cvsps, read the provided cvsps output file. Useful
-	for debugging or when cvsps is being handled outside cvsimport.
-
--m::
-	Attempt to detect merges based on the commit message. This option
-	will enable default regexes that try to capture the source
-	branch name from the commit message.
-
--M <regex>::
-	Attempt to detect merges based on the commit message with a custom
-	regex. It can be used with '-m' to enable the default regexes
-	as well. You must escape forward slashes.
-+
-The regex must capture the source branch name in $1.
-+
-This option can be used several times to provide several detection regexes.
-
--S <regex>::
-	Skip paths matching the regex.
+	Instead of calling a conversion engine, read the provided
+	import-stream file. Useful for debugging or when the first
+	stage of conversion is being handled outside cvsimport.
 
--a::
-	Import all commits, including recent ones. cvsimport by default
-	skips commits that have a timestamp less than 10 minutes ago.
-
--L <limit>::
-	Limit the number of commits imported. Workaround for cases where
-	cvsimport leaks memory.
-
--A <author-conv-file>::
-	CVS by default uses the Unix username when writing its
-	commit logs. Using this option and an author-conv-file
-	maps the name recorded in CVS to author name, e-mail and
-	optional timezone:
-+
----------
-	exon=Andreas Ericsson <ae@op5.se>
-	spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
+-r <remote>::
+	The git remote to import this CVS repository into.
+	Moves all CVS branches into remotes/<remote>/<branch>
+	akin to the way 'git clone' uses 'origin' by default.
 
----------
-+
-'git cvsimport' will make it appear as those authors had
-their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
-all along.  If a timezone is specified, GIT_AUTHOR_DATE will
-have the corresponding offset applied.
-+
-For convenience, this data is saved to `$GIT_DIR/cvs-authors`
-each time the '-A' option is provided and read from that same
-file each time 'git cvsimport' is run.
-+
-It is not recommended to use this feature if you intend to
-export changes back to CVS again later with
-'git cvsexportcommit'.
+-p <options-for-engine>::
+	Additional options for the engine. If you need to pass
+	multiple options, separate them with a comma.
 
 -R::
 	Generate a `$GIT_DIR/cvs-revisions` file containing a mapping from CVS
@@ -174,50 +121,98 @@ doing incremental imports.
 +
 This option may be useful if you have CVS revision numbers stored in commit
 messages, bug-tracking systems, email archives, and the like.
++
+-s <subst>::
+	Substitute the character "/" in branch names with <subst>
 
--h::
-	Print a short usage message and exit.
-
-OUTPUT
-------
-If '-v' is specified, the script reports what it is doing.
-
-Otherwise, success is indicated the Unix way, i.e. by simply exiting with
-a zero exit status.
+-S <regex>::
+	Skip paths matching the regex.
 
-[[issues]]
-ISSUES
-------
-Problems related to timestamps:
+-u::
+	Convert underscores in tag and branch names to dots.
 
- * If timestamps of commits in the CVS repository are not stable enough
-   to be used for ordering commits changes may show up in the wrong
-   order.
- * If any files were ever "cvs import"ed more than once (e.g., import of
-   more than one vendor release) the HEAD contains the wrong content.
- * If the timestamp order of different files cross the revision order
-   within the commit matching time window the order of commits may be
-   wrong.
+-v::
+	Verbosity: let 'cvsimport' report what it is doing.
 
-Problems related to branches:
+-z <fuzz>::
+	Pass the timestamp fuzz factor, in seconds. If unset, this has 
+	an engine-dependent default - usually 300s.
 
- * Branches on which no commits have been made are not imported.
- * All files from the branching point are added to a branch even if
-   never added in CVS.
- * This applies to files added to the source branch *after* a daughter
-   branch was created: if previously no commit was made on the daughter
-   branch they will erroneously be added to the daughter branch in git.
+<CVS_module>::
+	The CVS module you want to import. Relative to <CVSROOT>.  It
+	is only necessary to specify this option if you are running
+	from somewhere other than a CVS checkout directory; the value
+	is passed to the conversion engine to be interpreted.
 
-Problems related to tags:
+OUTPUT
+------
+If '-v' is specified, the program reports what it is doing.
 
-* Multiple tags on the same revision are not imported.
+Otherwise, success is indicated the Unix way, i.e. by simply exiting with
+a zero exit status.
 
-If you suspect that any of these issues may apply to the repository you
-want to import consider using these alternative tools which proved to be
-more stable in practice:
+[[compatibility]]
+COMPATIBILITY
+-------------
+In 2012 two serious bugs dating back to 2006 in cvsps were exposed.  The
+ancestry-branch tracking formerly enabled by -A did not work, and
+branch detection was generally buggy; translations of branchy repos
+could be mangled.  While the --fast-export mode in 3.x releases of
+cvsps solved the problem, it required an emergency rewrite of
+git-cvsimport.  Some compatibility with older versions was unavoidably
+lost
+
+The -a, -o, -m, -M, and -L options in older versions of this tool have
+been removed (in effect, -a is always on; you can negate it with
+suitably crafted -d arguments).  Certain older versions could take a
+named timezone (like "America/Chicago") in an author-map file rather
+than just a [+-]hhmm offset; this version doesn't do that, but the
+capability may be restored in a future release.
 
-* cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
-* parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
+[[issues]]
+ENGINE-SPECIFIC ISSUES
+----------------------
+The conversion engines try to warn you about repository histories they
+can't handle; see their individual manual pages to learn how to
+interpret the warnings you may receive.
+
+The default conversion engine is 'cvsps'.  If warnings you receive
+suggest that the repository translation is invalid, consider switching
+engines to 'cvs2git'.
+
+cvsps
+~~~~~
+The default conversion engine is 'cvsps'; at least version 3.3 is
+required.  The cvsps project page is at `http://www.catb.org/~esr/cvsps`.
+Things to know about this engine:
+
+* As well as working from within a CVS checkout directory,
+  'cvsps' will also adapt without requiring a root or module
+  specification when run from within a module subdirectory within a CVS
+  repository directory.  When run from within the top level of a CVS
+  repository, 'cvsps' requires only a module argument.
+
+* The -S option will interpret exclusion regular expressions using the
+  POSIX syntax of regex(7).
+
+* 'cvsps' automatically removes characters in CVS tag and branch names
+  that would be illegal in git.
+
+cvs2git
+~~~~~~~
+The cvs2git project page is at `http://cvs2svn.tigris.org`.  It is
+much slower than cvsps, and does not implement some git-cvsimport
+options (such as -d and -A), but it handles a wider range of
+pathological CVS cases.
+
+* 'cvs2git' takes a path option pointing to a repository module
+  subdirectory, defaulting to ".".
+
+* The -S option will interpret exclusion regular expressions using
+  Python syntax.
+
+* Illegal characters in branch and tag names will cause cvs2git to
+  abort with an error message.
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 736ecd4..626494e 100644
--- a/Makefile
+++ b/Makefile
@@ -464,7 +464,6 @@ SCRIPT_PERL += git-add--interactive.perl
 SCRIPT_PERL += git-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
-SCRIPT_PERL += git-cvsimport.perl
 SCRIPT_PERL += git-cvsserver.perl
 SCRIPT_PERL += git-relink.perl
 SCRIPT_PERL += git-send-email.perl
@@ -472,6 +471,7 @@ SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-remote-testgit.py
 SCRIPT_PYTHON += git-p4.py
+SCRIPT_PYTHON += git-cvsimport.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
deleted file mode 100755
index 0a31ebd..0000000
--- a/git-cvsimport.perl
+++ /dev/null
@@ -1,1177 +0,0 @@
-#!/usr/bin/perl
-
-# This tool is copyright (c) 2005, Matthias Urlichs.
-# It is released under the Gnu Public License, version 2.
-#
-# The basic idea is to aggregate CVS check-ins into related changes.
-# Fortunately, "cvsps" does that for us; all we have to do is to parse
-# its output.
-#
-# Checking out the files is done by a single long-running CVS connection
-# / server process.
-#
-# The head revision is on branch "origin" by default.
-# You can change that with the '-o' option.
-
-use 5.008;
-use strict;
-use warnings;
-use Getopt::Long;
-use File::Spec;
-use File::Temp qw(tempfile tmpnam);
-use File::Path qw(mkpath);
-use File::Basename qw(basename dirname);
-use Time::Local;
-use IO::Socket;
-use IO::Pipe;
-use POSIX qw(strftime tzset dup2 ENOENT);
-use IPC::Open2;
-
-$SIG{'PIPE'}="IGNORE";
-set_timezone('UTC');
-
-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
-my (%conv_author_name, %conv_author_email, %conv_author_tz);
-
-sub usage(;$) {
-	my $msg = shift;
-	print(STDERR "Error: $msg\n") if $msg;
-	print STDERR <<END;
-Usage: git cvsimport     # fetch/update GIT from CVS
-       [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
-       [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
-       [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [-r remote] [-R] [CVS_module]
-END
-	exit(1);
-}
-
-sub read_author_info($) {
-	my ($file) = @_;
-	my $user;
-	open my $f, '<', "$file" or die("Failed to open $file: $!\n");
-
-	while (<$f>) {
-		# Expected format is this:
-		#   exon=Andreas Ericsson <ae@op5.se>
-		if (m/^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*$/) {
-			$user = $1;
-			$conv_author_name{$user} = $2;
-			$conv_author_email{$user} = $3;
-		}
-		# or with an optional timezone:
-		#   spawn=Simon Pawn <spawn@frog-pond.org> America/Chicago
-		elsif (m/^(\S+?)\s*=\s*(.+?)\s*<(.+)>\s*(\S+?)\s*$/) {
-			$user = $1;
-			$conv_author_name{$user} = $2;
-			$conv_author_email{$user} = $3;
-			$conv_author_tz{$user} = $4;
-		}
-		# However, we also read from CVSROOT/users format
-		# to ease migration.
-		elsif (/^(\w+):(['"]?)(.+?)\2\s*$/) {
-			my $mapped;
-			($user, $mapped) = ($1, $3);
-			if ($mapped =~ /^\s*(.*?)\s*<(.*)>\s*$/) {
-				$conv_author_name{$user} = $1;
-				$conv_author_email{$user} = $2;
-			}
-			elsif ($mapped =~ /^<?(.*)>?$/) {
-				$conv_author_name{$user} = $user;
-				$conv_author_email{$user} = $1;
-			}
-		}
-		# NEEDSWORK: Maybe warn on unrecognized lines?
-	}
-	close ($f);
-}
-
-sub write_author_info($) {
-	my ($file) = @_;
-	open my $f, '>', $file or
-	  die("Failed to open $file for writing: $!");
-
-	foreach (keys %conv_author_name) {
-		print $f "$_=$conv_author_name{$_} <$conv_author_email{$_}>";
-		print $f " $conv_author_tz{$_}" if ($conv_author_tz{$_});
-		print $f "\n";
-	}
-	close ($f);
-}
-
-# Versions of perl before 5.10.0 may not automatically check $TZ each
-# time localtime is run (most platforms will do so only the first time).
-# We can work around this by using tzset() to update the internal
-# variable whenever we change the environment.
-sub set_timezone {
-	$ENV{TZ} = shift;
-	tzset();
-}
-
-# convert getopts specs for use by git config
-my %longmap = (
-	'A:' => 'authors-file',
-	'M:' => 'merge-regex',
-	'P:' => undef,
-	'R' => 'track-revisions',
-	'S:' => 'ignore-paths',
-);
-
-sub read_repo_config {
-	# Split the string between characters, unless there is a ':'
-	# So "abc:de" becomes ["a", "b", "c:", "d", "e"]
-	my @opts = split(/ *(?!:)/, shift);
-	foreach my $o (@opts) {
-		my $key = $o;
-		$key =~ s/://g;
-		my $arg = 'git config';
-		$arg .= ' --bool' if ($o !~ /:$/);
-		my $ckey = $key;
-
-		if (exists $longmap{$o}) {
-			# An uppercase option like -R cannot be
-			# expressed in the configuration, as the
-			# variable names are downcased.
-			$ckey = $longmap{$o};
-			next if (! defined $ckey);
-			$ckey =~ s/-//g;
-		}
-		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
-		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
-			no strict 'refs';
-			my $opt_name = "opt_" . $key;
-			if (!$$opt_name) {
-				$$opt_name = $tmp;
-			}
-		}
-	}
-}
-
-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R";
-read_repo_config($opts);
-Getopt::Long::Configure( 'no_ignore_case', 'bundling' );
-
-# turn the Getopt::Std specification in a Getopt::Long one,
-# with support for multiple -M options
-GetOptions( map { s/:/=s/; /M/ ? "$_\@" : $_ } split( /(?!:)/, $opts ) )
-    or usage();
-usage if $opt_h;
-
-if (@ARGV == 0) {
-		chomp(my $module = `git config --get cvsimport.module`);
-		push(@ARGV, $module) if $? == 0;
-}
-@ARGV <= 1 or usage("You can't specify more than one CVS module");
-
-if ($opt_d) {
-	$ENV{"CVSROOT"} = $opt_d;
-} elsif (-f 'CVS/Root') {
-	open my $f, '<', 'CVS/Root' or die 'Failed to open CVS/Root';
-	$opt_d = <$f>;
-	chomp $opt_d;
-	close $f;
-	$ENV{"CVSROOT"} = $opt_d;
-} elsif ($ENV{"CVSROOT"}) {
-	$opt_d = $ENV{"CVSROOT"};
-} else {
-	usage("CVSROOT needs to be set");
-}
-$opt_s ||= "-";
-$opt_a ||= 0;
-
-my $git_tree = $opt_C;
-$git_tree ||= ".";
-
-my $remote;
-if (defined $opt_r) {
-	$remote = 'refs/remotes/' . $opt_r;
-	$opt_o ||= "master";
-} else {
-	$opt_o ||= "origin";
-	$remote = 'refs/heads';
-}
-
-my $cvs_tree;
-if ($#ARGV == 0) {
-	$cvs_tree = $ARGV[0];
-} elsif (-f 'CVS/Repository') {
-	open my $f, '<', 'CVS/Repository' or
-	    die 'Failed to open CVS/Repository';
-	$cvs_tree = <$f>;
-	chomp $cvs_tree;
-	close $f;
-} else {
-	usage("CVS module has to be specified");
-}
-
-our @mergerx = ();
-if ($opt_m) {
-	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
-}
-if (@opt_M) {
-	push (@mergerx, map { qr/$_/ } @opt_M);
-}
-
-# Remember UTC of our starting time
-# we'll want to avoid importing commits
-# that are too recent
-our $starttime = time();
-
-select(STDERR); $|=1; select(STDOUT);
-
-
-package CVSconn;
-# Basic CVS dialog.
-# We're only interested in connecting and downloading, so ...
-
-use File::Spec;
-use File::Temp qw(tempfile);
-use POSIX qw(strftime dup2);
-
-sub new {
-	my ($what,$repo,$subdir) = @_;
-	$what=ref($what) if ref($what);
-
-	my $self = {};
-	$self->{'buffer'} = "";
-	bless($self,$what);
-
-	$repo =~ s#/+$##;
-	$self->{'fullrep'} = $repo;
-	$self->conn();
-
-	$self->{'subdir'} = $subdir;
-	$self->{'lines'} = undef;
-
-	return $self;
-}
-
-sub find_password_entry {
-	my ($cvspass, @cvsroot) = @_;
-	my ($file, $delim) = @$cvspass;
-	my $pass;
-	local ($_);
-
-	if (open(my $fh, $file)) {
-		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
-		CVSPASSFILE:
-		while (<$fh>) {
-			chomp;
-			s/^\/\d+\s+//;
-			my ($w, $p) = split($delim,$_,2);
-			for my $cvsroot (@cvsroot) {
-				if ($w eq $cvsroot) {
-					$pass = $p;
-					last CVSPASSFILE;
-				}
-			}
-		}
-		close($fh);
-	}
-	return $pass;
-}
-
-sub conn {
-	my $self = shift;
-	my $repo = $self->{'fullrep'};
-	if ($repo =~ s/^:pserver(?:([^:]*)):(?:(.*?)(?::(.*?))?@)?([^:\/]*)(?::(\d*))?//) {
-		my ($param,$user,$pass,$serv,$port) = ($1,$2,$3,$4,$5);
-
-		my ($proxyhost,$proxyport);
-		if ($param && ($param =~ m/proxy=([^;]+)/)) {
-			$proxyhost = $1;
-			# Default proxyport, if not specified, is 8080.
-			$proxyport = 8080;
-			if ($ENV{"CVS_PROXY_PORT"}) {
-				$proxyport = $ENV{"CVS_PROXY_PORT"};
-			}
-			if ($param =~ m/proxyport=([^;]+)/) {
-				$proxyport = $1;
-			}
-		}
-		$repo ||= '/';
-
-		# if username is not explicit in CVSROOT, then use current user, as cvs would
-		$user=(getlogin() || $ENV{'LOGNAME'} || $ENV{'USER'} || "anonymous") unless $user;
-		my $rr2 = "-";
-		unless ($port) {
-			$rr2 = ":pserver:$user\@$serv:$repo";
-			$port=2401;
-		}
-		my $rr = ":pserver:$user\@$serv:$port$repo";
-
-		if ($pass) {
-			$pass = $self->_scramble($pass);
-		} else {
-			my @cvspass = ([$ENV{'HOME'}."/.cvspass", qr/\s/],
-				       [$ENV{'HOME'}."/.cvs/cvspass", qr/=/]);
-			my @loc = ();
-			foreach my $cvspass (@cvspass) {
-				my $p = find_password_entry($cvspass, $rr, $rr2);
-				if ($p) {
-					push @loc, $cvspass->[0];
-					$pass = $p;
-				}
-			}
-
-			if (1 < @loc) {
-				die("Multiple cvs password files have ".
-				    "entries for CVSROOT $opt_d: @loc");
-			} elsif (!$pass) {
-				$pass = "A";
-			}
-		}
-
-		my ($s, $rep);
-		if ($proxyhost) {
-
-			# Use a HTTP Proxy. Only works for HTTP proxies that
-			# don't require user authentication
-			#
-			# See: http://www.ietf.org/rfc/rfc2817.txt
-
-			$s = IO::Socket::INET->new(PeerHost => $proxyhost, PeerPort => $proxyport);
-			die "Socket to $proxyhost: $!\n" unless defined $s;
-			$s->write("CONNECT $serv:$port HTTP/1.1\r\nHost: $serv:$port\r\n\r\n")
-	                        or die "Write to $proxyhost: $!\n";
-	                $s->flush();
-
-			$rep = <$s>;
-
-			# The answer should look like 'HTTP/1.x 2yy ....'
-			if (!($rep =~ m#^HTTP/1\.. 2[0-9][0-9]#)) {
-				die "Proxy connect: $rep\n";
-			}
-			# Skip up to the empty line of the proxy server output
-			# including the response headers.
-			while ($rep = <$s>) {
-				last if (!defined $rep ||
-					 $rep eq "\n" ||
-					 $rep eq "\r\n");
-			}
-		} else {
-			$s = IO::Socket::INET->new(PeerHost => $serv, PeerPort => $port);
-			die "Socket to $serv: $!\n" unless defined $s;
-		}
-
-		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH REQUEST\n")
-			or die "Write to $serv: $!\n";
-		$s->flush();
-
-		$rep = <$s>;
-
-		if ($rep ne "I LOVE YOU\n") {
-			$rep="<unknown>" unless $rep;
-			die "AuthReply: $rep\n";
-		}
-		$self->{'socketo'} = $s;
-		$self->{'socketi'} = $s;
-	} else { # local or ext: Fork off our own cvs server.
-		my $pr = IO::Pipe->new();
-		my $pw = IO::Pipe->new();
-		my $pid = fork();
-		die "Fork: $!\n" unless defined $pid;
-		my $cvs = 'cvs';
-		$cvs = $ENV{CVS_SERVER} if exists $ENV{CVS_SERVER};
-		my $rsh = 'rsh';
-		$rsh = $ENV{CVS_RSH} if exists $ENV{CVS_RSH};
-
-		my @cvs = ($cvs, 'server');
-		my ($local, $user, $host);
-		$local = $repo =~ s/:local://;
-		if (!$local) {
-		    $repo =~ s/:ext://;
-		    $local = !($repo =~ s/^(?:([^\@:]+)\@)?([^:]+)://);
-		    ($user, $host) = ($1, $2);
-		}
-		if (!$local) {
-		    if ($user) {
-			unshift @cvs, $rsh, '-l', $user, $host;
-		    } else {
-			unshift @cvs, $rsh, $host;
-		    }
-		}
-
-		unless ($pid) {
-			$pr->writer();
-			$pw->reader();
-			dup2($pw->fileno(),0);
-			dup2($pr->fileno(),1);
-			$pr->close();
-			$pw->close();
-			exec(@cvs);
-		}
-		$pw->writer();
-		$pr->reader();
-		$self->{'socketo'} = $pw;
-		$self->{'socketi'} = $pr;
-	}
-	$self->{'socketo'}->write("Root $repo\n");
-
-	# Trial and error says that this probably is the minimum set
-	$self->{'socketo'}->write("Valid-responses ok error Valid-requests Mode M Mbinary E Checked-in Created Updated Merged Removed\n");
-
-	$self->{'socketo'}->write("valid-requests\n");
-	$self->{'socketo'}->flush();
-
-	my $rep=$self->readline();
-	die "Failed to read from server" unless defined $rep;
-	chomp($rep);
-	if ($rep !~ s/^Valid-requests\s*//) {
-		$rep="<unknown>" unless $rep;
-		die "Expected Valid-requests from server, but got: $rep\n";
-	}
-	chomp(my $res=$self->readline());
-	die "validReply: $res\n" if $res ne "ok";
-
-	$self->{'socketo'}->write("UseUnchanged\n") if $rep =~ /\bUseUnchanged\b/;
-	$self->{'repo'} = $repo;
-}
-
-sub readline {
-	my ($self) = @_;
-	return $self->{'socketi'}->getline();
-}
-
-sub _file {
-	# Request a file with a given revision.
-	# Trial and error says this is a good way to do it. :-/
-	my ($self,$fn,$rev) = @_;
-	$self->{'socketo'}->write("Argument -N\n") or return undef;
-	$self->{'socketo'}->write("Argument -P\n") or return undef;
-	# -kk: Linus' version doesn't use it - defaults to off
-	if ($opt_k) {
-	    $self->{'socketo'}->write("Argument -kk\n") or return undef;
-	}
-	$self->{'socketo'}->write("Argument -r\n") or return undef;
-	$self->{'socketo'}->write("Argument $rev\n") or return undef;
-	$self->{'socketo'}->write("Argument --\n") or return undef;
-	$self->{'socketo'}->write("Argument $self->{'subdir'}/$fn\n") or return undef;
-	$self->{'socketo'}->write("Directory .\n") or return undef;
-	$self->{'socketo'}->write("$self->{'repo'}\n") or return undef;
-	# $self->{'socketo'}->write("Sticky T1.0\n") or return undef;
-	$self->{'socketo'}->write("co\n") or return undef;
-	$self->{'socketo'}->flush() or return undef;
-	$self->{'lines'} = 0;
-	return 1;
-}
-sub _line {
-	# Read a line from the server.
-	# ... except that 'line' may be an entire file. ;-)
-	my ($self, $fh) = @_;
-	die "Not in lines" unless defined $self->{'lines'};
-
-	my $line;
-	my $res=0;
-	while (defined($line = $self->readline())) {
-		# M U gnupg-cvs-rep/AUTHORS
-		# Updated gnupg-cvs-rep/
-		# /daten/src/rsync/gnupg-cvs-rep/AUTHORS
-		# /AUTHORS/1.1///T1.1
-		# u=rw,g=rw,o=rw
-		# 0
-		# ok
-
-		if ($line =~ s/^(?:Created|Updated) //) {
-			$line = $self->readline(); # path
-			$line = $self->readline(); # Entries line
-			my $mode = $self->readline(); chomp $mode;
-			$self->{'mode'} = $mode;
-			defined (my $cnt = $self->readline())
-				or die "EOF from server after 'Changed'\n";
-			chomp $cnt;
-			die "Duh: Filesize $cnt" if $cnt !~ /^\d+$/;
-			$line="";
-			$res = $self->_fetchfile($fh, $cnt);
-		} elsif ($line =~ s/^ //) {
-			print $fh $line;
-			$res += length($line);
-		} elsif ($line =~ /^M\b/) {
-			# output, do nothing
-		} elsif ($line =~ /^Mbinary\b/) {
-			my $cnt;
-			die "EOF from server after 'Mbinary'" unless defined ($cnt = $self->readline());
-			chomp $cnt;
-			die "Duh: Mbinary $cnt" if $cnt !~ /^\d+$/ or $cnt<1;
-			$line="";
-			$res += $self->_fetchfile($fh, $cnt);
-		} else {
-			chomp $line;
-			if ($line eq "ok") {
-				# print STDERR "S: ok (".length($res).")\n";
-				return $res;
-			} elsif ($line =~ s/^E //) {
-				# print STDERR "S: $line\n";
-			} elsif ($line =~ /^(Remove-entry|Removed) /i) {
-				$line = $self->readline(); # filename
-				$line = $self->readline(); # OK
-				chomp $line;
-				die "Unknown: $line" if $line ne "ok";
-				return -1;
-			} else {
-				die "Unknown: $line\n";
-			}
-		}
-	}
-	return undef;
-}
-sub file {
-	my ($self,$fn,$rev) = @_;
-	my $res;
-
-	my ($fh, $name) = tempfile('gitcvs.XXXXXX',
-		    DIR => File::Spec->tmpdir(), UNLINK => 1);
-
-	$self->_file($fn,$rev) and $res = $self->_line($fh);
-
-	if (!defined $res) {
-	    print STDERR "Server has gone away while fetching $fn $rev, retrying...\n";
-	    truncate $fh, 0;
-	    $self->conn();
-	    $self->_file($fn,$rev) or die "No file command send";
-	    $res = $self->_line($fh);
-	    die "Retry failed" unless defined $res;
-	}
-	close ($fh);
-
-	return ($name, $res);
-}
-sub _fetchfile {
-	my ($self, $fh, $cnt) = @_;
-	my $res = 0;
-	my $bufsize = 1024 * 1024;
-	while ($cnt) {
-	    if ($bufsize > $cnt) {
-		$bufsize = $cnt;
-	    }
-	    my $buf;
-	    my $num = $self->{'socketi'}->read($buf,$bufsize);
-	    die "Server: Filesize $cnt: $num: $!\n" if not defined $num or $num<=0;
-	    print $fh $buf;
-	    $res += $num;
-	    $cnt -= $num;
-	}
-	return $res;
-}
-
-sub _scramble {
-	my ($self, $pass) = @_;
-	my $scrambled = "A";
-
-	return $scrambled unless $pass;
-
-	my $pass_len = length($pass);
-	my @pass_arr = split("", $pass);
-	my $i;
-
-	# from cvs/src/scramble.c
-	my @shifts = (
-		  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		114,120, 53, 79, 96,109, 72,108, 70, 64, 76, 67,116, 74, 68, 87,
-		111, 52, 75,119, 49, 34, 82, 81, 95, 65,112, 86,118,110,122,105,
-		 41, 57, 83, 43, 46,102, 40, 89, 38,103, 45, 50, 42,123, 91, 35,
-		125, 55, 54, 66,124,126, 59, 47, 92, 71,115, 78, 88,107,106, 56,
-		 36,121,117,104,101,100, 69, 73, 99, 63, 94, 93, 39, 37, 61, 48,
-		 58,113, 32, 90, 44, 98, 60, 51, 33, 97, 62, 77, 84, 80, 85,223,
-		225,216,187,166,229,189,222,188,141,249,148,200,184,136,248,190,
-		199,170,181,204,138,232,218,183,255,234,220,247,213,203,226,193,
-		174,172,228,252,217,201,131,230,197,211,145,238,161,179,160,212,
-		207,221,254,173,202,146,224,151,140,196,205,130,135,133,143,246,
-		192,159,244,239,185,168,215,144,139,165,180,157,147,186,214,176,
-		227,231,219,169,175,156,206,198,129,164,150,210,154,177,134,127,
-		182,128,158,208,162,132,167,209,149,241,153,251,237,236,171,195,
-		243,233,253,240,194,250,191,155,142,137,245,235,163,242,178,152
-	);
-
-	for ($i = 0; $i < $pass_len; $i++) {
-		$scrambled .= pack("C", $shifts[ord($pass_arr[$i])]);
-	}
-
-	return $scrambled;
-}
-
-package main;
-
-my $cvs = CVSconn->new($opt_d, $cvs_tree);
-
-
-sub pdate($) {
-	my ($d) = @_;
-	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
-		or die "Unparseable date: $d\n";
-	my $y=$1; $y-=1900 if $y>1900;
-	return timegm($6||0,$5,$4,$3,$2-1,$y);
-}
-
-sub pmode($) {
-	my ($mode) = @_;
-	my $m = 0;
-	my $mm = 0;
-	my $um = 0;
-	for my $x(split(//,$mode)) {
-		if ($x eq ",") {
-			$m |= $mm&$um;
-			$mm = 0;
-			$um = 0;
-		} elsif ($x eq "u") { $um |= 0700;
-		} elsif ($x eq "g") { $um |= 0070;
-		} elsif ($x eq "o") { $um |= 0007;
-		} elsif ($x eq "r") { $mm |= 0444;
-		} elsif ($x eq "w") { $mm |= 0222;
-		} elsif ($x eq "x") { $mm |= 0111;
-		} elsif ($x eq "=") { # do nothing
-		} else { die "Unknown mode: $mode\n";
-		}
-	}
-	$m |= $mm&$um;
-	return $m;
-}
-
-sub getwd() {
-	my $pwd = `pwd`;
-	chomp $pwd;
-	return $pwd;
-}
-
-sub is_sha1 {
-	my $s = shift;
-	return $s =~ /^[a-f0-9]{40}$/;
-}
-
-sub get_headref ($) {
-	my $name = shift;
-	my $r = `git rev-parse --verify '$name' 2>/dev/null`;
-	return undef unless $? == 0;
-	chomp $r;
-	return $r;
-}
-
-my $user_filename_prepend = '';
-sub munge_user_filename {
-	my $name = shift;
-	return File::Spec->file_name_is_absolute($name) ?
-		$name :
-		$user_filename_prepend . $name;
-}
-
--d $git_tree
-	or mkdir($git_tree,0777)
-	or die "Could not create $git_tree: $!";
-if ($git_tree ne '.') {
-	$user_filename_prepend = getwd() . '/';
-	chdir($git_tree);
-}
-
-my $last_branch = "";
-my $orig_branch = "";
-my %branch_date;
-my $tip_at_start = undef;
-
-my $git_dir = $ENV{"GIT_DIR"} || ".git";
-$git_dir = getwd()."/".$git_dir unless $git_dir =~ m#^/#;
-$ENV{"GIT_DIR"} = $git_dir;
-my $orig_git_index;
-$orig_git_index = $ENV{GIT_INDEX_FILE} if exists $ENV{GIT_INDEX_FILE};
-
-my %index; # holds filenames of one index per branch
-
-unless (-d $git_dir) {
-	system(qw(git init));
-	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
-	system(qw(git read-tree --empty));
-	die "Cannot init an empty tree: $?\n" if $?;
-
-	$last_branch = $opt_o;
-	$orig_branch = "";
-} else {
-	open(F, "-|", qw(git symbolic-ref HEAD)) or
-		die "Cannot run git symbolic-ref: $!\n";
-	chomp ($last_branch = <F>);
-	$last_branch = basename($last_branch);
-	close(F);
-	unless ($last_branch) {
-		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
-		$last_branch = "master";
-	}
-	$orig_branch = $last_branch;
-	$tip_at_start = `git rev-parse --verify HEAD`;
-
-	# Get the last import timestamps
-	my $fmt = '($ref, $author) = (%(refname), %(author));';
-	my @cmd = ('git', 'for-each-ref', '--perl', "--format=$fmt", $remote);
-	open(H, "-|", @cmd) or die "Cannot run git for-each-ref: $!\n";
-	while (defined(my $entry = <H>)) {
-		my ($ref, $author);
-		eval($entry) || die "cannot eval refs list: $@";
-		my ($head) = ($ref =~ m|^$remote/(.*)|);
-		$author =~ /^.*\s(\d+)\s[-+]\d{4}$/;
-		$branch_date{$head} = $1;
-	}
-	close(H);
-        if (!exists $branch_date{$opt_o}) {
-		die "Branch '$opt_o' does not exist.\n".
-		       "Either use the correct '-o branch' option,\n".
-		       "or import to a new repository.\n";
-        }
-}
-
--d $git_dir
-	or die "Could not create git subdir ($git_dir).\n";
-
-# now we read (and possibly save) author-info as well
--f "$git_dir/cvs-authors" and
-  read_author_info("$git_dir/cvs-authors");
-if ($opt_A) {
-	read_author_info(munge_user_filename($opt_A));
-	write_author_info("$git_dir/cvs-authors");
-}
-
-# open .git/cvs-revisions, if requested
-open my $revision_map, '>>', "$git_dir/cvs-revisions"
-    or die "Can't open $git_dir/cvs-revisions for appending: $!\n"
-	if defined $opt_R;
-
-
-#
-# run cvsps into a file unless we are getting
-# it passed as a file via $opt_P
-#
-my $cvspsfile;
-unless ($opt_P) {
-	print "Running cvsps...\n" if $opt_v;
-	my $pid = open(CVSPS,"-|");
-	my $cvspsfh;
-	die "Cannot fork: $!\n" unless defined $pid;
-	unless ($pid) {
-		my @opt;
-		@opt = split(/,/,$opt_p) if defined $opt_p;
-		unshift @opt, '-z', $opt_z if defined $opt_z;
-		unshift @opt, '-q'         unless defined $opt_v;
-		unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
-			push @opt, '--cvs-direct';
-		}
-		exec("cvsps","--norc",@opt,"-u","-A",'--root',$opt_d,$cvs_tree);
-		die "Could not start cvsps: $!\n";
-	}
-	($cvspsfh, $cvspsfile) = tempfile('gitXXXXXX', SUFFIX => '.cvsps',
-					  DIR => File::Spec->tmpdir());
-	while (<CVSPS>) {
-	    print $cvspsfh $_;
-	}
-	close CVSPS;
-	$? == 0 or die "git cvsimport: fatal: cvsps reported error\n";
-	close $cvspsfh;
-} else {
-	$cvspsfile = munge_user_filename($opt_P);
-}
-
-open(CVS, "<$cvspsfile") or die $!;
-
-## cvsps output:
-#---------------------
-#PatchSet 314
-#Date: 1999/09/18 13:03:59
-#Author: wkoch
-#Branch: STABLE-BRANCH-1-0
-#Ancestor branch: HEAD
-#Tag: (none)
-#Log:
-#    See ChangeLog: Sat Sep 18 13:03:28 CEST 1999  Werner Koch
-#Members:
-#	README:1.57->1.57.2.1
-#	VERSION:1.96->1.96.2.1
-#
-#---------------------
-
-my $state = 0;
-
-sub update_index (\@\@) {
-	my $old = shift;
-	my $new = shift;
-	open(my $fh, '|-', qw(git update-index -z --index-info))
-		or die "unable to open git update-index: $!";
-	print $fh
-		(map { "0 0000000000000000000000000000000000000000\t$_\0" }
-			@$old),
-		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
-			@$new)
-		or die "unable to write to git update-index: $!";
-	close $fh
-		or die "unable to write to git update-index: $!";
-	$? and die "git update-index reported error: $?";
-}
-
-sub write_tree () {
-	open(my $fh, '-|', qw(git write-tree))
-		or die "unable to open git write-tree: $!";
-	chomp(my $tree = <$fh>);
-	is_sha1($tree)
-		or die "Cannot get tree id ($tree): $!";
-	close($fh)
-		or die "Error running git write-tree: $?\n";
-	print "Tree ID $tree\n" if $opt_v;
-	return $tree;
-}
-
-my ($patchset,$date,$author_name,$author_email,$author_tz,$branch,$ancestor,$tag,$logmsg);
-my (@old,@new,@skipped,%ignorebranch,@commit_revisions);
-
-# commits that cvsps cannot place anywhere...
-$ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
-
-sub commit {
-	if ($branch eq $opt_o && !$index{branch} &&
-		!get_headref("$remote/$branch")) {
-	    # looks like an initial commit
-	    # use the index primed by git init
-	    $ENV{GIT_INDEX_FILE} = "$git_dir/index";
-	    $index{$branch} = "$git_dir/index";
-	} else {
-	    # use an index per branch to speed up
-	    # imports of projects with many branches
-	    unless ($index{$branch}) {
-		$index{$branch} = tmpnam();
-		$ENV{GIT_INDEX_FILE} = $index{$branch};
-		if ($ancestor) {
-		    system("git", "read-tree", "$remote/$ancestor");
-		} else {
-		    system("git", "read-tree", "$remote/$branch");
-		}
-		die "read-tree failed: $?\n" if $?;
-	    }
-	}
-        $ENV{GIT_INDEX_FILE} = $index{$branch};
-
-	update_index(@old, @new);
-	@old = @new = ();
-	my $tree = write_tree();
-	my $parent = get_headref("$remote/$last_branch");
-	print "Parent ID " . ($parent ? $parent : "(empty)") . "\n" if $opt_v;
-
-	my @commit_args;
-	push @commit_args, ("-p", $parent) if $parent;
-
-	# loose detection of merges
-	# based on the commit msg
-	foreach my $rx (@mergerx) {
-		next unless $logmsg =~ $rx && $1;
-		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
-		if (my $sha1 = get_headref("$remote/$mparent")) {
-			push @commit_args, '-p', "$remote/$mparent";
-			print "Merge parent branch: $mparent\n" if $opt_v;
-		}
-	}
-
-	set_timezone($author_tz);
-	my $commit_date = strftime("%s %z", localtime($date));
-	set_timezone('UTC');
-	$ENV{GIT_AUTHOR_NAME} = $author_name;
-	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
-	$ENV{GIT_AUTHOR_DATE} = $commit_date;
-	$ENV{GIT_COMMITTER_NAME} = $author_name;
-	$ENV{GIT_COMMITTER_EMAIL} = $author_email;
-	$ENV{GIT_COMMITTER_DATE} = $commit_date;
-	my $pid = open2(my $commit_read, my $commit_write,
-		'git', 'commit-tree', $tree, @commit_args);
-
-	# compatibility with git2cvs
-	substr($logmsg,32767) = "" if length($logmsg) > 32767;
-	$logmsg =~ s/[\s\n]+\z//;
-
-	if (@skipped) {
-	    $logmsg .= "\n\n\nSKIPPED:\n\t";
-	    $logmsg .= join("\n\t", @skipped) . "\n";
-	    @skipped = ();
-	}
-
-	print($commit_write "$logmsg\n") && close($commit_write)
-		or die "Error writing to git commit-tree: $!\n";
-
-	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
-	chomp(my $cid = <$commit_read>);
-	is_sha1($cid) or die "Cannot get commit id ($cid): $!\n";
-	print "Commit ID $cid\n" if $opt_v;
-	close($commit_read);
-
-	waitpid($pid,0);
-	die "Error running git commit-tree: $?\n" if $?;
-
-	system('git' , 'update-ref', "$remote/$branch", $cid) == 0
-		or die "Cannot write branch $branch for update: $!\n";
-
-	if ($revision_map) {
-		print $revision_map "@$_ $cid\n" for @commit_revisions;
-	}
-	@commit_revisions = ();
-
-	if ($tag) {
-	        my ($xtag) = $tag;
-		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
-		$xtag =~ tr/_/\./ if ( $opt_u );
-		$xtag =~ s/[\/]/$opt_s/g;
-
-		# See refs.c for these rules.
-		# Tag cannot contain bad chars. (See bad_ref_char in refs.c.)
-		$xtag =~ s/[ ~\^:\\\*\?\[]//g;
-		# Other bad strings for tags:
-		# (See check_refname_component in refs.c.)
-		1 while $xtag =~ s/
-			(?: \.\.        # Tag cannot contain '..'.
-			|   \@{         # Tag cannot contain '@{'.
-			| ^ -           # Tag cannot begin with '-'.
-			|   \.lock $    # Tag cannot end with '.lock'.
-			| ^ \.          # Tag cannot begin...
-			|   \. $        # ...or end with '.'
-			)//xg;
-		# Tag cannot be empty.
-		if ($xtag eq '') {
-			warn("warning: ignoring tag '$tag'",
-			" with invalid tagname\n");
-			return;
-		}
-
-		if (system('git' , 'tag', '-f', $xtag, $cid) != 0) {
-			# We did our best to sanitize the tag, but still failed
-			# for whatever reason. Bail out, and give the user
-			# enough information to understand if/how we should
-			# improve the translation in the future.
-			if ($tag ne $xtag) {
-				print "Translated '$tag' tag to '$xtag'\n";
-			}
-			die "Cannot create tag $xtag: $!\n";
-		}
-
-		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
-	}
-};
-
-my $commitcount = 1;
-while (<CVS>) {
-	chomp;
-	if ($state == 0 and /^-+$/) {
-		$state = 1;
-	} elsif ($state == 0) {
-		$state = 1;
-		redo;
-	} elsif (($state==0 or $state==1) and s/^PatchSet\s+//) {
-		$patchset = 0+$_;
-		$state=2;
-	} elsif ($state == 2 and s/^Date:\s+//) {
-		$date = pdate($_);
-		unless ($date) {
-			print STDERR "Could not parse date: $_\n";
-			$state=0;
-			next;
-		}
-		$state=3;
-	} elsif ($state == 3 and s/^Author:\s+//) {
-		$author_tz = "UTC";
-		s/\s+$//;
-		if (/^(.*?)\s+<(.*)>/) {
-		    ($author_name, $author_email) = ($1, $2);
-		} elsif ($conv_author_name{$_}) {
-			$author_name = $conv_author_name{$_};
-			$author_email = $conv_author_email{$_};
-			$author_tz = $conv_author_tz{$_} if ($conv_author_tz{$_});
-		} else {
-		    $author_name = $author_email = $_;
-		}
-		$state = 4;
-	} elsif ($state == 4 and s/^Branch:\s+//) {
-		s/\s+$//;
-		tr/_/\./ if ( $opt_u );
-		s/[\/]/$opt_s/g;
-		$branch = $_;
-		$state = 5;
-	} elsif ($state == 5 and s/^Ancestor branch:\s+//) {
-		s/\s+$//;
-		$ancestor = $_;
-		$ancestor = $opt_o if $ancestor eq "HEAD";
-		$state = 6;
-	} elsif ($state == 5) {
-		$ancestor = undef;
-		$state = 6;
-		redo;
-	} elsif ($state == 6 and s/^Tag:\s+//) {
-		s/\s+$//;
-		if ($_ eq "(none)") {
-			$tag = undef;
-		} else {
-			$tag = $_;
-		}
-		$state = 7;
-	} elsif ($state == 7 and /^Log:/) {
-		$logmsg = "";
-		$state = 8;
-	} elsif ($state == 8 and /^Members:/) {
-		$branch = $opt_o if $branch eq "HEAD";
-		if (defined $branch_date{$branch} and $branch_date{$branch} >= $date) {
-			# skip
-			print "skip patchset $patchset: $date before $branch_date{$branch}\n" if $opt_v;
-			$state = 11;
-			next;
-		}
-		if (!$opt_a && $starttime - 300 - (defined $opt_z ? $opt_z : 300) <= $date) {
-			# skip if the commit is too recent
-			# given that the cvsps default fuzz is 300s, we give ourselves another
-			# 300s just in case -- this also prevents skipping commits
-			# due to server clock drift
-			print "skip patchset $patchset: $date too recent\n" if $opt_v;
-			$state = 11;
-			next;
-		}
-		if (exists $ignorebranch{$branch}) {
-			print STDERR "Skipping $branch\n";
-			$state = 11;
-			next;
-		}
-		if ($ancestor) {
-			if ($ancestor eq $branch) {
-				print STDERR "Branch $branch erroneously stems from itself -- changed ancestor to $opt_o\n";
-				$ancestor = $opt_o;
-			}
-			if (defined get_headref("$remote/$branch")) {
-				print STDERR "Branch $branch already exists!\n";
-				$state=11;
-				next;
-			}
-			my $id = get_headref("$remote/$ancestor");
-			if (!$id) {
-				print STDERR "Branch $ancestor does not exist!\n";
-				$ignorebranch{$branch} = 1;
-				$state=11;
-				next;
-			}
-
-			system(qw(git update-ref -m cvsimport),
-				"$remote/$branch", $id);
-			if($? != 0) {
-				print STDERR "Could not create branch $branch\n";
-				$ignorebranch{$branch} = 1;
-				$state=11;
-				next;
-			}
-		}
-		$last_branch = $branch if $branch ne $last_branch;
-		$state = 9;
-	} elsif ($state == 8) {
-		$logmsg .= "$_\n";
-	} elsif ($state == 9 and /^\s+(.+?):(INITIAL|\d+(?:\.\d+)+)->(\d+(?:\.\d+)+)\s*$/) {
-#	VERSION:1.96->1.96.2.1
-		my $init = ($2 eq "INITIAL");
-		my $fn = $1;
-		my $rev = $3;
-		$fn =~ s#^/+##;
-		if ($opt_S && $fn =~ m/$opt_S/) {
-		    print "SKIPPING $fn v $rev\n";
-		    push(@skipped, $fn);
-		    next;
-		}
-		push @commit_revisions, [$fn, $rev];
-		print "Fetching $fn   v $rev\n" if $opt_v;
-		my ($tmpname, $size) = $cvs->file($fn,$rev);
-		if ($size == -1) {
-			push(@old,$fn);
-			print "Drop $fn\n" if $opt_v;
-		} else {
-			print "".($init ? "New" : "Update")." $fn: $size bytes\n" if $opt_v;
-			my $pid = open(my $F, '-|');
-			die $! unless defined $pid;
-			if (!$pid) {
-			    exec("git", "hash-object", "-w", $tmpname)
-				or die "Cannot create object: $!\n";
-			}
-			my $sha = <$F>;
-			chomp $sha;
-			close $F;
-			my $mode = pmode($cvs->{'mode'});
-			push(@new,[$mode, $sha, $fn]); # may be resurrected!
-		}
-		unlink($tmpname);
-	} elsif ($state == 9 and /^\s+(.+?):\d+(?:\.\d+)+->(\d+(?:\.\d+)+)\(DEAD\)\s*$/) {
-		my $fn = $1;
-		my $rev = $2;
-		$fn =~ s#^/+##;
-		push @commit_revisions, [$fn, $rev];
-		push(@old,$fn);
-		print "Delete $fn\n" if $opt_v;
-	} elsif ($state == 9 and /^\s*$/) {
-		$state = 10;
-	} elsif (($state == 9 or $state == 10) and /^-+$/) {
-		$commitcount++;
-		if ($opt_L && $commitcount > $opt_L) {
-			last;
-		}
-		commit();
-		if (($commitcount & 1023) == 0) {
-			system(qw(git repack -a -d));
-		}
-		$state = 1;
-	} elsif ($state == 11 and /^-+$/) {
-		$state = 1;
-	} elsif (/^-+$/) { # end of unknown-line processing
-		$state = 1;
-	} elsif ($state != 11) { # ignore stuff when skipping
-		print STDERR "* UNKNOWN LINE * $_\n";
-	}
-}
-commit() if $branch and $state != 11;
-
-unless ($opt_P) {
-	unlink($cvspsfile);
-}
-
-# The heuristic of repacking every 1024 commits can leave a
-# lot of unpacked data.  If there is more than 1MB worth of
-# not-packed objects, repack once more.
-my $line = `git count-objects`;
-if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
-  my ($n_objects, $kb) = ($1, $2);
-  1024 < $kb
-    and system(qw(git repack -a -d));
-}
-
-foreach my $git_index (values %index) {
-    if ($git_index ne "$git_dir/index") {
-	unlink($git_index);
-    }
-}
-
-if (defined $orig_git_index) {
-	$ENV{GIT_INDEX_FILE} = $orig_git_index;
-} else {
-	delete $ENV{GIT_INDEX_FILE};
-}
-
-# Now switch back to the branch we were in before all of this happened
-if ($orig_branch) {
-	print "DONE.\n" if $opt_v;
-	if ($opt_i) {
-		exit 0;
-	}
-	my $tip_at_end = `git rev-parse --verify HEAD`;
-	if ($tip_at_start ne $tip_at_end) {
-		for ($tip_at_start, $tip_at_end) { chomp; }
-		print "Fetched into the current branch.\n" if $opt_v;
-		system(qw(git read-tree -u -m),
-		       $tip_at_start, $tip_at_end);
-		die "Fast-forward update failed: $?\n" if $?;
-	}
-	else {
-		system(qw(git merge cvsimport HEAD), "$remote/$opt_o");
-		die "Could not merge $opt_o into the current branch.\n" if $?;
-	}
-} else {
-	$orig_branch = "master";
-	print "DONE; creating $orig_branch branch\n" if $opt_v;
-	system("git", "update-ref", "refs/heads/master", "$remote/$opt_o")
-		unless defined get_headref('refs/heads/master');
-	system("git", "symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
-		if ($opt_r && $opt_o ne 'HEAD');
-	system('git', 'update-ref', 'HEAD', "$orig_branch");
-	unless ($opt_i) {
-		system(qw(git checkout -f));
-		die "checkout failed: $?\n" if $?;
-	}
-}
diff --git a/git-cvsimport.py b/git-cvsimport.py
new file mode 100755
index 0000000..6407e8a
--- /dev/null
+++ b/git-cvsimport.py
@@ -0,0 +1,342 @@
+#!/usr/bin/env python
+#
+# Import CVS history into git
+#
+# Intended to be a near-workalike of Matthias Urlichs's Perl implementation.
+#
+# By Eric S. Raymond <esr@thyrsus.com>, December 2012
+# May be redistributed under the license of the git project.
+
+import sys
+
+if sys.hexversion < 0x02060000:
+    sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
+    sys.exit(1)
+
+import os, getopt, subprocess, tempfile, shutil
+
+DEBUG_COMMANDS = 1
+
+class Fatal(Exception):
+    "Unrecoverable error."
+    def __init__(self, msg):
+        Exception.__init__(self)
+        self.msg = msg
+
+def do_or_die(dcmd, legend=""):
+    "Either execute a command or raise a fatal exception."
+    if legend:
+        legend = " "  + legend
+    if verbose >= DEBUG_COMMANDS:
+        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
+    try:
+        retcode = subprocess.call(dcmd, shell=True)
+        if retcode < 0:
+            raise Fatal("git cvsimport: child was terminated by signal %d." % -retcode)
+        elif retcode != 0:
+            raise Fatal("git cvsimport: child returned %d." % retcode)
+    except (OSError, IOError) as e:
+        raise Fatal("git cvsimport: execution of %s%s failed: %s" % (dcmd, legend, e))
+
+def capture_or_die(dcmd, legend=""):
+    "Either execute a command and capture its output or die."
+    if legend:
+        legend = " "  + legend
+    if verbose >= DEBUG_COMMANDS:
+        sys.stdout.write("git cvsimport: executing '%s'%s\n" % (dcmd, legend))
+    try:
+        return subprocess.check_output(dcmd, shell=True)
+    except subprocess.CalledProcessError as e:
+        if e.returncode < 0:
+            sys.stderr.write("git cvsimport: child was terminated by signal %d." % -e.returncode)
+        elif e.returncode != 0:
+            sys.stderr.write("git cvsimport: child returned %d." % e.returncode)
+        sys.exit(1)
+    
+class cvsps:
+    "Method class for cvsps back end."
+    def __init__(self):
+        self.opts = ""
+        self.revmap = None
+    def set_repo(self, val):
+        "Set the repository root option."
+        if not val.startswith(":"):
+            if not val.startswith(os.sep):
+                val = os.path.abspath(val)
+            val = ":local:" + val
+        self.opts += " --root '%s'" % val
+    def set_authormap(self, val):
+        "Set the author-map file."
+        self.opts += " -A '%s'" % val
+    def set_fuzz(self, val):
+        "Set the commit-similarity window."
+        self.opts += " -z %s" % val
+    def set_nokeywords(self):
+        "Suppress CVS keyword expansion."
+        self.opts += " -k"
+    def add_opts(self, val):
+        "Add options to the engine command line."
+        self.opts += " " + val
+    def set_exclusion(self, val):
+        "Set a file exclusion regexp."
+        self.opts += " -n -f '%s'" % val
+    def set_after(self, val):
+        "Set a date threshold for incremental import."
+        self.opts += " -d '%s'" % val
+    def set_revmap(self, val):
+        "Set the file to which the engine should dump a reference map."
+        self.revmap = val
+        self.opts += " -R '%s'" % self.revmap
+    def set_module(self, val):
+        "Set the module to query."
+        self.opts += " " + val
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "cvsps --fast-export " + self.opts
+
+class cvs2git:
+    "Method class for cvs2git back end."
+    def __init__(self):
+        self.opts = ""
+        self.modulepath = "."
+    def set_authormap(self, _val):
+        "Set the author-map file."
+        sys.stderr.write("git cvsimport: author maping is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_repo(self, _val):
+        "Set the repository root option."
+        sys.stderr.write("git cvsimport: cvs2git must run within a repository checkout directory.\n")
+        sys.exit(1)
+    def set_fuzz(self, _val):
+        "Set the commit-similarity window."
+        sys.stderr.write("git cvsimport: fuzz setting is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_nokeywords(self):
+        "Suppress CVS keyword expansion."
+        self.opts += " --keywords-off"
+    def add_opts(self, val):
+        "Add options to the engine command line."
+        self.opts += " " + val
+    def set_exclusion(self, val):
+        "Set a file exclusion regexp."
+        self.opts += " --exclude='%s'" % val
+    def set_after(self, _val):
+        "Set a date threshold for incremental import."
+        sys.stderr.write("git cvsimport: incremental import is not supported with cvs2git.\n")
+        sys.exit(1)
+    def set_revmap(self, _val):
+        "Set the file to which the engine should dump a reference map."
+        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
+        sys.exit(1)
+    def set_module(self, val):
+        "Set the module to query."
+        self.modulepath = " " + val
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "(cvs2git --username=git-cvsimport --quiet --quiet --blobfile={0} --dumpfile={1} {2} {3} && cat {0} {1} && rm {0} {1})".format(tempfile.mkstemp()[1], tempfile.mkstemp()[1], self.opts, self.modulepath)
+
+class filesource:
+    "Method class for file-source back end."
+    def __init__(self, filename):
+        self.filename = filename
+    def __complain(self, legend):
+        sys.stderr.write("git cvsimport: %s with file source.\n" % legend)
+        sys.exit(1)
+    def set_repo(self, _val):
+        "Set the repository root option."
+        self.__complain("repository can't be set")
+    def set_authormap(self, _val):
+        "Set the author-map file."
+        sys.stderr.write("git cvsimport: author maping is not supported with filesource.\n")
+        sys.exit(1)
+    def set_fuzz(self, _val):
+        "Set the commit-similarity window."
+        self.__complain("fuzz can't be set")
+    def set_nokeywords(self, _val):
+        "Suppress CVS keyword expansion."
+        self.__complain("keyword suppression can't be set")
+    def add_opts(self, _val):
+        "Add options to the engine command line."
+        self.__complain("other options can't be set")
+    def set_exclusion(self, _val):
+        "Set a file exclusion regexp."
+        self.__complain("exclusions can't be set")
+    def set_after(self, _val):
+        "Set a date threshold for incremental import."
+        pass
+    def set_revmap(self, _val):
+        "Set the file to which the engine should dump a reference map."
+        sys.stderr.write("git cvsimport: can't get a reference map from cvs2git.\n")
+        sys.exit(1)
+    def set_module(self, _val):
+        "Set the module to query."
+        self.__complain("module can't be set")
+    def command(self):
+        "Emit the command implied by all previous options."
+        return "cat " + self.filename
+
+if __name__ == '__main__':
+    if sys.hexversion < 0x02060000:
+        sys.stderr.write("git cvsimport: requires Python 2.6 or later.\n")
+        sys.exit(1)
+    (options, arguments) = getopt.getopt(sys.argv[1:], "vbe:d:C:r:o:ikus:p:z:P:S:aL:A:Rh")
+    verbose = 0
+    bare = False
+    root = None
+    outdir = os.getcwd()
+    remotize = False
+    import_only = False
+    underscore_to_dot = False
+    slashsubst = None
+    authormap = None
+    revisionmap = False
+    backend = cvsps()
+    for (opt, val) in options:
+        if opt == '-v':
+            verbose += 1
+        elif opt == '-b':
+            bare = True
+        elif opt == '-e':
+            for cls in (cvsps, cvs2git):
+                if cls.__name__ == val:
+                    backend = cls()
+                    break
+            else:
+                sys.stderr.write("git cvsimport: unknown engine %s.\n" % val)
+                sys.exit(1)
+        elif opt == '-d':
+            backend.set_repo(val)
+        elif opt == '-C':
+            outdir = val
+        elif opt == '-r':
+            remotize = True
+        elif opt == '-o':
+            sys.stderr.write("git cvsimport: -o is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-i':
+            import_only = True
+        elif opt == '-k':
+            backend.set_nokeywords()
+        elif opt == '-u':
+            underscore_to_dot = True
+        elif opt == '-s':
+            slashsubst = val
+        elif opt == '-p':
+            backend.add_opts(val.replace(",", " "))
+        elif opt == '-z':
+            backend.set_fuzz(val)
+        elif opt == '-P':
+            backend = filesource(val)
+            sys.exit(1)
+        elif opt in ('-m', '-M'):
+            sys.stderr.write("git cvsimport: -m and -M are no longer supported: use reposurgeon instead.\n")
+            sys.exit(1)
+        elif opt == '-S':
+            backend.set_exclusion(val)
+        elif opt == '-a':
+            sys.stderr.write("git cvsimport: -a is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-L':
+            sys.stderr.write("git cvsimport: -L is no longer supported.\n")
+            sys.exit(1)
+        elif opt == '-A':
+            authormap = os.path.abspath(val)
+        elif opt == '-R':
+            revisionmap = True
+        else:
+            print """\
+git cvsimport [-A <author-conv-file>] [-C <git_repository>] [-b] [-d <CVSROOT>]
+     [-e engine] [-h] [-i] [-k] [-p <options-for-cvsps>] [-P <source-file>]
+     [-r <remote>] [-R] [-s <subst>] [-S <regex>] [-u] [-v] [-z <fuzz>]
+     [<CVS_module>]
+"""         
+
+    def metadata(fn):
+        if bare:
+            return fn
+        else:
+            return os.path.join(".git", fn) 
+    try:
+        if outdir:
+            try:
+                # If the output directory does not exist, create it
+                # and initialize it as a git repository.
+                os.mkdir(outdir)
+                do_or_die("git init --quiet " + outdir)
+            except OSError:
+                # Otherwise, assume user wants incremental import.
+                if not bare and not os.path.exists(os.path.join(outdir, ".git")):
+                    raise Fatal("output directory is not a git repository")
+                threshold = capture_or_die("git log -1 --format=%ct").strip()
+                backend.set_after(threshold)
+        if revisionmap:
+            backend.set_revmap(tempfile.mkstemp()[1])
+            markmap = tempfile.mkstemp()[1]
+        if arguments:
+            backend.set_module(arguments[0])
+        gitopts = ""
+        if bare:
+            gitopts += " --bare"
+        if revisionmap:
+            gitopts += " --export-marks='%s'" % markmap
+        if authormap:
+            shutil.copyfile(authormap, metadata("cvs_authors"))
+        if os.path.exists(metadata("cvs-authors")):
+            backend.set_authormap(metadata("cvs-authors"))
+        do_or_die("%s | (cd %s >/dev/null; git fast-import --quiet %s)" \
+                  % (backend.command(), outdir, gitopts))
+        os.chdir(outdir)
+        if underscore_to_dot or slashsubst:
+            tagnames = capture_or_die("git tag -l")
+            for tag in tagnames.split():
+                if tag:
+                    changed = tag
+                    if underscore_to_dot:
+                        changed = changed.replace("_", ".")
+                    if slashsubst:
+                        changed = changed.replace(os.sep, slashsubst)
+                    if changed != tag:
+                        do_or_die("git tag -f %s %s >/dev/null" % (tag, changed))
+        if underscore_to_dot or slashsubst or remotize:
+            branchnames = capture_or_die("git branch -l")
+            for branch in branchnames.split():
+                if branch:
+                    # Ugh - fragile dependency on branch -l output format
+                    branch = branch[2:]
+                    changed = branch
+                    if underscore_to_dot:
+                        changed = changed.replace("_", ".")
+                    if slashsubst:
+                        changed = changed.replace(os.sep, slashsubst)
+                    if remotize:
+                        changed = os.path.join("remotes", remotize, branch)
+                    if changed != branch:
+                        do_or_die("branch --m %s %s >/dev/null" % (branch, changed))
+        if revisionmap:
+            refd = {}
+            for line in open(backend.revmap):
+                if line.startswith("#"):
+                    continue
+                (fn, rev, mark) = line.split()
+                refd[(fn, rev)] = mark
+            markd = {}
+            for line in open(markmap):
+                if line.startswith("#"):
+                    continue
+                (mark, hashd) = line.split()
+                markd[mark] = hashd
+            with open(metadata("cvs-revisions"), "a") as wfp:
+                for ((fn, rev), val) in refd.items():
+                    if val in markd:
+                        wfp.write("%s %s %s\n" % (fn, rev, markd[val]))
+            os.remove(markmap)
+            os.remove(backend.revmap)
+        if not import_only and not bare:
+            do_or_die("git checkout -q")
+    except Fatal, err:
+        sys.stderr.write("git_cvsimport: " + err.msg + "\n")
+        sys.exit(1)
+    except KeyboardInterrupt:
+        pass
+
+# end
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
deleted file mode 100755
index 827d39f..0000000
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-
-# Description of the files in the repository:
-#
-#    imported-once.txt:
-#
-#       Imported once.  1.1 and 1.1.1.1 should be identical.
-#
-#    imported-twice.txt:
-#
-#       Imported twice.  HEAD should reflect the contents of the
-#       second import (i.e., have the same contents as 1.1.1.2).
-#
-#    imported-modified.txt:
-#
-#       Imported, then modified on HEAD.  HEAD should reflect the
-#       modification.
-#
-#    imported-modified-imported.txt:
-#
-#       Imported, then modified on HEAD, then imported again.
-#
-#    added-imported.txt,v:
-#
-#       Added with 'cvs add' to create 1.1, then imported with
-#       completely different contents to create 1.1.1.1, therefore the
-#       vendor branch was never the default branch.
-#
-#    imported-anonymously.txt:
-#
-#       Like imported-twice.txt, but with a vendor branch whose branch
-#       tag has been removed.
-
-test_description='git cvsimport handling of vendor branches'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9601
-
-test_expect_success PERL 'import a module with a vendor branch' '
-
-	git cvsimport -C module-git module
-
-'
-
-test_expect_success PERL 'check HEAD out of cvs repository' 'test_cvs_co master'
-
-test_expect_success PERL 'check master out of git repository' 'test_git_co master'
-
-test_expect_success PERL 'check a file that was imported once' '
-
-	test_cmp_branch_file master imported-once.txt
-
-'
-
-test_expect_failure PERL 'check a file that was imported twice' '
-
-	test_cmp_branch_file master imported-twice.txt
-
-'
-
-test_expect_success PERL 'check a file that was imported then modified on HEAD' '
-
-	test_cmp_branch_file master imported-modified.txt
-
-'
-
-test_expect_success PERL 'check a file that was imported, modified, then imported again' '
-
-	test_cmp_branch_file master imported-modified-imported.txt
-
-'
-
-test_expect_success PERL 'check a file that was added to HEAD then imported' '
-
-	test_cmp_branch_file master added-imported.txt
-
-'
-
-test_expect_success PERL 'a vendor branch whose tag has been removed' '
-
-	test_cmp_branch_file master imported-anonymously.txt
-
-'
-
-test_done
diff --git a/t/t9601/cvsroot/.gitattributes b/t/t9601/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9601/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9601/cvsroot/CVSROOT/.gitignore b/t/t9601/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9601/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9601/cvsroot/module/added-imported.txt,v b/t/t9601/cvsroot/module/added-imported.txt,v
deleted file mode 100644
index 5f83072..0000000
--- a/t/t9601/cvsroot/module/added-imported.txt,v
+++ /dev/null
@@ -1,44 +0,0 @@
-head	1.1;
-access;
-symbols
-	vtag-4:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.15;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.16;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Add a file to the working copy.
-@
-text
-@Adding this file, before importing it with different contents.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-4).
-@
-text
-@d1 1
-a1 1
-This is vtag-4 (on vbranchA) of added-then-imported.txt.
-@
-
diff --git a/t/t9601/cvsroot/module/imported-anonymously.txt,v b/t/t9601/cvsroot/module/imported-anonymously.txt,v
deleted file mode 100644
index 55e1b0c..0000000
--- a/t/t9601/cvsroot/module/imported-anonymously.txt,v
+++ /dev/null
@@ -1,42 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-1:1.1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-anonymously.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-modified-imported.txt,v b/t/t9601/cvsroot/module/imported-modified-imported.txt,v
deleted file mode 100644
index e5830ae..0000000
--- a/t/t9601/cvsroot/module/imported-modified-imported.txt,v
+++ /dev/null
@@ -1,76 +0,0 @@
-head	1.2;
-access;
-symbols
-	vtag-2:1.1.1.2
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2004.02.09.15.43.14;	author kfogel;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	1.1.1.2;
-
-1.1.1.2
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@First regular commit, to imported-modified-imported.txt, on HEAD.
-@
-text
-@This is a modification of imported-modified-imported.txt on HEAD.
-It should supersede the version from the vendor branch.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d1 2
-a2 1
-This is vtag-1 (on vbranchA) of imported-modified-imported.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
-1.1.1.2
-log
-@Import (vbranchA, vtag-2).
-@
-text
-@d1 1
-a1 1
-This is vtag-2 (on vbranchA) of imported-modified-imported.txt.
-@
-
-
diff --git a/t/t9601/cvsroot/module/imported-modified.txt,v b/t/t9601/cvsroot/module/imported-modified.txt,v
deleted file mode 100644
index bbcfe44..0000000
--- a/t/t9601/cvsroot/module/imported-modified.txt,v
+++ /dev/null
@@ -1,59 +0,0 @@
-head	1.2;
-access;
-symbols
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2004.02.09.15.43.14;	author kfogel;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Commit on HEAD.
-@
-text
-@This is a modification of imported-modified.txt on HEAD.
-It should supersede the version from the vendor branch.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d1 2
-a2 1
-This is vtag-1 (on vbranchA) of imported-modified.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-once.txt,v b/t/t9601/cvsroot/module/imported-once.txt,v
deleted file mode 100644
index c5dd82b..0000000
--- a/t/t9601/cvsroot/module/imported-once.txt,v
+++ /dev/null
@@ -1,43 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-once.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
diff --git a/t/t9601/cvsroot/module/imported-twice.txt,v b/t/t9601/cvsroot/module/imported-twice.txt,v
deleted file mode 100644
index d1f3f1b..0000000
--- a/t/t9601/cvsroot/module/imported-twice.txt,v
+++ /dev/null
@@ -1,60 +0,0 @@
-head	1.1;
-branch	1.1.1;
-access;
-symbols
-	vtag-2:1.1.1.2
-	vtag-1:1.1.1.1
-	vbranchA:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	1.1.1.2;
-
-1.1.1.2
-date	2004.02.09.15.43.13;	author kfogel;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@This is vtag-1 (on vbranchA) of imported-twice.txt.
-@
-
-
-1.1.1.1
-log
-@Import (vbranchA, vtag-1).
-@
-text
-@@
-
-
-1.1.1.2
-log
-@Import (vbranchA, vtag-2).
-@
-text
-@d1 1
-a1 1
-This is vtag-2 (on vbranchA) of imported-twice.txt.
-@
-
-
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
deleted file mode 100755
index e1db323..0000000
--- a/t/t9602-cvsimport-branches-tags.sh
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/sh
-
-# A description of the repository used for this test can be found in
-# t9602/README.
-
-test_description='git cvsimport handling of branches and tags'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9602
-
-test_expect_success PERL 'import module' '
-
-	git cvsimport -C module-git module
-
-'
-
-test_expect_success PERL 'test branch master' '
-
-	test_cmp_branch_tree master
-
-'
-
-test_expect_success PERL 'test branch vendorbranch' '
-
-	test_cmp_branch_tree vendorbranch
-
-'
-
-test_expect_failure PERL 'test branch B_FROM_INITIALS' '
-
-	test_cmp_branch_tree B_FROM_INITIALS
-
-'
-
-test_expect_failure PERL 'test branch B_FROM_INITIALS_BUT_ONE' '
-
-	test_cmp_branch_tree B_FROM_INITIALS_BUT_ONE
-
-'
-
-test_expect_failure PERL 'test branch B_MIXED' '
-
-	test_cmp_branch_tree B_MIXED
-
-'
-
-test_expect_success PERL 'test branch B_SPLIT' '
-
-	test_cmp_branch_tree B_SPLIT
-
-'
-
-test_expect_failure PERL 'test tag vendortag' '
-
-	test_cmp_branch_tree vendortag
-
-'
-
-test_expect_success PERL 'test tag T_ALL_INITIAL_FILES' '
-
-	test_cmp_branch_tree T_ALL_INITIAL_FILES
-
-'
-
-test_expect_failure PERL 'test tag T_ALL_INITIAL_FILES_BUT_ONE' '
-
-	test_cmp_branch_tree T_ALL_INITIAL_FILES_BUT_ONE
-
-'
-
-test_expect_failure PERL 'test tag T_MIXED' '
-
-	test_cmp_branch_tree T_MIXED
-
-'
-
-
-test_done
diff --git a/t/t9602/README b/t/t9602/README
deleted file mode 100644
index c231e0f..0000000
--- a/t/t9602/README
+++ /dev/null
@@ -1,62 +0,0 @@
-This repository is for testing the ability to group revisions
-correctly along tags and branches.  Here is its history:
-
-  1.  The initial import (revision 1.1 of everybody) created a
-      directory structure with a file named `default' in each dir:
-
-            ./
-              default
-              sub1/default
-                   subsubA/default
-                   subsubB/default
-              sub2/default
-                   subsubA/default
-              sub3/default
-
-  2.  Then tagged everyone with T_ALL_INITIAL_FILES.
-
-  3.  Then tagged everyone except sub1/subsubB/default with
-      T_ALL_INITIAL_FILES_BUT_ONE.
-
-  4.  Then created branch B_FROM_INITIALS on everyone.
-
-  5.  Then created branch B_FROM_INITIALS_BUT_ONE on everyone except
-      /sub1/subsubB/default.
-
-  6.  Then committed modifications to two files: sub3/default, and
-      sub1/subsubA/default.
-
-  7.  Then committed a modification to all 7 files.
-
-  8.  Then backdated sub3/default to revision 1.2, and
-      sub2/subsubA/default to revision 1.1, and tagged with T_MIXED.
-
-  9.  Same as 8, but tagged with -b to create branch B_MIXED.
-
-  10. Switched the working copy to B_MIXED, and added
-      sub2/branch_B_MIXED_only.  (That's why the RCS file is in
-      sub2/Attic/ -- it never existed on trunk.)
-
-  11. In one commit, modified default, sub1/default, and
-      sub2/subsubA/default, on branch B_MIXED.
-
-  12. Did "cvs up -A" on sub2/default, then in one commit, made a
-      change to sub2/default and sub2/branch_B_MIXED_only.  So this
-      commit should be spread between the branch and the trunk.
-
-  13. Do "cvs up -A" to get everyone back to trunk, then make a new
-      branch B_SPLIT on everyone except sub1/subsubB/default,v.
-
-  14. Switch to branch B_SPLIT (see sub1/subsubB/default disappear)
-      and commit a change that affects everyone except sub3/default.
-
-  15. An hour or so later, "cvs up -A" to get sub1/subsubB/default
-      back, then commit a change on that file, on trunk.  (It's
-      important that this change happened after the previous commits
-      on B_SPLIT.)
-
-  16. Branch sub1/subsubB/default to B_SPLIT, then "cvs up -r B_SPLIT"
-      to switch the whole working copy to the branch.
-
-  17. Commit a change on B_SPLIT, to sub1/subsubB/default and
-      sub3/default.
diff --git a/t/t9602/cvsroot/.gitattributes b/t/t9602/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9602/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9602/cvsroot/CVSROOT/.gitignore b/t/t9602/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9602/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9602/cvsroot/module/default,v b/t/t9602/cvsroot/module/default,v
deleted file mode 100644
index 3b68382..0000000
--- a/t/t9602/cvsroot/module/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.4
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1
-	1.2.4.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is the file `default' in the top level of the project.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a5 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/default,v b/t/t9602/cvsroot/module/sub1/default,v
deleted file mode 100644
index b7fdccd..0000000
--- a/t/t9602/cvsroot/module/sub1/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.4
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1
-	1.2.4.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub1/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a5 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubA/default,v b/t/t9602/cvsroot/module/sub1/subsubA/default,v
deleted file mode 100644
index 472b7b2..0000000
--- a/t/t9602/cvsroot/module/sub1/subsubA/default,v
+++ /dev/null
@@ -1,101 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.4
-	B_MIXED:1.3.0.2
-	T_MIXED:1.3
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.3.4.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.15.26;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.4.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub1/subsubA/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added by the first commit (affecting two files).
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.3.4.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a7 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2
-log
-@First commit to proj, affecting two files.
-@
-text
-@d6 2
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubB/default,v b/t/t9602/cvsroot/module/sub1/subsubB/default,v
deleted file mode 100644
index fe6efa4..0000000
--- a/t/t9602/cvsroot/module/sub1/subsubB/default,v
+++ /dev/null
@@ -1,107 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.06.03.04.29.14;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.04.33.13;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@A trunk change to sub1/subsubB/default.  This was committed about an
-hour after an earlier change that affected most files on branch
-B_SPLIT.  This file is not on that branch yet, but after this commit,
-we'll branch to B_SPLIT, albeit rooted in a revision that didn't exist
-at the time the rest of B_SPLIT was created.
-@
-text
-@This is sub1/subsubB/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-
-This bit was committed on trunk about an hour after an earlier change
-to everyone else on branch B_SPLIT.  Afterwards, we'll finally branch
-this file to B_SPLIT, but rooted in a revision that didn't exist at
-the time the rest of B_SPLIT was created.
-@
-
-
-1.3.2.1
-log
-@This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-text
-@a10 4
-
-This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@d6 5
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v b/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
deleted file mode 100644
index 34c9789..0000000
--- a/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
+++ /dev/null
@@ -1,59 +0,0 @@
-head	1.1;
-access;
-symbols
-	B_MIXED:1.1.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.1
-date	2003.05.23.00.25.26;	author jrandom;	state dead;
-branches
-	1.1.2.1;
-next	;
-
-1.1.2.1
-date	2003.05.23.00.25.26;	author jrandom;	state Exp;
-branches;
-next	1.1.2.2;
-
-1.1.2.2
-date	2003.05.23.00.48.51;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.1
-log
-@file branch_B_MIXED_only was initially added on branch B_MIXED.
-@
-text
-@@
-
-
-1.1.2.1
-log
-@Add a file on branch B_MIXED.
-@
-text
-@a0 1
-This file was added on branch B_MIXED.  It never existed on trunk.
-@
-
-
-1.1.2.2
-log
-@A single commit affecting one file on branch B_MIXED and one on trunk.
-@
-text
-@a1 3
-
-The same commit added these two lines here on branch B_MIXED, and two
-similar lines to ./default on trunk.
-@
-
-
diff --git a/t/t9602/cvsroot/module/sub2/default,v b/t/t9602/cvsroot/module/sub2/default,v
deleted file mode 100644
index 018f7f8..0000000
--- a/t/t9602/cvsroot/module/sub2/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.48.51;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@A single commit affecting one file on branch B_MIXED and one on trunk.
-@
-text
-@This is sub2/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-
-The same commit added these two lines here on trunk, and two similar
-lines to ./branch_B_MIXED_only on branch B_MIXED.
-@
-
-
-1.3.2.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a8 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@d6 3
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub2/subsubA/default,v b/t/t9602/cvsroot/module/sub2/subsubA/default,v
deleted file mode 100644
index d13242c..0000000
--- a/t/t9602/cvsroot/module/sub2/subsubA/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.2;
-access;
-symbols
-	B_SPLIT:1.2.0.2
-	B_MIXED:1.1.0.2
-	T_MIXED:1.1
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1
-	1.1.2.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.1.2.1
-date	2003.05.23.00.31.36;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2003.06.03.03.20.31;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub2/subsub2/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.2.2.1
-log
-@First change on branch B_SPLIT.
-
-This change excludes sub3/default, because it was not part of this
-commit, and sub1/subsubB/default, which is not even on the branch yet.
-@
-text
-@a5 2
-
-First change on branch B_SPLIT.
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.2.1
-log
-@Modify three files, on branch B_MIXED.
-@
-text
-@a3 2
-
-This line was added on branch B_MIXED only (affecting 3 files).
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9602/cvsroot/module/sub3/default,v b/t/t9602/cvsroot/module/sub3/default,v
deleted file mode 100644
index 88e4567..0000000
--- a/t/t9602/cvsroot/module/sub3/default,v
+++ /dev/null
@@ -1,102 +0,0 @@
-head	1.3;
-access;
-symbols
-	B_SPLIT:1.3.0.2
-	B_MIXED:1.2.0.2
-	T_MIXED:1.2
-	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
-	B_FROM_INITIALS:1.1.1.1.0.2
-	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
-	T_ALL_INITIAL_FILES:1.1.1.1
-	vendortag:1.1.1.1
-	vendorbranch:1.1.1;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2003.05.23.00.17.53;	author jrandom;	state Exp;
-branches
-	1.3.2.1;
-next	1.2;
-
-1.2
-date	2003.05.23.00.15.26;	author jrandom;	state Exp;
-branches;
-next	1.1;
-
-1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches
-	1.1.1.1;
-next	;
-
-1.1.1.1
-date	2003.05.22.23.20.19;	author jrandom;	state Exp;
-branches;
-next	;
-
-1.3.2.1
-date	2003.06.03.04.33.13;	author jrandom;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Second commit to proj, affecting all 7 files.
-@
-text
-@This is sub3/default.
-
-Every directory in the `proj' project has a file named `default'.
-
-This line was added by the first commit (affecting two files).
-
-This line was added in the second commit (affecting all 7 files).
-@
-
-
-1.3.2.1
-log
-@This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-text
-@a7 4
-
-This change affects sub3/default and sub1/subsubB/default, on branch
-B_SPLIT.  Note that the latter file did not even exist on this branch
-until after some other files had had revisions committed on B_SPLIT.
-@
-
-
-1.2
-log
-@First commit to proj, affecting two files.
-@
-text
-@d6 2
-@
-
-
-1.1
-log
-@Initial revision
-@
-text
-@d4 2
-@
-
-
-1.1.1.1
-log
-@Initial import.
-@
-text
-@@
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
deleted file mode 100755
index 52034c8..0000000
--- a/t/t9603-cvsimport-patchsets.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-
-# Structure of the test cvs repository
-#
-# Message   File:Content         Commit Time
-# Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
-# Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
-# Rev 3               b: 1.2     2009-02-21 19:11:43 +0100
-#
-# As you can see the commit of Rev 3 has the same time as
-# Rev 1 this leads to a broken import because of a cvsps
-# bug.
-
-test_description='git cvsimport testing for correct patchset estimation'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9603
-
-test_expect_failure 'import with criss cross times on revisions' '
-
-    git cvsimport -p"-x" -C module-git module &&
-    (cd module-git &&
-        git log --pretty=format:%s > ../actual-master &&
-        git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
-        echo "" >> ../actual-master &&
-	echo "" >> ../actual-A
-    ) &&
-    echo "Rev 4
-Rev 3
-Rev 2
-Rev 1" > expect-master &&
-    test_cmp actual-master expect-master &&
-
-    echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
-Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
-    test_cmp actual-A expect-A
-'
-
-test_done
diff --git a/t/t9603/cvsroot/.gitattributes b/t/t9603/cvsroot/.gitattributes
deleted file mode 100644
index 562b12e..0000000
--- a/t/t9603/cvsroot/.gitattributes
+++ /dev/null
@@ -1 +0,0 @@
-* -whitespace
diff --git a/t/t9603/cvsroot/CVSROOT/.gitignore b/t/t9603/cvsroot/CVSROOT/.gitignore
deleted file mode 100644
index 3bb9b34..0000000
--- a/t/t9603/cvsroot/CVSROOT/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-history
-val-tags
diff --git a/t/t9603/cvsroot/module/a,v b/t/t9603/cvsroot/module/a,v
deleted file mode 100644
index ba8fd5a..0000000
--- a/t/t9603/cvsroot/module/a,v
+++ /dev/null
@@ -1,74 +0,0 @@
-head	1.2;
-access;
-symbols
-	A:1.2.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.2
-date	2009.02.21.18.11.14;	author tester;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2009.02.21.18.11.43;	author tester;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2009.03.11.19.03.52;	author tester;	state Exp;
-branches;
-next	1.2.2.2;
-
-1.2.2.2
-date	2009.03.11.19.09.10;	author tester;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.2
-log
-@Rev 2
-@
-text
-@1.2
-@
-
-
-1.2.2.1
-log
-@Rev 4 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.1
-@
-
-
-1.2.2.2
-log
-@Rev 5 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.2
-@
-
-
-1.1
-log
-@Rev 1
-@
-text
-@d1 1
-a1 1
-1.1
-@
diff --git a/t/t9603/cvsroot/module/b,v b/t/t9603/cvsroot/module/b,v
deleted file mode 100644
index d268855..0000000
--- a/t/t9603/cvsroot/module/b,v
+++ /dev/null
@@ -1,90 +0,0 @@
-head	1.3;
-access;
-symbols
-	A:1.2.0.2;
-locks; strict;
-comment	@# @;
-
-
-1.3
-date	2009.03.11.19.05.08;	author tester;	state Exp;
-branches;
-next	1.2;
-
-1.2
-date	2009.02.21.18.11.43;	author tester;	state Exp;
-branches
-	1.2.2.1;
-next	1.1;
-
-1.1
-date	2009.02.21.18.11.14;	author tester;	state Exp;
-branches;
-next	;
-
-1.2.2.1
-date	2009.03.11.19.03.52;	author tester;	state Exp;
-branches;
-next	1.2.2.2;
-
-1.2.2.2
-date	2009.03.11.19.09.10;	author tester;	state Exp;
-branches;
-next	;
-
-
-desc
-@@
-
-
-1.3
-log
-@Rev 4
-@
-text
-@1.3
-@
-
-
-1.2
-log
-@Rev 3
-@
-text
-@d1 1
-a1 1
-1.2
-@
-
-
-1.2.2.1
-log
-@Rev 4 Branch A
-@
-text
-@d1 1
-a1 1
-1.2.2.1
-@
-
-
-1.2.2.2
-log
-@Rev 5 Branch A
-@
-text
-@d1 1
-a1 1
-1.2
-@
-
-
-1.1
-log
-@Rev 2
-@
-text
-@d1 1
-a1 1
-1.1
-@
-- 
1.8.1.rc2



-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
