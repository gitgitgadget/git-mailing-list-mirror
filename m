From: Damien Diederen <dash@foobox.net>
Subject: [PATCH v2 7/7] cvsserver: Use the user part of the email in log and annotate results
Date: Thu, 27 Mar 2008 23:18:35 +0100
Message-ID: <f7869cd4f5ed963cbc298ee64b77a43ebd778b0f.1206654905.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Damien Diederen <dash@foobox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf0RN-00069n-3b
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 23:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761526AbYC0WSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761322AbYC0WSj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 18:18:39 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:60652 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760619AbYC0WSi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2008 18:18:38 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id D77554C45E;
	Thu, 27 Mar 2008 23:18:36 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id C3C732DAAA4;
	Thu, 27 Mar 2008 23:18:36 +0100 (CET)
Received: from keem.bcc (dslb-084-057-042-002.pools.arcor-ip.net [84.57.42.2])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id EAC1267E09;
	Thu, 27 Mar 2008 23:18:35 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: f7869cd4f5ed963cbc298ee64b77a43ebd778b0f Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6432/Thu Mar 27 22:18:40 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78376>

Generate the CVS author names by taking the first eight characters of
the user part of the email address.  The resulting names are more
likely to make sense (or at least reduce ambiguities) in "corporate"
environments.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 49c0ba2..dcca4e7 100755
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
@@ -2139,6 +2137,16 @@ sub kopts_from_path
     }
 }
 
+# Generate a CVS author name from Git author information, by taking
+# the first eight characters of the user part of the email address.
+sub cvs_author
+{
+    my $author_line = shift;
+    (my $author) = $author_line =~ /<([^>@]{1,8})/;
+
+    $author;
+}
+
 package GITCVS::log;
 
 ####
-- 
1.5.5.rc1.19.gfe7681
