From: Josh Elsasser <josh@elsasser.org>
Subject: [PATCH v2] Allow git-cvsserver database table name prefix to be specified.
Date: Wed, 19 Mar 2008 22:05:46 -0700
Message-ID: <1205989546855-git-send-email-josh@elsasser.org>
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Josh Elsasser <josh@elsasser.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 06:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCz0-00036m-AT
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 06:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYCTFFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 01:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYCTFFt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 01:05:49 -0400
Received: from opal.elsasser.org ([198.145.64.114]:13055 "EHLO
	opal.elsasser.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYCTFFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 01:05:48 -0400
Received: by opal.elsasser.org (Postfix, from userid 1000)
	id 4AA913E247; Wed, 19 Mar 2008 22:05:47 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: 20080318080913.GF18624@mail-vs.djpig.de
References: 20080318080913.GF18624@mail-vs.djpig.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77629>

Adds a gitcvs.dbprefix config variable, the contents of which are
prepended to any database tables used by git-cvsserver. The same
substutions as gitcvs.dbname and gitcvs.dbuser are supported, and any
non-alphabetic characters are replaced with underscores.
---

The purpose of this patch is to easily allow a single database (think
PostgreSQL or MySQL) to be shared by multiple repositories.

This version of the patches fixes a couple spelling mistakes and
unrelated changes pointed out by Frank Lichtenheld, thanks.

 Documentation/config.txt               |    7 +++
 Documentation/git-cvsserver.txt        |    5 ++
 contrib/completion/git-completion.bash |    2 +-
 git-cvsserver.perl                     |   73 +++++++++++++++++++-------------
 4 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0865f4e..1919cde 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -661,6 +661,13 @@ gitcvs.dbuser, gitcvs.dbpass::
 	'gitcvs.dbuser' supports variable substitution (see
 	linkgit:git-cvsserver[1] for details).
 
+gitcvs.dbprefix::
+	Database table name prefix. This will be prepended to any
+	tables used, allowing a single database to be used for several
+	repositories. Supports variable substitution (see
+	linkgit:git-cvsserver[1] for details). Any non-alphabetic
+	characters will be replaced with underscores.
+
 All gitcvs variables except for 'gitcvs.allbinary' can also be
 specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index d3e9993..5299c47 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -227,6 +227,11 @@ gitcvs.dbpass::
 	Database password.  Only useful if setting `dbdriver`, since
 	SQLite has no concept of database passwords.
 
+gitcvs.dbprefix::
+	Database table name prefix. Supports variable substitution
+	(see below). Any non-alphabetic characters will be replaced
+	with underscores.
+
 All variables can also be set per access method, see <<configaccessmethod,above>>.
 
 Variable substitution
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5046f69..7d77374 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -999,7 +999,7 @@ _git_config ()
 		gitcvs.enabled
 		gitcvs.logfile
 		gitcvs.allbinary
-		gitcvs.dbname gitcvs.dbdriver gitcvs.dbuser gitcvs.dvpass
+		gitcvs.dbname gitcvs.dbdriver gitcvs.dbuser gitcvs.dbpass gitcvs.dbprefix
 		gc.packrefs
 		gc.reflogexpire
 		gc.reflogexpireunreachable
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7f632af..fe6464f 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2326,6 +2326,8 @@ sub new
         $cfg->{gitcvs}{dbuser} || "";
     $self->{dbpass} = $cfg->{gitcvs}{$state->{method}}{dbpass} ||
         $cfg->{gitcvs}{dbpass} || "";
+    $self->{dbprefix} = $cfg->{gitcvs}{$state->{method}}{dbprefix} ||
+        $cfg->{gitcvs}{dbprefix} || "";
     my %mapping = ( m => $module,
                     a => $state->{method},
                     u => getlogin || getpwuid($<) || $<,
@@ -2334,6 +2336,8 @@ sub new
                     );
     $self->{dbname} =~ s/%([mauGg])/$mapping{$1}/eg;
     $self->{dbuser} =~ s/%([mauGg])/$mapping{$1}/eg;
+    $self->{dbprefix} =~ s/%([mauGg])/$mapping{$1}/eg;
+    $self->{dbprefix} = mangle_tablename($self->{dbprefix});
 
     die "Invalid char ':' in dbdriver" if $self->{dbdriver} =~ /:/;
     die "Invalid char ';' in dbname" if $self->{dbname} =~ /;/;
@@ -2349,10 +2353,10 @@ sub new
     }
 
     # Construct the revision table if required
