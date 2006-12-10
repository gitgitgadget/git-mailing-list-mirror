X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make cvsexportcommit work with filenames with spaces and
	non-ascii characters.
Date: Sun, 10 Dec 2006 16:45:42 +0100
Message-ID: <20061210154542.3909.289.stgit@lathund.dewire.com>
References: <200612101639.22397.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 15:44:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
In-Reply-To: <200612101639.22397.robin.rosenberg@dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33897>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQqn-00030R-Ey for gcvg-git@gmane.org; Sun, 10 Dec
 2006 16:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761287AbWLJPoW convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761291AbWLJPoW
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 10:44:22 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10627 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1761287AbWLJPoV (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 10:44:21 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id CCE658030B8; Sun, 10 Dec 2006 16:40:26 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08161-01; Sun, 10 Dec
 2006 16:40:26 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3]) by torino.dewire.com
 (Postfix) with ESMTP id 8D3A6802AB4; Sun, 10 Dec 2006 16:40:25 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 9E5E128DA7; Sun, 10 Dec 2006
 16:46:54 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 dSmVlP6732VE; Sun, 10 Dec 2006 16:46:50 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 24F0428C39; Sun, 10 Dec 2006
 16:46:50 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>

This patch uses git-apply to do the patching which simplifies the code =
a lot.

Removed the test for checking for matching binary files when deleting t=
hem
since git-apply happily deletes the file. This is matter of taste since=
 we
allow some fuzz for text patches also.

Error handling was cleaned up, but not much tested.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Updated patch using --numstat to figure which files are binary.

 git-cvsexportcommit.perl       |  158 +++++++++++---------------------=
--------
 t/t9200-git-cvsexportcommit.sh |  108 ++++++++++++++++++++-------
 2 files changed, 125 insertions(+), 141 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index c9d1d88..159af66 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -2,9 +2,8 @@
=20
 # Known limitations:
 # - does not propagate permissions
-# - tells "ready for commit" even when things could not be completed
-#   (not sure this is true anymore, more testing is needed)
-# - does not handle whitespace in pathnames at all.
+# - error handling has not been extensively tested
+#
=20
 use strict;
 use Getopt::Std;
