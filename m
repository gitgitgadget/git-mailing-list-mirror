From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] create_symref: check error return from open().
Date: Fri, 26 Jan 2007 17:46:12 -0800
Message-ID: <7v64ats0m3.fsf@assigned-by-dhcp.cox.net>
References: <11698503133039-git-send-email-nico@cam.org>
	<7vbqkluzcm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 02:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAceH-0000SV-Kf
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 02:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbXA0BqR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 20:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbXA0BqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 20:46:16 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49387 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbXA0BqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 20:46:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127014613.EHQI3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 20:46:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G1lF1W00N1kojtg0000000; Fri, 26 Jan 2007 20:45:15 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37910>


Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * There seem to be similarly "casual" users of open in the rest
   of the code, but I noticed this while looking at your series.
   I've already done the necessary shuffling in my tree, so
   there is no need to resend your "move create_symref()".

 refs.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 0840b3b..12e46b8 100644
--- a/refs.c
+++ b/refs.c
@@ -331,7 +331,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master)
 		return -1;
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
-	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);	
+	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	if (fd < 0) {
+		error("Unable to open %s for writing", lockpath);
+		return -5;
+	}
 	written = write_in_full(fd, ref, len);
 	close(fd);
 	if (written != len) {
-- 
1.5.0.rc2.g8ac6-dirty
