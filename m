From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 14/20] cvsserver: add misc commit lookup, file meta data, and file listing functions
Date: Sat, 13 Oct 2012 23:42:27 -0600
Message-ID: <1350193353-19210-15-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH4L-0007D4-1b
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2JNFsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:31 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54953 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157Ab2JNFsV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:21 -0400
Received: from omta11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Atk71k0090mlR8UA1toMKn; Sun, 14 Oct 2012 05:48:21 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta11.emeryville.ca.mail.comcast.net with comcast
	id AtjL1k00G2wKXRC8XtjLgz; Sun, 14 Oct 2012 05:43:21 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id E9B371E96025; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207623>

These will be used soon, but not yet.

PERFORMANCE NOTE: getMetaFromCommithash() does not scale well as currently
implemented.  See comment for possible optimization strategies.
Fortunately, it will only be used in cases that would not have worked
at all before this change.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 366 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 365 insertions(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 4eecc0b..16e2e1f 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2986,6 +2986,9 @@ sub new
 
     die "Git repo '$self->{git_path}' doesn't exist" unless ( -d $self->{git_path} );
 
+    # Stores full sha1's for various branch/tag names, abbreviations, etc:
+    $self->{commitRefCache} = {};
+
     $self->{dbdriver} = $cfg->{gitcvs}{$state->{method}}{dbdriver} ||
         $cfg->{gitcvs}{dbdriver} || "SQLite";
     $self->{dbname} = $cfg->{gitcvs}{$state->{method}}{dbname} ||
@@ -3446,7 +3449,7 @@ sub update
         );
     }
     # invalidate the gethead cache
-    $self->{gethead_cache} = undef;
+    $self->clearCommitRefCaches();
 
 
     # Ending exclusive lock here
@@ -3648,6 +3651,169 @@ sub gethead
     return $tree;
 }
 
+=head2 getAnyHead
+
+Returns a reference to an array of getmeta structures, one
+per file in the specified tree hash.
+
+=cut
+
+sub getAnyHead
+{
+    my ($self,$hash) = @_;
+
+    if(!defined($hash))
+    {
+        return $self->gethead();
+    }
+
+    my @files;
+    {
+        open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
+                or die("Cannot call git-ls-tree : $!");
+        local $/ = "\0";
+        @files=<$filePipe>;
+        close $filePipe;
+    }
+
+    my $tree=[];
+    my($line);
+    foreach $line (@files)
+    {
+        $line=~s/\0$//;
+        unless ( $line=~/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
+        {
+            die("Couldn't process git-ls-tree line : $_");
+        }
+
+        my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
+        push @$tree, $self->getMetaFromCommithash($git_filename,$hash);
+    }
+
+    return $tree;
+}
+
+=head2 getRevisionDirMap
+
+A "revision dir map" contains all the plain-file filenames associated
+with a particular revision (treeish), organized by directory:
+
+  $type = $out->{$dir}{$fullName}
+
+The type of each is "F" (for ordinary file) or "D" (for directory,
+for which the map $out->{$fullName} will also exist).
+
+=cut
+
+sub getRevisionDirMap
+{
+    my ($self,$ver)=@_;
+
+    if(!defined($self->{revisionDirMapCache}))
+    {
+        $self->{revisionDirMapCache}={};
+    }
+
+        # Get file list (previously cached results are dependent on HEAD,
+        # but are early in each case):
+    my $cacheKey;
+    my (@fileList);
+    if( !defined($ver) || $ver eq "" )
+    {
+        $cacheKey="";
+        if( defined($self->{revisionDirMapCache}{$cacheKey}) )
+        {
+            return $self->{revisionDirMapCache}{$cacheKey};
+        }
+
+        my @head = @{$self->gethead()};
+        foreach my $file ( @head )
+        {
+            next if ( $file->{filehash} eq "deleted" );
+
+            push @fileList,$file->{name};
+        }
+    }
+    else
+    {
+        my ($hash)=$self->lookupCommitRef($ver);
+        if( !defined($hash) )
+        {
+            return undef;
+        }
+
+        $cacheKey=$hash;
+        if( defined($self->{revisionDirMapCache}{$cacheKey}) )
+        {
+            return $self->{revisionDirMapCache}{$cacheKey};
+        }
+
+        open(my $filePipe, '-|', 'git', 'ls-tree', '-z', '-r', $hash)
+                or die("Cannot call git-ls-tree : $!");
+        local $/ = "\0";
+        while ( <$filePipe> )
+        {
+            chomp;
+            unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
+            {
+                die("Couldn't process git-ls-tree line : $_");
+            }
+
+            my($mode, $git_type, $git_hash, $git_filename) = ($1, $2, $3, $4);
+
+            push @fileList, $git_filename;
+        }
+        close $filePipe;
+    }
+
+        # Convert to normalized form:
+    my %revMap;
+    my $file;
+    foreach $file (@fileList)
+    {
+        my($dir) = ($file=~m%^(?:(.*)/)?([^/]*)$%);
+        $dir='' if(!defined($dir));
+
+            # parent directories:
+            # ... create empty dir maps for parent dirs:
+        my($td)=$dir;
+        while(!defined($revMap{$td}))
+        {
+            $revMap{$td}={};
+
+            my($tp)=($td=~m%^(?:(.*)/)?([^/]*)$%);
+            $tp='' if(!defined($tp));
+            $td=$tp;
+        }
+            # ... add children to parent maps (now that they exist):
+        $td=$dir;
+        while($td ne "")
+        {
+            my($tp)=($td=~m%^(?:(.*)/)?([^/]*)$%);
+            $tp='' if(!defined($tp));
+
+            if(defined($revMap{$tp}{$td}))
+            {
+                if($revMap{$tp}{$td} ne 'D')
+                {
+                    die "Weird file/directory inconsistency in $cacheKey";
+                }
+                last;   # loop exit
+            }
+            $revMap{$tp}{$td}='D';
+
+            $td=$tp;
+        }
+
+            # file
+        $revMap{$dir}{$file}='F';
+    }
+
+        # Save in cache:
+    $self->{revisionDirMapCache}{$cacheKey}=\%revMap;
+    return $self->{revisionDirMapCache}{$cacheKey};
+}
+
 =head2 getlog
 
 See also gethistorydense().
@@ -3742,6 +3908,204 @@ sub getmeta
     return $meta;
 }
 
