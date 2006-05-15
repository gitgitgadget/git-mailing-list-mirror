From: Junio C Hamano <junkio@cox.net>
Subject: Re: Simplify "git reset --hard"
Date: Mon, 15 May 2006 00:08:45 -0700
Message-ID: <7vwtcnvk76.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605141040210.3866@g5.osdl.org>
	<Pine.LNX.4.64.0605141110150.3866@g5.osdl.org>
	<7v1wuvwzdv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 09:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfXCH-0006bJ-1P
	for gcvg-git@gmane.org; Mon, 15 May 2006 09:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWEOHIr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 03:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWEOHIr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 03:08:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45991 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932318AbWEOHIq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 03:08:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515070845.LVX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 03:08:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v1wuvwzdv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 14 May 2006 23:55:24 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20031>

Junio C Hamano <junkio@cox.net> writes:

>> Instead, just pass in "-u" to git-read-tree when we do a hard reset, and 
>> depend on git-read-tree to update the working tree appropriately.
>
> Well, this is wrong.  Local modifications remain after your
> version of "git-reset --hard HEAD". which is not what we want
> from a hard reset.

... and attempting to paper it over in git-reset.sh is also
wrong.  Keep your "--hard is noop" change in git-reset.sh and
replace it with this would be the right fix.

-- >8 --

diff --git a/read-tree.c b/read-tree.c
index 11157f4..c135f08 100644
--- a/read-tree.c
+++ b/read-tree.c
@@ -686,6 +686,7 @@ static int oneway_merge(struct cache_ent
 	if (!a)
 		return deleted_entry(old, NULL);
 	if (old && same(old, a)) {
+		old->ce_flags |= htons(CE_UPDATE);
 		return keep_entry(old);
 	}
 	return merged_entry(a, NULL);