@@ -116,16 +115,13 @@ if ($opt_a) {
 close MSG;
=20
 my (@afiles, @dfiles, @mfiles, @dirs);
-my %amodes;
-my @files =3D safe_pipe_capture('git-diff-tree', '-r', $parent, $commi=
t);
-#print @files;
+my $files =3D safe_pipe_capture_blob('git-diff-tree', '-z', '-r', $par=
ent, $commit);
 $? && die "Error in git-diff-tree";
-foreach my $f (@files) {
-    chomp $f;
-    my @fields =3D split(m!\s+!, $f);
+while ($files =3D~ m/(.*?\000.*?\000)/g) {
+    my $f=3D$1;
+    my @fields =3D ( $f =3D~ m/^(\S+) (\S+) (\S+) (\S+) (\S+)\000(.*)\=
000/ );
     if ($fields[4] eq 'A') {
         my $path =3D $fields[5];
-	$amodes{$path} =3D $fields[1];
 	push @afiles, $path;
         # add any needed parent directories
 	$path =3D dirname $path;
@@ -141,20 +137,10 @@ foreach my $f (@files) {
 	push @dfiles, $fields[5];
     }
 }
-my (@binfiles, @abfiles, @dbfiles, @bfiles, @mbfiles);
-@binfiles =3D grep m/^Binary files/, safe_pipe_capture('git-diff-tree'=
, '-p', $parent, $commit);
-map { chomp } @binfiles;
-@abfiles =3D grep s/^Binary files \/dev\/null and b\/(.*) differ$/$1/,=
 @binfiles;
-@dbfiles =3D grep s/^Binary files a\/(.*) and \/dev\/null differ$/$1/,=
 @binfiles;
-@mbfiles =3D grep s/^Binary files a\/(.*) and b\/(.*) differ$/$1/, @bi=
nfiles;
-push @bfiles, @abfiles;
-push @bfiles, @dbfiles;
-push @bfiles, @mbfiles;
-push @mfiles, @mbfiles;
=20
+`git-diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;# |=
| die "Cannot diff";
 $opt_v && print "The commit affects:\n ";
 $opt_v && print join ("\n ", @afiles,@mfiles,@dfiles) . "\n\n";
-undef @files; # don't need it anymore
=20
 # check that the files are clean and up to date according to cvs
 my $dirty;
@@ -197,87 +183,36 @@ if ($dirty) {
     }
 }
=20
-###
-### NOTE: if you are planning to die() past this point
-###       you MUST call cleanupcvs(@files) before die()
-###
-
-
-print "Creating new directories\n";
-foreach my $d (@dirs) {
-    unless (mkdir $d) {
-        warn "Could not mkdir $d: $!";
-	$dirty =3D 1;
-    }
-    `cvs add $d`;
-    if ($?) {
-	$dirty =3D 1;
-	warn "Failed to cvs add directory $d -- you may need to do it manuall=
y";
-    }
-}
-
-print "'Patching' binary files\n";
-
-foreach my $f (@bfiles) {
-    # check that the file in cvs matches the "old" file
-    # extract the file to $tmpdir and compare with cmp
-    if (not(grep { $_ eq $f } @afiles)) {
-        my $tree =3D safe_pipe_capture('git-rev-parse', "$parent^{tree=
}");
-	chomp $tree;
-	my $blob =3D `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
-	chomp $blob;
-        `git-cat-file blob $blob > $tmpdir/blob`;
-        if (system('cmp', '-s', $f, "$tmpdir/blob")) {
-	    warn "Binary file $f in CVS does not match parent.\n";
-	    if (not $opt_f) {
-	        $dirty =3D 1;
-		next;
-	    }
-        }
-    }
-    if (not(grep { $_ eq $f } @dfiles)) {
-	my $tree =3D safe_pipe_capture('git-rev-parse', "$commit^{tree}");
-	chomp $tree;
-	my $blob =3D `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
-	chomp $blob;
-	# replace with the new file
-	`git-cat-file blob $blob > $f`;
-    }
-
-    # TODO: something smart with file modes
-
-}
-if ($dirty) {
-    cleanupcvs(@files);
-    die "Exiting: Binary files in CVS do not match parent";
-}
-
 ## apply non-binary changes
 my $fuzz =3D $opt_p ? 0 : 2;
=20
-print "Patching non-binary files\n";
+print "Patching\n";
=20
-if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) !=3D scalar(@bfile=
s)) {
-    print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz )=
 2>&1`;
-}
+my @stat;
+open APPLY, "GIT_DIR=3D git-apply -C$fuzz --binary --numstat --apply <=
=2Ecvsexportcommit.diff|" || die "cannot patch";
+@stat=3D<APPLY>;
+close APPLY || die "Cannot patch";
+my @bfiles=3Dgrep { chomp && s/^\-\t\-\t(.*)$/$1/; } @stat;
+map { s/^"(.*)"$/$1/g } @bfiles;
+map { s/\\([\d]{3})/sprintf('%c',oct $1)/eg } @bfiles;
=20
+print "Patch applied successfully. Adding new files and directories to=
 CVS\n";
 my $dirtypatch =3D 0;
-if (($? >> 8) =3D=3D 2) {
-    cleanupcvs(@files);
-    die "Exiting: Patch reported serious trouble -- you will have to a=
pply this patch manually";
-} elsif (($? >> 8) =3D=3D 1) { # some hunks failed to apply
-    $dirtypatch =3D 1;
+foreach my $d (@dirs) {
+    if (system('cvs','add',$d)) {
+	$dirtypatch =3D 1;
+	warn "Failed to cvs add directory $d -- you may need to do it manuall=
y";
+    }
 }
=20
 foreach my $f (@afiles) {
-    set_new_file_permissions($f, $amodes{$f});
     if (grep { $_ eq $f } @bfiles) {
       system('cvs', 'add','-kb',$f);
     } else {
       system('cvs', 'add', $f);
     }
     if ($?) {
-	$dirty =3D 1;
+	$dirtypatch =3D 1;
 	warn "Failed to cvs add $f -- you may need to do it manually";
     }
 }
@@ -285,35 +220,40 @@ foreach my $f (@afiles) {
 foreach my $f (@dfiles) {
     system('cvs', 'rm', '-f', $f);
     if ($?) {
-	$dirty =3D 1;
+	$dirtypatch =3D 1;
 	warn "Failed to cvs rm -f $f -- you may need to do it manually";
     }
 }
=20
 print "Commit to CVS\n";
-print "Patch: $title\n";
-my $commitfiles =3D join(' ', @afiles, @mfiles, @dfiles);
-my $cmd =3D "cvs commit -F .msg $commitfiles";
+print "Patch title (first comment line): $title\n";
+my @commitfiles =3D map { unless (m/\s/) { '\''.$_.'\''; } else { $_; =
}; } (@afiles, @mfiles, @dfiles);
+my $cmd =3D "cvs commit -F .msg @commitfiles";
=20
 if ($dirtypatch) {
     print "NOTE: One or more hunks failed to apply cleanly.\n";
-    print "Resolve the conflicts and then commit using:\n";
+    print "You'll need to apply the patch in .cvsexportcommit.diff man=
ually\n";
+    print "using a patch program. After applying the patch and resolvi=
ng the\n";
+    print "problems you may commit using:";
     print "\n    $cmd\n\n";
     exit(1);
 }
=20
-
 if ($opt_c) {
     print "Autocommit\n  $cmd\n";
     print safe_pipe_capture('cvs', 'commit', '-F', '.msg', @afiles, @m=
files, @dfiles);
     if ($?) {
-	cleanupcvs(@files);
 	die "Exiting: The commit did not succeed";
     }
     print "Committed successfully to CVS\n";
 } else {
     print "Ready for you to commit, just run:\n\n   $cmd\n";
 }
+
+# clean up
+unlink(".cvsexportcommit.diff");
+unlink(".msg");
+
 sub usage {
 	print STDERR <<END;
 Usage: GIT_DIR=3D/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f=
] [-m msgprefix] [ parent ] commit
@@ -321,17 +261,6 @@ END
 	exit(1);
 }
=20
-# ensure cvs is clean before we die
-sub cleanupcvs {
-    my @files =3D @_;
-    foreach my $f (@files) {
-	system('cvs', '-q', 'update', '-C', $f);
-	if ($?) {
-	    warn "Warning! Failed to cleanup state of $f\n";
-	}
-    }
-}
-
 # An alternative to `command` that allows input to be passed as an arr=
ay
 # to work around shell problems with weird characters in arguments
 # if the exec returns non-zero we die
@@ -346,12 +275,15 @@ sub safe_pipe_capture {
     return wantarray ? @output : join('',@output);
 }
=20
-# For any file we want to add to cvs, we must first set its permission=
s
-# properly, *before* the "cvs add ..." command.  Otherwise, it is impo=
ssible
-# to change the permission of the file in the CVS repository using onl=
y cvs
-# commands.  This should be fixed in cvs-1.12.14.
-sub set_new_file_permissions {
-    my ($file, $perm) =3D @_;
-    chmod oct($perm), $file
-      or die "failed to set permissions of \"$file\": $!\n";
+sub safe_pipe_capture_blob {
+    my $output;
+    if (my $pid =3D open my $child, '-|') {
+        local $/;
+	undef $/;
+	$output =3D (<$child>);
+	close $child or die join(' ',@_).": $! $?";
+    } else {
+	exec(@_) or die "$! $?"; # exec() can fail the executable can't be fo=
und
+    }
+    return $output;
 }
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index c102479..63eafc8 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -89,18 +89,17 @@ test_expect_success \
      ! git cvsexportcommit -c $id
      )'
=20
-# Should fail, but only on the git-cvsexportcommit stage
-test_expect_success \
-    'Fail to remove binary file more than one generation old' \
-    'git reset --hard HEAD^ &&
-     cat F/newfile6.png >>D/newfile4.png &&
-     git commit -a -m "generation 2 (again)" &&
-     rm -f D/newfile4.png &&
-     git commit -a -m "generation 3" &&
-     id=3D$(git rev-list --max-count=3D1 HEAD) &&
-     (cd "$CVSWORK" &&
-     ! git cvsexportcommit -c $id
-     )'
+#test_expect_success \
+#    'Fail to remove binary file more than one generation old' \
+#    'git reset --hard HEAD^ &&
+#     cat F/newfile6.png >>D/newfile4.png &&
+#     git commit -a -m "generation 2 (again)" &&
+#     rm -f D/newfile4.png &&
+#     git commit -a -m "generation 3" &&
+#     id=3D$(git rev-list --max-count=3D1 HEAD) &&
+#     (cd "$CVSWORK" &&
+#     ! git cvsexportcommit -c $id
+#     )'
=20
 # We reuse the state from two tests back here
=20
@@ -108,7 +107,7 @@ test_expect_success \
 # fail with gnu patch, so cvsexportcommit must handle that.
 test_expect_success \
     'Remove only binary files' \
-    'git reset --hard HEAD^^^ &&
+    'git reset --hard HEAD^^ &&
      rm -f D/newfile4.png &&
      git commit -a -m "test: remove only a binary file" &&
      id=3D$(git rev-list --max-count=3D1 HEAD) &&
@@ -142,20 +141,73 @@ test_expect_success \
      diff F/newfile6.png ../F/newfile6.png
      )'
=20
-test_expect_success 'Retain execute bit' '
-	mkdir G &&
-	echo executeon >G/on &&
-	chmod +x G/on &&
-	echo executeoff >G/off &&
-	git add G/on &&
-	git add G/off &&
-	git commit -a -m "Execute test" &&
-	(
-		cd "$CVSWORK" &&
-		git-cvsexportcommit -c HEAD
-		test -x G/on &&
-		! test -x G/off
-	)
-'
+test_expect_success \
+     'New file with spaces in file name' \
+     'mkdir "G g" &&
+      echo ok then >"G g/with spaces.txt" &&
+      git add "G g/with spaces.txt" && \
+      cp ../test9200a.png "G g/with spaces.png" && \
+      git add "G g/with spaces.png" &&
+      git commit -a -m "With spaces" &&
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id &&
+      test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.1/-kb with spaces.txt/1.1/"
+      )'
+
+test_expect_success \
+     'Update file with spaces in file name' \
+     'echo Ok then >>"G g/with spaces.txt" &&
+      cat ../test9200a.png >>"G g/with spaces.png" && \
+      git add "G g/with spaces.png" &&
+      git commit -a -m "Update with spaces" &&
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c $id
+      test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
+      )'
+
+# This test contains ISO-8859-1 characters
+test_expect_success \
+     'File with non-ascii file name' \
+     'mkdir =C5 &&
+      echo Foo >=C5/g=E5rdets=E5g=E5rdet.txt &&
+      git add =C5/g=E5rdets=E5g=E5rdet.txt &&
+      cp ../test9200a.png =C5/g=E5rdets=E5g=E5rdet.png &&
+      git add =C5/g=E5rdets=E5g=E5rdet.png &&
+      git commit -a -m "G=E5r det s=E5 g=E5r det" && \
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -v -c $id &&
+      test "$(echo $(sort =C5/CVS/Entries|cut -d/ -f2,3,5))" =3D "g=E5=
rdets=E5g=E5rdet.png/1.1/-kb g=E5rdets=E5g=E5rdet.txt/1.1/"
+      )'
+
+test_expect_success \
+     'Mismatching patch should fail' \
+     'date >>"E/newfile5.txt" &&
+      git add "E/newfile5.txt" &&
+      git commit -a -m "Update one" &&
+      date >>"E/newfile5.txt" &&
+      git add "E/newfile5.txt" &&
+      git commit -a -m "Update two" &&
+      id=3D$(git rev-list --max-count=3D1 HEAD) &&
+      (cd "$CVSWORK" &&
+      ! git-cvsexportcommit -c $id
+      )'
+
+test_expect_success \
+     'Retain execute bit' \
+     'mkdir G &&
+      echo executeon >G/on &&
+      chmod +x G/on &&
+      echo executeoff >G/off &&
+      git add G/on &&
+      git add G/off &&
+      git commit -a -m "Execute test" &&
+      (cd "$CVSWORK" &&
+      git-cvsexportcommit -c HEAD
+      test -x G/on &&
+      ! test -x G/off
+      )'
=20
