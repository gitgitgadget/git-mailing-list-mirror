From: Junio C Hamano <junkio@cox.net>
Subject: Re: git+ssh://master.kernel.org/home/rmk/linux-2.6-arm.git
Date: Tue, 01 Aug 2006 01:46:03 -0700
Message-ID: <7v4pww3ktw.fsf@assigned-by-dhcp.cox.net>
References: <20060801001958.67a071b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Aug 01 10:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7ptE-00081U-6b
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 10:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWHAIqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 04:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWHAIqG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 04:46:06 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:13040 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750864AbWHAIqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 04:46:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801084604.PFSX554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 04:46:04 -0400
To: git@vger.kernel.org
In-Reply-To: <20060801001958.67a071b2.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 1 Aug 2006 00:19:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24582>

Andrew Morton <akpm@osdl.org> writes:

> 
> fyi, a git-fetch of this tree gives:
>
> error: refs/heads/devel does not point to a valid commit object!
> error: refs/heads/devel does not point to a valid commit object!
>
> Junio, I'm running git-core-1.4.0-1.fc5 - perhaps more recent gits are
> better at telling the user if the error is remote or local.  If not: whine ;)

I'd try this out and see what people think.

-- >8 --
[PATCH] fetch/clone: mark messages from remote side stand out.

When dealing with a corrupt or out of sync remote repository,
the user often gets error messages like this:

	error: refs/heads/devel does not point to a valid commit object!

which leaves the user wondering if the breakage is on the local
end or on the remote end.  This is unnecessarily alarming.

This patch changes the way we display messages received from the
remote side over the git protocol sideband (i.e. stderr stream
of the remote process).  It shows them with blue background with
white letters, but this presentation is subject to proposals of
better ways from the list.

The problem was pointed out by Andrew Morton.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 fetch-clone.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fetch-clone.c b/fetch-clone.c
index 81d1371..692d9b7 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -133,7 +133,10 @@ static pid_t setup_sideband(int sideband
 				fprintf(stderr, "\n");
 				exit(1);
 			case 2:
+				/* color sideband */
+				safe_write(2, "\033[44;37;1m", 10);
 				safe_write(2, buf+1, len);
+				safe_write(2, "\033[m", 3);
 				continue;
 			case 1:
 				safe_write(fd[1], buf+1, len);
-- 
1.4.2.rc2.gb9f77
