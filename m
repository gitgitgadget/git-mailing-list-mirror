From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Skip t3403 selftests if stdin is not a terminal
Date: Fri, 15 Sep 2006 23:19:02 -0700
Message-ID: <7v3base3l5.fsf@assigned-by-dhcp.cox.net>
References: <20060915125910.10514.qmail@26499ea44f2ee3.315fe32.mid.smarden.org>
	<7vk644e5f5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Sat Sep 16 08:19:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOTWr-0007Yq-IJ
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 08:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWIPGTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 02:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWIPGTG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 02:19:06 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32137 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932199AbWIPGTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 02:19:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916061903.DUZL26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 02:19:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NuK41V0071kojtg0000000
	Sat, 16 Sep 2006 02:19:04 -0400
To: Gerrit Pape <pape@smarden.org>
In-Reply-To: <7vk644e5f5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 15 Sep 2006 22:39:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27111>

Junio C Hamano <junkio@cox.net> writes:

> Gerrit Pape <pape@smarden.org> writes:
>
>> sh t3403-rebase-skip.sh </dev/null fails because stdin is not connected
>> to a terminal, as in the Debian autobuild environment.  This disbales
>> the test 3 and 7 in this case.
>
> Disabling these tests somehow feels as if you are shooting the
> messenger who reports breakage of the commands they try to test.
>
> Is it expected that the git Porcelainish commands involved in
> these particular tests not to work without terminal?  If not
> maybe we should fix them, not the test.

How about this instead?

-- >8 --
Fix git-am safety checks

An earlier commit cbd64af added a check that prevents "git-am"
to run without its standard input connected to a terminal while
resuming operation.  This was to catch a user error to try
feeding a new patch from its standard input while recovery.

The assumption of the check was that it is an indication that a
new patch is being fed if the standard input is not connected to
a terminal.  It is however not quite correct (the standard input
can be /dev/null if the user knows the operation does not need
any input, for example).  This broke t3403 when the test was run
with its standard input connected to /dev/null.

When git-am is given an explicit command such as --skip, there
is no reason to insist that the standard input is a terminal; we
are not going to read a new patch anyway.

Credit goes to Gerrit Pape for noticing and reporting the
problem with t3403-rebase-skip test.

---
diff --git a/git-am.sh b/git-am.sh
index d0af786..66a8e3d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -166,10 +166,25 @@ fi
 
 if test -d "$dotest"
 then
-	if test ",$#," != ",0," || ! tty -s
-	then
-		die "previous dotest directory $dotest still exists but mbox given."
-	fi
+	case "$#,$skip$resolved" in    
+	0,*t*)
+		# Explicit resume command and we do not have file, so
+		# we are happy.
+		: ;;
+	0,)
+		# No file input but without resume parameters; catch
+		# user error to feed us a patch from standard input
+		# when there is already .dotest.  This is somewhat
+		# unreliable -- stdin could be /dev/null for example
+		# and the caller did not intend to feed us a patch but
+		# wanted to continue unattended.
+		tty -s
+		;;
+	*)
+		false
+		;;
+	esac ||
+	die "previous dotest directory $dotest still exists but mbox given."
 	resume=yes
 else
 	# Make sure we are not given --skip nor --resolved
