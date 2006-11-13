X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Sun, 12 Nov 2006 20:39:18 -0800
Message-ID: <7vmz6wark9.fsf@assigned-by-dhcp.cox.net>
References: <200611121629.43104.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 04:39:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611121629.43104.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sun, 12 Nov 2006 16:29:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31287>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjTbP-0004i9-4M for gcvg-git@gmane.org; Mon, 13 Nov
 2006 05:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753882AbWKMEjU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 23:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbWKMEjU
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 23:39:20 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39821 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1753882AbWKMEjT
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 23:39:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113043919.TRGF7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 23:39:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id m4et1V0011kojtg0000000; Sun, 12 Nov 2006
 23:38:53 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Now adding, removing and changing binary files works. I added
> test cases to make sure qit works and can be verified by
> others. Som other corner cases were resolved too.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

Thanks.

It is necessary to clarify what these other corner cases are in
the commit log message.  Three months down the road you yourself
would not remember what they were.

You seem to like:

	my $p = "m,^$pathname\$,";
        if (grep $p,@array) { do this... }

but this is a bad habit.  $pathname can contain regexp
metacharacters or a comma.  You should just say:

	if (grep { $_ eq $pathname } @arrray) { do this... }

instead.  I'd fix them up with the attached patch.

It would also be nice to rework this program so that it can work
with whitespaces in pathnames.  I do not think it currently
works with them at all.

It appears that this program was never used in western
hemisphere, by the way ;-).

---

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 78c847e..b1cc014 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,10 +1,10 @@
 #!/usr/bin/perl -w
 
 # Known limitations:
-# - cannot add or remove binary files
 # - does not propagate permissions
 # - tells "ready for commit" even when things could not be completed
 #   (eg addition of a binary file)
+# - does not handle whitespace in pathnames at all.
 
 use strict;
 use Getopt::Std;
@@ -68,9 +68,9 @@ foreach my $line (@commit) {
     if ($stage eq 'headers') {
 	if ($line =~ m/^parent (\w{40})$/) { # found a parent
 	    push @parents, $1;
-	} elsif ($line =~ m/^author (.+) \d+ \+\d+$/) {
+	} elsif ($line =~ m/^author (.+) \d+ [-+]\d+$/) {
 	    $author = $1;
-	} elsif ($line =~ m/^committer (.+) \d+ \+\d+$/) {
+	} elsif ($line =~ m/^committer (.+) \d+ [-+]\d+$/) {
 	    $committer = $1;
 	}
     } else {
@@ -165,8 +165,8 @@ foreach my $d (@dirs) {
 foreach my $f (@afiles) {
     # This should return only one value
     if ($f =~ m,(.*)/[^/]*$,) {
-        my $p="m,^".$1."\$,";
-	next if grep $p,@dirs;
+	my $p = $1;
+	next if (grep { $_ eq $p } @dirs);
     }
     my @status = grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'status' ,$f));
     if (@status > 1) { warn 'Strange! cvs status returned more than one line?'};
@@ -219,8 +219,7 @@ print "'Patching' binary files\n";
 foreach my $f (@bfiles) {
     # check that the file in cvs matches the "old" file
     # extract the file to $tmpdir and compare with cmp
-    my $p="m/^$f$/";
-    if (not(grep $p,@afiles)) {
+    if (not(grep { $_ eq $f } @afiles)) {
         my $tree = safe_pipe_capture('git-rev-parse', "$parent^{tree}");
 	chomp $tree;
 	my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
@@ -234,7 +233,7 @@ foreach my $f (@bfiles) {
 	    }
         }
     }
-    if (not(grep m/^$f$/,@dfiles)) {
+    if (not(grep { $_ eq $f } @dfiles)) {
 	my $tree = safe_pipe_capture('git-rev-parse', "$commit^{tree}");
 	chomp $tree;
 	my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
@@ -256,7 +255,7 @@ my $fuzz = $opt_p ? 0 : 2;
 
 print "Patching non-binary files\n";
 
-if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) ne scalar(@bfiles)) {
+if (scalar(@afiles)+scalar(@dfiles)+scalar(@mfiles) != scalar(@bfiles)) {
     print `(git-diff-tree -p $parent -p $commit | patch -p1 -F $fuzz ) 2>&1`;
 }
 
@@ -269,7 +268,7 @@ if (($? >> 8) == 2) {
 }
 
 foreach my $f (@afiles) {
-    if (grep /^$f$/,@bfiles) {
+    if (grep { $_ eq $f } @bfiles) {
       system('cvs', 'add','-kb',$f);
     } else {
       system('cvs', 'add', $f);


