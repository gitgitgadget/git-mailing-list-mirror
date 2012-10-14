From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 17/20] cvsserver: Add version awareness to argsfromdir
Date: Sat, 13 Oct 2012 23:42:30 -0600
Message-ID: <1350193353-19210-18-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHDP-0006s7-KB
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab2JNF6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:58:06 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:49744
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751913Ab2JNF6D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:58:03 -0400
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id AtwN1k0021eYJf8ACty3D1; Sun, 14 Oct 2012 05:58:03 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta19.emeryville.ca.mail.comcast.net with comcast
	id Att21k0062wKXRC01tt2bC; Sun, 14 Oct 2012 05:53:03 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 384AF1E9601C; Sat, 13 Oct 2012 23:43:20 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207627>

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 228 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 198 insertions(+), 30 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7bb6f83..5e558d1 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2226,55 +2226,222 @@ sub argsplit
     }
 }
 
-# This method uses $state->{directory} to populate $state->{args} with a list of filenames
-sub argsfromdir
+# Used by argsfromdir
+sub expandArg
 {
-    my $updater = shift;
+    my ($updater,$outNameMap,$outDirMap,$path,$isDir) = @_;
 
-    $state->{args} = [] if ( scalar(@{$state->{args}}) == 1 and $state->{args}[0] eq "." );
+    my $fullPath = filecleanup($path);
 
-    return if ( scalar ( @{$state->{args}} ) > 1 );
+      # Is it a directory?
+    if( defined($state->{dirMap}{$fullPath}) ||
+        defined($state->{dirMap}{"$fullPath/"}) )
+    {
+          # It is a directory in the user's sandbox.
+        $isDir=1;
 
-    my @gethead = @{$updater->gethead};
+        if(defined($state->{entries}{$fullPath}))
+        {
+            $log->fatal("Inconsistent file/dir type");
+            die "Inconsistent file/dir type";
+        }
+    }
+    elsif(defined($state->{entries}{$fullPath}))
+    {
+          # It is a file in the user's sandbox.
+        $isDir=0;
+    }
+    my($revDirMap,$otherRevDirMap);
+    if(!defined($isDir) || $isDir)
+    {
+          # Resolve version tree for sticky tag:
+          # (for now we only want list of files for the version, not
+          # particular versions of those files: assume it is a directory
+          # for the moment; ignore Entry's stick tag)
+
+          # Order of precedence of sticky tags:
+          #    -A       [head]
+          #    -r /tag/
+          #    [file entry sticky tag, but that is only relevant to files]
+          #    [the tag specified in dir req_Sticky]
+          #    [the tag specified in a parent dir req_Sticky]
+          #    [head]
+          # Also, -r may appear twice (for diff).
+          #
+          # FUTURE: When/if -j (merges) are supported, we also
+          #  need to add relevant files from one or two
+          #  versions specified with -j.
+
+        if(exists($state->{opt}{A}))
+        {
+            $revDirMap=$updater->getRevisionDirMap();
+        }
+        elsif( defined($state->{opt}{r}) and
+               ref $state->{opt}{r} eq "ARRAY" )
+        {
+            $revDirMap=$updater->getRevisionDirMap($state->{opt}{r}[0]);
+            $otherRevDirMap=$updater->getRevisionDirMap($state->{opt}{r}[1]);
+        }
+        elsif(defined($state->{opt}{r}))
+        {
+            $revDirMap=$updater->getRevisionDirMap($state->{opt}{r});
+        }
+        else
+        {
+            my($sticky)=getDirStickyInfo($fullPath);
+            $revDirMap=$updater->getRevisionDirMap($sticky->{tag});
+        }
 
-    # push added files
-    foreach my $file (keys %{$state->{entries}}) {
-	if ( exists $state->{entries}{$file}{revision} &&
-		$state->{entries}{$file}{revision} eq '0' )
-	{
-	    push @gethead, { name => $file, filehash => 'added' };
-	}
+          # Is it a directory?
+        if( defined($revDirMap->{$fullPath}) ||
+            defined($otherRevDirMap->{$fullPath}) )
+        {
+            $isDir=1;
+        }
     }
 
-    if ( scalar(@{$state->{args}}) == 1 )
+      # What to do with it?
+    if(!$isDir)
     {
-        my $arg = $state->{args}[0];
-        $arg .= $state->{prependdir} if ( defined ( $state->{prependdir} ) );
-
-        $log->info("Only one arg specified, checking for directory expansion on '$arg'");
+        $outNameMap->{$fullPath}=1;
+    }
+    else
+    {
+        $outDirMap->{$fullPath}=1;
 
-        foreach my $file ( @gethead )
+        if(defined($revDirMap->{$fullPath}))
         {
-            next if ( $file->{filehash} eq "deleted" and not defined ( $state->{entries}{$file->{name}} ) );
-            next unless ( $file->{name} =~ /^$arg\// or $file->{name} eq $arg  );
-            push @{$state->{args}}, $file->{name};
+            addDirMapFiles($updater,$outNameMap,$outDirMap,
+                           $revDirMap->{$fullPath});
         }
+        if( defined($otherRevDirMap) &&
+            defined($otherRevDirMap->{$fullPath}) )
+        {
+            addDirMapFiles($updater,$outNameMap,$outDirMap,
+                           $otherRevDirMap->{$fullPath});
+        }
+    }
+}
 
-        shift @{$state->{args}} if ( scalar(@{$state->{args}}) > 1 );
-    } else {
-        $log->info("Only one arg specified, populating file list automatically");
+# Used by argsfromdir
+# Add entries from dirMap to outNameMap.  Also recurse into entries
+# that are subdirectories.
+sub addDirMapFiles
+{
+    my($updater,$outNameMap,$outDirMap,$dirMap)=@_;
 
-        $state->{args} = [];
+    my($fullName);
+    foreach $fullName (keys(%$dirMap))
+    {
+        my $cleanName=$fullName;
+        if(defined($state->{prependdir}))
+        {
+            if(!($cleanName=~s/^\Q$state->{prependdir}\E//))
+            {
+                $log->fatal("internal error stripping prependdir");
+                die "internal error stripping prependdir";
+            }
+        }
 
-        foreach my $file ( @gethead )
+        if($dirMap->{$fullName} eq "F")
+        {
+            $outNameMap->{$cleanName}=1;
+        }
+        elsif($dirMap->{$fullName} eq "D")
+        {
+            if(!$state->{opt}{l})
+            {
+                expandArg($updater,$outNameMap,$outDirMap,$cleanName,1);
+            }
+        }
+        else
         {
-            next if ( $file->{filehash} eq "deleted" and not defined ( $state->{entries}{$file->{name}} ) );
-            next unless ( $file->{name} =~ s/^$state->{prependdir}// );
-            push @{$state->{args}}, $file->{name};
+            $log->fatal("internal error in addDirMapFiles");
+            die "internal error in addDirMapFiles";
         }
     }
 }
 
+# This method replaces $state->{args} with a directory-expanded
+# list of all relevant filenames (recursively unless -d), based
+# on $state->{entries}, and the "current" list of files in
+# each directory.  "Current" files as determined by
+# either the requested (-r/-A) or "req_Sticky" version of
+# that directory.
+#    Both the input args and the new output args are relative
+# to the cvs-client's CWD, although some of the internal
+# computations are relative to the top of the project.
+sub argsfromdir
+{
+    my $updater = shift;
+
+    # Notes about requirements for specific callers:
+    #   update # "standard" case (entries; a single -r/-A/default; -l)
+    #          # Special case: -d for create missing directories.
+    #   diff # 0 or 1 -r's: "standard" case.
+    #        # 2 -r's: We could ignore entries (just use the two -r's),
+    #        # but it doesn't really matter.
+    #   annotate # "standard" case
+    #   log # Punting: log -r has a more complex non-"standard"
+    #       # meaning, and we don't currently try to support log'ing
+    #       # branches at all (need a lot of work to
+    #       # support CVS-consistent branch relative version
+    #       # numbering).
+#HERE: But we still want to expand directories.  Maybe we should
+#  essentially force "-A".
+    #   status # "standard", except that -r/-A/default are not possible.
+    #          # Mostly only used to expand entries only)
+    #
+    # Don't use argsfromdir at all:
+    #   add # Explicit arguments required.  Directory args imply add
+    #       # the directory itself, not the files in it.
+    #   co  # Obtain list directly.
+    #   remove # HERE: TEST: MAYBE client does the recursion for us,
+    #          # since it only makes sense to remove stuff already in
+    #          # the sandobx?
+    #   ci # HERE: Similar to remove...
+    #      # Don't try to implement the confusing/weird
+    #      # ci -r bug er.."feature".
+
+    if(scalar(@{$state->{args}})==0)
+    {
+        $state->{args} = [ "." ];
+    }
+    my %allArgs;
+    my %allDirs;
+    for my $file (@{$state->{args}})
+    {
+        expandArg($updater,\%allArgs,\%allDirs,$file);
+    }
+
+    # Include any entries from sandbox.  Generally client won't
+    # send entries that shouldn't be used.
+    foreach my $file (keys %{$state->{entries}})
+    {
+        $allArgs{remove_prependdir($file)} = 1;
+    }
+
+    $state->{dirArgs} = \%allDirs;
+    $state->{args} = [
+        sort {
+                # Sort priority: by directory depth, then actual file name:
+            my @piecesA=split('/',$a);
+            my @piecesB=split('/',$b);
+
+            my $count=scalar(@piecesA);
+            my $tmp=scalar(@piecesB);
+            return $count<=>$tmp if($count!=$tmp);
+
+            for($tmp=0;$tmp<$count;$tmp++)
+            {
+                if($piecesA[$tmp] ne $piecesB[$tmp])
+                {
+                    return $piecesA[$tmp] cmp $piecesB[$tmp]
+                }
+            }
+            return 0;
+        } keys(%allArgs) ];
+}
 
 ## look up directory sticky tag, of either fullPath or a parent:
 sub getDirStickyInfo
@@ -2383,6 +2550,7 @@ sub getStickyTagOrDate
 sub statecleanup
 {
     $state->{files} = [];
+    $state->{dirArgs} = {};
     $state->{args} = [];
     $state->{arguments} = [];
     $state->{entries} = {};
-- 
1.7.10.2.484.gcd07cc5
