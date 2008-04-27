From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Die for an early EOF in a file reading loop
Date: Sun, 27 Apr 2008 17:07:24 +0300
Message-ID: <20080427140724.GA26018@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 16:08:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq7Y6-0006PB-Pn
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 16:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbYD0OH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 10:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbYD0OH0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 10:07:26 -0400
Received: from zakalwe.fi ([80.83.5.154]:54719 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbYD0OH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 10:07:26 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id D56FB2BC8E; Sun, 27 Apr 2008 17:07:24 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80447>

The resulting data is zero terminated after the read loop, but
the subsequent loop that scans for '\n' will overrun the buffer.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
Yes, I know it is highly improbable that the file size changes between 
fstat() and read(), but so is read error on media.

 combine-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 0e19cba..a4269f6 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -719,8 +719,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			while (sz < len) {
 				ssize_t done = xread(fd, result+sz, len-sz);
 				if (done == 0)
-					break;
-				if (done < 0)
+					die("early EOF '%s'", elem->path);
+				else if (done < 0)
 					die("read error '%s'", elem->path);
 				sz += done;
 			}
-- 
1.5.4.4
