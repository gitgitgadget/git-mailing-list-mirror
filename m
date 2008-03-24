From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 7/7] cvsserver: Use the user part of the email in log and annotate results
Date: Mon, 24 Mar 2008 23:50:55 +0100
Message-ID: <01e5947cde524f4eb97a86785d0e1f28e2d040e0.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvW8-00037V-RN
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbYCXWvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYCXWu7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:50:59 -0400
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:48238 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754620AbYCXWu6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:50:58 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id EE6411F7146;
	Mon, 24 Mar 2008 23:50:56 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id D723A51013F;
	Mon, 24 Mar 2008 23:50:56 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 4A5A88C468;
	Mon, 24 Mar 2008 23:50:56 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 01e5947cde524f4eb97a86785d0e1f28e2d040e0 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78122>

Generate the CVS author names by taking the first eight characters of
the user part of the email address.  The resulting names are more
likely to make sense (or at least reduce ambiguities) in "corporate"
environments.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3c97226..9d845c8 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1728,8 +1728,7 @@ sub req_log
             print "M revision 1.$revision->{revision}\n";
             # reformat the date for log output
             $revision->{modified} = sprintf('%04d/%02d/%02d %s', $3, $DATE_LIST->{$2}, $1, $4 ) if ( $revision->{modified} =~ /(\d+)\s+(\w+)\s+(\d+)\s+(\S+)/ and defined($DATE_LIST->{$2}) );
-            $revision->{author} =~ s/\s+.*//;
-            $revision->{author} =~ s/^(.{8}).*/$1/;
+            $revision->{author} = cvs_author($revision->{author});
             print "M date: $revision->{modified};  author: $revision->{author};  state: " . ( $revision->{filehash} eq "deleted" ? "dead" : "Exp" ) . ";  lines: +2 -3\n";
             my $commitmessage = $updater->commitmessage($revision->{commithash});
             $commitmessage =~ s/^/M /mg;
@@ -1844,8 +1843,7 @@ sub req_annotate
                 unless ( defined ( $metadata->{$commithash} ) )
                 {
                     $metadata->{$commithash} = $updater->getmeta($filename, $commithash);
-                    $metadata->{$commithash}{author} =~ s/\s+.*//;
-                    $metadata->{$commithash}{author} =~ s/^(.{8}).*/$1/;
+                    $metadata->{$commithash}{author} = cvs_author($metadata->{$commithash}{author});
                     $metadata->{$commithash}{modified} = sprintf("%02d-%s-%02d", $1, $2, $3) if ( $metadata->{$commithash}{modified} =~ /^(\d+)\s(\w+)\s\d\d(\d\d)/ );
                 }
                 printf("M 1.%-5d      (%-8s %10s): %s\n",
@@ -2136,6 +2134,18 @@ sub kopts_from_path
     }
 }
 
+# Generate a CVS author name from Git author information, by taking
+# the first eight characters of the user part of the email address.
+sub cvs_author
+{
+    my $author = shift;
+
+    $author =~ s/.*<([^>]+)\@[^>]+>$/$1/;
+    $author =~ s/^(.{8}).*/$1/;
+
+    $author;
+}
+
 package GITCVS::log;
 
 ####
-- 
1.5.5.rc1.6.gd183
