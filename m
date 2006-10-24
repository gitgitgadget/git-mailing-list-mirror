From: Junio C Hamano <junkio@cox.net>
Subject: Re: git.kernel.org disconnects when git-1.3.3 tries to pull changes
Date: Mon, 23 Oct 2006 18:23:34 -0700
Message-ID: <7vbqo2wlpl.fsf@assigned-by-dhcp.cox.net>
References: <453D583E.3010601@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 03:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcB12-0000sz-3G
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 03:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWJXBXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWJXBXf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 21:23:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30371 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964896AbWJXBXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 21:23:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024012334.CTJZ16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Oct 2006 21:23:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e1PJ1V00U1kojtg0000000
	Mon, 23 Oct 2006 21:23:18 -0400
To: Simon Arlott <simon@arlott.org>
In-Reply-To: <453D583E.3010601@simon.arlott.org.uk> (Simon Arlott's message of
	"Tue, 24 Oct 2006 01:03:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29911>

Yes, this is a recent breakage.  Thanks for bringing it up.

We need at least a fix like this in 'maint'.

diff --git a/daemon.c b/daemon.c
index ad84928..e66bb80 100644
--- a/daemon.c
+++ b/daemon.c
@@ -450,6 +450,8 @@ void fill_in_extra_table_entries(struct 
 	 * Replace literal host with lowercase-ized hostname.
 	 */
 	hp = interp_table[INTERP_SLOT_HOST].value;
+	if (!hp)
+		return;
 	for ( ; *hp; hp++)
 		*hp = tolower(*hp);
 
@@ -544,8 +546,10 @@ #endif
 		loginfo("Extended attributes (%d bytes) exist <%.*s>",
 			(int) pktlen - len,
 			(int) pktlen - len, line + len + 1);
-	if (len && line[len-1] == '\n')
+	if (len && line[len-1] == '\n') {
 		line[--len] = 0;
+		pktlen--;
+	}
 
 	/*
 	 * Initialize the path interpolation table for this connection.
