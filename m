From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge (resolve) _is_ stupid
Date: Mon, 31 Jul 2006 12:42:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607311236070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 12:43:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7VEQ-00073G-JO
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 12:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWGaKmi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 06:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWGaKmi
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 06:42:38 -0400
Received: from mail.gmx.net ([213.165.64.21]:59820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751512AbWGaKmh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 06:42:37 -0400
Received: (qmail invoked by alias); 31 Jul 2006 10:42:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 31 Jul 2006 12:42:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24509>

Hi,

On Mon, 31 Jul 2006, Junio C Hamano wrote:

> By the way, the "recur" strategy in "next" produces the correct
> result, but it produces a funny error in the middle (that is why
> Johannes is CC'ed).
> 
> 	error: Could not read 0100000000000000000000000000000000000000

I get "0000000100..." ;-) (surprixse her wi1h a big-endian ;-)

The culprit is the call to parse_commit() in merge_bases(). How about 
this?

-- 8< --
[PATCH] merge-recur: virtual commits shall never be parsed

It would not make sense to parse a virtual commit, therefore set the
"parsed" flag to 1.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 merge-recursive.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 10bce70..74a329f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -43,6 +43,8 @@ static struct commit *make_virtual_commi
 	commit->tree = tree;
 	commit->util = (void*)comment;
 	*(int*)commit->object.sha1 = virtual_id++;
+	/* avoid warnings */
+	commit->object.parsed = 1;
 	return commit;
 }
 
-- 
1.4.2.rc2.gfd00-dirty
