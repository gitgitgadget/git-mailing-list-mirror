From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH/resend] Fix use of hardlinks in "make install"
Date: Sat, 30 Aug 2008 02:20:32 +0200
Message-ID: <20080830002032.GA14522@steel.home>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com> <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 02:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEDt-0003gc-Mh
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYH3AUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbYH3AUk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:20:40 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:57088 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYH3AUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:20:39 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EK7
Received: from tigra.home (Fad0a.f.strato-dslnet.de [195.4.173.10])
	by post.webmailer.de (fruni mo9) (RZmta 16.47)
	with ESMTP id m01781k7TMLVAn ; Sat, 30 Aug 2008 02:20:34 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2185B277AE;
	Sat, 30 Aug 2008 02:20:33 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B874056D2A; Sat, 30 Aug 2008 02:20:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94337>

The code failed to filter-out git-add properly on platforms were $X is
not empty (ATM there is only one such a platform).

Than it tried to create a hardlink to the file ($execdir/git-add) it just
removed (because git-add is first in the BUILT_INS), so ln failed (but
because stderr was redirected into /dev/null the error was never seen), and
the whole install ended up using "ln -s" instead.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
> 2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
>>
>> It created endless symlink loops on cygwin, but obviously nowhere else.
>>
>
> Sh@#! Scrap that, there is something else going on in that cygwindows thing...
>

Well, as usual, simple fix for a trivial typo caused by existence of an
idiotic platform.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index bf400e6..20f028f 100644
--- a/Makefile
+++ b/Makefile
@@ -1379,7 +1379,7 @@ endif
 	{ $(RM) "$$execdir/git-add$X" && \
 		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
 		cp git-add$X "$$execdir/git-add$X"; } && \
-	{ $(foreach p,$(filter-out git-add,$(BUILT_INS)), $(RM) "$$execdir/$p" && \
+	{ $(foreach p,$(filter-out git-add$X,$(BUILT_INS)), $(RM) "$$execdir/$p" && \
 		ln "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
 		ln -s "git-add$X" "$$execdir/$p" 2>/dev/null || \
 		cp "$$execdir/git-add$X" "$$execdir/$p" || exit;) } && \
-- 
1.6.0.1.152.g6969c
