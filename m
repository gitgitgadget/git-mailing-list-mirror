From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 11:34:13 -0700
Message-ID: <7v7irwjql6.fsf@assigned-by-dhcp.cox.net>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
	<7virbgjthr.fsf@assigned-by-dhcp.cox.net>
	<m2odl8fjv1.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 20:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhrkT-0008SE-Ki
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 20:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163502AbXD1SeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 14:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163503AbXD1SeQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 14:34:16 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50112 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163502AbXD1SeO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 14:34:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428183414.IGCC1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Apr 2007 14:34:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id siaD1W00D1kojtg0000000; Sat, 28 Apr 2007 14:34:13 -0400
In-Reply-To: <m2odl8fjv1.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sat,
	28 Apr 2007 11:13:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45792>

Seth Falcon <sethfalcon@gmail.com> writes:

> On OS X, I get:
>
>     ziti:~/temp seth$ ./perltest1.pl 
>     read[5]: link 
>     child says: child: at 5

Ah, so the previous read($fh, $buf, 5) lets stdio absorb the
whole (short) input, and the underlying seek pointer is not
adjusted back across fork, and the child does not have anything
to read.

> And uncommenting the sysseek call, I get:
>
>     ziti:~/temp seth$ ./perltest1.pl 
>     read[5]: link 
>     child says: child: at 5
>     child says: >>12345

Then I suspect the following could be less invasive and more
efficient fix for the problem.  I do not have an access to MacOS
box, and I do not have a working sync with any SVN repository,
so I cannot test it myself, though...

diff --git a/git-svn.perl b/git-svn.perl
index 7b5f8ab..e487da6 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2454,6 +2454,7 @@ sub close_file {
 		}
 		defined(my $pid = open my $out,'-|') or die "Can't fork: $!\n";
 		if (!$pid) {
+			sysseek($fh, 5, 0);
 			open STDIN, '<&', $fh or croak $!;
 			exec qw/git-hash-object -w --stdin/ or croak $!;
 		}
