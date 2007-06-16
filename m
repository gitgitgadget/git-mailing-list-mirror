From: Dirk Koopman <djk@tobit.co.uk>
Subject: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sat, 16 Jun 2007 19:50:06 +0100
Message-ID: <11820198064114-git-send-email-djk@tobit.co.uk>
Cc: Dirk Koopman <djk@tobit.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 21:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdjD-0001OJ-PR
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 21:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbXFPTOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbXFPTOa
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 15:14:30 -0400
Received: from post.tobit.co.uk ([82.68.205.2]:42678 "EHLO post.tobit.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbXFPTOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 15:14:30 -0400
X-Greylist: delayed 1458 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jun 2007 15:14:29 EDT
Received: from dmzgate.tobit.co.uk ([82.68.205.1] helo=localhost.localdomain)
	by post.tobit.co.uk with esmtp (Exim 4.60)
	(envelope-from <djk@tobit.co.uk>)
	id 1HzdLa-00011e-Vi; Sat, 16 Jun 2007 19:50:07 +0100
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 242234
References: 242234
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50305>

Early cvs clients don't cause state->{args} to be initialised,
so force this to occur.
Some revision checking code assumes that revisions will be
recognisably numeric to perl, Branches are not, because they
have more decimal points (eg 1.2.3.4 instead of just 1.2).
---
 git-cvsserver.perl |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5cbf27e..0a4b75e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1813,11 +1813,14 @@ sub req_annotate
 # the second is $state->{files} which is everything after it.
 sub argsplit
 {
+    $state->{args} = [];        # need this here because later code depends on it
+                                # and for some reason earlier versions of CVS don't
+                                # satisfy the next condition on plain 'cvs update'
+
     return unless( defined($state->{arguments}) and ref $state->{arguments} eq "ARRAY" );
 
     my $type = shift;
 
-    $state->{args} = [];
     $state->{files} = [];
     $state->{opt} = {};
 
@@ -1906,11 +1909,13 @@ sub argsfromdir
 
     # push added files
     foreach my $file (keys %{$state->{entries}}) {
-	if ( exists $state->{entries}{$file}{revision} &&
-		$state->{entries}{$file}{revision} == 0 )
-	{
-	    push @gethead, { name => $file, filehash => 'added' };
-	}
+        # remember that revisions could be on branches 1.2.3.4[.5.6..]
+        # not just a recogisable "numeric" 1.2
+        if ( exists $state->{entries}{$file}{revision} &&
+             !$state->{entries}{$file}{revision} )
+        {
+            push @gethead, { name => $file, filehash => 'added' };
+        }
     }
 
     if ( scalar(@{$state->{args}}) == 1 )
-- 
1.5.2.1
