From: Josh Elsasser <josh@elsasser.org>
Subject: [PATCH v3] Allow git-cvsserver database table name prefix to be specified.
Date: Thu, 27 Mar 2008 14:02:14 -0700
Message-ID: <12066517343988-git-send-email-josh@elsasser.org>
References: <20080327205727.GN2324@opal.elsasser.org>
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Elsasser <josh@elsasser.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 22:03:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JezFq-0002lo-65
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 22:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760616AbYC0VCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760039AbYC0VCR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 17:02:17 -0400
Received: from opal.elsasser.org ([198.145.64.114]:37381 "EHLO
	opal.elsasser.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760016AbYC0VCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 17:02:16 -0400
Received: by opal.elsasser.org (Postfix, from userid 1000)
	id 478873E247; Thu, 27 Mar 2008 14:02:15 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <20080327205727.GN2324@opal.elsasser.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78366>

Adds a gitcvs.dbtablenameprefix config variable, the contents of which
are prepended to any database tables names used by git-cvsserver. The
same substutions as gitcvs.dbname and gitcvs.dbuser are supported, and
any non-alphabetic characters are replaced with underscores.

A typo found in contrib/completion/git-completion.bash is also fixed.
---

This version of the patch is a bit cleaner, it calls a function to get
the table names instead of pasting a variable reference everywhere.
The config var name has also been changed from gitcvs.dbprefix to
gitcvs.dbTableNamePrefix

 Documentation/config.txt               |    7 ++
 Documentation/git-cvsserver.txt        |    5 ++
 contrib/completion/git-completion.bash |    3 +-
 git-cvsserver.perl                     |  123 ++++++++++++++++++++++++--------
 4 files changed, 107 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3017d64..04c01c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -661,6 +661,13 @@ gitcvs.dbuser, gitcvs.dbpass::
 	'gitcvs.dbuser' supports variable substitution (see
 	linkgit:git-cvsserver[1] for details).
 
+gitcvs.dbTableNamePrefix::
+	Database table name prefix.  Prepended to the names of any
+	database tables used, allowing a single database to be used
+	for several repositories.  Supports variable substitution (see
+	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
+	characters will be replaced with underscores.
+
 All gitcvs variables except for 'gitcvs.allbinary' can also be
 specified as 'gitcvs.<access_method>.<varname>' (where 'access_method'
 is one of "ext" and "pserver") to make them apply only for the given
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index d3e9993..9cec802 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -227,6 +227,11 @@ gitcvs.dbpass::
 	Database password.  Only useful if setting `dbdriver`, since
 	SQLite has no concept of database passwords.
 
+gitcvs.dbTableNamePrefix::
+	Database table name prefix.  Supports variable substitution
+	(see below).  Any non-alphabetic characters will be replaced
+	with underscores.
+
 All variables can also be set per access method, see <<configaccessmethod,above>>.
 
 Variable substitution
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5046f69..791e30f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -999,7 +999,8 @@ _git_config ()
 		gitcvs.enabled
 		gitcvs.logfile
 		gitcvs.allbinary
-		gitcvs.dbname gitcvs.dbdriver gitcvs.dbuser gitcvs.dvpass
+		gitcvs.dbname gitcvs.dbdriver gitcvs.dbuser gitcvs.dbpass
+		gitcvs.dbtablenameprefix
 		gc.packrefs
 		gc.reflogexpire
 		gc.reflogexpireunreachable
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7f632af..7a57177 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2311,6 +2311,14 @@ sub new
 
     bless $self, $class;
 
+    $self->{valid_tables} = {'revision' => 1,
+                             'revision_ix1' => 1,
+                             'revision_ix2' => 1,
+                             'head' => 1,
+                             'head_ix1' => 1,
+                             'properties' => 1,
+                             'commitmsgs' => 1};
+
     $self->{module} = $module;
     $self->{git_path} = $config . "/";
 
@@ -2326,6 +2334,8 @@ sub new
         $cfg->{gitcvs}{dbuser} || "";
     $self->{dbpass} = $cfg->{gitcvs}{$state->{method}}{dbpass} ||
         $cfg->{gitcvs}{dbpass} || "";
+    $self->{dbtablenameprefix} = $cfg->{gitcvs}{$state->{method}}{dbtablenameprefix} ||
+        $cfg->{gitcvs}{dbtablenameprefix} || "";
     my %mapping = ( m => $module,
                     a => $state->{method},
                     u => getlogin || getpwuid($<) || $<,
@@ -2334,6 +2344,8 @@ sub new
                     );
     $self->{dbname} =~ s/%([mauGg])/$mapping{$1}/eg;
     $self->{dbuser} =~ s/%([mauGg])/$mapping{$1}/eg;
+    $self->{dbtablenameprefix} =~ s/%([mauGg])/$mapping{$1}/eg;
+    $self->{dbtablenameprefix} = mangle_tablename($self->{dbtablenameprefix});
 
     die "Invalid char ':' in dbdriver" if $self->{dbdriver} =~ /:/;
     die "Invalid char ';' in dbname" if $self->{dbname} =~ /;/;
@@ -2349,10 +2361,13 @@ sub new
     }
 
     # Construct the revision table if required
-    unless ( $self->{tables}{revision} )
+    unless ( $self->{tables}{$self->tablename("revision")} )
     {
+        my $tablename = $self->tablename("revision");
+        my $ix1name = $self->tablename("revision_ix1");
+        my $ix2name = $self->tablename("revision_ix2");
         $self->{dbh}->do("
-            CREATE TABLE revision (
+            CREATE TABLE $tablename (
                 name       TEXT NOT NULL,
                 revision   INTEGER NOT NULL,
                 filehash   TEXT NOT NULL,
@@ -2363,20 +2378,22 @@ sub new
             )
         ");
         $self->{dbh}->do("
-            CREATE INDEX revision_ix1
-            ON revision (name,revision)
+            CREATE INDEX $ix1name
+            ON $tablename (name,revision)
         ");
         $self->{dbh}->do("
-            CREATE INDEX revision_ix2
-            ON revision (name,commithash)
+            CREATE INDEX $ix2name
+            ON $tablename (name,commithash)
         ");
     }
 
     # Construct the head table if required
-    unless ( $self->{tables}{head} )
+    unless ( $self->{tables}{$self->tablename("head")} )
     {
+        my $tablename = $self->tablename("head");
+        my $ix1name = $self->tablename("head_ix1");
         $self->{dbh}->do("
-            CREATE TABLE head (
+            CREATE TABLE $tablename (
                 name       TEXT NOT NULL,
                 revision   INTEGER NOT NULL,
                 filehash   TEXT NOT NULL,
@@ -2387,16 +2404,17 @@ sub new
             )
         ");
         $self->{dbh}->do("
-            CREATE INDEX head_ix1
-            ON head (name)
+            CREATE INDEX $ix1name
+            ON $tablename (name)
         ");
     }
 
     # Construct the properties table if required
-    unless ( $self->{tables}{properties} )
+    unless ( $self->{tables}{$self->tablename("properties")} )
     {
+        my $tablename = $self->tablename("properties");
         $self->{dbh}->do("
-            CREATE TABLE properties (
+            CREATE TABLE $tablename (
                 key        TEXT NOT NULL PRIMARY KEY,
                 value      TEXT
             )
@@ -2404,10 +2422,11 @@ sub new
     }
 
     # Construct the commitmsgs table if required
-    unless ( $self->{tables}{commitmsgs} )
+    unless ( $self->{tables}{$self->tablename("commitmsgs")} )
     {
+        my $tablename = $self->tablename("commitmsgs");
         $self->{dbh}->do("
-            CREATE TABLE commitmsgs (
+            CREATE TABLE $tablename (
                 key        TEXT NOT NULL PRIMARY KEY,
                 value      TEXT
             )
@@ -2417,6 +2436,21 @@ sub new
     return $self;
 }
 
+=head2 tablename
+
+=cut
+sub tablename
+{
+    my $self = shift;
+    my $name = shift;
+
+    if (exists $self->{valid_tables}{$name}) {
+        return $self->{dbtablenameprefix} . $name;
+    } else {
+        return undef;
+    }
+}
+
 =head2 update
 
 =cut
@@ -2782,8 +2816,9 @@ sub insert_rev
     my $modified = shift;
     my $author = shift;
     my $mode = shift;
+    my $tablename = $self->tablename("revision");
 
-    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO $tablename (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
     $insert_rev->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
@@ -2792,16 +2827,18 @@ sub insert_mergelog
     my $self = shift;
     my $key = shift;
     my $value = shift;
+    my $tablename = $self->tablename("commitmsgs");
 
-    my $insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO commitmsgs (key, value) VALUES (?,?)",{},1);
+    my $insert_mergelog = $self->{dbh}->prepare_cached("INSERT INTO $tablename (key, value) VALUES (?,?)",{},1);
     $insert_mergelog->execute($key, $value);
 }
 
 sub delete_head
 {
     my $self = shift;
+    my $tablename = $self->tablename("head");
 
-    my $delete_head = $self->{dbh}->prepare_cached("DELETE FROM head",{},1);
+    my $delete_head = $self->{dbh}->prepare_cached("DELETE FROM $tablename",{},1);
     $delete_head->execute();
 }
 
@@ -2815,8 +2852,9 @@ sub insert_head
     my $modified = shift;
     my $author = shift;
     my $mode = shift;
+    my $tablename = $self->tablename("head");
 
-    my $insert_head = $self->{dbh}->prepare_cached("INSERT INTO head (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
+    my $insert_head = $self->{dbh}->prepare_cached("INSERT INTO $tablename (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
     $insert_head->execute($name, $revision, $filehash, $commithash, $modified, $author, $mode);
 }
 
@@ -2824,8 +2862,9 @@ sub _headrev
 {
     my $self = shift;
     my $filename = shift;
+    my $tablename = $self->tablename("head");
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM head WHERE name=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT filehash, revision, mode FROM $tablename WHERE name=?",{},1);
     $db_query->execute($filename);
     my ( $hash, $revision, $mode ) = $db_query->fetchrow_array;
 
@@ -2836,8 +2875,9 @@ sub _get_prop
 {
     my $self = shift;
     my $key = shift;
+    my $tablename = $self->tablename("properties");
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT value FROM properties WHERE key=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT value FROM $tablename WHERE key=?",{},1);
     $db_query->execute($key);
     my ( $value ) = $db_query->fetchrow_array;
 
@@ -2849,13 +2889,14 @@ sub _set_prop
     my $self = shift;
     my $key = shift;
     my $value = shift;
+    my $tablename = $self->tablename("properties");
 
-    my $db_query = $self->{dbh}->prepare_cached("UPDATE properties SET value=? WHERE key=?",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("UPDATE $tablename SET value=? WHERE key=?",{},1);
     $db_query->execute($value, $key);
 
     unless ( $db_query->rows )
     {
-        $db_query = $self->{dbh}->prepare_cached("INSERT INTO properties (key, value) VALUES (?,?)",{},1);
+        $db_query = $self->{dbh}->prepare_cached("INSERT INTO $tablename (key, value) VALUES (?,?)",{},1);
         $db_query->execute($key, $value);
     }
 
@@ -2869,10 +2910,11 @@ sub _set_prop
 sub gethead
 {
     my $self = shift;
+    my $tablename = $self->tablename("head");
 
     return $self->{gethead_cache} if ( defined ( $self->{gethead_cache} ) );
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, mode, revision, modified, commithash, author FROM head ORDER BY name ASC",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, mode, revision, modified, commithash, author FROM $tablename ORDER BY name ASC",{},1);
     $db_query->execute();
 
     my $tree = [];
@@ -2894,8 +2936,9 @@ sub getlog
 {
     my $self = shift;
     my $filename = shift;
+    my $tablename = $self->tablename("revision");
 
-    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    my $db_query = $self->{dbh}->prepare_cached("SELECT name, filehash, author, mode, revision, modified, commithash FROM $tablename WHERE name=? ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     my $tree = [];
@@ -2919,19 +2962,21 @@ sub getmeta
     my $self = shift;
     my $filename = shift;
     my $revision = shift;
+    my $tablename_rev = $self->tablename("revision");
+    my $tablename_head = $self->tablename("head");
 
     my $db_query;
     if ( defined($revision) and $revision =~ /^\d+$/ )
     {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND revision=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_rev WHERE name=? AND revision=?",{},1);
         $db_query->execute($filename, $revision);
     }
     elsif ( defined($revision) and $revision =~ /^[a-zA-Z0-9]{40}$/ )
     {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM revision WHERE name=? AND commithash=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_rev WHERE name=? AND commithash=?",{},1);
         $db_query->execute($filename, $revision);
     } else {
-        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM head WHERE name=?",{},1);
+        $db_query = $self->{dbh}->prepare_cached("SELECT * FROM $tablename_head WHERE name=?",{},1);
         $db_query->execute($filename);
     }
 
@@ -2947,11 +2992,12 @@ sub commitmessage
 {
     my $self = shift;
     my $commithash = shift;
+    my $tablename = $self->tablename("commitmsgs");
 
     die("Need commithash") unless ( defined($commithash) and $commithash =~ /^[a-zA-Z0-9]{40}$/ );
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT value FROM commitmsgs WHERE key=?",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT value FROM $tablename WHERE key=?",{},1);
     $db_query->execute($commithash);
 
     my ( $message ) = $db_query->fetchrow_array;
@@ -2979,9 +3025,10 @@ sub gethistory
 {
     my $self = shift;
     my $filename = shift;
+    my $tablename = $self->tablename("revision");
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? ORDER BY revision DESC",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $tablename WHERE name=? ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     return $db_query->fetchall_arrayref;
@@ -3001,9 +3048,10 @@ sub gethistorydense
 {
     my $self = shift;
     my $filename = shift;
+    my $tablename = $self->tablename("revision");
 
     my $db_query;
-    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM revision WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
+    $db_query = $self->{dbh}->prepare_cached("SELECT revision, filehash, commithash FROM $tablename WHERE name=? AND filehash!='deleted' ORDER BY revision DESC",{},1);
     $db_query->execute($filename);
 
     return $db_query->fetchall_arrayref;
@@ -3061,4 +3109,19 @@ sub mangle_dirname {
     return $dirname;
 }
 
+=head2 mangle_tablename
+
+create a string from a that is suitable to use as part of an SQL table
+name, mainly by converting all chars except \w to _
+
+=cut
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
