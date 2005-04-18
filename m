From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] remove_special() tentative fix.
Date: Sun, 17 Apr 2005 18:51:34 -0700
Message-ID: <7voeccvom1.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
	<Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
	<20050418002326.GC1461@pasky.ji.cz>
	<Pine.LNX.4.58.0504171806230.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Brad Roberts <braddr@puremagic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:48:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNLMY-0006nw-SW
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDRBvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVDRBvk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:51:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61886 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261587AbVDRBvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 21:51:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418015134.QZIT2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 21:51:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504171806230.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 17 Apr 2005 18:07:18 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Mon, 18 Apr 2005, Petr Baudis wrote:
>> 
>> Am I just slow or does the first dst-- make it miss the last trailing
>> /[,;.]/?

LT> Hopefully not. It _should_ make it miss the last '\0', but hey, it got my
LT> usual amount of testing (ie none). I'm sure Brad can tell us whether it
LT> makes any difference..

No, you are both slow ;-)  At that point p is not the beginning
of the input anymore.  This is a *tentative* fix to implement
your intended solution.

I have a suspicion that your intended solution would not work on
systems that really use these GECOS subfields, though.  These
commas are there to separate subfields and your intended
solution would keep the office numbers etc. as part of commiter
name.  Honestly, I think your COMMITTER_* environment variable
idea is far better than playing games like this, although at the
same time I sympathize your not wanting to encourage people to
lie about the committer identity.

Signed-off-by: Junio C Hamano <junkio@cox.net> 
---

cd /opt/packrat/playpen/public/in-place/git/git/
show-diff commit-tree.c
commit-tree.c: ec53a4565ec0033aaf6df2a48d233ccf4823e8b0
--- commit-tree.c
+++ commit-tree.c	2005-04-17 18:43:39.000000000 -0700
@@ -83,6 +83,7 @@ static void finish_buffer(char *tag, cha
 static void remove_special(char *p)
 {
 	char c;
+	char *begin = p;
 	char *dst = p;
 
 	for (;;) {
@@ -102,7 +103,7 @@ static void remove_special(char *p)
 	 * have commas etc in their gecos field
 	 */
 	dst--;
-	while (--dst >= p) {
+	while (--dst >= begin) {
 		unsigned char c = *dst;
 		switch (c) {
 		case ',': case ';': case '.':

Compilation finished at Sun Apr 17 18:44:55

