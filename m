From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsserver: avoid warning about active db handles
Date: Tue, 25 Jul 2006 13:57:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 25 13:58:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5LY3-00018x-S1
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 13:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWGYL57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 07:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGYL57
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 07:57:59 -0400
Received: from mail.gmx.de ([213.165.64.21]:6573 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932342AbWGYL56 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 07:57:58 -0400
Received: (qmail invoked by alias); 25 Jul 2006 11:57:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 25 Jul 2006 13:57:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24170>


Turns out that DBD::SQLite does not favour preparing statements which are
never executed. So, turn all 4 statements, which were prepared _always_,
into methods, like the other 12 prepared statements.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	Now, the only warning left is the gzip one...

 git-cvsserver.perl |   70 ++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 981b6ba..b2837ad 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2131,12 +2131,6 @@ sub update
     # first lets get the commit list
     $ENV{GIT_DIR} = $self->{git_path};
 
-    # prepare database queries
-    my $db_insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
-    my $db_insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO commitmsgs (key, value) VALUES (?,?)",{},1);
-    my $db_delete_head = $self->{dbh}->prepare_cached("DELETE FROM head",{},1);
-    my $db_insert_head = $self->{dbh}->prepare_cached("INSERT INTO head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
-
     my $commitinfo = `git-cat-file commit $self->{module} 2>&1`;
     unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
     {
@@ -2325,7 +2319,7 @@ sub update
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
                 elsif ( $3 eq "M" )
                 {
@@ -2339,7 +2333,7 @@ sub update
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
                 elsif ( $3 eq "A" )
                 {
@@ -2353,7 +2347,7 @@ sub update
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $db_insert_rev->execute($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
                 else
                 {
@@ -2410,7 +2404,7 @@ sub update
                     };
 
 
-                    $db_insert_rev->execute($git_filename, $newrevision, $git_hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($git_filename, $newrevision, $git_hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
             }
             close FILELIST;
@@ -2426,7 +2420,7 @@ sub update
                     $head->{$file}{modified} = $commit->{date};
                     $head->{$file}{author} = $commit->{author};
 
-                    $db_insert_rev->execute($file, $head->{$file}{revision}, $head->{$file}{filehash}, $commit->{hash}, $commit->{date}, $commit->{author}, $head->{$file}{mode});
+                    $self->insert_rev($file, $head->{$file}{revision}, $head->{$file}{filehash}, $commit->{hash}, $commit->{date}, $commit->{author}, $head->{$file}{mode});
                 }
             }
             # END : "Detect deleted files"
@@ -2435,7 +2429,7 @@ sub update
 
         if (exists $commit->{mergemsg})
         {
-            $db_insert_mergelog->execute($commit->{hash}, $commit->{mergemsg});
+            $self->insert_mergelog($commit->{hash}, $commit->{mergemsg});
         }
 
         $lastpicked = $commit->{hash};
@@ -2443,10 +2437,10 @@ sub update
         $self->_set_prop("last_commit", $commit->{hash});
     }
 
-    $db_delete_head->execute();
+    $self->delete_head();
     foreach my $file ( keys %$head )
     {
-        $db_insert_head->execute(
+        $self->insert_head(
             $file,
             $head->{$file}{revision},
             $head->{$file}{filehash},
@@ -2464,6 +2458,54 @@ sub update
     $self->{dbh}->commit() or die "Failed to commit changes to SQLite";
 }
 
+sub insert_rev
+{
+    my $self = shift;
+    my $name = shift;
+    my $revision = shift;
+    my $filehash = shift;
+    my $commithash = shift;
+    my $modified = shift;
+    my $author = shift;
+    my $mode = shift;
+
+    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    $insert_rev->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
+}
+
+sub insert_mergelog
+{
+    my $self = shift;
+    my $key = shift;
+    my $value = shift;
+
+    my $insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO commitmsgs (key, value) VALUES (?,?)",{},1);
+    $insert_mergelog->execute($key, $value);
+}
+
+sub delete_head
+{
+    my $self = shift;
+
+    my $delete_head = $self->{dbh}->prepare_cached("DELETE FROM head",{},1);
+    $delete_head->execute();
+}
+
+sub insert_head
+{
+    my $self = shift;
+    my $name = shift;
+    my $revision = shift;
+    my $filehash = shift;
+    my $commithash = shift;
+    my $modified = shift;
+    my $author = shift;
+    my $mode = shift;
+
+    my $insert_head = $self->{dbh}->prepare_cached("INSERT INTO head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    $insert_head->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
+}
+
 sub _headrev
 {
     my $self = shift;
-- 
1.4.2.rc1.gd3c5-dirty
