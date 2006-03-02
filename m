From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: Checkout correctly on Eclipse
Date: Thu, 2 Mar 2006 13:58:57 +1300
Message-ID: <11412611372638-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Mar 02 01:42:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEbu3-0002Et-5S
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 01:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWCBAmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 19:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWCBAmn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 19:42:43 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:47496 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751006AbWCBAmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 19:42:42 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FEbtw-0001W6-AR; Thu, 02 Mar 2006 13:42:40 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1FEc9h-0006Og-00; Thu, 02 Mar 2006 13:58:57 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17034>

Initial checkouts were failing to create Entries files under Eclipse.
Eclipse was waiting for two non-standard directory-resets to prepare for a new
directory from the server.

This patch is tricky, because the same directory resets tend to confuse other
clients. It's taken a bit of fiddling to get the commandline cvs client and
Eclipse to get a good, clean checkout.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

Heh! Using git-format-patch I make sure I don't send you stray spaces ;-)

(actually, I am back to using cperl-mode which highlights trailing ws)

I'll rewind/reset my 'cvsserver' branch so it's all clean and you can pull
from it and not fear white space monsters.

cheers,


martin
---

 git-cvsserver.perl |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

6a6ad59c4979e88e7f2a7b0997a3eb9fa115d6a7
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3c588c9..d641c03 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -571,8 +571,19 @@ sub req_co
     my $updater = GITCVS::updater->new($state->{CVSROOT}, $module, $log);
     $updater->update();
 
+    $checkout_path =~ s|/$||; # get rid of trailing slashes
+
+    # Eclipse seems to need the Clear-sticky command
+    # to prepare the 'Entries' file for the new directory.
+    print "Clear-sticky $checkout_path/\n";
+    print $state->{CVSROOT} . "/$checkout_path/\n";
+    print "Clear-static-directory $checkout_path/\n";
+    print $state->{CVSROOT} . "/$checkout_path/\n";
+
     # instruct the client that we're checking out to $checkout_path
-    print "E cvs server: updating $checkout_path\n";
+    print "E cvs checkout: Updating $checkout_path\n";
+
+    my %seendirs = ();
 
     foreach my $git ( @{$updater->gethead} )
     {
@@ -585,16 +596,24 @@ sub req_co
         print "Mod-time $git->{modified}\n";
 
         # print some information to the client
-        print "MT +updated\n";
-        print "MT text U \n";
         if ( defined ( $git->{dir} ) and $git->{dir} ne "./" )
         {
-            print "MT fname $checkout_path/$git->{dir}$git->{name}\n";
+            print "M U $checkout_path/$git->{dir}$git->{name}\n";
         } else {
-            print "MT fname $checkout_path/$git->{name}\n";
+            print "M U $checkout_path/$git->{name}\n";
         }
-        print "MT newline\n";
-        print "MT -updated\n";
+
+	if (length($git->{dir}) && $git->{dir} ne './' && !exists($seendirs{$git->{dir}})) {
+
+	    # Eclipse seems to need the Clear-sticky command
+	    # to prepare the 'Entries' file for the new directory.
+	    print "Clear-sticky $module/$git->{dir}\n";
+	    print $state->{CVSROOT} . "/$module/$git->{dir}\n";
+	    print "Clear-static-directory $module/$git->{dir}\n";
+	    print $state->{CVSROOT} . "/$module/$git->{dir}\n";
+	    print "E cvs checkout: Updating /$module/$git->{dir}\n";
+	    $seendirs{$git->{dir}} = 1;
+	}
 
         # instruct client we're sending a file to put in this path
         print "Created $checkout_path/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "\n";
-- 
1.2.3.g67153
