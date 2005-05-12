From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix git-diff-files for symlinks.
Date: Thu, 12 May 2005 16:51:08 -0700
Message-ID: <7vekccc8b7.fsf_-_@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
	<7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
	<20050512192941.GC324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 01:44:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNLU-0005uX-71
	for gcvg-git@gmane.org; Fri, 13 May 2005 01:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVELXvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 19:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVELXvj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 19:51:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:25850 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262182AbVELXvf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 19:51:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512235108.OQIM22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 19:51:08 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050512192941.GC324@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 21:29:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Again I am not sure why this was missed during the last round,
but git-diff-files mishandles symlinks on the filesystem.  This
patch fixes it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Petr, this one falls into "emergency obvious fix" category.
*** I found it during adding more "basic" test to the test suite,
*** which turns out to be quite useful.

diff-files.c |    3 ++-
1 files changed, 2 insertions(+), 1 deletion(-)

--- a/diff-files.c
+++ b/diff-files.c
@@ -126,7 +126,8 @@
 			continue;
 
 		oldmode = ntohl(ce->ce_mode);
-		mode = S_IFREG | ce_permissions(st.st_mode);
+		mode = (S_ISLNK(st.st_mode) ? S_IFLNK :
+			S_IFREG | ce_permissions(st.st_mode));
 
 		show_modified(oldmode, mode, ce->sha1, null_sha1,
 			      ce->name);
------------------------------------------------

