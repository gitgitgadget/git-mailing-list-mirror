From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Tue, 27 Feb 2007 13:45:08 +0000
Message-ID: <200702271345.09341.andyparkins@gmail.com>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 14:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2dr-0006G9-FS
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 14:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXB0NpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 08:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbXB0NpP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 08:45:15 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:41216 "EHLO
	369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751586AbXB0NpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 08:45:13 -0500
Received: from dvr.360vision.com ([192.189.1.65]) by 369run02s.360vision.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 27 Feb 2007 13:47:20 +0000
Received: from localhost ([127.0.0.1])
	by dvr.360vision.com with esmtp (Exim 3.36 #1 (Debian))
	id 1HM2di-0007yR-00
	for <git@vger.kernel.org>; Tue, 27 Feb 2007 13:45:10 +0000
In-Reply-To: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
X-TUID: 6c3bad8195495980
X-UID: 266
X-Length: 5185
Content-Disposition: inline
X-OriginalArrivalTime: 27 Feb 2007 13:47:20.0453 (UTC) FILETIME=[CD3FC350:01C75A75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40731>

The config option gitcvs.allbinary may be set to force all entries to
get the -kb flag.

In the future the gitattributes system will probably be a more
appropriate way of doing this, but that will easily slot in as the
entries lines sent to the CVS client now have their kopts set via the
function kopts_from_path().

In the interim it might be better to not just have a all-or-nothing
approach, but rather detect based on file extension (or file contents?).
That would slot in easily here as well.  However, I personally prefer
everything to be binary-safe, so I just switch the switch.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
How about this instead?

I've added one new function - kopts_from_path() - which is passed the
path of the file having an "Entries" line generated.  It can do what it
likes to convert that into the options component.  I've just used a
config option to decide whether everything is binary or nothing is binary.

Default is to be the same as previous behaviour - you have to specifically
ask for the binary flag.

 git-cvsserver.perl |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 56f21b6..15b9443 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -374,7 +374,8 @@ sub req_add
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        print "/$filepart/0//-kb/\n";
+        my $kopts = kopts_from_path($filepart);
+        print "/$filepart/0//$kopts/\n";
 
         $addcount++;
     }
@@ -455,7 +456,8 @@ sub req_remove
 
         print "Checked-in $dirpart\n";
         print "$filename\n";
-        print "/$filepart/-1.$wrev//-kb/\n";
+        my $kopts = kopts_from_path($filepart);
+        print "/$filepart/-1.$wrev//$kopts/\n";
 
         $rmcount++;
     }
@@ -726,7 +728,8 @@ sub req_co
        print $state->{CVSROOT} . "/$module/" . ( defined ( $git->{dir} ) and 
$git->{dir} ne "./" ? $git->{dir} . "/" : "" ) . "$git->{name}\n";
 
         # this is an "entries" line
-        print "/$git->{name}/1.$git->{revision}//-kb/\n";
+        my $kopts = kopts_from_path($git->{name});
+        print "/$git->{name}/1.$git->{revision}//$kopts/\n";
         # permissions
         print "u=$git->{mode},g=$git->{mode},o=$git->{mode}\n";
 
@@ -917,8 +920,9 @@ sub req_update
 		print $state->{CVSROOT} . "/$state->{module}/$filename\n";
 
 		# this is an "entries" line
-		$log->debug("/$filepart/1.$meta->{revision}//-kb/");
-		print "/$filepart/1.$meta->{revision}//-kb/\n";
+		my $kopts = kopts_from_path($filepart);
+		$log->debug("/$filepart/1.$meta->{revision}//$kopts/");
+		print "/$filepart/1.$meta->{revision}//$kopts/\n";
 
 		# permissions
 		$log->debug("SEND : u=$meta->{mode},g=$meta->{mode},o=$meta->{mode}");
@@ -961,8 +965,9 @@ sub req_update
                     print "Update-existing $dirpart\n";
                     
$log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
                     print 
$state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    $log->debug("/$filepart/1.$meta->{revision}//-kb/");
-                    print "/$filepart/1.$meta->{revision}//-kb/\n";
+                    my $kopts = kopts_from_path($filepart);
+                    $log->debug("/$filepart/1.$meta->{revision}//$kopts/");
+                    print "/$filepart/1.$meta->{revision}//$kopts/\n";
                 }
             }
             elsif ( $return == 1 )
@@ -975,7 +980,8 @@ sub req_update
                 {
                     print "Update-existing $dirpart\n";
                     print 
$state->{CVSROOT} . "/$state->{module}/$filename\n";
-                    print "/$filepart/1.$meta->{revision}/+/-kb/\n";
+                    my $kopts = kopts_from_path($filepart);
+                    print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
                 }
             }
             else
@@ -1206,7 +1212,8 @@ sub req_ci
         } else {
             print "Checked-in $dirpart\n";
             print "$filename\n";
-            print "/$filepart/1.$meta->{revision}//-kb/\n";
+            my $kopts = kopts_from_path($filepart);
+            print "/$filepart/1.$meta->{revision}//$kopts/\n";
         }
     }
 
@@ -1887,6 +1894,28 @@ sub filecleanup
     return $filename;
 }
 
+# Given a path, this function returns a string containing the kopts
+# that should go into that path's Entries line.  For example, a binary
+# file should get -kb.
+sub kopts_from_path
+{
+	my ($path) = @_;
+
+	# Once it exists, the git attributes system should be used to look up
+	# what attributes apply to this path.
+
+	# Until then, take the setting from the config file
+    unless ( defined ( $cfg->{gitcvs}{allbinary} ) and $cfg->{gitcvs}
{allbinary} =~ /^\s*(1|true|yes)\s*$/i )
+    {
+		# Return "" to give no special treatment to any path
+		return "";
+    } else {
+		# Alternatively, to have all files treated as if they are binary (which
+		# is more like git itself), always return the "-kb" option
+		return "-kb";
+    }
+}
+
 package GITCVS::log;
 
 ####
-- 
1.5.0.2.778.gdcb06
