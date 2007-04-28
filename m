From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sat, 28 Apr 2007 10:31:28 -0700
Message-ID: <7virbgjthr.fsf@assigned-by-dhcp.cox.net>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
	<m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
	<alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
	<loom.20070428T144858-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Klink <ak-git@cynops.de>
X-From: git-owner@vger.kernel.org Sat Apr 28 19:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhqlj-0000eN-EQ
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 19:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030765AbXD1Rbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031579AbXD1Rbb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 13:31:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59050 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030765AbXD1Rb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 13:31:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428173130.GUJM13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Apr 2007 13:31:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id shXU1W00h1kojtg0000000; Sat, 28 Apr 2007 13:31:29 -0400
In-Reply-To: <loom.20070428T144858-521@post.gmane.org> (Alexander Klink's
	message of "Sat, 28 Apr 2007 13:02:01 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45788>

Is it really the redirection that is the problem?

The process seeks $fh back to the beginning, reads 5 bytes from
it (to ensure that is 'link '), and then forks to feed $fh to
git-hash-object.

Now what do you really want to hash here?  I do not know what
this "file that begins with 'link '" magic is about, but I
suspect that the child may or may not start reading from byte
offset 5 of that file, depending on how the low-level I/O is
tied to Perl.

Here is a little test script to imitate what the part in
close_file sub is doing.  What does it output on MacOS (or
whatever systems that are having the same problem)?

On a Linux box, it appears that it reads the remainder of the
file and the test script says "child says: >>12345", so I am
assuming that is what close_file sub wants to do.  If my
suspicion is correct, you would get "child says: >>link 12345",
in which case sysseek() commented out below would help,
perhaps.

-- >8 --
#!/usr/bin/perl -w

open F, ">footest";
print F "link 12345\n";
close F;

my ($fh, $buf, $n, $pid, $out);

open $fh, "<footest";
seek($fh, 0, 0);
$n = read($fh, $buf, 5);
print "read[$n]: $buf\n";

$pid = open $out , '-|';
if (!$pid) {
	my $at = tell $fh;
	print "child: at $at\n";

	# We may want to do
        #
	#	 sysseek($fh, 5, 0);
        #
        # here.

	open STDIN, '<&', $fh;
	exec qw(sed -e s/^/>>/);
}
while (my $read = <$out>) {
	print "child says: $read";
}
close ($out);
close ($fh);
