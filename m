From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-cvsserver: detect/diagnose write failure, etc.
Date: Sat, 14 Jul 2007 20:48:42 +0200
Message-ID: <87abtyn7n9.fsf@rho.meyering.net>
References: <87vecx4tel.fsf@rho.meyering.net>
	<7v1wfe38xp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:48:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9mfl-0002zx-B6
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759480AbXGNSsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759466AbXGNSsu
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:48:50 -0400
Received: from server1.f7.net ([64.34.169.74]:52132 "EHLO f7.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbXGNSst (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:48:49 -0400
X-Envelope-From: jim@meyering.net
Received: from mx.meyering.net (server1.f7.net [64.34.169.74])
	by f7.net (8.11.7-20030920/8.11.7) with ESMTP id l6EImhF16782;
	Sat, 14 Jul 2007 13:48:43 -0500
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C463935AFC; Sat, 14 Jul 2007 20:48:42 +0200 (CEST)
In-Reply-To: <7v1wfe38xp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed\, 11 Jul 2007 14\:52\:02 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52494>

Junio C Hamano <gitster@pobox.com> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Beware: in some contexts (when running as server), one must
>> not "die", but rather return an "error" indicator to the client.
>> I did that in the second hunk.  However, I haven't carefully
>> audited the others, and so, some of the "die" calls I added may
>> end up killing the server, when a gentler failure is required.
>>
>> I've just looked, and can confirm that my change to req_Modified
>> (first hunk) is wrong.  It should not die.  Rather, it should probably
>> do something like the "print "E ... in hunk#2.  Ideally, someone
>> would write a test to exercise code like this, to make sure it works.
>>
>> Jim
>
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index 5cbf27e..8d8d6f5 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -644,7 +644,7 @@ sub req_Modified
>>          $bytesleft -= $blocksize;
>>      }
>>
>> -    close $fh;
>> +    close $fh or die "Failed to write temporary, $filename: $!";
>
> True; dying is not appropriate here.
...

Hi Jun,

Thanks for the feedback.
Since no one else stepped forward, I've gone ahead and addressed the
problems -- though I haven't tested any of these server-side diagnostics.
I've added two new checks in req_Modified, to better diagnose an
incomplete request.  Also, I converted each of the "die" stmts in
req_annotate to print "E..." + return.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git-cvsserver.perl |   50 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 10aba50..ae7d511 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -623,8 +623,12 @@ sub req_Modified
     my ( $cmd, $data ) = @_;
 
     my $mode = <STDIN>;
+    defined $mode
+        or (print "E end of file reading mode for $data\n"), return;
     chomp $mode;
     my $size = <STDIN>;
+    defined $size
+        or (print "E end of file reading size of $data\n"), return;
     chomp $size;
 
     # Grab config information
@@ -644,7 +648,8 @@ sub req_Modified
         $bytesleft -= $blocksize;
     }
 
-    close $fh;
+    close $fh
+        or (print "E failed to write temporary, $filename: $!\n"), return;
 
     # Ensure we have something sensible for the file mode
     if ( $mode =~ /u=(\w+)/ )
@@ -901,8 +906,13 @@ sub req_update
     # projects (heads in this case) to checkout.
     #
     if ($state->{module} eq '') {
+	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
+	if (!opendir HEADS, $heads_dir) {
+	    print "E [server aborted]: Failed to open directory, "
+	      . "$heads_dir: $!\nerror\n";
+	    return 0;
+	}
         print "E cvs update: Updating .\n";
-	opendir HEADS, $state->{CVSROOT} . '/refs/heads';
 	while (my $head = readdir(HEADS)) {
 	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
 	        print "E cvs update: New directory `$head'\n";
@@ -1737,14 +1747,16 @@ sub req_annotate
 	system("git-read-tree", $lastseenin);
 	unless ($? == 0)
 	{
-	    die "Error running git-read-tree $lastseenin $file_index $!";
+	    print "E error running git-read-tree $lastseenin $file_index $!\n";
+	    return;
 	}
 	$log->info("Created index '$file_index' with commit $lastseenin - exit status $?");
 
         # do a checkout of the file
         system('git-checkout-index', '-f', '-u', $filename);
         unless ($? == 0) {
-            die "Error running git-checkout-index -f -u $filename : $!";
+            print "E error running git-checkout-index -f -u $filename : $!\n";
+            return;
         }
 
         $log->info("Annotate $filename");
@@ -1754,7 +1766,11 @@ sub req_annotate
         # git-jsannotate telling us about commits we are hiding
         # from the client.
 
-        open(ANNOTATEHINTS, ">$tmpdir/.annotate_hints") or die "Error opening > $tmpdir/.annotate_hints $!";
+        my $a_hints = "$tmpdir/.annotate_hints";
+        if (!open(ANNOTATEHINTS, '>', $a_hints)) {
+            print "E failed to open '$a_hints' for writing: $!\n";
+            return;
+        }
         for (my $i=0; $i < @$revisions; $i++)
         {
             print ANNOTATEHINTS $revisions->[$i][2];
@@ -1765,11 +1781,14 @@ sub req_annotate
         }
 
         print ANNOTATEHINTS "\n";
-        close ANNOTATEHINTS;
+        close ANNOTATEHINTS
+            or (print "E failed to write $a_hints: $!\n"), return;
 
-        my $annotatecmd = 'git-annotate';
-        open(ANNOTATE, "-|", $annotatecmd, '-l', '-S', "$tmpdir/.annotate_hints", $filename)
-	    or die "Error invoking $annotatecmd -l -S $tmpdir/.annotate_hints $filename : $!";
+        my @cmd = (qw(git-annotate -l -S), $a_hints, $filename);
+        if (!open(ANNOTATE, "-|", @cmd)) {
+            print "E error invoking ". join(' ',@cmd) .": $!\n";
+            return;
+        }
         my $metadata = {};
         print "E Annotations for $filename\n";
         print "E ***************\n";
@@ -1996,12 +2015,12 @@ sub transmitfile
         {
             open NEWFILE, ">", $targetfile or die("Couldn't open '$targetfile' for writing : $!");
             print NEWFILE $_ while ( <$fh> );
-            close NEWFILE;
+            close NEWFILE or die("Failed to write '$targetfile': $!");
         } else {
             print "$size\n";
             print while ( <$fh> );
         }
-        close $fh or die ("Couldn't close filehandle for transmitfile()");
+        close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
     } else {
         die("Couldn't execute git-cat-file");
     }
@@ -2501,17 +2520,14 @@ sub update
                     if ($parent eq $lastpicked) {
                         next;
                     }
-                    open my $p, 'git-merge-base '. $lastpicked . ' '
-                    . $parent . '|';
-                    my @output = (<$p>);
-                    close $p;
-                    my $base = join('', @output);
+                    my $base = safe_pipe_capture('git-merge-base',
+						 $lastpicked, $parent);
                     chomp $base;
                     if ($base) {
                         my @merged;
                         # print "want to log between  $base $parent \n";
                         open(GITLOG, '-|', 'git-log', "$base..$parent")
-                        or die "Cannot call git-log: $!";
+			  or die "Cannot call git-log: $!";
                         my $mergedhash;
                         while (<GITLOG>) {
                             chomp;
-- 
1.5.3.rc1.5.g9d947
