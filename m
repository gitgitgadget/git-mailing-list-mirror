From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git stash" is not known to git
Date: Tue, 31 Jul 2007 01:20:54 -0700
Message-ID: <7vps29f0gp.fsf@assigned-by-dhcp.cox.net>
References: <86bqduutz4.fsf@lola.quinscape.zz>
	<vpqwswi2pkw.fsf@bauges.imag.fr>
	<20070730100408.GA8829@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:21:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFmyU-0000yQ-Pt
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 10:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbXGaIU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 04:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXGaIU5
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 04:20:57 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33782 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXGaIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 04:20:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731082055.UISH23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 04:20:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W8Lu1X00L1kojtg0000000; Tue, 31 Jul 2007 04:20:55 -0400
In-Reply-To: <20070730100408.GA8829@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 30 Jul 2007 06:04:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54327>

Jeff King <peff@peff.net> writes:

> We never actually look in the regular PATH since we call execv_git_cmd
> (although we do still munge the PATH, apparently so shell scripts can
> use git-foo syntax; see 77cb17e9). This means you can't drop "git-foo"
> into your PATH and have it work as "git foo".

Would this be a good replacement?

diff --git a/git.c b/git.c
index 2433355..25b8274 100644
--- a/git.c
+++ b/git.c
@@ -448,11 +448,11 @@ int main(int argc, const char **argv)
 	cmd = argv[0];
 
 	/*
-	 * We search for git commands in the following order:
-	 *  - git_exec_path()
-	 *  - the path of the "git" command if we could find it
-	 *    in $0
-	 *  - the regular PATH.
+	 * We execute external git command via execv_git_cmd(),
+	 * which looks at "--exec-path" option, GIT_EXEC_PATH
+	 * environment, and $(gitexecdir) in Makefile while built,
+	 * in this order.  For scripted commands, we prepend
+	 * the value of the exec_path variable to the PATH.
 	 */
 	if (exec_path)
 		prepend_to_path(exec_path, strlen(exec_path));
