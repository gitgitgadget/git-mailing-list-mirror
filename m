X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rework cvsexportcommit to handle binary files for all cases.
Date: Mon, 13 Nov 2006 16:47:27 -0800
Message-ID: <7vveli4zxc.fsf@assigned-by-dhcp.cox.net>
References: <200611121629.43104.robin.rosenberg@dewire.com>
	<7vmz6wark9.fsf@assigned-by-dhcp.cox.net>
	<200611132139.25342.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 00:47:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31330>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjmSg-0001l8-PQ for gcvg-git@gmane.org; Tue, 14 Nov
 2006 01:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933282AbWKNAr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 19:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933283AbWKNAr3
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 19:47:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53187 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S933282AbWKNAr2
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 19:47:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114004728.OQGX18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 19:47:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id mQn21V0031kojtg0000000; Mon, 13 Nov 2006
 19:47:02 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> It would also be nice to rework this program so that it can work
>> with whitespaces in pathnames.  I do not think it currently
>> works with them at all.
>
> I sent a patch earlier, which was not applied, due to imperfections that I 
> cannot solve fully. One issue was that patch 2.5.9 was required and hacking 
> it to handle binary diffs with spaces would require and even worse kludge,

I suspect that we should not be using patch, but instead be
using git-apply perhaps with -C option if people want fuzz.

>> It appears that this program was never used in western
>> hemisphere, by the way ;-).
>
> Now, Sweden is definitely in the northern hemisphere, even during the cold 
> war, though a number of computer games colored it red (or was it only 
> Finland) during the cold war.

I know this script originally came from southern hemisphere, but
I was talking about _western_ hemisphere.  The comment refers to
the part of the code the attached patch fixes, which I will
apply along with your updated patch.

> The tests work with my locale (swedish ISO-8859-15),  even though they like 
> all other tests run in the C "hemishpere" by default. AFAIK, git isn't very 
> user friendly with non-ascii filenames as it is today and cvsexportcommit 
> didn't work on such files before, and it doesn't now. No change there. 

That is a separate issue.  I think scripts that work with git
plumbing should read from -z output when they need to and are
capable of, as we have done for git-cvsserver recently, and
things written in Perl certainly are capable of doing so.

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index facb466..b1cc014 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
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
