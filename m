From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] cvsserver: Determinize output to combat Perl 5.18 hash
 randomization
Date: Wed, 30 Oct 2013 04:44:43 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1310300413430.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, 727226@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbROZ-0001hn-Td
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab3J3Iov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:44:51 -0400
Received: from dmz-mailsec-scanner-7.mit.edu ([18.7.68.36]:60810 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269Ab3J3Iot (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 04:44:49 -0400
X-AuditID: 12074424-b7f528e0000009aa-a0-5270c7003760
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E0.C3.02474.007C0725; Wed, 30 Oct 2013 04:44:48 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r9U8ikO8031120;
	Wed, 30 Oct 2013 04:44:47 -0400
Received: from localhost (dr-wily.mit.edu [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r9U8ihHu004467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 30 Oct 2013 04:44:45 -0400
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixCmqrMtwvCDIoLlfzmLFwX3MFl1Xupks
	GnqvMDswe1zYOonF4+IlZY/Pm+QCmKO4bFJSczLLUov07RK4Mv7+X8ZS8Fug4vCao8wNjIt5
	uhg5OSQETCTe/JrNBmGLSVy4tx7I5uIQEtjHKHHyyk1mCGcjo8Tpi29ZIJxtTBJLbs5mB2lh
	EdCW+Na9F8xmE1CTmLthMpgtAmRPbDvEAmIzC+hL7Lq7nwnEFhYIl5hybA0ziM0r4CixbMoz
	sBpRAV2JvYfOsEPEBSVOznwC1aslsXz6NpYJjHyzkKRmIUktYGRaxSibklulm5uYmVOcmqxb
	nJyYl5dapGuul5tZopeaUrqJERRy7C4qOxibDykdYhTgYFTi4TV4kB8kxJpYVlyZe4hRkoNJ
	SZQ38XBBkBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3sgtQDnelMTKqtSifJiUNAeLkjjvLQ77
	ICGB9MSS1OzU1ILUIpisDAeHkgTv4aNAjYJFqempFWmZOSUIaSYOTpDhPEDDH4PU8BYXJOYW
	Z6ZD5E8xKkqJ854CSQiAJDJK8+B6YSnhFaM40CvCvK9BqniA6QSu+xXQYCagwXtY8kAGlyQi
	pKQaGOcu5lv2vD7eYLr7g/qe3/Py/Xclvi05YvRY/bN6Q31q8r5FEo6ccuuf8nmXm79z4Jd2
	DzRl4l3jNW+2uf4rt8CyT6fzBc5abrLKSjS/1ZHhEnjp4SsnI5ffKuybl3v832P/2yXY5nqv
	2OQVv5Zu9D54llc0KJl5tmzCNL7bS3sj+Q+HbN8QoMRSnJFoqMVcVJwIAG3xOXLk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237003>

Perl 5.18 randomizes the seed used by its hash function, so iterating
through hashes results in different orders from run to run:
  http://perldoc.perl.org/perl5180delta.html#Hash-overhaul

This usually broke t9400 (gitcvs.dbname, gitcvs.ext.dbname, when
running cmp on two .sqlite files) and t9402 (check [cvswork3] diff,
when running test_cmp on two diffs).

To fix this, hide the internal order of hashes with sort when sending
output or running database queries.

(An alternative workaround is PERL_HASH_SEED=0, but this seems nicer.)

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-cvsserver.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 67b1e7b..6177f4a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -430,10 +430,10 @@ sub req_validrequests
 
     $log->debug("req_validrequests");
 
-    $log->debug("SEND : Valid-requests " . join(" ",keys %$methods));
+    $log->debug("SEND : Valid-requests " . join(" ",sort keys %$methods));
     $log->debug("SEND : ok");
 
-    print "Valid-requests " . join(" ",keys %$methods) . "\n";
+    print "Valid-requests " . join(" ",sort keys %$methods) . "\n";
     print "ok\n";
 }
 
@@ -2124,7 +2124,7 @@ sub req_diff
             print "M retrieving revision $meta2->{revision}\n"
         }
         print "M diff ";
-        foreach my $opt ( keys %{$state->{opt}} )
+        foreach my $opt ( sort keys %{$state->{opt}} )
         {
             if ( ref $state->{opt}{$opt} eq "ARRAY" )
             {
@@ -4050,7 +4050,7 @@ sub update
             close FILELIST;
 
             # Detect deleted files
-            foreach my $file ( keys %$head )
+            foreach my $file ( sort keys %$head )
             {
                 unless ( exists $seen_files->{$file} or $head->{$file}{filehash} eq "deleted" )
                 {
@@ -4078,7 +4078,7 @@ sub update
     }
 
     $self->delete_head();
-    foreach my $file ( keys %$head )
+    foreach my $file ( sort keys %$head )
     {
         $self->insert_head(
             $file,
-- 
1.8.4.1
