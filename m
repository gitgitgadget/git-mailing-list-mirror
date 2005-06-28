From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Obtain sha1_file_info() for deltified pack entry properly.
Date: Mon, 27 Jun 2005 23:56:02 -0700
Message-ID: <7vpsu7x94t.fsf@assigned-by-dhcp.cox.net>
References: <20050624.212009.92584730.davem@davemloft.net>
	<42BCE026.8050405@pobox.com>
	<Pine.LNX.4.58.0506242208210.11175@ppc970.osdl.org>
	<42BCF02B.5090706@pobox.com>
	<Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
	<Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org>
	<7vzmtdq7wy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506261206170.19755@ppc970.osdl.org>
	<7vll4wq4va.fsf@assigned-by-dhcp.cox.net>
	<7v1x6om6o5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506271227160.19755@ppc970.osdl.org>
	<7v64vzyqyw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 08:52:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn9wt-0001zz-QT
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 08:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVF1G6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 02:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVF1G4v
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 02:56:51 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14007 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261159AbVF1G4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 02:56:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628065604.LPMT17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 02:56:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64vzyqyw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 27 Jun 2005 22:45:27 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I will be sending these three patches:

    [PATCH 1/3] Obtain sha1_file_info() for deltified pack entry properly.
    [PATCH 2/3] git-cat-file: use sha1_object_info() on '-t'.
    [PATCH 3/3] git-cat-file: '-s' to find out object size.

The first one is slightly different from what I sent earlier to
you privately.  If you have already applied it, please apply the
4-liner alternate patch attached to this message on top of it
for the fix included in the one in this series (and drop the
first one, obviously).

The second and third patches fell out as a bonus while I was
debugging the sha1_file_info().  Especially the third one is in
"because we can do it so cheaply now", not "because I need to
have that feature" category, and I do not mind too much if you
drop it, but I suspect somebody may find it useful.

The "4-liner alternate patch" follows.

------------
Add missing use_packed_git() call.

The function sha1_object_info() was using packed GIT file
without making sure it is mapped, which resulted in
segfaulting.

We would need to introduce unuse_packed_git() call and do proper
use counting to figure out when it is safe to unmap, but
currently we do not unmap packed file yet.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -675,6 +675,10 @@ static int packed_object_info(struct pac
 	offset = entry->offset;
 	if (p->pack_size - 5 < offset)
 		die("object offset outside of pack file");
+
+	if (use_packed_git(p))
+		die("cannot map packed file");
+
 	pack = p->pack_base + offset;
 	size = (pack[1] << 24) + (pack[2] << 16) + (pack[3] << 8) + pack[4];
 	left = p->pack_size - offset - 5;
------------------------------------------------