-    unless ( $self->{tables}{revision} )
+    unless ( $self->{tables}{"$self->{dbprefix}revision"} )
     {
         $self->{dbh}->do("
-            CREATE TABLE revision (
+            CREATE TABLE $self->{dbprefix}revision (
                 name       TEXT NOT NULL,
                 revision   INTEGER NOT NULL,
                 filehash   TEXT NOT NULL,
@@ -2363,20 +2367,20 @@ sub new
             )
         ");
         $self->{dbh}->do("
-            CREATE INDEX revision_ix1
-            ON revision (name,revision)
+            CREATE INDEX $self->{dbprefix}revision_ix1
+            ON $self->{dbprefix}revision (name,revision)
         ");
         $self->{dbh}->do("
-            CREATE INDEX revision_ix2
-            ON revision (name,commithash)
+            CREATE INDEX $self->{dbprefix}revision_ix2
+            ON $self->{dbprefix}revision (name,commithash)
         ");
     }
 
     # Construct the head table if required
-    unless ( $self->{tables}{head} )
+    unless ( $self->{tables}{"$self->{dbprefix}head"} )
     {
         $self->{dbh}->do("
-            CREATE TABLE head (
+            CREATE TABLE $self->{dbprefix}head (
                 name       TEXT NOT NULL,
                 revision   INTEGER NOT NULL,
                 filehash   TEXT NOT NULL,
@@ -2387,16 +2391,16 @@ sub new
             )
         ");
         $self->{dbh}->do("
-            CREATE INDEX head_ix1
-            ON head (name)
+            CREATE INDEX $self->{dbprefix}head_ix1
+            ON $self->{dbprefix}head (name)
         ");
     }
 
     # Construct the properties table if required
-    unless ( $self->{tables}{properties} )
+    unless ( $self->{tables}{"$self->{dbprefix}properties"} )
     {
         $self->{dbh}->do("
-            CREATE TABLE properties (
+            CREATE TABLE $self->{dbprefix}properties (
                 key        TEXT NOT NULL PRIMARY KEY,
                 value      TEXT
             )
@@ -2404,10 +2408,10 @@ sub new
     }
 
     # Construct the commitmsgs table if required
-    unless ( $self->{tables}{commitmsgs} )
+    unless ( $self->{tables}{"$self->{dbprefix}commitmsgs"} )
     {
         $self->{dbh}->do("
-            CREATE TABLE commitmsgs (
+            CREATE TABLE $self->{dbprefix}commitmsgs (
                 key        TEXT NOT NULL PRIMARY KEY,
                 value      TEXT
             )
@@ -2783,7 +2787,7 @@ sub insert_rev
     my $author = shift;
     my $mode = shift;
 
-    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO $self->{dbprefix}revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
     $insert_rev->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
@@ -2793,7 +2797,7 @@ sub insert_mergelog
     my $key = shift;
     my $value = shift;
 
-    my $insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO commitmsgs (key, value) VALUES (?,?)",{},1);
+    my $insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO $self->{dbprefix}commitmsgs (key, value) VALUES (?,?)",{},1);
     $insert_mergelog->execute($key, $value);
 }
 
@@ -2801,7 +2805,7 @@ sub delete_head
 {
     my $self = shift;
 
-    my $delete_head = $self->{dbh}->prepare_cached("DELETE FROM head",{},1);
+    my $delete_head = $self->{dbh}->prepare_cached("DELETE FROM $self->{dbprefix}head",{},1);
     $delete_head->execute();
 }
 
@@ -2816,7 +2820,7 @@ sub insert_head
     my $author = shift;
     my $mode = shift;
 
-    my $insert_head = $self->{dbh}->prepare_cached("INSERT INTO head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    my $insert_head = $self->{dbh}->prepare_cached("INSERT INTO $self->{dbprefix}head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
     $insert_head->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
@@ -2825,7 +2829,7 @@ sub _headrev
     my $self = shift;
     my $filename = shift;
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM head WHERE name=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM $self->{dbprefix}head WHERE name=?",{},1);
     $db_query->execute($filename);
     my ( $hash, $revision, $mode ) = $db_query->fetchrow_array;
 
@@ -2837,7 +2841,7 @@ sub _get_prop
     my $self = shift;
     my $key = shift;
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT value FROM properties WHERE key=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT value FROM $self->{dbprefix}properties WHERE key=?",{},1);
     $db_query->execute($key);
     my ( $value ) = $db_query->fetchrow_array;
 
@@ -2850,12 +2854,12 @@ sub _set_prop
     my $key = shift;
     my $value = shift;
 
-    my $db_query = $self->{dbh}->prepare_cached("UPDATE properties SET value=? WHERE key=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("UPDATE $self->{dbprefix}properties SET value=? WHERE key=?",{},1);
     $db_query->execute($value, $key);
 
     unless ( $db_query->rows )
     {
-        $db_query = $self->{dbh}->prepare_cached("INSERT INTO properties (key, value) VALUES (?,?)",{},1);
+        $db_query = $self->{dbh}->prepare_cached("INSERT INTO $self->{dbprefix}properties (key, value) VALUES (?,?)",{},1);
         $db_query->execute($key, $value);
     }
 
@@ -2872,7 +2876,7 @@ sub gethead
 
     return $self->{gethead_cache} if ( defined ( $self->{gethead_cache} ) );
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, mode, revision, modified, commithash, author FROM head ORDER BY name ASC",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, mode, revision, modified, commithash, author FROM $self->{dbprefix}head ORDER BY name ASC",{},1);
     $db_query->execute();
 
     my $tree = [];
@@ -2895,7 +2899,7 @@ sub getlog
     my $self = shift;
     my $filename = shift;
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM $self->{dbprefix}revision WHERE name=? ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     my $tree = [];
@@ -2923,15 +2927,15 @@ sub getmeta
     my $db_query;
     if ( defined($revision) and $revision =~ /^\d+$/ )
     {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND revision=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $self->{dbprefix}revision WHERE name=? AND revision=?",{},1);
         $db_query->execute($filename, $revision);
     }
     elsif ( defined($revision) and $revision =~ /^[a-zA-Z0-9]{40}$/ )
     {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND commithash=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $self->{dbprefix}revision WHERE name=? AND commithash=?",{},1);
         $db_query->execute($filename, $revision);
     } else {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM head WHERE name=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $self->{dbprefix}head WHERE name=?",{},1);
         $db_query->execute($filename);
     }
 
@@ -2951,7 +2955,7 @@ sub commitmessage
     die("Need commithash") unless ( defined($commithash) and $commithash =~ /^[a-zA-Z0-9]{40}$/ );
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT value FROM commitmsgs WHERE key=?",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT value FROM $self->{dbprefix}commitmsgs WHERE key=?",{},1);
     $db_query->execute($commithash);
 
     my ( $message ) = $db_query->fetchrow_array;
@@ -2981,7 +2985,7 @@ sub gethistory
     my $filename = shift;
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $self->{dbprefix}revision WHERE name=? ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     return $db_query->fetchall_arrayref;
@@ -3003,7 +3007,7 @@ sub gethistorydense
     my $filename = shift;
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $self->{dbprefix}revision WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     return $db_query->fetchall_arrayref;
@@ -3061,4 +3065,13 @@ sub mangle_dirname {
     return $dirname;
 }
 
+sub mangle_tablename {
+    my $tablename = shift;
+    return unless defined $tablename;
+
+    $tablename =~ s/[^\w_]/_/g;
+
+    return $tablename;
+}
+
 1;
-- 
1.5.4.2
