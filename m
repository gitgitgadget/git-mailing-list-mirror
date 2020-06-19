Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0EC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C092223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZCODg56D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgFSWvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:51:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39802 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729746AbgFSWvj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:51:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E1F660A72;
        Fri, 19 Jun 2020 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607097;
        bh=/RCWfAMlaGU8Y+6sjRJ8oDEKHR0VpV2hOcyN+/qexsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ZCODg56DschXDMNWY5phuKvWxHS1isqnnnFTIzXnwIMxSPER7Xr6X19ijc6KJPC7u
         Sc4RQ68axAChEJCBuE2byblEKP/FkbXIrf/+p8LvaSXh/doSwKqq8FkHdU3OPqQYlx
         23oLZwUMlkMj8kcIArd19NsMqeqf/zkIoEz62I3hytdXz6aC1OJgE/XKKZvgra3o00
         urOZHLG4HGjHRA8tOhV33geuH6wVScZUAx+pBHKfe07cpXH7PafQGoWvi+ltGI3Y3e
         2z7eywdb/u8ogq7KwE1O8lC/BUDm7gK0skqVSCWy8V96x1tZdo3RPr7PD98bMFrL6t
         Ei36kpCCBCng3BMDFsgWXW7UzNZUvII+XLdRru8dDjraO8DsysSe/VGNVi4z+Knd1x
         C4fasAnkQnSlwPraQhdf2X/znVAY2CPsam4RiS5R8vbAEc+rnbPFyD9HKNOjhv1i8B
         iiR7HKYir/oHBeFDJj93iLfpJFSM2uJxsAQwHPf1BC79b9tFzPq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 12/14] git-cvsserver: port to SHA-256
Date:   Fri, 19 Jun 2020 22:39:45 +0000
Message-Id: <20200619223947.947067-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code of git-cvsserver currently has several hard-coded 20 and 40
constants that are the length of SHA-1.  When parsing the configuration
file, read the extensions.objectformat configuration setting as well as
CVS-related ones and adjust the hash sizes accordingly.  Use these
computed values in all the places we match object IDs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-cvsserver.perl | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ae1044273d..f6f3fc192c 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -365,7 +365,7 @@ sub req_Root
     }
     foreach my $line ( @gitvars )
     {
-        next unless ( $line =~ /^(gitcvs)\.(?:(ext|pserver)\.)?([\w-]+)=(.*)$/ );
+        next unless ( $line =~ /^(gitcvs|extensions)\.(?:(ext|pserver)\.)?([\w-]+)=(.*)$/ );
         unless ($2) {
             $cfg->{$1}{$3} = $4;
         } else {
@@ -392,6 +392,9 @@ sub req_Root
         $log->nofile();
     }
 
+    $state->{rawsz} = ($cfg->{'extensions'}{'objectformat'} || 'sha1') eq 'sha256' ? 32 : 20;
+    $state->{hexsz} = $state->{rawsz} * 2;
+
     return 1;
 }
 
@@ -1581,7 +1584,7 @@ sub req_ci
 
             $parenthash = safe_pipe_capture('git', 'show-ref', '-s', $branchRef);
             chomp $parenthash;
