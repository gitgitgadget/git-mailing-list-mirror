From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 11/20] cvsserver: factor out git-log parsing logic
Date: Sat, 13 Oct 2012 23:42:24 -0600
Message-ID: <1350193353-19210-12-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDd-00073P-3c
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab2JNF6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:19 -0400
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:54394
	"EHLO qmta15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752004Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta15.emeryville.ca.mail.comcast.net with comcast
	id Atwe1k0011Y3wxoAFty39G; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id Att21k00F2wKXRC8btt3t9; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id ABC5E1E96022; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207630>

Some field conversion was already duplicated, and more calls will
be added soon.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 176 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 105 insertions(+), 71 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index c5ebfa0..dca0ed6 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -3157,45 +3157,10 @@ sub update
         push @git_log_params, $self->{module};
     }
     # git-rev-list is the backend / plumbing version of git-log
-    open(GITLOG, '-|', 'git', 'rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
-
-    my @commits;
-
-    my %commit = ();
-
-    while ( <GITLOG> )
-    {
-        chomp;
-        if (m/^commit\s+(.*)$/) {
-            # on ^commit lines put the just seen commit in the stack
-            # and prime things for the next one
-            if (keys %commit) {
-                my %copy = %commit;
-                unshift @commits, \%copy;
-                %commit = ();
-            }
-            my @parents = split(m/\s+/, $1);
-            $commit{hash} = shift @parents;
-            $commit{parents} = \@parents;
-        } elsif (m/^(\w+?):\s+(.*)$/ && !exists($commit{message})) {
-            # on rfc822-like lines seen before we see any message,
-            # lowercase the entry and put it in the hash as key-value
-            $commit{lc($1)} = $2;
-        } else {
-            # message lines - skip initial empty line
-            # and trim whitespace
-            if (!exists($commit{message}) && m/^\s*$/) {
-                # define it to mark the end of headers
-                $commit{message} = '';
-                next;
-            }
-            s/^\s+//; s/\s+$//; # trim ws
-            $commit{message} .= $_ . "\n";
-        }
-    }
-    close GITLOG;
-
-    unshift @commits, \%commit if ( keys %commit );
+    open(my $gitLogPipe, '-|', 'git', 'rev-list', @git_log_params)
+                or die "Cannot call git-rev-list: $!";
+    my @commits=readCommits($gitLogPipe);
+    close $gitLogPipe;
 
     # Now all the commits are in the @commits bucket
     # ordered by time DESC. for each commit that needs processing,
@@ -3294,7 +3259,7 @@ sub update
         }
 
         # convert the date to CVS-happy format
-        $commit->{date} = "$2 $1 $4 $3 $5" if ( $commit->{date} =~ /^\w+\s+(\w+)\s+(\d+)\s+(\d+:\d+:\d+)\s+(\d+)\s+([+-]\d+)$/ );
+        my $cvsDate = convertToCvsDate($commit->{date});
 
         if ( defined ( $lastpicked ) )
         {
@@ -3303,7 +3268,7 @@ sub update
             while ( <FILELIST> )
             {
 		chomp;
-                unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+([a-zA-Z0-9]{40})\s+(\w)$/o )
+                unless ( /^:\d{6}\s+([0-7]{6})\s+[a-f0-9]{40}\s+([a-f0-9]{40})\s+(\w)$/o )
                 {
                     die("Couldn't process git-diff-tree line : $_");
                 }
@@ -3313,11 +3278,7 @@ sub update
 
                 # $log->debug("File mode=$mode, hash=$hash, change=$change, name=$name");
 
-                my $git_perms = "";
-                $git_perms .= "r" if ( $mode & 4 );
-                $git_perms .= "w" if ( $mode & 2 );
-                $git_perms .= "x" if ( $mode & 1 );
-                $git_perms = "rw" if ( $git_perms eq "" );
+                my $dbMode = convertToDbMode($mode);
 
                 if ( $change eq "D" )
                 {
@@ -3327,11 +3288,11 @@ sub update
                         revision => $head->{$name}{revision} + 1,
                         filehash => "deleted",
                         commithash => $commit->{hash},
-                        modified => $commit->{date},
+                        modified => $cvsDate,
                         author => $commit->{author},
-                        mode => $git_perms,
+                        mode => $dbMode,
                     };
-                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $cvsDate, $commit->{author}, $dbMode);
                 }
                 elsif ( $change eq "M" || $change eq "T" )
                 {
@@ -3341,11 +3302,11 @@ sub update
                         revision => $head->{$name}{revision} + 1,
                         filehash => $hash,
                         commithash => $commit->{hash},
-                        modified => $commit->{date},
+                        modified => $cvsDate,
                         author => $commit->{author},
-                        mode => $git_perms,
+                        mode => $dbMode,
                     };
-                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $cvsDate, $commit->{author}, $dbMode);
                 }
                 elsif ( $change eq "A" )
                 {
@@ -3355,11 +3316,11 @@ sub update
                         revision => $head->{$name}{revision} ? $head->{$name}{revision}+1 : 1,
                         filehash => $hash,
                         commithash => $commit->{hash},
-                        modified => $commit->{date},
+                        modified => $cvsDate,
                         author => $commit->{author},
-                        mode => $git_perms,
+                        mode => $dbMode,
                     };
-                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $cvsDate, $commit->{author}, $dbMode);
                 }
                 else
                 {
@@ -3382,7 +3343,7 @@ sub update
                     die("Couldn't process git-ls-tree line : $_");
                 }
 
