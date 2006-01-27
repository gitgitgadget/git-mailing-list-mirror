From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is "-u" supposed to mean in git-fetch?
Date: Thu, 26 Jan 2006 19:37:46 -0800
Message-ID: <7v3bja733p.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601261148510.32499@wbgn013.biozentrum.uni-wuerzburg.de>
	<7voe1zfbsm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 04:37:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2KQp-0001z9-Ol
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 04:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWA0Dht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 22:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWA0Dht
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 22:37:49 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26590 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932414AbWA0Dhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 22:37:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060127033459.FYAY17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 22:34:59 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, torvalds@osdl.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15174>

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>...
>> Also, in the course of researching this, I tried
>>
>> 	git-whatchanged git-fetch-script
>
> As in Linus' message, "git whatchanged -- git-fetch-script" is
> supposed to be the kosher way now, but it does *not* work.


Here is an attempt to fix it.

It is not perfect.  As I said in a different message, the option
parsing by rev-parse in whatchanged might have outlived its
usefulness, especially after rev-list acquired path limit
arguments.  If you see what 'sh -x git-whatchanged' does, you
will notice that the path limiter is not given to rev-list, but
is given to diff-tree.

-- >8 --
[PATCH] rev-parse: make "whatchanged -- git-fetch-script" work again.

The latest update to avoid misspelled revs interfered when we
were not interested in parsing non flags or arguments not meant
for rev-list.  This makes these two forms work again:

	git whatchanged -- git-fetch-script

We could enable "!def" in the part this change touches to make
the above work without '--', but then it would cause misspelled
v2.6.14..v2.6.16 to be given to diff-tree and defeats the whole
point of the previous fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 rev-parse.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

f63fb6067037890d4928e35f7839f2a133a08d80
diff --git a/rev-parse.c b/rev-parse.c
index 7abad35..9567b0f 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -294,7 +294,9 @@ int main(int argc, char **argv)
 		}
 		if (verify)
 			die("Needed a single revision");
-		if (lstat(arg, &st) < 0)
+		if ((filter & DO_REVS) &&
+		    (filter & DO_NONFLAGS) && /* !def && */
+		    lstat(arg, &st) < 0)
 			die("'%s': %s", arg, strerror(errno));
 		as_is = 1;
 		show_file(arg);
-- 
1.1.4.g2cff
