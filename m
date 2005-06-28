From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] cvsimport: rewritten in Perl
Date: Tue, 28 Jun 2005 21:23:23 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jun 28 21:33:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnLmu-0006qA-H9
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 21:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVF1Tf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVF1TeA
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 15:34:00 -0400
Received: from main.gmane.org ([80.91.229.2]:38326 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261378AbVF1TYq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 15:24:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnLZJ-0002Ek-BK
	for git@vger.kernel.org; Tue, 28 Jun 2005 21:16:25 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:16:25 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2005 21:16:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just got my machine blocked from a CVS server which didn't like
to get hammered with connections.

That was cvs2git's shell script. Which, by the way, is slow as hell.

Appended: a git-cvsimport script, written in Perl, which directly talks
to the CVS server. If the repository is local, it runs a "cvs server"
child. It produces the same git repository as Linus' version. It can do
incremental imports. And it's 20 times faster (on my system, with a
local CVS repository).

cvs2git is thus obsolete; this patch deletes it.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

--- 

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -63,18 +63,38 @@ Once you've gotten (and installed) cvsps
 any more familiar with it, but make sure it is in your path. After that,
 the magic command line is
 
-	git cvsimport <cvsroot> <module>
+	git cvsimport -v -d <cvsroot> <module> <destination>
 
 which will do exactly what you'd think it does: it will create a git
-archive of the named CVS module. The new archive will be created in a
-subdirectory named <module>.
+archive of the named CVS module. The new archive will be created in the
+subdirectory named <destination>; it'll be created if it doesn't exist.
+Default is the local directory.
 
 It can take some time to actually do the conversion for a large archive
 since it involves checking out from CVS every revision of every file,
-and the conversion script can be reasonably chatty, but on some not very
-scientific tests it averaged about eight revisions per second, so a
-medium-sized project should not take more than a couple of minutes.  For
-larger projects or remote repositories, the process may take longer.
+and the conversion script is reasonably chatty unless you omit the '-v'
+option, but on some not very scientific tests it averaged about twenty
+revisions per second, so a medium-sized project should not take more
+than a couple of minutes.  For larger projects or remote repositories,
+the process may take longer.
+
+After the (initial) import is done, the CVS archive's current head
+revision will be checked out -- thus, you can start adding your own
+changes right away.
+
+The import is incremental, i.e. if you call it again next month it'll
+fetch any CVS updates that have been happening in the meantime. The
+cut-off is date-based, so don't change the branches that were imported
+from CVS.
+
+You can merge those updates (or, in fact, a different CVS branch) into
+your main branch:
+
+	cg-merge <branch>
+
+The HEAD revision from CVS is named "origin", not "HEAD", because git
+already uses "HEAD". (If you don't like 'origin', use cvsimport's
+'-o' option to change it.)
 
 
 Emulating CVS behaviour
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -35,7 +35,7 @@ PROG=   git-update-cache git-diff-files 
 	git-http-pull git-ssh-push git-ssh-pull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
 	git-get-tar-commit-id git-apply git-stripspace \
-	git-cvs2git git-diff-stages git-rev-parse git-patch-id \
+	git-diff-stages git-rev-parse git-patch-id \
 	git-pack-objects git-unpack-objects
 
 all: $(PROG)
@@ -118,7 +118,6 @@ git-diff-helper: diff-helper.c
 git-tar-tree: tar-tree.c
 git-write-blob: write-blob.c
 git-stripspace: stripspace.c
-git-cvs2git: cvs2git.c
 git-diff-stages: diff-stages.c
 git-rev-parse: rev-parse.c
 git-patch-id: patch-id.c
