From: Alex Bennee <kernel-hacker@bennee.com>
Subject: git-cvsexportcommit getting out of sync with CVS status requests
Date: Wed, 15 Aug 2007 12:48:30 +0100
Organization: Insert joke here
Message-ID: <1187178510.13096.46.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ieykuWFOOacbWCOrbBuN"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 14:22:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILHtg-0005lu-2j
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 14:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbXHOMWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 08:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbXHOMWo
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 08:22:44 -0400
Received: from mx.transitive.com ([217.207.128.220]:35659 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754669AbXHOMWn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 08:22:43 -0400
X-Greylist: delayed 2089 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2007 08:22:42 EDT
Received: from [192.168.2.164] (helo=[192.168.2.164])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1ILHCh-0001h7-2o
	for git@vger.kernel.org; Wed, 15 Aug 2007 11:38:25 +0000
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55895>


--=-ieykuWFOOacbWCOrbBuN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Occasionally (usually when a lot of files have been added or moved in my
git tree) git-cvsexportcommit gets confused when I'm exporting. I'll get
the error like:

File path/to/filea is already known in your CVS checkout.

But when manually querying:

$ cvs status path/to/filea
===================================================================
File: no file filea           Status: Unknown

   Working revision:    No entry for filea
   Repository revision: No revision control file

It's often combined with other errors like:

File path/to/fileb not up to date but has status 'Unknown' in your CVS
checkout!

Again manually querying:

$ cvs status path/to/fileb
===================================================================
File: fileb        Status: Up-to-date

   Working revision:    1.2
   Repository revision: 1.2     /path/to/cvs/path/to/fileb,v
   Sticky Tag:          ATAG (branch: 1.2.98)
   Sticky Date:         (none)
   Sticky Options:      (none)

I'm trying to pick out how the script queries cvs but I'm no perl expert
and there seems to be complex pipe->array magics going on in there. It
certainly looks like it's got the cvs status for the wrong file
associated with it.

I've made some hacks to the script and now I can see it does get into a
funny state:

We matched File: a.sh      Status: Up-to-date and store Up-to-date for
path/to/a.sh
We matched File: b                Status: Up-to-date and store
Up-to-date for path/to/c.sh
We matched File: no file c.sh         Status: Unknown and store Unknown
for path/to/d.sh

Patches (not fixes, just instrumentation to see whats going on) attached
for people who are interested.

-- 
Alex, homepage: http://www.bennee.com/~alex/
Merchandise can be shipped only upon receipt of payment.


--=-ieykuWFOOacbWCOrbBuN
Content-Disposition: attachment; filename=cvsexport.patch
Content-Type: text/x-patch; name=cvsexport.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- git-cvsexportcommit.perl	2007-08-15 12:10:03.000000000 +0100
+++ git-cvsexportcommit	2007-08-15 12:37:50.000000000 +0100
@@ -1,4 +1,5 @@
 #!/usr/bin/perl -w
+use lib (split(/:/, $ENV{GITPERLLIB} || "/home/alexjb/share/perl/5.8.8"));
 
 # Known limitations:
 # - does not propagate permissions
@@ -173,6 +174,9 @@
 foreach my $f (@files) {
     my $path = dirname $f;
     next if (grep { $_ eq $path } @dirs);
+
+    $opt_v && print "Adding $f to files to check status of\n";
+    
     push @canstatusfiles, $f;
 }
 
@@ -185,12 +189,13 @@
     my @cvsoutput;
     @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
     my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
+    foreach my $cvsoutput (@cvsoutput) {
+        chomp $cvsoutput;
 
-	$opt_v && print "Processing $1\n";
+#	$opt_v && print "Processing $cvsoutput\n";
 
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
+        if ( $cvsoutput =~ /^File:/ and  $cvsoutput =~ /Status: (.*)$/ ) {
+	    $opt_v && print "We matched $cvsoutput and store $1 for $canstatusfiles[$matchcount]\n";
             $cvsstat{$canstatusfiles[$matchcount]} = $1;
             $matchcount++;
         }
@@ -201,9 +206,9 @@
 foreach my $f (@afiles) {
     if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
 	$dirty = 1;
-	warn "File $f is already known in your CVS checkout.\n"
-	warn "  Perhaps it has been added by another user.\n"
-	warn "  Or this may indicate that it exists on a different branch.\n"
+	warn "File $f is already known in your CVS checkout.\n";
+	warn "  Perhaps it has been added by another user?\n";
+	warn "  Or this may indicate that it exists on a different branch?\n";
 	warn "  If this is the case, use -f to force the merge.\n";
 	warn "Status was: $cvsstat{$f}\n";
     }
@@ -300,6 +305,7 @@
 # if the exec returns non-zero we die
 sub safe_pipe_capture {
     my @output;
+
     if (my $pid = open my $child, '-|') {
 	@output = (<$child>);
 	close $child or die join(' ',@_).": $! $?";

--=-ieykuWFOOacbWCOrbBuN--
