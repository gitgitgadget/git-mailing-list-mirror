From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb on kernel.org broken
Date: Mon, 16 Jan 2006 12:02:05 -0800
Message-ID: <7vwth0rlfm.fsf@assigned-by-dhcp.cox.net>
References: <43CBE993.9060701@zytor.com> <20060116185342.GA14088@vrfy.org>
	<20060116190556.GA14184@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	gregkh@kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 21:02:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyaYc-0001zr-R7
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 21:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWAPUCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWAPUCI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 15:02:08 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7328 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751161AbWAPUCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 15:02:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116200212.EIZY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 15:02:12 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14757>

Kay Sievers <kay.sievers@vrfy.org> writes:

>> Junio, seems your "textual symref HEAD" change is causing this?

Yeah, I assumed git_read_head() is called only on a repository
that was verified to be valid, and the subroutine did not check
the case where HEAD does not verify.  My bad.  The attached
patch should solve this.

The error log says hotplug-ng.git is triggering it.  I wonder what
is so special about that repository.  I hope it is transient
during mirroring that mirrored HEAD before objects, not a
corrupt repository at the mirroring source.

	... goes to kernel.org mirroring source machine ...

Ugh.  It is _not_ a valid git repository.  HEAD should be either a symlink
or a symref pointing somewhere under refs/heads/, but in that
directory, it instead is a regular file that contains an object
name.  There is nothing under refs/ either:

        $ ls -l /pub/scm/linux/hotplug/hotplug-ng.git/HEAD
        -rw-r--r--  2 gregkh users 41 May  6  2005 /pub/s...ug-ng.git/HEAD
	$ cat /pub/scm/linux/hotplug/hotplug-ng.git/HEAD
        b26bec9f620a969fe5238e8666ab698f197df488
	$ ls -l /pub/scm/linux/hotplug/hotplug-ng.git/refs
	total 0
	$ exit

Greg, could you let me know what is going on with this
repository, please?

First of all, I am wondering if this repository is still used
(maintained); a regular file HEAD that contains an object name
would have stopped working on Aug 27 2005 with this commit at the
latest, maybe even before that:

    diff-tree 5f5608b... (from 9740d28...
    Author: Linus Torvalds <torvalds@osdl.org>
    Date:   Sat Aug 27 13:54:42 2005 -0700

    [PATCH] Make .git directory validation code test HEAD

    Inspired by a report by Kalle Valo, this changes git-sh-setup-script and
    the "setup_git_directory()" function to test that $GIT_DIR/HEAD is a
    symlink, since a number of core git features depend on that these days.
    ...

The way I expected to see that part of the directory laid out in
a valid git repository would be:

	$ cd /pub/scm/linux/hotplug/hotplug-ng.git/
	$ mkdir -p refs/heads
	$ cat HEAD >refs/heads/master
	$ rm -f HEAD
	$ ln -s refs/heads/master HEAD

Anyhow, here is a gitweb patch to skip this.

---
diff --git a/gitweb.cgi b/gitweb.cgi
index 986d7da..f3853e7 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -404,9 +404,8 @@ sub git_read_head {
 	if (open my $fd, "-|", "$gitbin/git-rev-parse", "--verify", "HEAD") {
 		my $head = <$fd>;
 		close $fd;
-		chomp $head;
-		if ($head =~ m/^[0-9a-fA-F]{40}$/) {
-			$retval = $head;
+		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
+			$retval = $1;
 		}
 	}
 	$ENV{'GIT_DIR'} = $oENV;
