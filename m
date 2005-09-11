From: martin@catalyst.net.nz
Subject: [PATCH 4/5] archimport - use GIT_DIR instead of hardcoded ".git"
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <1126430765745-git-send-email-martin@catalyst.net.nz>
References: <11264307653007-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 11 11:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6f-00067Y-E7
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVIKJ0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbVIKJ0W
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:22 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:10195 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964837AbVIKJ0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:20 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id CBE2B8A72E;
	Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: <11264307653007-git-send-email-martin@catalyst.net.nz>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8286>

Use GIT_DIR from the environment instead of a hardcoded '.git' string.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport.perl |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

600258cfefc38939f09f267090ba400d80ab14c3
diff --git a/git-archimport.perl b/git-archimport.perl
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -24,7 +24,6 @@ See man (1) git-archimport for more deta
  - create tag objects instead of ref tags
  - audit shell-escaping of filenames
  - better handling of temp directories
- - use GIT_DIR instead of hardcoded ".git"
  - hide our private tags somewhere smarter
  - find a way to make "cat *patches | patch" safe even when patchfiles are missing newlines  
 
@@ -52,6 +51,9 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
+my $git_dir = $ENV{"GIT_DIR"} || ".git";
+$ENV{"GIT_DIR"} = $git_dir;
+
 our($opt_h,$opt_v, $opt_T,
     $opt_C,$opt_t);
 
@@ -179,7 +181,7 @@ foreach my $root (@arch_roots) {
 ##      and put an initial import
 ##      or a full tag
 my $import = 0;
-unless (-d '.git') { # initial import
+unless (-d $git_dir) { # initial import
     if ($psets[0]{type} eq 'i' || $psets[0]{type} eq 't') {
         print "Starting import from $psets[0]{id}\n";
 	`git-init-db`;
@@ -190,11 +192,11 @@ unless (-d '.git') { # initial import
     }
 } else {    # progressing an import
     # load the rptags
-    opendir(DIR, ".git/archimport/tags")
+    opendir(DIR, "$git_dir/archimport/tags")
 	|| die "can't opendir: $!";
     while (my $file = readdir(DIR)) {
 	# skip non-interesting-files
-	next unless -f ".git/archimport/tags/$file";
+	next unless -f "$git_dir/archimport/tags/$file";
 	next if     $file =~ m/--base-0$/; # don't care for base-0
 	my $sha = ptag($file);
 	chomp $sha;
@@ -238,7 +240,7 @@ foreach my $ps (@psets) {
     }
 
     unless ($import) { # skip for import
-        if ( -e ".git/refs/heads/$ps->{branch}") {
+        if ( -e "$git_dir/refs/heads/$ps->{branch}") {
             # we know about this branch
             `git checkout    $ps->{branch}`;
         } else {
@@ -291,7 +293,7 @@ foreach my $ps (@psets) {
     # imports don't give us good info
     # on added files. Shame on them
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') { 
-        `find . -type f -print0 | grep -zv '^./.git' | xargs -0 -l100 git-update-index --add`;
+        `find . -type f -print0 | grep -zv '^./$git_dir' | xargs -0 -l100 git-update-index --add`;
         `git-ls-files --deleted -z | xargs --no-run-if-empty -0 -l100 git-update-index --remove`;
     }
 
@@ -355,8 +357,8 @@ foreach my $ps (@psets) {
     # Who's your daddy?
     #
     my @par;
-    if ( -e ".git/refs/heads/$ps->{branch}") {
-        if (open HEAD, "<.git/refs/heads/$ps->{branch}") {
+    if ( -e "$git_dir/refs/heads/$ps->{branch}") {
+        if (open HEAD, "<$git_dir/refs/heads/$ps->{branch}") {
             my $p = <HEAD>;
             close HEAD;
             chomp $p;
@@ -403,11 +405,11 @@ foreach my $ps (@psets) {
     #
     # Update the branch
     # 
-    open  HEAD, ">.git/refs/heads/$ps->{branch}";
+    open  HEAD, ">$git_dir/refs/heads/$ps->{branch}";
     print HEAD $commitid;
     close HEAD;
-    unlink ('.git/HEAD');
-    symlink("refs/heads/$ps->{branch}",".git/HEAD");
+    unlink ("$git_dir/HEAD");
+    symlink("refs/heads/$ps->{branch}","$git_dir/HEAD");
 
     # tag accordingly
     ptag($ps->{id}, $commitid); # private tag
@@ -436,7 +438,7 @@ sub apply_import {
 
     `tla get -s --no-pristine -A $ps->{repo} $ps->{id} $tmp/import`;
     die "Cannot get import: $!" if $?;    
-    `rsync -v --archive --delete --exclude '.git' --exclude '.arch-ids' --exclude '{arch}' $tmp/import/* ./`;
+    `rsync -v --archive --delete --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/import/* ./`;
     die "Cannot rsync import:$!" if $?;
     
     `rm -fr $tmp/import`;
@@ -482,7 +484,7 @@ sub apply_cset {
     }
 
     # bring in new files
-    `rsync --archive --exclude '.git' --exclude '.arch-ids' --exclude '{arch}' $tmp/changeset/new-files-archive/* ./`;
+    `rsync --archive --exclude '$git_dir' --exclude '.arch-ids' --exclude '{arch}' $tmp/changeset/new-files-archive/* ./`;
 
     # deleted files are hinted from the commitlog processing
 
@@ -577,7 +579,7 @@ sub tag {
     $tag = shell_quote($tag);
     
     if ($commit) {
-        open(C,">.git/refs/tags/$tag")
+        open(C,">$git_dir/refs/tags/$tag")
             or die "Cannot create tag $tag: $!\n";
         print C "$commit\n"
             or die "Cannot write tag $tag: $!\n";
@@ -585,7 +587,7 @@ sub tag {
             or die "Cannot write tag $tag: $!\n";
         print " * Created tag ' $tag' on '$commit'\n" if $opt_v;
     } else {                    # read
-        open(C,"<.git/refs/tags/$tag")
+        open(C,"<$git_dir/refs/tags/$tag")
             or die "Cannot read tag $tag: $!\n";
         $commit = <C>;
         chomp $commit;
@@ -603,12 +605,12 @@ sub ptag {
     $tag =~ s|/|--|g; 
     $tag = shell_quote($tag);
     
-    unless (-d '.git/archimport/tags') {
-        mkpath('.git/archimport/tags');
+    unless (-d "$git_dir/archimport/tags") {
+        mkpath("$git_dir/archimport/tags");
     }
 
     if ($commit) {              # write
-        open(C,">.git/archimport/tags/$tag")
+        open(C,">$git_dir/archimport/tags/$tag")
             or die "Cannot create tag $tag: $!\n";
         print C "$commit\n"
             or die "Cannot write tag $tag: $!\n";
@@ -618,10 +620,10 @@ sub ptag {
 	    unless $tag =~ m/--base-0$/;
     } else {                    # read
         # if the tag isn't there, return 0
-        unless ( -s ".git/archimport/tags/$tag") {
+        unless ( -s "$git_dir/archimport/tags/$tag") {
             return 0;
         }
-        open(C,"<.git/archimport/tags/$tag")
+        open(C,"<$git_dir/archimport/tags/$tag")
             or die "Cannot read tag $tag: $!\n";
         $commit = <C>;
         chomp $commit;
