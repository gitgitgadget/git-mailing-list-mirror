From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: [PATCH] git-cvsexportcommit: handle file status reported out of order
 (was Re: [PATCH] Make git-cvsexportcommit "status" each file in turn)
Date: Thu, 02 Oct 2008 12:07:41 +0100
Message-ID: <48E4AB7D.5030705@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010308050503050807060400"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 13:45:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlMcW-0008N3-Na
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 13:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYJBLnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYJBLnn
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 07:43:43 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:4880 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYJBLnm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 07:43:42 -0400
X-Greylist: delayed 2202 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Oct 2008 07:43:41 EDT
Received: from 80-192-19-239.cable.ubr02.edin.blueyonder.co.uk ([80.192.19.239] helo=[192.168.0.123])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1KlM1K-0004aI-FJ
	for git@vger.kernel.org; Thu, 02 Oct 2008 12:06:58 +0100
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97316>

This is a multi-part message in MIME format.
--------------010308050503050807060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've encountered a problem with the Ubuntu Hardy version of 
git-cvsexportcommit (part of git-cvs 1:1.5.4.3-1ubuntu2). This seems to 
be the same problem describedin August last year in the thread on this 
list I referenced (Make git-cvsexportcommit "status" each file in turn).

The problem is that cvsexportcommit rejects a patch erroneously when CVS 
does not report file statuses in the expected order.  It confuses one 
file's status for another and says (at least in my case):

> Checking if patch will apply
> cvs server: nothing known about XXXXXXXXX
> cvs server: nothing known about XXXXXXXXX
> File XXXXXXXXX is already known in your CVS checkout   -- perhaps it\
 >  has been added by another user. Or this may indicate that it exists\
 >  on a different branch. If this is the case, use -f to force the\
 >  merge.
> Status was: Up-to-date
> File XXXXXXXXX not up to date but has status   'Unknown' in your\
 >  CVS checkout!
> Exiting: your CVS tree is not clean for this merge. at /usr/bin/git\
 >  -cvsexportcommit line 235.

I searched this list - including the release announcements - and the web 
and it did not seem that anyone had applied this patch or otherwise 
addressed it.

I then found the git release repository and it *does* seem to have been 
addressed in 1.6.0.  However, and correct me if I'm mistaken, but the 
implementation seems to assume that the committed files' basenames are 
unique?  This can't be guaranteed in general, can it?

Anyway, by then I'd already had a go at fixing it myself, and I had an 
alternative approach, partly based on the suggestions from Robin 
Rosenberg in the referenced thread. It doesn't assume basenames are 
unique, and therefore I think should be more robust.

So, attached is a patch against v1.5.4.  It works for me, but has only 
been tested with my particular circumstance, so there could be 
assumptions I made which aren't universally true.  I did try using the 
test suite in git 1.6.0 but it didn't work for reasons I don't want to 
spend too much more time investigating.  I think the patch as it is 
should be easy to follow and integrate with 1.6.0 for someone familiar 
with the codebase.

Some notes about the patch.

  - It parses the output of CVS status / update, getting the
    file status much as before

  - save_pipe_capture() is modified to capture STDERR as well as STDOUT

  - The STDERR message 'nothing known about <path>' is used
    preferentially to get a file's path.

  - Otherwise, uses the 'Repository revision' field, extracting the
    relevant part by removing the repository root constructed from
    meta-data in the CVS/Root and CVS/Repository files.

I hope this helps.  Comments welcome.

Thanks,

Nick


--------------010308050503050807060400
Content-Type: text/x-diff;
 name="git-cvsexportcommit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-cvsexportcommit.diff"

--- /usr/bin/git-cvsexportcommit.orig	2008-10-02 01:16:23.000000000 +0100
+++ /home/nick/bin/git-cvsexportcommit	2008-10-02 01:17:13.000000000 +0100
@@ -7,6 +7,18 @@
 use Data::Dumper;
 use File::Basename qw(basename dirname);
 
+# read in the first line of a file
+sub first_line {
+    my ($file) = @_;
+    my $line = '';
+   
+    return unless open my $fh, "<$file";
+    chomp ($line = <$fh>);
+    close $fh;
+    return $line;
+}
+
+
 our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
 
 getopts('uhPpvcfam:d:w:');
@@ -193,21 +205,63 @@
     push @canstatusfiles, $f;
 }
 
+
+# Get the root path the CVS working directory thinks its respository is at.
+# (We're in the working dir). Note we assume the repository agrees on this
+# throughout, which isn't necessarily true, but if not it's just bonkers.
+my $root_path = first_line("CVS/Root") || '';
+
+# likewise the module
+my $module_path = first_line("CVS/Repository") || '';
+        
+# try and strip off all but the path from the root - we assume the path has no colons
+$root_path =~ s/^.*://;
+$root_path =~ s{/*$}{/$module_path}; # concatenate the paths
+
+
+# lightly tested - seems ok with unknown files, and CVS repos using non-symbolic modules
+    
+# get the files' statuses
 my %cvsstat;
 if (@canstatusfiles) {
     if ($opt_u) {
       my @updated = xargs_safe_pipe_capture([@cvs, 'update'], @canstatusfiles);
       print @updated;
     }
+
     my @cvsoutput;
     @cvsoutput = xargs_safe_pipe_capture([@cvs, 'status'], @canstatusfiles);
-    my $matchcount = 0;
-    foreach my $l (@cvsoutput) {
-        chomp $l;
-        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
-            $cvsstat{$canstatusfiles[$matchcount]} = $1;
-            $matchcount++;
+ 
+    chomp @cvsoutput;
+    my ($status, $path, $repo_path);
+    my %expected_paths = map { $_ => 1 } @canstatusfiles;
+
+    # Use $_ implcitly here to simplify the regex expressions.
+    # Note that foreach saves and restores $_ for us
+    foreach (@cvsoutput) {
+        # Grab the information when we see it
+        $status = $1, next if /^File:.*Status:\s*(.*)/i;
+        $path = $1,   next if /^cvs server: nothing known about (.*)/i;
+
+        next unless m{Repository revision:[\s\d.]*(.*)}i;
+        $repo_path = $1;
+
+        # At this point we can try and reconstruct the file path
+        if (!$path && $repo_path !~ /No entry for/i) { 
+            $repo_path =~ s{Attic/?}{}i;
+            $repo_path =~ s{,v\s*$}{}i;
+            $repo_path =~ s{^$root_path/}{};
+            
+            $path = $repo_path;
         }
+
+        warn "Failed to get a path from the CVS status entry containing:\n$_"
+            unless $path;
+        warn "Found a path in the CVS output we didn't ask for: '$path'" 
+            unless exists $expected_paths{$path};
+                
+        $cvsstat{$path} = $status;
+        $path = $repo_path = $status = undef; 
     }
 }
 
@@ -331,7 +385,8 @@
 	@output = (<$child>);
 	close $child or die join(' ',@_).": $! $?";
     } else {
-	exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
+        open STDERR, ">&STDOUT" or warn "child can't dup STDERR";;
+        exec(@_) or die "$! $?"; # exec() can fail the executable can't be found
     }
     return wantarray ? @output : join('',@output);
 }

--------------010308050503050807060400--
