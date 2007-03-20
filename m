From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 20:16:51 -0700
Message-ID: <7v3b40d2os.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	<Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	<118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
	<Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172136440.18328@xanadu.home>
	<Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
	<alpine.LFD.0.83.0703172200060.18328@xanadu.home>
	<Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
	<7v8xdunavr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 04:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTUqI-0007fw-VN
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 04:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbXCTDQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 23:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbXCTDQx
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 23:16:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40010 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932943AbXCTDQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 23:16:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320031652.MDMG28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 23:16:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id crGr1W00p1kojtg0000000; Mon, 19 Mar 2007 23:16:52 -0400
In-Reply-To: <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 18 Mar 2007 08:54:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42696>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So it looks like it *used* to be somewhat of a problem (the object access 
> itself must have been about 10 seconds, since that got shaved off the 
> time), but realistically, if you want to speed up "git blame", we can 
> totally ignore the git object data structures, an dconcentrate on xdiff 
> and on blame itself (cmp_suspect and assign_blame probably have some nasty 
> O(n^2) behaviour or something like that,...

With this stupidity-removal patch, it gets down to 7.80user from
8.72user (comparable number of minor faults) for blaming
block/ll_rw_blk.c (without tglx grafts)

diff --git a/builtin-blame.c b/builtin-blame.c
index b51cdc7..104521e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -182,9 +182,8 @@ struct scoreboard {
 
 static int cmp_suspect(struct origin *a, struct origin *b)
 {
-	int cmp = hashcmp(a->commit->object.sha1, b->commit->object.sha1);
-	if (cmp)
-		return cmp;
+	if (a->commit != b->commit)
+		return 1;
 	return strcmp(a->path, b->path);
 }
 