diff --git a/cvs2git.c b/cvs2git.c
deleted file mode 100644
--- a/cvs2git.c
+++ /dev/null
@@ -1,329 +0,0 @@
-/*
- * cvs2git
- *
- * Copyright (C) Linus Torvalds 2005
- */
-
-#include <stdio.h>
-#include <ctype.h>
-#include <string.h>
-#include <stdlib.h>
-#include <unistd.h>
-
-static int verbose = 0;
-
-/*
- * This is a really stupid program that takes cvsps output, and
- * generates a a long _shell_script_ that will create the GIT archive
- * from it. 
- *
- * You've been warned. I told you it was stupid.
- *
- * NOTE NOTE NOTE! In order to do branches correctly, this needs
- * the fixed cvsps that has the "Ancestor branch" tag output.
- * Hopefully David Mansfield will update his distribution soon
- * enough (he's the one who wrote the patch, so at least we don't
- * have to figt maintainer issues ;)
- *
- * Usage:
- *
- *	TZ=UTC cvsps -A |
- *		git-cvs2git --cvsroot=[root] --module=[module] > script
- *
- * Creates a shell script that will generate the .git archive of
- * the names CVS repository.
- *
- *	TZ=UTC cvsps -s 1234- -A |
- *		git-cvs2git -u --cvsroot=[root] --module=[module] > script
- *
- * Creates a shell script that will update the .git archive with
- * CVS changes from patchset 1234 until the last one.
- *
- * IMPORTANT NOTE ABOUT "cvsps"! This requires version 2.1 or better,
- * and the "TZ=UTC" and the "-A" flag is required for sane results!
- */
-enum state {
-	Header,
-	Log,
-	Members
-};
-
-static const char *cvsroot;
-static const char *cvsmodule;
-
-static char date[100];
-static char author[100];
-static char branch[100];
-static char ancestor[100];
-static char tag[100];
-static char log[32768];
-static int loglen = 0;
-static int initial_commit = 1;
-
-static void lookup_author(char *n, char **name, char **email)
-{
-	/*
-	 * FIXME!!! I'm lazy and stupid.
-	 *
-	 * This could be something like
-	 *
-	 *	printf("lookup_author '%s'\n", n);
-	 *	*name = "$author_name";
-	 *	*email = "$author_email";
-	 *
-	 * and that would allow the script to do its own
-	 * lookups at run-time.
-	 */
-	*name = n;
-	*email = n;
-}
-
-static void prepare_commit(void)
-{
-	char *author_name, *author_email;
-	char *src_branch;
-
-	lookup_author(author, &author_name, &author_email);
-
-	printf("export GIT_COMMITTER_NAME=%s\n", author_name);
-	printf("export GIT_COMMITTER_EMAIL=%s\n", author_email);
-	printf("export GIT_COMMITTER_DATE='+0000 %s'\n", date);
-
-	printf("export GIT_AUTHOR_NAME=%s\n", author_name);
-	printf("export GIT_AUTHOR_EMAIL=%s\n", author_email);
-	printf("export GIT_AUTHOR_DATE='+0000 %s'\n", date);
-
-	if (initial_commit)
-		return;
-
-	src_branch = *ancestor ? ancestor : branch;
-	if (!strcmp(src_branch, "HEAD"))
-		src_branch = "master";
-	printf("ln -sf refs/heads/'%s' .git/HEAD\n", src_branch);
-
-	/*
-	 * Even if cvsps claims an ancestor, we'll let the new
-	 * branch name take precedence if it already exists
-	 */
-	if (*ancestor) {
-		src_branch = branch;
-		if (!strcmp(src_branch, "HEAD"))
-			src_branch = "master";
-		printf("[ -e .git/refs/heads/'%s' ] && ln -sf refs/heads/'%s' .git/HEAD\n",
-			src_branch, src_branch);
-	}
-
-	printf("git-read-tree -m HEAD || exit 1\n");
-	printf("git-checkout-cache -f -u -a\n");
-}
-
-static void commit(void)
-{
-	const char *cmit_parent = initial_commit ? "" : "-p HEAD";
-	const char *dst_branch;
-	char *space;
-	int i;
-
-	printf("tree=$(git-write-tree)\n");
-	printf("cat > .cmitmsg <<EOFMSG\n");
-
-	/* Escape $ characters, and remove control characters */
-	for (i = 0; i < loglen; i++) {
-		unsigned char c = log[i];
-
-		switch (c) {
-		case '$':
-		case '\\':
-		case '`':
-			putchar('\\');
-			break;
-		case 0 ... 31:
-			if (c == '\n' || c == '\t')
-				break;
-		case 128 ... 159:
-			continue;
-		}
-		putchar(c);
-	}
-	printf("\nEOFMSG\n");
-	printf("commit=$(cat .cmitmsg | git-commit-tree $tree %s)\n", cmit_parent);
-
-	dst_branch = branch;
-	if (!strcmp(dst_branch, "HEAD"))
-		dst_branch = "master";
-
-	printf("echo $commit > .git/refs/heads/'%s'\n", dst_branch);
-
-	space = strchr(tag, ' ');
-	if (space)
-		*space = 0;
-	if (strcmp(tag, "(none)"))
-		printf("echo $commit > .git/refs/tags/'%s'\n", tag);
-
-	printf("echo 'Committed (to %s):' ; cat .cmitmsg; echo\n", dst_branch);
-
-	*date = 0;
-	*author = 0;
-	*branch = 0;
-	*ancestor = 0;
-	*tag = 0;
-	loglen = 0;
-
-	initial_commit = 0;
-}
-
-static void update_file(char *line)
-{
-	char *name, *version;
-	char *dir;
-
-	while (isspace(*line))
-		line++;
-	name = line;
-	line = strchr(line, ':');
-	if (!line)
-		return;
-	*line++ = 0;
-	line = strchr(line, '>');
-	if (!line)
-		return;
-	*line++ = 0;
-	version = line;
-	line = strchr(line, '(');
-	if (line) {	/* "(DEAD)" */
-		printf("git-update-cache --force-remove '%s'\n", name);
-		return;
-	}
-
-	dir = strrchr(name, '/');
-	if (dir)
-		printf("mkdir -p %.*s\n", (int)(dir - name), name);
-
-	printf("cvs -q -d %s checkout -d .git-tmp -r%s '%s/%s'\n", 
-		cvsroot, version, cvsmodule, name);
-	printf("mv -f .git-tmp/%s %s\n", dir ? dir+1 : name, name);
-	printf("rm -rf .git-tmp\n");
-	printf("git-update-cache --add -- '%s'\n", name);
-}
-
-struct hdrentry {
-	const char *name;
-	char *dest;
-} hdrs[] = {
-	{ "Date:", date },
-	{ "Author:", author },
-	{ "Branch:", branch },
-	{ "Ancestor branch:", ancestor },
-	{ "Tag:", tag },
-	{ "Log:", NULL },
-	{ NULL, NULL }
-};
-
-int main(int argc, char **argv)
-{
-	static char line[1000];
-	enum state state = Header;
-	int i;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!memcmp(arg, "--cvsroot=", 10)) {
-			cvsroot = arg + 10;
-			continue;
-		}
-		if (!memcmp(arg, "--module=", 9)) {
-			cvsmodule = arg+9;
-			continue;
-		} 
-		if (!strcmp(arg, "-v")) {
-			verbose = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u")) {
-			initial_commit = 0;
-			continue;
-		}
-	}
-
-
-	if (!cvsroot)
-		cvsroot = getenv("CVSROOT");
-
-	if (!cvsmodule || !cvsroot) {
-		fprintf(stderr, "I need a CVSROOT and module name\n");
-		exit(1);
-	}
-
-	if (initial_commit) {
-		printf("[ -d .git ] && exit 1\n");
-		    printf("git-init-db\n");
-		printf("mkdir -p .git/refs/heads\n");
-		printf("mkdir -p .git/refs/tags\n");
-		printf("ln -sf refs/heads/master .git/HEAD\n");
-	}
-
-	while (fgets(line, sizeof(line), stdin) != NULL) {
-		int linelen = strlen(line);
-
-		while (linelen && isspace(line[linelen-1]))
-			line[--linelen] = 0;
-
-		switch (state) {
-		struct hdrentry *entry;
-
-		case Header:
-			if (verbose)
-				printf("# H: %s\n", line);
-			for (entry = hdrs ; entry->name ; entry++) {
-				int len = strlen(entry->name);
-				char *val;
-
-				if (memcmp(entry->name, line, len))
-					continue;
-				if (!entry->dest) {
-					state = Log;
-					break;
-				}
-				val = line + len;
-				linelen -= len;
-				while (isspace(*val)) {
-					val++;
-					linelen--;
-				}
-				memcpy(entry->dest, val, linelen+1);
-				break;
-			}
-			continue;
-
-		case Log:
-			if (verbose)
-				printf("# L: %s\n", line);
-			if (!strcmp(line, "Members:")) {
-				while (loglen && isspace(log[loglen-1]))
-					log[--loglen] = 0;
-				prepare_commit();
-				state = Members;
-				continue;
-			}
-				
-			if (loglen + linelen + 5 > sizeof(log))
-				continue;
-			memcpy(log + loglen, line, linelen);
-			loglen += linelen;
-			log[loglen++] = '\n';
-			continue;
-
-		case Members:
-			if (verbose)
-				printf("# M: %s\n", line);
-			if (!linelen) {
-				commit();
-				state = Header;
-				continue;
-			}
-			update_file(line);
-			continue;
-		}
-	}
-	return 0;
-}
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -1,38 +1,629 @@
-#!/bin/sh
+#!/usr/bin/perl -w
 