-                my ( $git_perms, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );
+                my ( $mode, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );
 
                 $seen_files->{$git_filename} = 1;
 
@@ -3392,18 +3353,10 @@ sub update
                     $head->{$git_filename}{mode}
                 );
 
-                if ( $git_perms =~ /^\d\d\d(\d)\d\d/o )
-                {
-                    $git_perms = "";
-                    $git_perms .= "r" if ( $1 & 4 );
-                    $git_perms .= "w" if ( $1 & 2 );
-                    $git_perms .= "x" if ( $1 & 1 );
-                } else {
-                    $git_perms = "rw";
-                }
+                my $dbMode = convertToDbMode($mode);
 
                 # unless the file exists with the same hash, we need to update it ...
-                unless ( defined($oldhash) and $oldhash eq $git_hash and defined($oldmode) and $oldmode eq $git_perms )
+                unless ( defined($oldhash) and $oldhash eq $git_hash and defined($oldmode) and $oldmode eq $dbMode )
                 {
                     my $newrevision = ( $oldrevision or 0 ) + 1;
 
@@ -3412,13 +3365,13 @@ sub update
                         revision => $newrevision,
                         filehash => $git_hash,
                         commithash => $commit->{hash},
-                        modified => $commit->{date},
+                        modified => $cvsDate,
                         author => $commit->{author},
-                        mode => $git_perms,
+                        mode => $dbMode,
                     };
 
 
-                    $self->insert_rev($git_filename, $newrevision, $git_hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($git_filename, $newrevision, $git_hash, $commit->{hash}, $cvsDate, $commit->{author}, $dbMode);
                 }
             }
             close FILELIST;
@@ -3431,10 +3384,10 @@ sub update
                     $head->{$file}{revision}++;
                     $head->{$file}{filehash} = "deleted";
                     $head->{$file}{commithash} = $commit->{hash};
-                    $head->{$file}{modified} = $commit->{date};
+                    $head->{$file}{modified} = $cvsDate;
                     $head->{$file}{author} = $commit->{author};
 
-                    $self->insert_rev($file, $head->{$file}{revision}, $head->{$file}{filehash}, $commit->{hash}, $commit->{date}, $commit->{author}, $head->{$file}{mode});
+                    $self->insert_rev($file, $head->{$file}{revision}, $head->{$file}{filehash}, $commit->{hash}, $cvsDate, $commit->{author}, $head->{$file}{mode});
                 }
             }
             # END : "Detect deleted files"
@@ -3472,6 +3425,87 @@ sub update
     $self->{dbh}->commit() or die "Failed to commit changes to SQLite";
 }
 
+sub readCommits
+{
+    my $pipeHandle = shift;
+    my @commits;
+
+    my %commit = ();
+
+    while ( <$pipeHandle> )
+    {
+        chomp;
+        if (m/^commit\s+(.*)$/) {
+            # on ^commit lines put the just seen commit in the stack
+            # and prime things for the next one
+            if (keys %commit) {
+                my %copy = %commit;
+                unshift @commits, \%copy;
+                %commit = ();
+            }
+            my @parents = split(m/\s+/, $1);
+            $commit{hash} = shift @parents;
+            $commit{parents} = \@parents;
+        } elsif (m/^(\w+?):\s+(.*)$/ && !exists($commit{message})) {
+            # on rfc822-like lines seen before we see any message,
+            # lowercase the entry and put it in the hash as key-value
+            $commit{lc($1)} = $2;
+        } else {
+            # message lines - skip initial empty line
+            # and trim whitespace
+            if (!exists($commit{message}) && m/^\s*$/) {
+                # define it to mark the end of headers
+                $commit{message} = '';
+                next;
+            }
+            s/^\s+//; s/\s+$//; # trim ws
+            $commit{message} .= $_ . "\n";
+        }
+    }
+
+    unshift @commits, \%commit if ( keys %commit );
+
+    return @commits;
+}
+
+sub convertToCvsDate
+{
+    my $date = shift;
+    # Convert from: "git rev-list --pretty" formatted date
+    # Convert to: "the format specified by RFC822 as modified by RFC1123."
+    # Example: 26 May 1997 13:01:40 -0400
+    if( $date =~ /^\w+\s+(\w+)\s+(\d+)\s+(\d+:\d+:\d+)\s+(\d+)\s+([+-]\d+)$/ )
+    {
+        $date = "$2 $1 $4 $3 $5";
+    }
+
+    return $date;
+}
+
+sub convertToDbMode
+{
+    my $mode = shift;
+
+    # NOTE: The CVS protocol uses a string similar "u=rw,g=rw,o=rw",
+    #  but the database "mode" column historically (and currently)
+    #  only stores the "rw" (for user) part of the string.
+    #    FUTURE: It might make more sense to persist the raw
+    #  octal mode (or perhaps the final full CVS form) instead of
+    #  this half-converted form, but it isn't currently worth the
+    #  backwards compatibility headaches.
+
+    $mode=~/^\d\d(\d)\d{3}$/;
+    my $userBits=$1;
+
+    my $dbMode = "";
+    $dbMode .= "r" if ( $userBits & 4 );
+    $dbMode .= "w" if ( $userBits & 2 );
+    $dbMode .= "x" if ( $userBits & 1 );
+    $dbMode = "rw" if ( $dbMode eq "" );
+
+    return $dbMode;
+}
+
 sub insert_rev
 {
     my $self = shift;
-- 
1.7.10.2.484.gcd07cc5
