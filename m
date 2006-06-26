From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Mon, 26 Jun 2006 09:09:15 -0700
Message-ID: <7vhd27j3v8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 18:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuteL-0003w4-0u
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 18:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFZQJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWFZQJS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 12:09:18 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11263 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750736AbWFZQJR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 12:09:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626160917.LISQ19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 12:09:17 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 26 Jun 2006 17:33:40 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22676>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	It is not clean to reset the flags of all objects to 0. Instead, 
> 	the commits are walked directly. Not that it matters in that
> 	particular case (the only read objects _are_ these commits).

I think this makes sense, but the clear-commit-marks function
itself looks fishy.  I suspect a parent that has not been parsed
could be already marked in which case the current code would
leave it marked.  Don't we need this perhaps?

diff --git a/commit.c b/commit.c
index 946615d..69fbc41 100644
--- a/commit.c
+++ b/commit.c
@@ -397,8 +397,7 @@ void clear_commit_marks(struct commit *c
 	commit->object.flags &= ~mark;
 	while (parents) {
 		struct commit *parent = parents->item;
-		if (parent && parent->object.parsed &&
-		    (parent->object.flags & mark))
+		if (parent && (parent->object.flags & mark))
 			clear_commit_marks(parent, mark);
 		parents = parents->next;
 	}
