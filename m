From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/5] remove shellquote usage for tags
Date: Sat, 12 Nov 2005 01:25:34 -0800
Message-ID: <20051112092533.GB16218@Muzzle>
References: <20051112092336.GA16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 10:26:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eardj-0005HR-Lg
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 10:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKLJZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 04:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVKLJZh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 04:25:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39309 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932259AbVKLJZg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 04:25:36 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id DD8932DC03B;
	Sat, 12 Nov 2005 01:25:34 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Sat, 12 Nov 2005 01:25:34 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112092336.GA16218@Muzzle>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11663>

use ',' to encode '/' in "archivename/foo--bar--0.0" so we can allow
"--branch"-less trees which are valid in Arch ("archivename/foo--0.0")

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |   55 ++++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

applies-to: 76d3d1c302c20b82fd976e958aabd19f7f01e7b5
28d4f9ee8ba83b35eea66d4dd19b8ec26a0218c7
diff --git a/git-archimport.perl b/git-archimport.perl
index e22c816..7c15184 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -52,6 +52,7 @@ $ENV{'TZ'}="UTC";
 
 my $git_dir = $ENV{"GIT_DIR"} || ".git";
 $ENV{"GIT_DIR"} = $git_dir;
+my $ptag_dir = "$git_dir/archimport/tags";
 
 our($opt_h,$opt_v, $opt_T,
     $opt_C,$opt_t);
@@ -195,16 +196,19 @@ unless (-d $git_dir) { # initial import
     opendir(DIR, "$git_dir/archimport/tags")
 	|| die "can't opendir: $!";
     while (my $file = readdir(DIR)) {
-	# skip non-interesting-files
-	next unless -f "$git_dir/archimport/tags/$file";
-	next if     $file =~ m/--base-0$/; # don't care for base-0
+        # skip non-interesting-files
+        next unless -f "$ptag_dir/$file";
+   
+        # convert first '--' to '/' from old git-archimport to use
+        # as an archivename/c--b--v private tag
+        if ($file !~ m!,!) {
+            my $oldfile = $file;
+            $file =~ s!--!,!;
+            print STDERR "converting old tag $oldfile to $file\n";
+            rename("$ptag_dir/$oldfile", "$ptag_dir/$file") or die $!;
+        }
 	my $sha = ptag($file);
 	chomp $sha;
-	# reconvert the 3rd '--' sequence from the end
-	# into a slash
-	# $file = reverse $file;
-	# $file =~ s!^(.+?--.+?--.+?--.+?)--(.+)$!$1/$2!;
-	# $file = reverse $file;
 	$rptags{$sha} = $file;
     }
     closedir DIR;
@@ -582,19 +586,20 @@ sub parselog {
 # write/read a tag
 sub tag {
     my ($tag, $commit) = @_;
-    $tag =~ s|/|--|g; 
-    $tag = shell_quote($tag);
+ 
+    # don't use subdirs for tags yet, it could screw up other porcelains
+    $tag =~ s|/|,|;
     
     if ($commit) {
-        open(C,">$git_dir/refs/tags/$tag")
+        open(C,">","$git_dir/refs/tags/$tag")
             or die "Cannot create tag $tag: $!\n";
         print C "$commit\n"
             or die "Cannot write tag $tag: $!\n";
         close(C)
             or die "Cannot write tag $tag: $!\n";
-        print " * Created tag ' $tag' on '$commit'\n" if $opt_v;
+        print " * Created tag '$tag' on '$commit'\n" if $opt_v;
     } else {                    # read
-        open(C,"<$git_dir/refs/tags/$tag")
+        open(C,"<","$git_dir/refs/tags/$tag")
             or die "Cannot read tag $tag: $!\n";
         $commit = <C>;
         chomp $commit;
@@ -609,15 +614,16 @@ sub tag {
 # reads fail softly if the tag isn't there
 sub ptag {
     my ($tag, $commit) = @_;
-    $tag =~ s|/|--|g; 
-    $tag = shell_quote($tag);
+
+    # don't use subdirs for tags yet, it could screw up other porcelains
+    $tag =~ s|/|,|g; 
     
-    unless (-d "$git_dir/archimport/tags") {
-        mkpath("$git_dir/archimport/tags");
-    }
+    my $tag_file = "$ptag_dir/$tag";
+    my $tag_branch_dir = dirname($tag_file);
+    mkpath($tag_branch_dir) unless (-d $tag_branch_dir);
 
     if ($commit) {              # write
-        open(C,">$git_dir/archimport/tags/$tag")
+        open(C,">",$tag_file)
             or die "Cannot create tag $tag: $!\n";
         print C "$commit\n"
             or die "Cannot write tag $tag: $!\n";
@@ -627,10 +633,10 @@ sub ptag {
 	    unless $tag =~ m/--base-0$/;
     } else {                    # read
         # if the tag isn't there, return 0
-        unless ( -s "$git_dir/archimport/tags/$tag") {
+        unless ( -s $tag_file) {
             return 0;
         }
-        open(C,"<$git_dir/archimport/tags/$tag")
+        open(C,"<",$tag_file)
             or die "Cannot read tag $tag: $!\n";
         $commit = <C>;
         chomp $commit;
@@ -780,12 +786,7 @@ sub commitid2pset {
     chomp $commitid;
     my $name = $rptags{$commitid} 
 	|| die "Cannot find reverse tag mapping for $commitid";
-    # the keys in %rptag  are slightly munged; unmunge
-    # reconvert the 3rd '--' sequence from the end
-    # into a slash
-    $name = reverse $name;
-    $name =~ s!^(.+?--.+?--.+?--.+?)--(.+)$!$1/$2!;
-    $name = reverse $name;
+    $name =~ s|,|/|;
     my $ps   = $psets{$name} 
 	|| (print Dumper(sort keys %psets)) && die "Cannot find patchset for $name";
     return $ps;
---
0.99.9.GIT
