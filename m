From: Junio C Hamano <junkio@cox.net>
Subject: Honor extractor's umask in git-tar-tree.
Date: Sat, 01 Oct 2005 12:07:14 -0700
Message-ID: <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050930160353.F025C352B7B@atlas.denx.de>
	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>
	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 21:07:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELmhe-0002Ws-Uo
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 21:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJATHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJATHR
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 15:07:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:18121 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750767AbVJATHP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2005 15:07:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051001190713.JSKH9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 1 Oct 2005 15:07:13 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 01 Oct 2005 11:14:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9601>

The archive generated with git-tar-tree had 0755 and 0644 mode bits.
This inconvenienced the extractor with umask 002 by robbing g+w bit
unconditionally.  Just write it out with loose permissions bits and
let the umask of the extractor do its job.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
Junio C Hamano <junkio@cox.net> writes:

> Unrelated to the topic at hand, but related to the mode bits --
> tar-tree generates archives with 0644/0755 permission bits.  It
> might not be a bad idea to just let the tar command honor umask
> of the extracter, by storing 0666 and 0777 in the archive.
>
> I always work in an environment where umask 002 is the norm, and
> get irritated when upstream tarballs of other peoples' projects
> create directories with mode 0755, making me do chmod 2775 on
> them.

diff --git a/tar-tree.c b/tar-tree.c
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -353,6 +353,7 @@ static void traverse_tree(void *buffer, 
 
 		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
 			die("corrupt 'tree' file");
+		mode |= (mode & 0100) ? 0777 : 0666;
 		buffer = sha1 + 20;
 		size -= namelen + 20;
 
