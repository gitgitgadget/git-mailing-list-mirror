From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] exportcommit: replace backticks with safe_pipe_capture() or system() - initial pass
Date: Mon, 30 Jan 2006 19:12:12 +1300
Message-ID: <11386015323441-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 30 07:13:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3SHg-0000Zz-Gz
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 07:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWA3GM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 01:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWA3GM0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 01:12:26 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:12473 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751250AbWA3GMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 01:12:25 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=aporo.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with smtp (Exim 4.50)
	id 1F3SGp-0006aP-Uq; Mon, 30 Jan 2006 19:12:12 +1300
In-Reply-To: 
To: git@vger.kernel.org
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15259>

Replaced backticks with potentially troublesome unescaped input with
safe_pipe_capture().

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

NOTE: this has only seen some limited testing. Needs review. 

---

 git-cvsexportcommit.perl |   53 +++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 20 deletions(-)

dcd2656443a39d64cc899fe1709a6bb35e89561d
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d5fbee7..7b3a3d3 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -27,7 +27,7 @@ print Dumper(@ARGV);
 # resolve target commit
 my $commit;
 $commit = pop @ARGV;
-$commit = `git-rev-parse --verify "$commit"^0`;
+$commit = safe_pipe_capture('git-rev-parse', '--verify', "$commit^0");
 chomp $commit;
 if ($?) {
     die "The commit reference $commit did not resolve!";
@@ -37,7 +37,7 @@ if ($?) {
 my $parent;
 if (@ARGV) {
     $parent = pop @ARGV;
-    $parent =  `git-rev-parse --verify "$parent"^0"`;
+    $parent =  safe_pipe_capture('git-rev-parse', '--verify', "$parent^0");
     chomp $parent;
     if ($?) {
 	die "The parent reference did not resolve!";
@@ -45,7 +45,7 @@ if (@ARGV) {
 }
 
 # find parents from the commit itself
-my @commit  = `git-cat-file commit $commit`;
+my @commit  = safe_pipe_capture('git-cat-file', 'commit', $commit);
 my @parents;
 foreach my $p (@commit) {
     if ($p =~ m/^$/) { # end of commit headers, we're done
@@ -81,12 +81,12 @@ $opt_v && print "Applying to CVS commit 
 $? && die "Error extracting the commit message";
 
 my (@afiles, @dfiles, @mfiles);
-my @files = `git-diff-tree -r $parent $commit`;
+my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
 print @files;
 $? && die "Error in git-diff-tree";
 foreach my $f (@files) {
     chomp $f;
-    my @fields = split(m/\s+/, $f);
+    my @fields = split(m!\s+!, $f);
     if ($fields[4] eq 'A') {
 	push @afiles, $fields[5];
     }
@@ -104,18 +104,19 @@ undef @files; # don't need it anymore
 # check that the files are clean and up to date according to cvs
 my $dirty;
 foreach my $f (@afiles) {
-    my $status = `cvs -q status "$f" | grep '^File: '`;
-
-    unless ($status =~ m/Status: Unknown$/) {
-	$dirty = 1;
+    # This should return only one value
+    my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
+    if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
+    unless ($status[0] =~ m/Status: Unknown$/) {
+ 	$dirty = 1;
 	warn "File $f is already known in your CVS checkout!\n";
     }
 }
 foreach my $f (@mfiles, @dfiles) {
     # TODO:we need to handle removed in cvs
-    my $status = `cvs -q status "$f" | grep '^File: '`;
-
-    unless ($status =~ m/Status: Up-to-date$/) {
+    my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
+    if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
+    unless ($status[0] =~ m/Status: Up-to-date$/) {
 	$dirty = 1;
 	warn "File $f not up to date in your CVS checkout!\n";
     }
@@ -132,18 +133,17 @@ if ($dirty) {
 
 print "'Patching' binary files\n";
 
-my @bfiles = `git-diff-tree -p $parent $commit | grep '^Binary'`;
+my @bfiles = grep(m/^Binary/, safe_pipe_capture('git-diff-tree', '-p', $parent, $commit));
 @bfiles = map { chomp } @bfiles;
 foreach my $f (@bfiles) {
     # check that the file in cvs matches the "old" file
     # extract the file to $tmpdir and comparre with cmp
-    my $tree = `git-rev-parse $parent^{tree} `;
+    my $tree = safe_pipe_capture('git-rev-parse', "$parent^{tree}");
     chomp $tree;
     my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
     chomp $blob;
     `git-cat-file blob $blob > $tmpdir/blob`;
-    `cmp -q $f $tmpdir/blob`;
-    if ($?) {
+    if (system('cmp', '-q', $f, "$tmpdir/blob")) {
 	warn "Binary file $f in CVS does not match parent.\n";
 	$dirty = 1;
 	next;
@@ -175,7 +175,7 @@ if (($? >> 8) == 2) {
 }
 
 foreach my $f (@afiles) {
-    `cvs add $f`;
+    system('cvs', 'add', $f);
     if ($?) {
 	$dirty = 1;
 	warn "Failed to cvs add $f -- you may need to do it manually";
@@ -183,7 +183,7 @@ foreach my $f (@afiles) {
 }
 
 foreach my $f (@dfiles) {
-    `cvs rm -f $f`;
+    system('cvs', 'rm', '-f', $f);
     if ($?) {
 	$dirty = 1;
 	warn "Failed to cvs rm -f $f -- you may need to do it manually";
@@ -204,7 +204,7 @@ if ($dirtypatch) {
 
 if ($opt_c) {
     print "Autocommit\n  $cmd\n";
-    print `cvs commit -F .msg $commitfiles 2>&1`;
+    print safe_pipe_capture('cvs', 'commit', '-F', '.msg', @afiles, @mfiles, @dfiles);
     if ($?) {
 	cleanupcvs(@files);
 	die "Exiting: The commit did not succeed";
@@ -224,10 +224,23 @@ END
 sub cleanupcvs {
     my @files = @_;
     foreach my $f (@files) {
-	`cvs -q update -C "$f"`;
+	system('cvs', '-q', 'update', '-C', $f);
 	if ($?) {
 	    warn "Warning! Failed to cleanup state of $f\n";
 	}
     }
 }
 
+# An alterative to `command` that allows input to be passed as an array
+# to work around shell problems with weird characters in arguments
+# if the exec returns non-zero we die
+sub safe_pipe_capture {
+    my @output;
+    if (my $pid = open my $child, '-|') {
+	@output = (<$child>);
+	close $child or die join(' ',@_).": $! $?";
+    } else {
+	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
+    }
+    return wantarray ? @output : join('',@output);
+}
-- 
1.1.6.g170f-dirty
