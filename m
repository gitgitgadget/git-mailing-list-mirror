From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-tree: add "-t" option to always show the tree entries
Date: Thu, 01 Dec 2005 13:15:20 -0800
Message-ID: <7vlkz4friv.fsf@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 22:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehvm2-0003f2-4N
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 22:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVLAVPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 16:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVLAVPX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 16:15:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52684 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932475AbVLAVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 16:15:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201211439.UJIT6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 16:14:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13074>

Linus Torvalds <torvalds@osdl.org> writes:

> NOTE! This also means that it will show all trees leading up to that tree. 

... which is logical but slightly unexpected.  Also I noticed we
lost '-d' but still accept it as an option, so...

-- >8 --
[PATCH]: ls-tree: resurrect '-d' to mean 'show trees only'

With this:

	git-ls-tree -d HEAD -- drivers/net/

shows only immediate subtrees of drivers/net.

	git-ls-tree -d -t HEAD -- drivers/net/

shows drivers, drivers/net and immediate subtrees of
drivers/net.

	git-ls-tree -d -r HEAD -- drivers/net/

shows drivers, drivers/net and all subtrees of drivers/net (but
not blobs).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The practical value of this patch is dubious, and we might
   want to simply remove '-d' from the options.  But the output
   from this looks kind-of nice.  Thoughts?

diff --git a/ls-tree.c b/ls-tree.c
index a2a5eb0..07db863 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -61,6 +61,8 @@ static int show_tree(unsigned char *sha1
 		}
 		type = "tree";
 	}
+	else if (ls_options & LS_TREE_ONLY)
+		return 0;
 
 	printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
 	write_name_quoted(base, baselen, pathname, line_termination, stdout);
@@ -95,6 +97,10 @@ int main(int argc, const char **argv)
 		}
 		argc--; argv++;
 	}
+	/* -d -r should imply -t, but -d by itself should not have to. */
+	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
+	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
+		ls_options |= LS_SHOW_TREES;
 
 	if (argc < 2)
 		usage(ls_tree_usage);
