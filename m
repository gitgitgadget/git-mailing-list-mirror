From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: using quotemeta
Date: Mon, 02 Oct 2006 23:30:55 -0700
Message-ID: <7vven1syg0.fsf@assigned-by-dhcp.cox.net>
References: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
	<200610022250.32029.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 08:31:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUdnw-0003ox-6i
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 08:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWJCGa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 02:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWJCGa5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 02:30:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49886 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750960AbWJCGa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 02:30:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003063055.XLLF12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 02:30:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ViWx1V00a1kojtg0000000
	Tue, 03 Oct 2006 02:30:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610022250.32029.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 2 Oct 2006 22:50:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28247>

Jakub Narebski <jnareb@gmail.com> writes:

> But you forget that in HTTP headers, to be more exact in
> 	Content-Disposition: inline; filename="<filename>"
> header, the quote '"' and end-of-line '\n' characters in <filename>
> are treated specially. So you need to quote somehow at least those
> two characters.

True, but untrue.  This is just a suggestion so we do not _have_
to quote.  We only need to avoid spitting out dq and lf
literally.  We could even just do something like the attached if
we wanted to:

	s/[^ -~]+/?/g	;# replace each sequence of bytes outside
        		 # ' ' to '~' range to a '?'

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 44991b1..e7202ee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2651,7 +2651,7 @@ sub git_blob_plain {
 	# save as filename, even when no $file_name is given
 	my $save_as = "$hash";
 	if (defined $file_name) {
-		$save_as = $file_name;
+		($save_as = $file_name) =~ s/[^ -~]+/?/g;
 	} elsif ($type =~ m/^text\//) {
 		$save_as .= '.txt';
 	}
@@ -2830,6 +2830,7 @@ sub git_snapshot {
 	}
 
 	my $filename = basename($project) . "-$hash.tar.$suffix";
+	$filename =~ s/[^ -~]+/?/g;
 
 	print $cgi->header(
 		-type => 'application/x-tar',
@@ -3139,6 +3140,7 @@ sub git_blobdiff {
 		}
 
 	} elsif ($format eq 'plain') {
+		$file_name =~ s/[^ -~]+/?/g;
 		print $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
@@ -3241,6 +3243,7 @@ sub git_commitdiff {
 		my $refs = git_get_references("tags");
 		my $tagname = git_get_rev_name_tags($hash);
 		my $filename = basename($project) . "-$hash.patch";
+		$filename =~ s/[^ -~]+/?/g;
 
 		print $cgi->header(
 			-type => 'text/plain',
