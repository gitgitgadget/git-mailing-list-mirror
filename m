From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git to be (more) ANSI C99 compliant.
Date: Mon, 19 Jun 2006 18:59:38 -0700
Message-ID: <7vac8860z9.fsf@assigned-by-dhcp.cox.net>
References: <1150609831500-git-send-email-octo@verplant.org>
	<Pine.LNX.4.64.0606180946090.5498@g5.osdl.org>
	<20060619212116.GL1331@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jun 20 03:59:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsVWq-00006i-FQ
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 03:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWFTB7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 21:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWFTB7l
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 21:59:41 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58589 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964806AbWFTB7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 21:59:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620015940.YPOS27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 21:59:40 -0400
To: Florian Forster <octo@verplant.org>
In-Reply-To: <20060619212116.GL1331@verplant.org> (Florian Forster's message
	of "Mon, 19 Jun 2006 23:21:16 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22158>

Florian Forster <octo@verplant.org> writes:

> I didn't start writing the patch because I like C99 so much. In fact, in
> my opinion it introduces some possibilities I'd rather not have in C
> because people might actually use them. But by default the Sun cc
> complains about void-pointer arithmetic...

I am reasonably sympathetic to that, and judging from the number
of lines the patch touches, I am not as strongly opposed to it
as Linus seems to be.

> Maybe Rene Scharfe's method (as used in the patch to git-tar-tree) is a
> good way around it? There are no explicit casts involved and standard-
> compliant compilers like it, too. The downside is that you have two
> variables for the same thing/memory.

I think Rene's patch makes sense primarily because the functions
affected are small and we can easily see that the aliased input
variable ("data") is not used -- IOW, there is no confusion.

If it were a big function and the code used one variable for
some purpose and the other one for another purpose, it would be
far worse than having to cast the same variable occasionally.

BTW, I think we would probably want to have this patch on top of
Rene's patch.  In all instances, the variable "buf" is of type
"const char *" and the existing casts do not make sense to me.


diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 5c8a5f0..39a61b6 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -36,7 +36,7 @@ static void reliable_write(const void *d
 			die("git-tar-tree: disk full?");
 		}
 		size -= ret;
-		buf = (char *) buf + ret;
+		buf += ret;
 	}
 }
 
@@ -65,13 +65,13 @@ static void write_blocked(const void *da
 		memcpy(block + offset, buf, chunk);
 		size -= chunk;
 		offset += chunk;
-		buf = (char *) buf + chunk;
+		buf += chunk;
 		write_if_needed();
 	}
 	while (size >= BLOCKSIZE) {
 		reliable_write(buf, BLOCKSIZE);
 		size -= BLOCKSIZE;
-		buf = (char *) buf + BLOCKSIZE;
+		buf += BLOCKSIZE;
 	}
 	if (size) {
 		memcpy(block + offset, buf, size);
