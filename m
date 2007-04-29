From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 14:01:10 -0700
Message-ID: <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net>
References: <20070414201003.GA28389@muzzle> <m2slb1c8ps.fsf@fhcrc.org>
	<loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
	<7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
	<20070429183136.GE12375@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 23:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiGWh-0007DL-EL
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 23:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbXD2VBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbXD2VBP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 17:01:15 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45934 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161227AbXD2VBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 17:01:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429210111.YZAR1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Apr 2007 17:01:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id t91A1W00E1kojtg0000000; Sun, 29 Apr 2007 17:01:11 -0400
In-Reply-To: <20070429183136.GE12375@untitled> (Eric Wong's message of "Sun,
	29 Apr 2007 11:31:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45839>

Eric Wong <normalperson@yhbt.net> writes:

> Alexander: please don't drop me from the Cc next time, thanks.
>
> Junio C Hamano <junkio@cox.net> wrote:
>> Seth Falcon <sethfalcon@gmail.com> writes:
>> > Junio C Hamano <junkio@cox.net> writes:
>> > ...
>> >> Then I suspect the following could be less invasive and more
>> >> efficient fix for the problem.  I do not have an access to MacOS
>> >> box, and I do not have a working sync with any SVN repository,
>> >> so I cannot test it myself, though...
>> ...
>> 
>> Well, I think the sysseek should be done only when we did read
>> 'link ' from the beginning and not in other cases, so in that
>> sense my patch is very broken.  Probably the sysseek() needs to
>> be done inside the "if ($fb->mode_b} == 120000)" part, after it
>> checks for 'link '.
>
> Yes, don't add the new sysseek there.  All the reads and seeks in that
> block of code should probably be sysreads and sysseeks instead.  Feel
> free to patch and test this as I don't have time at the moment.

Ok.  As I do not have an access to a working sync with an SVN
repository nor a Mac OS box, I cannot test this, but something
like this should be applied to 'maint' before v1.5.1.3.  I've
run testsuite we have including t9XXX series, but that is the
only test I did.

Testing, acks and feedback are very much appreciated.

-- >8 --
Fix symlink handling in git-svn, related to PerlIO

After reading the leading contents from a symlink data obtained
from subversion, which we expect to begin with 'link ', the code
forked to hash the remainder (which should match readlink()
result) using git-hash-objects, by redirecting its STDIN from
the filehandle we read that 'link ' from.  This was Ok with Perl
on modern Linux, but on Mac OS, the read in the parent process
slurped more than we asked for in stdio buffer, and the child
did not correctly see the "remainder".

This attempts to fix the issue by using lower level sysseek and
sysread instead of seek and read to bypass the stdio buffer.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4be8576..cef6697 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2464,15 +2464,15 @@ sub close_file {
 	my $hash;
 	my $path = $self->git_path($fb->{path});
 	if (my $fh = $fb->{fh}) {
-		seek($fh, 0, 0) or croak $!;
+		sysseek($fh, 0, 0) or croak $!;
 		my $md5 = Digest::MD5->new;
 		$md5->addfile($fh);
 		my $got = $md5->hexdigest;
 		die "Checksum mismatch: $path\n",
 		    "expected: $exp\n    got: $got\n" if ($got ne $exp);
-		seek($fh, 0, 0) or croak $!;
+		sysseek($fh, 0, 0) or croak $!;
 		if ($fb->{mode_b} == 120000) {
-			read($fh, my $buf, 5) == 5 or croak $!;
+			sysread($fh, my $buf, 5) == 5 or croak $!;
 			$buf eq 'link ' or die "$path has mode 120000",
 			                       "but is not a link\n";
 		}