+sub getMetaFromCommithash
+{
+    my $self = shift;
+    my $filename = shift;
+    my $revCommit = shift;
+
+    # NOTE: This function doesn't scale well (lots of forks), especially
+    #   if you have many files that have not been modified for many commits
+    #   (each git-rev-parse redoes a lot of work for each file
+    #   that theoretically could be done in parallel by smarter
+    #   graph traversal).
+    #
+    # TODO: Possible optimization strategies:
+    #   - Solve the issue of assigning and remembering "real" CVS
+    #     revision numbers for branches, and ensure the
+    #     data structure can do this efficiently.  Perhaps something
+    #     similar to "git notes", and carefully structured to take
+    #     advantage same-sha1-is-same-contents, to roll the same
+    #     unmodified subdirectory data onto multiple commits?
+    #   - Write and use a C tool that is like git-blame, but
+    #     operates on multiple files with file granularity, instead
+    #     of one file with line granularity.  Cache
+    #     most-recently-modified in $self->{commitRefCache}{$revCommit}.
+    #     Try to be intelligent about how many files we do with
+    #     one fork (perhaps one directory at a time, without recursion,
+    #     and/or include directory as one line item, recurse from here
+    #     instead of in C tool?).
+    #   - Perhaps we could ask the DB for (filename,fileHash),
+    #     and just guess that it is correct (that the file hadn't
+    #     changed between $revCommit and the found commit, then
+    #     changed back, confusing anything trying to interpret
+    #     history).  Probably need to add another index to revisions
+    #     DB table for this.
+    #   - NOTE: Trying to store all (commit,file) keys in DB [to
+    #     find "lastModfiedCommit] (instead of
+    #     just files that changed in each commit as we do now) is
+    #     probably not practical from a disk space perspective.
+
+        # Does the file exist in $revCommit?
+    # TODO: Include file hash in dirmap cache.
+    my($dirMap)=$self->getRevisionDirMap($revCommit);
+    my($dir,$file)=($filename=~m%^(?:(.*)/)?([^/]*$)%);
+    if(!defined($dir))
+    {
+        $dir="";
+    }
+    if( !defined($dirMap->{$dir}) ||
+        !defined($dirMap->{$dir}{$filename}) )
+    {
+        my($fileHash)="deleted";
+
+        my($retVal)={};
+        $retVal->{name}=$filename;
+        $retVal->{filehash}=$fileHash;
+
+            # not needed and difficult to compute:
+        $retVal->{revision}="0";  # $revision;
+        $retVal->{commithash}=$revCommit;
+        #$retVal->{author}=$commit->{author};
+        #$retVal->{modified}=convertToCvsDate($commit->{date});
+        #$retVal->{mode}=convertToDbMode($mode);
+
+        return $retVal;
+    }
+
+    my($fileHash)=safe_pipe_capture("git","rev-parse","$revCommit:$filename");
+    chomp $fileHash;
+    if(!($fileHash=~/^[0-9a-f]{40}$/))
+    {
+        die "Invalid fileHash '$fileHash' looking up"
+                    ." '$revCommit:$filename'\n";
+    }
+
+    # information about most recent commit to modify $filename:
+    open(my $gitLogPipe, '-|', 'git', 'rev-list',
+         '--max-count=1', '--pretty', '--parents',
+         $revCommit, '--', $filename)
+                or die "Cannot call git-rev-list: $!";
+    my @commits=readCommits($gitLogPipe);
+    close $gitLogPipe;
+    if(scalar(@commits)!=1)
+    {
+        die "Can't find most recent commit changing $filename\n";
+    }
+    my($commit)=$commits[0];
+    if( !defined($commit) || !defined($commit->{hash}) )
+    {
+        return undef;
+    }
+
+    # does this (commit,file) have a real assigned CVS revision number?
+    my $tablename_rev = $self->tablename("revision");
+    my $db_query;
+    $db_query = $self->{dbh}->prepare_cached(
+        "SELECT * FROM $tablename_rev WHERE name=? AND commithash=?",
+        {},1);
+    $db_query->execute($filename, $commit->{hash});
+    my($meta)=$db_query->fetchrow_hashref;
+    if($meta)
+    {
+        $meta->{revision} = "1.$meta->{revision}";
+        return $meta;
+    }
+
+    # fall back on special revision number
+    my($revision)=$commit->{hash};
+    $revision=~s/(..)/'.' . (hex($1)+100)/eg;
+    $revision="2.1.1.2000$revision";
+
+    # meta data about $filename:
+    open(my $filePipe, '-|', 'git', 'ls-tree', '-z',
+                $commit->{hash}, '--', $filename)
+            or die("Cannot call git-ls-tree : $!");
+    local $/ = "\0";
+    my $line;
+    $line=<$filePipe>;
+    if(defined(<$filePipe>))
+    {
+        die "Expected only a single file for git-ls-tree $filename\n";
+    }
+    close $filePipe;
+
+    chomp $line;
+    unless ( $line=~m/^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
+    {
+        die("Couldn't process git-ls-tree line : $line\n");
+    }
+    my ( $mode, $git_type, $git_hash, $git_filename ) = ( $1, $2, $3, $4 );
+
+    # save result:
+    my($retVal)={};
+    $retVal->{name}=$filename;
+    $retVal->{revision}=$revision;
+    $retVal->{filehash}=$fileHash;
+    $retVal->{commithash}=$revCommit;
+    $retVal->{author}=$commit->{author};
+    $retVal->{modified}=convertToCvsDate($commit->{date});
+    $retVal->{mode}=convertToDbMode($mode);
+
+    return $retVal;
+}
+
+=head2 lookupCommitRef
+
+Convert tag/branch/abbreviation/etc into a commit sha1 hash.  Caches
+the result so looking it up again is fast.
+
+=cut
+
+sub lookupCommitRef
+{
+    my $self = shift;
+    my $ref = shift;
+
+    my $commitHash = $self->{commitRefCache}{$ref};
+    if(defined($commitHash))
+    {
+        return $commitHash;
+    }
+
+    $commitHash=safe_pipe_capture("git","rev-parse","--verify","--quiet",
+                                  $self->unescapeRefName($ref));
+    $commitHash=~s/\s*$//;
+    if(!($commitHash=~/^[0-9a-f]{40}$/))
+    {
+        $commitHash=undef;
+    }
+
+    if( defined($commitHash) )
+    {
+        my $type=safe_pipe_capture("git","cat-file","-t",$commitHash);
+        if( ! ($type=~/^commit\s*$/ ) )
+        {
+            $commitHash=undef;
+        }
+    }
+    if(defined($commitHash))
+    {
+        $self->{commitRefCache}{$ref}=$commitHash;
+    }
+    return $commitHash;
+}
+
+=head2 clearCommitRefCaches
+
+Clears cached commit cache (sha1's for various tags/abbeviations/etc),
+and related caches.
+
+=cut
+
+sub clearCommitRefCaches
+{
+    my $self = shift;
+    $self->{commitRefCache} = {};
+    $self->{revisionDirMapCache} = undef;
+    $self->{gethead_cache} = undef;
+}
+
 =head2 commitmessage
 
 this function takes a commithash and returns the commit message for that commit
-- 
1.7.10.2.484.gcd07cc5
