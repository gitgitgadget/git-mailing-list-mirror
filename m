From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff: use filespec as in-place size cache
Date: Sun, 06 May 2007 01:51:13 -0700
Message-ID: <7vfy6acp32.fsf@assigned-by-dhcp.cox.net>
References: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 10:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkcSc-0001XC-8f
	for gcvg-git@gmane.org; Sun, 06 May 2007 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXEFIvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbXEFIvO
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 04:51:14 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51762 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXEFIvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 04:51:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506085113.VIIU2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 04:51:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vkrD1W0061kojtg0000000; Sun, 06 May 2007 04:51:13 -0400
In-Reply-To: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 06 May 2007 01:47:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46319>

When we have a filespec primed with size, later size_only
request should be fillable without recomputing it.

---
diff --git a/diff.c b/diff.c
index 0f8c68f..fb3eba5 100644
--- a/diff.c
+++ b/diff.c
@@ -1515,6 +1515,9 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 	if (s->data)
 		return err;
 
+	if (size_only && 0 < s->size)
+		return err;
+
 	if (S_ISDIRLNK(s->mode))
 		return diff_populate_gitlink(s, size_only);
 
