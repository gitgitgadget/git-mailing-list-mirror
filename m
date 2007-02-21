From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref to update a ref during commit in git-cvsserver
Date: Tue, 20 Feb 2007 21:54:39 -0800
Message-ID: <7vmz38t5r4.fsf@assigned-by-dhcp.cox.net>
References: <200702200857.02779.andyparkins@gmail.com>
	<200702202010.02128.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 21 06:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJkRL-000497-TN
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 06:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbXBUFym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 00:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXBUFyl
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 00:54:41 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51044 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbXBUFyl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 00:54:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221055441.KTEV1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 00:54:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S5uf1W00C1kojtg0000000; Wed, 21 Feb 2007 00:54:40 -0500
In-Reply-To: <200702202010.02128.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 20:10:01 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40281>

Andy Parkins <andyparkins@gmail.com> writes:

> As promised...
>
>  git-cvsserver.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index b4ef6bc..54d943a 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1216,9 +1216,9 @@ sub req_ci
>      }
>  
>      close LOCKFILE;
> -    my $reffile = "$ENV{GIT_DIR}refs/heads/$state->{module}";
> -    unlink($reffile);
> -    rename($lockfile, $reffile);
> +    my $reffile = "refs/heads/$state->{module}";
> +	`git-update-ref -m "git-cvsserver commit" $reffile $commithash $parenthash`;
> +	unlink($lockfile);
>      chdir "/";
>  
>      print "ok\n";

Using its own lockfile to update ref by hand while running
update-ref alongside it feels _very_ wrong.  How about this one
instead?

-- >8 --
[PATCH] Make 'cvs ci' lockless

This makes "ci" codepath lockless by following the usual
"remember the tip, do your thing, then compare and swap at the
end" update pattern using update-ref.  Incidentally, by updating
the code that reads where the tip of the head is to use
show-ref, it makes it safe to use in a repository whose refs are
pack-pruned.

I noticed that other parts of the program are not yet pack-refs
safe, but tried to keep the changes to the minimum.

Now I rarely use git-cvsserver myself, so I may be completely
breaking the check-in codepath.  Buyers beware...

---

 git-cvsserver.perl |   41 ++++++++++++++++-------------------------
 1 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 9371788..471621b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1031,36 +1031,35 @@ sub req_ci
         exit;
     }
 
-    my $lockfile = "$state->{CVSROOT}/refs/heads/$state->{module}.lock";
-    unless ( sysopen(LOCKFILE,$lockfile,O_EXCL|O_CREAT|O_WRONLY) )
-    {
-        $log->warn("lockfile '$lockfile' already exists, please try again");
-        print "error 1 Lock file '$lockfile' already exists, please try again\n";
-        exit;
-    }
-
     # Grab a handle to the SQLite db and do any necessary updates
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $state->{module}, $log);
     $updater->update();
 
     my $tmpdir = tempdir ( DIR => $TEMP_DIR );
     my ( undef, $file_index ) = tempfile ( DIR => $TEMP_DIR, OPEN => 0 );
-    $log->info("Lock successful, basing commit on '$tmpdir', index file is '$file_index'");
+    $log->info("Lockless commit start, basing commit on '$tmpdir', index file is '$file_index'");
 
     $ENV{GIT_DIR} = $state->{CVSROOT} . "/";
     $ENV{GIT_INDEX_FILE} = $file_index;
 
+    # Remember where the head was at the beginning.
+    my $parenthash = `git show-ref -s refs/heads/$state->{module}`;
+    chomp $parenthash;
+    if ($parenthash !~ /^[0-9a-f]{40}$/) {
+	    print "error 1 pserver cannot find the current HEAD of module";
+	    exit;
+    }
+
     chdir $tmpdir;
 
     # populate the temporary index based
-    system("git-read-tree", $state->{module});
+    system("git-read-tree", $parenthash);
     unless ($? == 0)
     {
 	die "Error running git-read-tree $state->{module} $file_index $!";
     }
     $log->info("Created index '$file_index' with for head $state->{module} - exit status $?");
 
-
     my @committedfiles = ();
 
     # foreach file specified on the command line ...
@@ -1095,8 +1094,6 @@ sub req_ci
         {
             # fail everything if an up to date check fails
             print "error 1 Up to date check failed for $filename\n";
-            close LOCKFILE;
-            unlink($lockfile);
             chdir "/";
             exit;
         }
@@ -1139,16 +1136,12 @@ sub req_ci
     {
         print "E No files to commit\n";
         print "ok\n";
-        close LOCKFILE;
-        unlink($lockfile);
         chdir "/";
         return;
     }
 
     my $treehash = `git-write-tree`;
-    my $parenthash = `cat $ENV{GIT_DIR}refs/heads/$state->{module}`;
     chomp $treehash;
-    chomp $parenthash;
 
     $log->debug("Treehash : $treehash, Parenthash : $parenthash");
 
@@ -1165,13 +1158,16 @@ sub req_ci
     {
         $log->warn("Commit failed (Invalid commit hash)");
         print "error 1 Commit failed (unknown reason)\n";
-        close LOCKFILE;
-        unlink($lockfile);
         chdir "/";
         exit;
     }
 
-    print LOCKFILE $commithash;
+    if (system(qw(git update-ref -m), "cvsserver ci",
+	       "refs/heads/$state->{module}", $commithash, $parenthash)) {
+	    $log->warn("update-ref for $state->{module} failed.");
+	    print "error 1 Cannot commit -- update first\n";
+	    exit;
+    }
 
     $updater->update();
 
@@ -1200,12 +1196,7 @@ sub req_ci
         }
     }
 
-    close LOCKFILE;
-    my $reffile = "$ENV{GIT_DIR}refs/heads/$state->{module}";
-    unlink($reffile);
-    rename($lockfile, $reffile);
     chdir "/";
-
     print "ok\n";
 }
 
