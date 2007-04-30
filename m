From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 22:08:26 -0700
Message-ID: <7vmz0qcuut.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
	<7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
	<m2k5vwfbf6.fsf@ziti.fhcrc.org>
	<7vwszwi0h2.fsf@assigned-by-dhcp.cox.net>
	<20070429183136.GE12375@untitled>
	<7vr6q2dhex.fsf@assigned-by-dhcp.cox.net>
	<20070429222136.GA1800@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 07:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiO7j-00020d-O0
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 07:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423018AbXD3FI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 01:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423019AbXD3FI2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 01:08:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58390 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423018AbXD3FI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 01:08:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430050828.FLPL1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 01:08:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tH8S1W00C1kojtg0000000; Mon, 30 Apr 2007 01:08:27 -0400
In-Reply-To: <20070429222136.GA1800@untitled> (Eric Wong's message of "Sun, 29
	Apr 2007 15:21:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45853>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 4be8576..cef6697 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -2464,15 +2464,15 @@ sub close_file {
>>  	my $hash;
>>  	my $path = $self->git_path($fb->{path});
>>  	if (my $fh = $fb->{fh}) {
>> -		seek($fh, 0, 0) or croak $!;
>> +		sysseek($fh, 0, 0) or croak $!;
>>  		my $md5 = Digest::MD5->new;
>>  		$md5->addfile($fh);
>
> We may want to keep the plain seek() here and do both seek and sysseek,
> I'm not sure if $md5->addfile() uses read or sysread internally.

Ok.  The seek before Digest::MD5 can stay as it has been that
way for a long time without causing problems.  How about this as
an replacement then?

-- >8 --
[PATCH] Fix symlink handling in git-svn, related to PerlIO

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
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4be8576..6f509f8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2470,9 +2470,9 @@ sub close_file {
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
-- 
1.5.2.rc0.781.g5868
