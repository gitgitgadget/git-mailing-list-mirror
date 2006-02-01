From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bottlenecks in git merge
Date: Tue, 31 Jan 2006 16:43:51 -0800
Message-ID: <7vvevzoqm0.fsf@assigned-by-dhcp.cox.net>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
	<7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net>
	<20060131233504.GB31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 01:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F466G-0004ED-Ez
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 01:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBAAny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 19:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBAAny
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 19:43:54 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50082 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932367AbWBAAnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 19:43:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201004139.IJQM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 19:41:39 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060131233504.GB31278@pasky.or.cz> (Petr Baudis's message of
	"Wed, 1 Feb 2006 00:35:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15369>

Petr Baudis <pasky@suse.cz> writes:

> What about letting the file-handler actually tell merge-index what to
> do? merge-index could make a fifo at fd 3 for it (we might fork a
> special buffering process for it to avoid PIPE_BUF issues) and let it
> write there a sequence of lines like...

Yes.  That is sensible.

A merge handler that is willing to look at the current index
stages (and merge-recursive certainly is capable of doing that)
can open an outgoing pipe to 'git-update-index --index-info' and
drive it.  The command syntax is a bit different from what you
wrote in your message and I think if we go this route we should
make --index-info a bit easier to use by allowing it to accept
stage 0 entries.

-- >8 --
update-index --index-info: allow stage 0 entries.

Somehow we did not allow stuffing the index with stage 0 entries
through --index-info interface.  I do not think of a reason to
forbid it offhand.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/update-index.c b/update-index.c
index 2361e41..94436dd 100644
--- a/update-index.c
+++ b/update-index.c
@@ -303,7 +303,7 @@ static void read_index_info(int line_ter
 		if (!tab || tab - ptr < 41)
 			goto bad_line;
 
-		if (tab[-2] == ' ' && '1' <= tab[-1] && tab[-1] <= '3') {
+		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
 			stage = tab[-1] - '0';
 			ptr = tab + 1; /* point at the head of path */
 			tab = tab - 2; /* point at tail of sha1 */