-            if ($parenthash !~ /^[0-9a-f]{40}$/)
+            if ($parenthash !~ /^[0-9a-f]{$state->{hexsz}}$/)
             {
                 if ( defined($stickyInfo) && defined($stickyInfo->{tag}) )
                 {
@@ -1708,7 +1711,7 @@ sub req_ci
     chomp($commithash);
     $log->info("Commit hash : $commithash");
 
-    unless ( $commithash =~ /[a-zA-Z0-9]{40}/ )
+    unless ( $commithash =~ /[a-zA-Z0-9]{$state->{hexsz}}/ )
     {
         $log->warn("Commit failed (Invalid commit hash)");
         print "error 1 Commit failed (unknown reason)\n";
@@ -2375,7 +2378,7 @@ sub req_annotate
         print "E ***************\n";
         while ( <ANNOTATE> )
         {
-            if (m/^([a-zA-Z0-9]{40})\t\([^\)]*\)(.*)$/i)
+            if (m/^([a-zA-Z0-9]{$state->{hexsz}})\t\([^\)]*\)(.*)$/i)
             {
                 my $commithash = $1;
                 my $data = $2;
@@ -2852,7 +2855,7 @@ sub transmitfile
         return;
     }
 
-    die "Need filehash" unless ( defined ( $filehash ) and $filehash =~ /^[a-zA-Z0-9]{40}$/ );
+    die "Need filehash" unless ( defined ( $filehash ) and $filehash =~ /^[a-zA-Z0-9]{$state->{hexsz}}$/ );
 
     my $type = safe_pipe_capture('git', 'cat-file', '-t', $filehash);
     chomp $type;
@@ -3042,7 +3045,7 @@ sub ensureWorkTree
 
     my $ver = safe_pipe_capture('git', 'show-ref', '-s', "refs/heads/$state->{module}");
     chomp $ver;
-    if ($ver !~ /^[0-9a-f]{40}$/)
+    if ($ver !~ /^[0-9a-f]{$state->{hexsz}}$/)
     {
         $log->warn("Error from git show-ref -s refs/head$state->{module}");
         print "error 1 cannot find the current HEAD of module";
@@ -3281,7 +3284,7 @@ sub open_blob_or_die
     }
     elsif( $srcType eq "sha1" )
     {
-        unless ( defined ( $name ) and $name =~ /^[a-zA-Z0-9]{40}$/ )
+        unless ( defined ( $name ) and $name =~ /^[a-zA-Z0-9]{$state->{hexsz}}$/ )
         {
             $log->warn("Need filehash");
             die "Need filehash\n";
@@ -3817,7 +3820,7 @@ sub update
     chomp $commitsha1;
 
     my $commitinfo = ::safe_pipe_capture('git', 'cat-file', 'commit', $self->{module});
-    unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
+    unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{$state->{hexsz}}/ )
     {
         die("Invalid module '$self->{module}'");
     }
@@ -3957,7 +3960,7 @@ sub update
             while ( <FILELIST> )
             {
 		chomp;
-                unless ( /^:\d{6}\s+([0-7]{6})\s+[a-f0-9]{40}\s+([a-f0-9]{40})\s+(\w)$/o )
+                unless ( /^:\d{6}\s+([0-7]{6})\s+[a-f0-9]{$state->{hexsz}}\s+([a-f0-9]{$state->{hexsz}})\s+(\w)$/o )
                 {
                     die("Couldn't process git-diff-tree line : $_");
                 }
@@ -4625,11 +4628,11 @@ sub getmeta
             $db_query->execute($filename, $intRev);
             $meta = $db_query->fetchrow_hashref;
         }
-        elsif ( $revision =~ /^2\.1\.1\.2000(\.[1-3][0-9][0-9]){20}$/ )
+        elsif ( $revision =~ /^2\.1\.1\.2000(\.[1-3][0-9][0-9]){$state->{rawsz}}$/ )
         {
             my ($commitHash)=($revision=~/^2\.1\.1\.2000(.*)$/);
             $commitHash=~s/\.([0-9]+)/sprintf("%02x",$1-100)/eg;
-            if($commitHash=~/^[0-9a-f]{40}$/)
+            if($commitHash=~/^[0-9a-f]{$state->{hexsz}}$/)
             {
                 return $self->getMetaFromCommithash($filename,$commitHash);
             }
@@ -4639,7 +4642,7 @@ sub getmeta
             $log->warning("failed get $revision with commithash=$commitHash");
             undef $revision;
         }
-        elsif ( $revision =~ /^[0-9a-f]{40}$/ )
+        elsif ( $revision =~ /^[0-9a-f]{$state->{hexsz}}$/ )
         {
             # Try DB first.  This is mostly only useful for req_annotate(),
             # which only calls this for stuff that should already be in
@@ -4658,7 +4661,7 @@ sub getmeta
             if(! $meta)
             {
                 my($revCommit)=$self->lookupCommitRef($revision);
-                if($revCommit=~/^[0-9a-f]{40}$/)
+                if($revCommit=~/^[0-9a-f]{$state->{hexsz}}$/)
                 {
                     return $self->getMetaFromCommithash($filename,$revCommit);
                 }
@@ -4672,7 +4675,7 @@ sub getmeta
         else
         {
             my($revCommit)=$self->lookupCommitRef($revision);
-            if($revCommit=~/^[0-9a-f]{40}$/)
+            if($revCommit=~/^[0-9a-f]{$state->{hexsz}}$/)
             {
                 return $self->getMetaFromCommithash($filename,$revCommit);
             }
@@ -4767,7 +4770,7 @@ sub getMetaFromCommithash
 
     my($fileHash) = ::safe_pipe_capture("git","rev-parse","$revCommit:$filename");
     chomp $fileHash;
-    if(!($fileHash=~/^[0-9a-f]{40}$/))
+    if(!($fileHash=~/^[0-9a-f]{$state->{hexsz}}$/))
     {
         die "Invalid fileHash '$fileHash' looking up"
                     ." '$revCommit:$filename'\n";
@@ -4863,7 +4866,7 @@ sub lookupCommitRef
     $commitHash = ::safe_pipe_capture("git","rev-parse","--verify","--quiet",
 				      $self->unescapeRefName($ref));
     $commitHash=~s/\s*$//;
-    if(!($commitHash=~/^[0-9a-f]{40}$/))
+    if(!($commitHash=~/^[0-9a-f]{$state->{hexsz}}$/))
     {
         $commitHash=undef;
     }
@@ -4909,7 +4912,7 @@ sub commitmessage
     my $commithash = shift;
     my $tablename = $self->tablename("commitmsgs");
 
-    die("Need commithash") unless ( defined($commithash) and $commithash =~ /^[a-zA-Z0-9]{40}$/ );
+    die("Need commithash") unless ( defined($commithash) and $commithash =~ /^[a-zA-Z0-9]{$state->{hexsz}}$/ );
 
     my $db_query;
     $db_query = $self->{dbh}->prepare_cached("SELECT value FROM $tablename WHERE key=?",{},1);
