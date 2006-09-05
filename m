From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] send pack remove remote reference limit
Date: Tue, 5 Sep 2006 20:00:17 +0100
Message-ID: <20060905190017.GA24102@shadowen.org>
References: <7v64g2i9p8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 05 21:01:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKgAJ-0004Yu-7q
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 21:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWIETAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWIETAm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 15:00:42 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:4553
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1030224AbWIETAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 15:00:41 -0400
Received: from apw by localhost.localdomain with local (Exim 4.62)
	(envelope-from <apw@shadowen.org>)
	id 1GKg9h-0006Gp-Q2; Tue, 05 Sep 2006 20:00:17 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <7v64g2i9p8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26483>

send-pack: remove remote reference limit

When build a pack for a push we query the remote copy for existant
heads.  These are used to prune unnecessary objects from the pack.
As we receive the remote references in get_remote_heads() we validate
the reference names via check_ref() which includes a length check;
rejecting those >45 characters in size.

This is a miss converted change, it was originally designed to reject
messages which were less than 45 characters in length (a 40 character
sha1 and refs/) to prevent comparing unitialised memory.  check_ref()
now gets the raw length so check for at least 5 characters.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/connect.c b/connect.c
index e501ccc..371aea1 100644
--- a/connect.c
+++ b/connect.c
@@ -17,7 +17,7 @@ static int check_ref(const char *name, i
 	if (!flags)
 		return 1;
 
-	if (len > 45 || memcmp(name, "refs/", 5))
+	if (len < 5 || memcmp(name, "refs/", 5))
 		return 0;
 
 	/* Skip the "refs/" part */
