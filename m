From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
Date: Tue, 27 Feb 2007 04:48:59 -0800
Message-ID: <200702271248.59652.andyparkins@gmail.com>
References: <200702210908.59579.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1lZ-00072d-Dx
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030608AbXB0MtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbXB0MtK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:49:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:22943 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030608AbXB0MtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:49:08 -0500
Received: by nf-out-0910.google.com with SMTP id o25so167643nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 04:49:06 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Qgv2xZgWpJNKeMlNr0si+/EL3zMlG3jm+7cAgIQAzBRDraylmNmn/tewTuLWjcRL0/+l1GCuEB2b/TTwXyK/QokQdPRNeMxoiioYONEc+lm2kXQFysS0fyFbinqhEHdrzjBafnT0Ox5Vt9KBLCrzsb6DfRKJz6ppUTIIZylTAsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=GgmvcPFUkm6kADRrbf120ROT47QpLubKnB+/kKF6cnooXICYzUPD+wmPUwDJQl/lIiKXJAQhtXk/xsFa3tsYG/ePjQzLGtBsMKu0hRbkksrbpQOUDtqfJ5O9gTeH1N8WhjTt1CMY12f8iqRsx5hfCEQMcF/8rM1OBRtkX7sFRUc=
Received: by 10.49.43.2 with SMTP id v2mr1033793nfj.1172580546641;
        Tue, 27 Feb 2007 04:49:06 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id y24sm1756611nfb.2007.02.27.04.49.02;
        Tue, 27 Feb 2007 04:49:02 -0800 (PST)
In-Reply-To: <200702210908.59579.andyparkins@gmail.com>
X-TUID: 42fa6f4ff25fb037
X-UID: 263
X-Length: 4704
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40723>

This makes "ci" codepath lockless by following the usual
"remember the tip, do your thing, then compare and swap at the
end" update pattern using update-ref.  Incidentally, by updating
the code that reads where the tip of the head is to use
show-ref, it makes it safe to use in a repository whose refs are
pack-pruned.

I noticed that other parts of the program are not yet pack-refs
safe, but tried to keep the changes to the minimum.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
This patch is actually yours (with one extra removal of lock file reference
that you'd missed, and a change of shortlog), but I don't know how to send
an email that comes from me but attributes authorship to you.


 git-cvsserver.perl |   43 ++++++++++++++++---------------------------
 1 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 84520e7..8e12f81 100755
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
 
@@ -1165,8 +1158,6 @@ sub req_ci
     {
         $log->warn("Commit failed (Invalid commit hash)");
         print "error 1 Commit failed (unknown reason)\n";
-        close LOCKFILE;
-        unlink($lockfile);
         chdir "/";
         exit;
     }
@@ -1179,14 +1170,17 @@ sub req_ci
 		{
 			$log->warn("Commit failed (update hook declined to update ref)");
 			print "error 1 Commit failed (update hook declined)\n";
-			close LOCKFILE;
-			unlink($lockfile);
 			chdir "/";
 			exit;
 		}
 	}
 
-    print LOCKFILE $commithash;
+	if (system(qw(git update-ref -m), "cvsserver ci",
+			"refs/heads/$state->{module}", $commithash, $parenthash)) {
+		$log->warn("update-ref for $state->{module} failed.");
+		print "error 1 Cannot commit -- update first\n";
+		exit;
+	}
 
     $updater->update();
 
@@ -1215,12 +1209,7 @@ sub req_ci
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
 
-- 
1.5.0.2.778.gdcb06
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
