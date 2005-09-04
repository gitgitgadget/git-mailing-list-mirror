From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] archimport autodetects import status, supports incremental imports
Date: Sun, 4 Sep 2005 22:55:06 +1200
Message-ID: <1125831306901-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sun Sep 04 12:57:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBsAf-0002Ns-8N
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 12:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVIDKzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 06:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVIDKzh
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 06:55:37 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:47552 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750744AbVIDKzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 06:55:37 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 925B88AAC3;
	Sun,  4 Sep 2005 22:55:06 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8056>

If there is no GIT directory, archimport will assume it is an initial import.

It now also supports incremental imports,  skipping "seen" commits. You can
now run it repeatedly to pull new commits from the Arch repository.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-archimport-script |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

cc93bff516ed5f460f4d5b0eeb6157ede88d21c1
diff --git a/git-archimport-script b/git-archimport-script
--- a/git-archimport-script
+++ b/git-archimport-script
@@ -49,12 +49,12 @@ $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
 our($opt_h,$opt_v, $opt_T,
-    $opt_C,$opt_t, $opt_i);
+    $opt_C,$opt_t);
 
 sub usage() {
     print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from Arch
-       [ -h ] [ -v ] [ -i ] [ -T ] 
+       [ -h ] [ -v ] [ -T ] 
        [ -C GIT_repository ] [ -t tempdir ] 
        repository/arch-branch [ repository/arch-branch] ...
 END
@@ -173,21 +173,19 @@ foreach my $root (@arch_roots) {
 ## TODO cleanup irrelevant patches
 ##      and put an initial import
 ##      or a full tag
-
-if ($opt_i) {                   # initial import 
+my $import = 0;
+unless (-d '.git') { # initial import
     if ($psets[0]{type} eq 'i' || $psets[0]{type} eq 't') {
         print "Starting import from $psets[0]{id}\n";
+	`git-init-db`;
+	die $! if $?;
+	$import = 1;
     } else {
         die "Need to start from an import or a tag -- cannot use $psets[0]{id}";
     }
-    `git-init-db`;
-    die $! if $?;
 }
 
-# process
-my $lastbranch = branchname($psets[0]{id}); # only good for initial import
-my $importseen = $opt_i ? 0 : 1; # start at 1 if opt_i
-
+# process patchsets
 foreach my $ps (@psets) {
 
     $ps->{branch} =  branchname($ps->{id});
@@ -201,14 +199,22 @@ foreach my $ps (@psets) {
     }
     die $! if $?;
 
+    #
+    # skip commits already in repo
+    #
+    if (ptag($ps->{id})) {
+      $opt_v && print "Skipping already imported: $ps->{id}\n";
+      next;
+    }
+
     # 
     # create the branch if needed
     #
-    if ($ps->{type} eq 'i' && $importseen) {
-        die "Should not have more than one 'Initial import' per GIT import";
+    if ($ps->{type} eq 'i' && !$import) {
+        die "Should not have more than one 'Initial import' per GIT import: $ps->{id}";
     }
 
-    unless ($opt_i && !$importseen) { # skip for first commit
+    unless ($import) { # skip for import
         if ( -e ".git/refs/heads/$ps->{branch}") {
             # we know about this branch
             `git checkout    $ps->{branch}`;
@@ -225,13 +231,12 @@ foreach my $ps (@psets) {
         die $! if $?;
     } 
 
-        
     #
     # Apply the import/changeset/merge into the working tree
     # 
     if ($ps->{type} eq 'i' || $ps->{type} eq 't') {
-        $importseen = 1;
         apply_import($ps) or die $!;
+        $import=0;
     } elsif ($ps->{type} eq 's') {
         apply_cset($ps);
     }
@@ -577,8 +582,6 @@ sub ptag {
     } else {                    # read
         # if the tag isn't there, return 0
         unless ( -s ".git/archimport/tags/$tag") {
-            warn "Could not find tag $tag -- perhaps it isn't in the repos we have?\n" 
-                if $opt_v;
             return 0;
         }
         open(C,"<.git/archimport/tags/$tag")
