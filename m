From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] Introducing: git-cvsexportcommit
Date: Mon, 7 Nov 2005 17:57:08 +1300
Message-ID: <11313394283536-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Nov 07 05:52:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYyzg-0003X5-Ra
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 05:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVKGEwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 23:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVKGEwa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 23:52:30 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:29856 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751284AbVKGEw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 23:52:29 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EYyzc-00047b-Cs; Mon, 07 Nov 2005 17:52:28 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EYz48-0003OY-00; Mon, 07 Nov 2005 17:57:08 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11255>

A script that can replay commits git into a CVS checkout. Tries to ensure the
sanity of the operation and supports mainly manual usage.

If you are reckless enough, you can ask it to autocommit when everything has
applied cleanly. Combined with a couple more scripts could become part of
a git2cvs gateway.

Should support adds/removes and binary files.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>

---
The script has been in use in-house for a few days now, so it seems to
work. Should grow a matching git-cvsexport script to drive it...
---

 Documentation/git-cvsexportcommit.txt |   56 ++++++++
 Makefile                              |    2 
 git-cvsexportcommit.perl              |  225 +++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-cvsexportcommit.txt
 create mode 100755 git-cvsexportcommit.perl

applies-to: faf296a197318ad6a001a672e3b585e6fe31f37b
3c52d7ffb4ce62605a132c72170613be84b5d733
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
new file mode 100644
index 0000000..532db66
--- /dev/null
+++ b/Documentation/git-cvsexportcommit.txt
@@ -0,0 +1,56 @@
+git-cvsexportcommit(1)
+================
+
+NAME
+----
+git-cvsexportcommit - Export a commit to a CVS checkout
+
+
+SYNOPSIS
+--------
+git-cvsapplycommmit.perl 
+                        [ -h ] [ -v ] [ -c ] [ -p ] [PARENTCOMMIT] COMMITID 
+
+
+DESCRIPTION
+-----------
+Exports a commit from GIT to a CVS checkout, making it easier
+to merge patches from a git repository into a CVS repository. 
+
+Execute it from the root of the CVS working copy. GIT_DIR must be defined. 
+
+It does its best to do the safe thing, it will check that the files are 
+unchanged and up to date in the CVS checkout, and it will not autocommit 
+by default.
+
+Supports file additions, removals, and commits that affect binary files.
+
+If the commit is a merge commit, you must tell git-cvsapplycommit what parent
+should the changeset be done against. 
+
+OPTIONS
+-------
+
+-c::
+	Commit automatically if the patch applied cleanly. It will not
+	commit if any hunks fail to apply or there were other problems.
+
+-p::
+	Be pedantic (paranoid) when applying patches. Invokes patch with 
+	--fuzz=0
+
+-v::
+	Verbose.
+
+Author
+------
+Written by Martin Langhoff <martin@catalyst.net.nz>
+
+Documentation
+--------------
+Documentation by Martin Langhoff <martin@catalyst.net.nz>
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index 6c01dc2..9ee1605 100644
--- a/Makefile
+++ b/Makefile
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
-	git-svnimport.perl git-mv.perl
+	git-svnimport.perl git-mv.perl git-cvsexportcommit.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
new file mode 100755
index 0000000..7074b0c
--- /dev/null
+++ b/git-cvsexportcommit.perl
@@ -0,0 +1,225 @@
+#!/usr/bin/perl -w
+
+use strict;
+use Getopt::Std;
+use File::Temp qw(tempdir);
+use Data::Dumper;
+
+unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
+    die "GIT_DIR is not defined or is unreadable";
+}
+
+our ($opt_h, $opt_p, $opt_v, $opt_c );
+
+getopt('hpvc');
+
+$opt_h && usage();
+
+die "Need at least one commit identifier!" unless @ARGV;
+
+# setup a tempdir
+our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX',
+				     TMPDIR => 1,
+				     CLEANUP => 1);
+
+print Dumper(@ARGV);
+# resolve target commit
+my $commit;
+$commit = pop @ARGV;
+$commit = `git-rev-parse --verify "$commit"^0`;
+chomp $commit;
+if ($?) {
+    die "The commit reference $commit did not resolve!";
+}
+
+# resolve what parent we want
+my $parent;
+if (@ARGV) {
+    $parent = pop @ARGV;
+    $parent =  `git-rev-parse --verify "$parent"^0"`;
+    chomp $parent;
+    if ($?) {
+	die "The parent reference did not resolve!";
+    }
+}
+
+# find parents from the commit itself
+my @commit  = `git-cat-file commit $commit`;
+my @parents;
+foreach my $p (@commit) {
+    if ($p =~ m/^$/) { # end of commit headers, we're done
+	last;
+    }
+    if ($p =~ m/^parent (\w{40})$/) { # found a parent
+	push @parents, $1;
+    }
+}
+
+if ($parent) {
+    # double check that it's a valid parent
+    foreach my $p (@parents) {
+	my $found;
+	if ($p eq $parent) {
+	    $found = 1;
+	    last;
+	}; # found it
+	die "Did not find $parent in the parents for this commit!";
+s    }
+} else { # we don't have a parent from the cmdline...
+    if (@parents == 1) { # it's safe to get it from the commit
+	$parent = $parents[0];
+    } else { # or perhaps not!
+	die "This commit has more than one parent -- please name the parent you want to use explicitly";
+    }
+}
+
+$opt_v && print "Applying to CVS commit $commit from parent $parent\n";
+
+# grab the commit message
+`git-cat-file commit $commit | sed -e '1,/^\$/d' > .msg`;
+$? && die "Error extraction the commit message";
+
+my (@afiles, @dfiles, @mfiles);
+my @files = `git-diff-tree -r $parent $commit`;
+print @files;
+$? && die "Error in git-diff-tree";
+foreach my $f (@files) {
+    chomp $f;
+    my @fields = split(m/\s+/, $f);
+    if ($fields[4] eq 'A') {
+	push @afiles, $fields[5];
+    }
+    if ($fields[4] eq 'M') {
+	push @mfiles, $fields[5];
+    }
+    if ($fields[4] eq 'R') {
+	push @dfiles, $fields[5];
+    }
+}
+$opt_v && print "The commit affects:\n ";
+$opt_v && print join ("\n ", @afiles,@mfiles,@dfiles) . "\n\n";
+undef @files; # don't need it anymore
+
+# check that the files are clean and up to date according to cvs
+my $dirty;
+foreach my $f (@afiles, @mfiles, @dfiles) {
+    # TODO:we need to handle removed in cvs and/or new (from git) 
+    my $status = `cvs -q status "$f" | grep '^File: '`;
+
+    unless ($status =~ m/Status: Up-to-date$/) {
+	$dirty = 1;
+	warn "File $f not up to date in your CVS checkout!\n";
+    }
+}
+if ($dirty) {
+    die "Exiting: your CVS tree is not clean for this merge.";
+}
+
+###
+### NOTE: if you are planning to die() past this point
+###       you MUST call cleanupcvs(@files) before die()
+###
+
+
+print "'Patching' binary files\n";
+
+my @bfiles = `git-diff-tree -p $parent $commit | grep '^Binary'`;
+@bfiles = map { chomp } @bfiles;
+foreach my $f (@bfiles) {
+    # check that the file in cvs matches the "old" file
+    # extract the file to $tmpdir and comparre with cmp
+    my $tree = `git-rev-parse $parent^{tree} `;
+    chomp $tree;
+    my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
+    chomp $blob;
+    `git-cat-file blob $blob > $tmpdir/blob`;
+    `cmp -q $f $tmpdir/blob`;
+    if ($?) {
+	warn "Binary file $f in CVS does not match parent.\n";
+	$dirty = 1;
+	next;
+    }
+
+    # replace with the new file
+     `git-cat-file blob $blob > $f`;
+
+    # TODO: something smart with file modes
+
+}
+if ($dirty) {
+    cleanupcvs(@files);
+    die "Exiting: Binary files in CVS do not match parent";
+}
+
+## apply non-binary changes
+my $fuzz = $opt_p ? 0 : 2;
+
+print "Patching non-binary files\n";
+print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
+
+my $dirtypatch = 0;
+if (($? >> 8) == 2) {
+    cleanupcvs(@files);
+    die "Exiting: Patch reported serious trouble -- you will have to apply this patch manually";
+} elsif (($? >> 8) == 1) { # some hunks failed to apply
+    $dirtypatch = 1;
+}
+
+foreach my $f (@afiles) {
+    `cvs add $f`;
+    if ($?) {
+	$dirty = 1;
+	warn "Failed to cvs add $f -- you may need to do it manually";
+    }
+}
+
+foreach my $f (@dfiles) {
+    `cvs rm -f $f`;
+    if ($?) {
+	$dirty = 1;
+	warn "Failed to cvs rm -f $f -- you may need to do it manually";
+    }
+}
+
+print "Commit to CVS\n";
+my $commitfiles = join(' ', @afiles, @mfiles, @dfiles);
+my $cmd = "cvs commit -F .msg $commitfiles";
+
+if ($dirtypatch) {
+    print "NOTE: One or more hunks failed to apply cleanly.\n";
+    print "Resolve the conflicts and then commit using:n";
+    print "\n    $cmd\n\n";
+    exit;
+}
+
+
+if ($opt_c) {
+    print "Autocommit\n  $cmd\n";
+    print `cvs commit -F .msg $commitfiles 2>&1`;
+    if ($?) {
+	cleanupcvs(@files);
+	die "Exiting: The commit did not succeed";
+    }
+    print "Committed successfully to CVS\n";
+} else {
+    print "Ready for you to commit, just run:\n\n   $cmd\n";
+}
+sub usage {
+	print STDERR <<END;
+Usage: GIT_DIR=/path/to/.gi ${\basename $0}      # fetch/update GIT from CVS
+       [-h] [-p] [ parent ] commit
+END
+	exit(1);
+}
+
+# ensure cvs is clean before we die
+sub cleanupcvs {
+    my @files = @_;
+    foreach my $f (@files) {
+	`cvs -q update -C "$f"`;
+	if ($?) {
+	    warn "Warning! Failed to cleanup state of $f\n";
+	}
+    }
+}
+
---
0.99.8.GIT
