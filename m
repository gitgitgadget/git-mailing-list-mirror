X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Fri, 10 Nov 2006 11:49:26 -0800
Message-ID: <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net>
References: <45530CEE.6030008@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 10 Nov 2006 19:49:48 +0000 (UTC)
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45530CEE.6030008@b-i-t.de> (sf@b-i-t.de's message of "Thu, 09
	Nov 2006 12:11:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31209>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GicNY-0007wt-CC for gcvg-git@gmane.org; Fri, 10 Nov
 2006 20:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946755AbWKJTt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 10 Nov 2006
 14:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946765AbWKJTt2
 (ORCPT <rfc822;git-outgoing>); Fri, 10 Nov 2006 14:49:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23950 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1946755AbWKJTt1
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2006 14:49:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061110194927.HKHU18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 10
 Nov 2006 14:49:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id l7pY1V00e1kojtg0000000; Fri, 10 Nov 2006
 14:49:33 -0500
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org

sf <sf@b-i-t.de> writes:

> I want to access a git repository via git-cvsserver. The problem is
> that the repository contains paths with umlauts. These paths come out
> quoted and escaped when checked out with cvs.

I think this is because the cvsserver invokes diff-tree and
ls-tree without -z and the output from these command quote
non-ascii letters as unsafe.

Martin's sqlite may probably be needed as well, but regardless
of that something like this patch is needed -- otherwise what 
populates sqlite database will be quoted to begin with so it
would not help much.

I've tested with your reproduction recipe, but otherwise not
tested this patch.

-- >8 --

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 8817f8b..ca519b7 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2343,67 +2343,72 @@ sub update
 
         if ( defined ( $lastpicked ) )
         {
-            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree : $!");
+	    local ($/) = "\0";
             while ( <FILELIST> )
             {
-                unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+([a-zA-Z0-9]{40})\s+(\w)\s+(.*)$/o )
+		chomp;
+                unless ( /^:\d{6}\s+\d{3}(\d)\d{2}\s+[a-zA-Z0-9]{40}\s+([a-zA-Z0-9]{40})\s+(\w)$/o )
                 {
                     die("Couldn't process git-diff-tree line : $_");
                 }
+		my ($mode, $hash, $change) = ($1, $2, $3);
+		my $name = <FILELIST>;
+		chomp($name);
 
-                # $log->debug("File mode=$1, hash=$2, change=$3, name=$4");
+                # $log->debug("File mode=$mode, hash=$hash, change=$change, name=$name");
 
                 my $git_perms = "";
-                $git_perms .= "r" if ( $1 & 4 );
-                $git_perms .= "w" if ( $1 & 2 );
-                $git_perms .= "x" if ( $1 & 1 );
+                $git_perms .= "r" if ( $mode & 4 );
+                $git_perms .= "w" if ( $mode & 2 );
+                $git_perms .= "x" if ( $mode & 1 );
                 $git_perms = "rw" if ( $git_perms eq "" );
 
-                if ( $3 eq "D" )
+                if ( $change eq "D" )
                 {
-                    #$log->debug("DELETE   $4");
-                    $head->{$4} = {
-                        name => $4,
-                        revision => $head->{$4}{revision} + 1,
+                    #$log->debug("DELETE   $name");
+                    $head->{$name} = {
+                        name => $name,
+                        revision => $head->{$name}{revision} + 1,
                         filehash => "deleted",
                         commithash => $commit->{hash},
                         modified => $commit->{date},
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
-                elsif ( $3 eq "M" )
+                elsif ( $change eq "M" )
                 {
-                    #$log->debug("MODIFIED $4");
-                    $head->{$4} = {
-                        name => $4,
-                        revision => $head->{$4}{revision} + 1,
-                        filehash => $2,
+                    #$log->debug("MODIFIED $name");
+                    $head->{$name} = {
+                        name => $name,
+                        revision => $head->{$name}{revision} + 1,
+                        filehash => $hash,
                         commithash => $commit->{hash},
                         modified => $commit->{date},
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
-                elsif ( $3 eq "A" )
+                elsif ( $change eq "A" )
                 {
-                    #$log->debug("ADDED    $4");
-                    $head->{$4} = {
-                        name => $4,
+                    #$log->debug("ADDED    $name");
+                    $head->{$name} = {
+                        name => $name,
                         revision => 1,
-                        filehash => $2,
+                        filehash => $hash,
                         commithash => $commit->{hash},
                         modified => $commit->{date},
                         author => $commit->{author},
                         mode => $git_perms,
                     };
-                    $self->insert_rev($4, $head->{$4}{revision}, $2, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
+                    $self->insert_rev($name, $head->{$name}{revision}, $hash, $commit->{hash}, $commit->{date}, $commit->{author}, $git_perms);
                 }
                 else
                 {
-                    $log->warn("UNKNOWN FILE CHANGE mode=$1, hash=$2, change=$3, name=$4");
+                    $log->warn("UNKNOWN FILE CHANGE mode=$mode, hash=$hash, change=$change, name=$name");
                     die;
                 }
             }
@@ -2412,10 +2417,12 @@ sub update
             # this is used to detect files removed from the repo
             my $seen_files = {};
 
-            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+            my $filepipe = open(FILELIST, '-|', 'git-ls-tree', '-z', '-r', $commit->{hash}) or die("Cannot call git-ls-tree : $!");
+	    local $/ = "\0";
             while ( <FILELIST> )
             {
-                unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\s+(.*)$/o )
+		chomp;
+                unless ( /^(\d+)\s+(\w+)\s+([a-zA-Z0-9]+)\t(.*)$/o )
                 {
                     die("Couldn't process git-ls-tree line : $_");
                 }
