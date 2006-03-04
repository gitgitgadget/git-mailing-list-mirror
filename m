From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: nested directory creation fixups for Eclipse clients
Date: Sat, 4 Mar 2006 17:47:29 +1300
Message-ID: <1141447649849-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Mar 04 05:31:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFOQ7-0003BF-PS
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 05:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWCDEbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 23:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWCDEbA
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 23:31:00 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:13249 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1750877AbWCDEa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 23:30:59 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FFOPy-0000wS-Gb; Sat, 04 Mar 2006 17:30:58 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1FFOfx-0000xG-00; Sat, 04 Mar 2006 17:47:29 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17171>

To create nested directories without (or before) sending file entries
is rather tricky. Most clients just work. Eclipse, however, expects
a very specific sequence of events. With this patch, cvsserver meets
those expectations.

Note: we may want to reuse prepdir() in req_update -- should move it
outside of req_co. Right now prepdir() is tied to how req_co() works.

---

 git-cvsserver.perl |   73 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 56 insertions(+), 17 deletions(-)

701168bf1ddad1dbc3788e58181589dc082ce536
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index ab32d3e..b450792 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -592,6 +592,11 @@ sub req_co
     print $state->{CVSROOT} . "/$module/\n";
     print "Clear-static-directory $checkout_path/\n";
     print $state->{CVSROOT} . "/$module/\n";
+    print "Clear-sticky $checkout_path/\n"; # yes, twice
+    print $state->{CVSROOT} . "/$module/\n";
+    print "Template $checkout_path/\n";
+    print $state->{CVSROOT} . "/$module/\n";
+    print "0\n";
 
     # instruct the client that we're checking out to $checkout_path
     print "E cvs checkout: Updating $checkout_path\n";
@@ -599,6 +604,43 @@ sub req_co
     my %seendirs = ();
     my $lastdir ='';
 
+    # recursive
+    sub prepdir {
+       my ($dir, $repodir, $remotedir, $seendirs) = @_;
+       my $parent = dirname($dir);
+       $dir       =~ s|/+$||;
+       $repodir   =~ s|/+$||;
+       $remotedir =~ s|/+$||;
+       $parent    =~ s|/+$||;
+       $log->debug("announcedir $dir, $repodir, $remotedir" );
+
+       if ($parent eq '.' || $parent eq './') {
+           $parent = '';
+       }
+       # recurse to announce unseen parents first
+       if (length($parent) && !exists($seendirs->{$parent})) {
+           prepdir($parent, $repodir, $remotedir, $seendirs);
+       }
+       # Announce that we are going to modify at the parent level
+       if ($parent) {
+           print "E cvs checkout: Updating $remotedir/$parent\n";
+       } else {
+           print "E cvs checkout: Updating $remotedir\n";
+       }
+       print "Clear-sticky $remotedir/$parent/\n";
+       print "$repodir/$parent/\n";
+
+       print "Clear-static-directory $remotedir/$dir/\n";
+       print "$repodir/$dir/\n";
+       print "Clear-sticky $remotedir/$parent/\n"; # yes, twice
+       print "$repodir/$parent/\n";
+       print "Template $remotedir/$dir/\n";
+       print "$repodir/$dir/\n";
+       print "0\n";
+
+       $seendirs->{$dir} = 1;
+    }
+
     foreach my $git ( @{$updater->gethead} )
     {
         # Don't want to check out deleted files
@@ -606,6 +648,17 @@ sub req_co
 
         ( $git->{name}, $git->{dir} ) = filenamesplit($git->{name});
 
+       if (length($git->{dir}) && $git->{dir} ne './'
+           && $git->{dir} ne $lastdir ) {
+           unless (exists($seendirs{$git->{dir}})) {
+               prepdir($git->{dir}, $state->{CVSROOT} . "/$module/",
+                       $checkout_path, \%seendirs);
+               $lastdir = $git->{dir};
+               $seendirs{$git->{dir}} = 1;
+           }
+           print "E cvs checkout: Updating /$checkout_path/$git->{dir}\n";
+       }
+
         # modification time of this file
         print "Mod-time $git->{modified}\n";
 
@@ -617,24 +670,10 @@ sub req_co
             print "M U $checkout_path/$git->{name}\n";
         }
 
-	if (length($git->{dir}) && $git->{dir} ne './' 
-	    && $git->{dir} ne $lastdir && !exists($seendirs{$git->{dir}})) {
-
-	    # Eclipse seems to need the Clear-sticky command
-	    # to prepare the 'Entries' file for the new directory.
-	    print "Clear-sticky $checkout_path/$git->{dir}\n";
-	    print $state->{CVSROOT} . "/$module/$git->{dir}\n";
-	    print "Clear-static-directory $checkout_path/$git->{dir}\n";
-	    print $state->{CVSROOT} . "/$module/$git->{dir}\n";
-	    print "E cvs checkout: Updating /$checkout_path/$git->{dir}\n";
-	    $lastdir = $git->{dir};
-	    $seendirs{$git->{dir}} = 1;
-	}
-
-        # instruct client we're sending a file to put in this path
-        print "Created $checkout_path/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "\n";
+       # instruct client we're sending a file to put in this path
+       print "Created $checkout_path/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "\n";
 
-        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
+       print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and $git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
 
         # this is an "entries" line
         print "/$git->{name}/1.$git->{revision}///\n";
-- 
1.2.4.g09a27-dirty
