X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set permissions of each new file before "cvs add"ing it.
Date: Sun, 03 Dec 2006 18:47:26 -0800
Message-ID: <7v64cstm0x.fsf@assigned-by-dhcp.cox.net>
References: <87ac24zrk0.fsf@rho.meyering.net>
	<7vbqmktmb7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 02:47:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqmktmb7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 03 Dec 2006 18:41:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33162>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr3rp-0007UP-Mm for gcvg-git@gmane.org; Mon, 04 Dec
 2006 03:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759018AbWLDCr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 21:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759019AbWLDCr2
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 21:47:28 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44479 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1759013AbWLDCr1
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 21:47:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204024727.NYKM20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Sun, 3
 Dec 2006 21:47:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uSnc1V00T1kojtg0000000; Sun, 03 Dec 2006
 21:47:36 -0500
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Jim Meyering <jim@meyering.net> writes:
>
>> Without the following patch, git-cvsexportcommit would fail to propagate
>> permissions of files added in git to the CVS repository...
> ...
> Why sed in a Perl script ;-)?

That is,...

-- >8 --

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 7bac16e..7f70501 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -116,6 +116,7 @@ if ($opt_a) {
 close MSG;
 
 my (@afiles, @dfiles, @mfiles, @dirs);
+my (%amodes);
 my @files = safe_pipe_capture('git-diff-tree', '-r', $parent, $commit);
 #print @files;
 $? && die "Error in git-diff-tree";
@@ -124,6 +125,7 @@ foreach my $f (@files) {
     my @fields = split(m!\s+!, $f);
     if ($fields[4] eq 'A') {
         my $path = $fields[5];
+	$amodes[$path] = $fields[1];
 	push @afiles, $path;
         # add any needed parent directories
 	$path = dirname $path;
@@ -268,6 +270,7 @@ if (($? >> 8) == 2) {
 }
 
 foreach my $f (@afiles) {
+    set_new_file_permissions($f, $amodes[$f]);
     if (grep { $_ eq $f } @bfiles) {
       system('cvs', 'add','-kb',$f);
     } else {
@@ -342,3 +345,13 @@ sub safe_pipe_capture {
     }
     return wantarray ? @output : join('',@output);
 }
+
+# For any file we want to add to cvs, we must first set its permissions
+# properly, *before* the "cvs add ..." command.  Otherwise, it is impossible
+# to change the permission of the file in the CVS repository using only cvs
+# commands.  This should be fixed in cvs-1.12.14.
+sub set_new_file_permissions {
+    my ($file, $perm) = @_;
+    chmod oct($perm), $file
+      or die "failed to set permissions of \"$file\": $!\n";
+}