-usage () {
-	echo "Usage: git cvsimport [-v] [-z fuzz] <cvsroot> <module>"
-	exit 1
-}
-
-CVS2GIT=""
-CVSPS="--cvs-direct -x -A"
-while true; do
-	case "$1" in
-	-v) CVS2GIT="$1" ;;
-	-z) shift; CVSPS="$CVSPS -z $1" ;;
-	-*) usage ;;
-	*)  break ;;
-	esac
-	shift
-done
-
-export CVSROOT="$1"
-export MODULE="$2"
-if [ ! "$CVSROOT" ] || [ ! "$MODULE" ] ; then
-	usage
-fi
-
-cvsps -h 2>&1 | grep -q "cvsps version 2.1" >& /dev/null || {
-	echo "I need cvsps version 2.1"
-	exit 1
-}
-
-mkdir "$MODULE" || exit 1
-cd "$MODULE"
-
-TZ=UTC cvsps $CVSPS $MODULE > .git-cvsps-result
-[ -s .git-cvsps-result ] || exit 1
-git-cvs2git $CVS2GIT --cvsroot="$CVSROOT" --module="$MODULE" < .git-cvsps-result > .git-create-script || exit 1
-sh .git-create-script
+# This tool is copyright (c) 2005, Matthias Urlichs.
+# It is released under the Gnu Public License, version 2.
+#
+# The basic idea is to aggregate CVS check-ins into related changes.
+# Fortunately, "cvsps" does that for us; all we have to do is to parse
+# its output.
+#
+# Checking out the files is done by a single long-running CVS connection
+# / server process.
+#
+# The head revision is on branch "origin" by default.
+# You can change that with the '-o' option.
+
+use strict;
+use warnings;
+use Getopt::Std;
+use File::Path qw(mkpath);
+use File::Basename qw(basename dirname);
+use Time::Local;
+use IO::Socket;
+use IO::Pipe;
+use POSIX qw(strftime dup2);
+
+$SIG{'PIPE'}="IGNORE";
+$ENV{'TZ'}="UTC";
+
+our($opt_h,$opt_o,$opt_v,$opt_d);
+
+sub usage() {
+	print STDERR <<END;
+Usage: ${\basename $0}     # fetch/update GIT from CVS
+	   [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
+       CVS_module [ GIT_repository ]
+END
+	exit(1);
+}
+
+getopts("hqvo:d:") or usage();
+usage if $opt_h;
+
+@ARGV == 1 or @ARGV == 2 or usage();
+
+my($cvs_tree, $git_tree) = @ARGV;
+
+if($opt_d) {
+	$ENV{"CVSROOT"} = $opt_d;
+} elsif($ENV{"CVSROOT"}) {
+	$opt_d = $ENV{"CVSROOT"};
+} else {
+	die "CVSROOT needs to be set";
+}
+$opt_o ||= "origin";
+$git_tree ||= ".";
+
+select(STDERR); $|=1; select(STDOUT);
+
+
+package CVSconn;
+# Basic CVS dialog.
+# We're only interested in connecting and downloading, so ...
+
+use POSIX qw(strftime dup2);
+
+sub new {
+	my($what,$repo,$subdir) = @_;
+	$what=ref($what) if ref($what);
+
+	my $self = {};
+	$self->{'buffer'} = "";
+	bless($self,$what);
+
+	$repo =~ s#/+$##;
+	$self->{'fullrep'} = $repo;
+	$self->conn();
+
+	$self->{'subdir'} = $subdir;
+	$self->{'lines'} = undef;
+
+	return $self;
+}
+
+sub conn {
+	my $self = shift;
+	my $repo = $self->{'fullrep'};
+	if($repo =~ s/^:pserver:(?:(.*?)(?::(.*?))?@)?([^:\/]*)(?::(\d*))?//) {
+		my($user,$pass,$serv,$port) = ($1,$2,$3,$4);
+		$user="anonymous" unless defined $user;
+		my $rr2 = "-";
+		unless($port) {
+			$rr2 = ":pserver:$user\@$serv:$repo";
+			$port=2401;
+		}
+		my $rr = ":pserver:$user\@$serv:$port$repo";
+
+		unless($pass) {
+			open(H,$ENV{'HOME'}."/.cvspass") and do {
+				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+				while(<H>) {
+					chomp;
+					s/^\/\d+\s+//;
+					my ($w,$p) = split(/\s/,$_,2);
+					if($w eq $rr or $w eq $rr2) {
+						$pass = $p;
+						last;
+					}
+				}
+			};
+		}
+		$pass="A" unless $pass;
+
+		my $s = IO::Socket::INET->new(PeerHost => $serv, PeerPort => $port);
+		die "Socket to $serv: $!\n" unless defined $s;
+		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH REQUEST\n")
+			or die "Write to $serv: $!\n";
+		$s->flush();
+
+		my $rep = <$s>;
+
+		if($rep ne "I LOVE YOU\n") {
+			$rep="<unknown>" unless $rep;
+			die "AuthReply: $rep\n";
+		}
+		$self->{'socketo'} = $s;
+		$self->{'socketi'} = $s;
+	} else { # local: Fork off our own cvs server.
+		my $pr = IO::Pipe->new();
+		my $pw = IO::Pipe->new();
+		my $pid = fork();
+		die "Fork: $!\n" unless defined $pid;
+		unless($pid) {
+			$pr->writer();
+			$pw->reader();
+			dup2($pw->fileno(),0);
+			dup2($pr->fileno(),1);
+			$pr->close();
+			$pw->close();
+			exec("cvs","server");
+		}
+		$pw->writer();
+		$pr->reader();
+		$self->{'socketo'} = $pw;
+		$self->{'socketi'} = $pr;
+	}
+	$self->{'socketo'}->write("Root $repo\n");
+
+	# Trial and error says that this probably is the minimum set
+	$self->{'socketo'}->write("Valid-responses ok error Valid-requests Mode M Mbinary E F Checked-in Created Updated Merged Removed\n");
+
+	$self->{'socketo'}->write("valid-requests\n");
+	$self->{'socketo'}->flush();
+
+	chomp(my $rep=$self->readline());
+	if($rep !~ s/^Valid-requests\s*//) {
+		$rep="<unknown>" unless $rep;
+		die "Expected Valid-requests from server, but got: $rep\n";
+	}
+	chomp(my $res=$self->readline());
+	die "validReply: $res\n" if $res ne "ok";
+
+	$self->{'socketo'}->write("UseUnchanged\n") if $rep =~ /\bUseUnchanged\b/;
+	$self->{'repo'} = $repo;
+}
+
+sub readline {
+	my($self) = @_;
+	return $self->{'socketi'}->getline();
+}
+
+sub _file {
+	# Request a file with a given revision.
+	# Trial and error says this is a good way to do it. :-/
+	my($self,$fn,$rev) = @_;
+	$self->{'socketo'}->write("Argument -N\n") or return undef;
+	$self->{'socketo'}->write("Argument -P\n") or return undef;
+	# $self->{'socketo'}->write("Argument -ko\n") or return undef;
+	# -ko: Linus' version doesn't use it
+	$self->{'socketo'}->write("Argument -r\n") or return undef;
+	$self->{'socketo'}->write("Argument $rev\n") or return undef;
+	$self->{'socketo'}->write("Argument --\n") or return undef;
+	$self->{'socketo'}->write("Argument $self->{'subdir'}/$fn\n") or return undef;
+	$self->{'socketo'}->write("Directory .\n") or return undef;
+	$self->{'socketo'}->write("$self->{'repo'}\n") or return undef;
+	$self->{'socketo'}->write("Sticky T1.1\n") or return undef;
+	$self->{'socketo'}->write("co\n") or return undef;
+	$self->{'socketo'}->flush() or return undef;
+	$self->{'lines'} = 0;
+	return 1;
+}
+sub _line {
+	# Read a line from the server.
+	# ... except that 'line' may be an entire file. ;-)
+	my($self) = @_;
+	die "Not in lines" unless defined $self->{'lines'};
+
+	my $line;
+	my $res="";
+	while(defined($line = $self->readline())) {
+		# M U gnupg-cvs-rep/AUTHORS
+		# Updated gnupg-cvs-rep/
+		# /daten/src/rsync/gnupg-cvs-rep/AUTHORS
+		# /AUTHORS/1.1///T1.1
+		# u=rw,g=rw,o=rw
+		# 0
+		# ok
+
+		if($line =~ s/^(?:Created|Updated) //) {
+			$line = $self->readline(); # path
+			$line = $self->readline(); # Entries line
+			my $mode = $self->readline(); chomp $mode;
+			$self->{'mode'} = $mode;
+			defined (my $cnt = $self->readline())
+				or die "EOF from server after 'Changed'\n";
+			chomp $cnt;
+			die "Duh: Filesize $cnt" if $cnt !~ /^\d+$/;
+			$line="";
+			$res="";
+			while($cnt) {
+				my $buf;
+				my $num = $self->{'socketi'}->read($buf,$cnt);
+				die "Server: Filesize $cnt: $num: $!\n" if not defined $num or $num<=0;
+				$res .= $buf;
+				$cnt -= $num;
+			}
+		} elsif($line =~ s/^ //) {
+			$res .= $line;
+		} elsif($line =~ /^M\b/) {
+			# output, do nothing
+		} elsif($line =~ /^Mbinary\b/) {
+			my $cnt;
+			die "EOF from server after 'Mbinary'" unless defined ($cnt = $self->readline());
+			chomp $cnt;
+			die "Duh: Mbinary $cnt" if $cnt !~ /^\d+$/ or $cnt<1;
+			$line="";
+			while($cnt) {
+				my $buf;
+				my $num = $self->{'socketi'}->read($buf,$cnt);
+				die "S: Mbinary $cnt: $num: $!\n" if not defined $num or $num<=0;
+				$res .= $buf;
+				$cnt -= $num;
+			}
+		} else {
+			chomp $line;
+			if($line eq "ok") {
+				# print STDERR "S: ok (".length($res).")\n";
+				return $res;
+			} elsif($line =~ s/^E //) {
+				# print STDERR "S: $line\n";
+			} else {
+				die "Unknown: $line\n";
+			}
+		}
+	}
+}
+sub file {
+	my($self,$fn,$rev) = @_;
+	my $res;
+
+	if ($self->_file($fn,$rev)) {
+		$res = $self->_line();
+		return $res if defined $res;
+	}
+
+	# retry
+	$self->conn();
+	$self->_file($fn,$rev)
+		or die "No file command send\n";
+	$res = $self->_line();
+	die "No input: $fn $rev\n" unless defined $res;
+	return $res;
+}
+
+
+package main;
+
+my $cvs = CVSconn->new($opt_d, $cvs_tree);
+
+
+sub pdate($) {
+	my($d) = @_;
+	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
+		or die "Unparseable date: $d\n";
+	my $y=$1; $y-=1900 if $y>1900;
+	return timegm($6||0,$5,$4,$3,$2-1,$y);
+}
+
+sub pmode($) {
+	my($mode) = @_;
+	my $m = 0;
+	my $mm = 0;
+	my $um = 0;
+	for my $x(split(//,$mode)) {
+		if($x eq ",") {
+			$m |= $mm&$um;
+			$mm = 0;
+			$um = 0;
+		} elsif($x eq "u") { $um |= 0700;
+		} elsif($x eq "g") { $um |= 0070;
+		} elsif($x eq "o") { $um |= 0007;
+		} elsif($x eq "r") { $mm |= 0444;
+		} elsif($x eq "w") { $mm |= 0222;
+		} elsif($x eq "x") { $mm |= 0111;
+		} elsif($x eq "=") { # do nothing
+		} else { die "Unknown mode: $mode\n";
+		}
+	}
+	$m |= $mm&$um;
+	return $m;
+}
+
+my $tmpcv = "/var/cache/cvs";
+
+sub getwd() {
+	my $pwd = `pwd`;
+	chomp $pwd;
+	return $pwd;
+}
+
+-d $git_tree
+	or mkdir($git_tree,0777)
+	or die "Could not create $git_tree: $!";
+chdir($git_tree);
+
+my $last_branch = "";
+my $orig_branch = "";
+my %branch_date;
+
+my $git_dir = $ENV{"GIT_DIR"} || ".git";
+$git_dir = getwd()."/".$git_dir unless $git_dir =~ m#^/#;
+$ENV{"GIT_DIR"} = $git_dir;
+unless(-d $git_dir) {
+	system("git-init-db");
+	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
+	system("git-read-tree");
+	die "Cannot init an empty tree: $?\n" if $?;
+
+	$last_branch = $opt_o;
+	$orig_branch = "";
+} else {
+	$last_branch = basename(readlink("$git_dir/HEAD"));
+	unless($last_branch) {
+		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
+		$last_branch = "master";
+	}
+	$orig_branch = $last_branch;
+
+	# Get the last import timestamps
+	opendir(D,"$git_dir/refs/heads");
+	while(defined(my $head = readdir(D))) {
+		next if $head =~ /^\./;
+		open(F,"$git_dir/refs/heads/$head")
+			or die "Bad head branch: $head: $!\n";
+		chomp(my $ftag = <F>);
+		close(F);
+		open(F,"git-cat-file commit $ftag |");
+		while(<F>) {
+			next unless /^author\s.*\s(\d+)\s[-+]\d{4}$/;
+			$branch_date{$head} = $1;
+			last;
+		}
+		close(F);
+	}
+	closedir(D);
+}
+
+-d $git_dir
+	or die "Could not create git subdir ($git_dir).\n";
+
+my $pid = open(CVS,"-|");
+die "Cannot fork: $!\n" unless defined $pid;
+unless($pid) {
+	exec("cvsps","-A","--cvs-direct",$cvs_tree);
+	die "Could not start cvsps: $!\n";
+}
+
+
+## cvsps output:
+#---------------------
+#PatchSet 314
+#Date: 1999/09/18 13:03:59
+#Author: wkoch
+#Branch: STABLE-BRANCH-1-0
+#Ancestor branch: HEAD
+#Tag: (none)
+#Log:
+#    See ChangeLog: Sat Sep 18 13:03:28 CEST 1999  Werner Koch
+#Members:
+#	README:1.57->1.57.2.1
+#	VERSION:1.96->1.96.2.1
+#
+#---------------------
+
+my $state = 0;
+
+my($patchset,$date,$author,$branch,$ancestor,$tag,$logmsg);
+my(@old,@new);
+my $commit = sub {
+	my $pid;
+	system("git-update-cache","--force-remove","--",@old) if @old;
+	die "Cannot remove files: $?\n" if $?;
+	system("git-update-cache","--add","--",@new) if @new;
+	die "Cannot add files: $?\n" if $?;
+
+	$pid = open(C,"-|");
+	die "Cannot fork: $!" unless defined $pid;
+	unless($pid) {
+		exec("git-write-tree");
+		die "Cannot exec git-write-tree: $!\n";
+	}
+	chomp(my $tree = <C>);
+	length($tree) == 40
+		or die "Cannot get tree id ($tree): $!\n";
+	close(C)
+		or die "Error running git-write-tree: $?\n";
+	print "Tree ID $tree\n" if $opt_v;
+
+	my $parent = "";
+	if(open(C,"$git_dir/refs/heads/$last_branch")) {
+		chomp($parent = <C>);
+		close(C);
+		length($parent) == 40
+			or die "Cannot get parent id ($parent): $!\n";
+		print "Parent ID $parent\n" if $opt_v;
+	}
+
+	my $pr = IO::Pipe->new();
+	my $pw = IO::Pipe->new();
+	$pid = fork();
+	die "Fork: $!\n" unless defined $pid;
+	unless($pid) {
+		$pr->writer();
+		$pw->reader();
+		dup2($pw->fileno(),0);
+		dup2($pr->fileno(),1);
+		$pr->close();
+		$pw->close();
+
+		my @par = ();
+		@par = ("-p",$parent) if $parent;
+		exec("env",
+			"GIT_AUTHOR_NAME=$author",
+			"GIT_AUTHOR_EMAIL=$author",
+			"GIT_AUTHOR_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
+			"GIT_COMMITTER_NAME=$author",
+			"GIT_COMMITTER_EMAIL=$author",
+			"GIT_COMMITTER_DATE=".strftime("+0000 %Y-%m-%d %H:%M:%S",gmtime($date)),
+			"git-commit-tree", $tree,@par);
+		die "Cannot exec git-commit-tree: $!\n";
+	}
+	$pw->writer();
+	$pr->reader();
+	print $pw $logmsg
+		or die "Error writing to git-commit-tree: $!\n";
+	$pw->close();
+
+	print "Committed patch $patchset ($branch)\n" if $opt_v;
+	chomp(my $cid = <$pr>);
+	length($cid) == 40
+		or die "Cannot get commit id ($cid): $!\n";
+	print "Commit ID $cid\n" if $opt_v;
+	$pr->close();
+
+	waitpid($pid,0);
+	die "Error running git-commit-tree: $?\n" if $?;
+
+	open(C,">$git_dir/refs/heads/$branch")
+		or die "Cannot open branch $branch for update: $!\n";
+	print C "$cid\n"
+		or die "Cannot write branch $branch for update: $!\n";
+	close(C)
+		or die "Cannot write branch $branch for update: $!\n";
+
+	if($tag) {
+		open(C,">$git_dir/refs/tags/$tag")
+			or die "Cannot create tag $tag: $!\n";
+		print C "$cid\n"
+			or die "Cannot write tag $branch: $!\n";
+		close(C)
+			or die "Cannot write tag $branch: $!\n";
+		print "Created tag '$tag' on '$branch'\n" if $opt_v;
+	}
+
+	@old = ();
+	@new = ();
+};
+
+while(<CVS>) {
+	chomp;
+	if($state == 0 and /^-+$/) {
+		$state = 1;
+	} elsif($state == 0) {
+		$state = 1;
+		redo;
+	} elsif(($state==0 or $state==1) and s/^PatchSet\s+//) {
+		$patchset = 0+$_;
+		$state=2;
+	} elsif($state == 2 and s/^Date:\s+//) {
+		$date = pdate($_);
+		unless($date) {
+			print STDERR "Could not parse date: $_\n";
+			$state=0;
+			next;
+		}
+		$state=3;
+	} elsif($state == 3 and s/^Author:\s+//) {
+		s/\s+$//;
+		$author = $_;
+		$state = 4;
+	} elsif($state == 4 and s/^Branch:\s+//) {
+		s/\s+$//;
+		$branch = $_;
+		$state = 5;
+	} elsif($state == 5 and s/^Ancestor branch:\s+//) {
+		s/\s+$//;
+		$ancestor = $_;
+		$ancestor = $opt_o if $ancestor == "HEAD";
+		$state = 6;
+	} elsif($state == 5) {
+		$ancestor = undef;
+		$state = 6;
+		redo;
+	} elsif($state == 6 and s/^Tag:\s+//) {
+		s/\s+$//;
+		if($_ eq "(none)") {
+			$tag = undef;
+		} else {
+			$tag = $_;
+		}
+		$state = 7;
+	} elsif($state == 7 and /^Log:/) {
+		$logmsg = "";
+		$state = 8;
+	} elsif($state == 8 and /^Members:/) {
+		$branch = $opt_o if $branch eq "HEAD";
+		if(defined $branch_date{$branch} and $branch_date{$branch} >= $date) {
+			# skip
+			print "skip patchset $patchset: $date before $branch_date{$branch}\n";
+			$state = 11;
+			next;
+		}
+		if($ancestor) {
+			if(-f "$git_dir/refs/heads/$branch") {
+				print STDERR "Branch $branch already exists!\n";
+				$state=11;
+				next;
+			}
+			unless(open(H,"$git_dir/refs/heads/$ancestor")) {
+				print STDERR "Branch $ancestor does not exist!\n";
+				$state=11;
+				next;
+			}
+			chomp(my $id = <H>);
+			close(H);
+			unless(open(H,"> $git_dir/refs/heads/$branch")) {
+				print STDERR "Could not create branch $branch: $!\n";
+				$state=11;
+				next;
+			}
+			print H "$id\n"
+				or die "Could not write branch $branch: $!";
+			close(H)
+				or die "Could not write branch $branch: $!";
+		}
+		if(($ancestor || $branch) ne $last_branch) {
+			print "Switching from $last_branch to $branch\n" if $opt_v;
+			system("git-read-tree","-m","-u","$last_branch","$branch");
+			die "read-tree failed: $?\n" if $?;
+		}
+		if($branch ne $last_branch) {
+			unlink("$git_dir/HEAD");
+			symlink("refs/heads/$branch","$git_dir/HEAD");
+			$last_branch = $branch;
+		}
+		$state = 9;
+	} elsif($state == 8) {
+		$logmsg .= "$_\n";
+	} elsif($state == 9 and /^\s+(\S+):(INITIAL|\d(?:\.\d+)+)->(\d(?:\.\d+)+)\s*$/) {
+#	VERSION:1.96->1.96.2.1
+		my $init = ($2 eq "INITIAL");
+		my $fn = $1;
+		my $rev = $3;
+		$fn =~ s#^/+##;
+		my $data = $cvs->file($fn,$rev);
+		print "".($init ? "New" : "Update")." $fn: ".length($data)." bytes.\n";
+		mkpath(dirname($fn),$opt_v);
+		open(F,"> ./$fn")
+			or die "Cannot create '$fn': $!\n";
+		print F $data
+			or die "Cannot write to '$fn': $!\n";
+		close(F)
+			or die "Cannot write to '$fn': $!\n";
+		chmod(pmode($cvs->{'mode'}), $fn);
+		push(@new,$fn); # may be resurrected!
+	} elsif($state == 9 and /^\s+(\S+):\d(?:\.\d+)+->(\d(?:\.\d+)+)\(DEAD\)\s*$/) {
+		my $fn = $1;
+		$fn =~ s#^/+##;
+		push(@old,$fn);
+	} elsif($state == 9 and /^\s*$/) {
+		$state = 10;
+	} elsif(($state == 9 or $state == 10) and /^-+$/) {
+		&$commit();
+		$state = 1;
+	} elsif($state == 11 and /^-+$/) {
+		$state = 1;
+	} elsif(/^-+$/) { # end of unknown-line processing
+		$state = 1;
+	} elsif($state != 11) { # ignore stuff when skipping
+		print "* UNKNOWN LINE * $_\n";
+	}
+}
+&$commit() if $branch and $state != 11;
+
+# Now switch back to the branch we were in before all of this happened
+if($orig_branch) {
+	print "DONE; switching back to $orig_branch\n" if $opt_v;
+} else {
+	$orig_branch = "master";
+	print "DONE; creating $orig_branch branch\n" if $opt_v;
+	system("cp","$git_dir/refs/heads/$opt_o","$git_dir/refs/heads/master")
+		unless -f "$git_dir/refs/heads/master";
+}
+
+system("git-read-tree","-m","-u","$last_branch","$orig_branch");
+die "read-tree failed: $?\n" if $?;
+
+unlink("$git_dir/HEAD");
+symlink("refs/heads/$orig_branch","$git_dir/HEAD");
 
