From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/7] Don't exit successfully on EPIPE in read_or_die.
Date: Sun, 24 Dec 2006 00:46:27 -0500
Message-ID: <20061224054627.GE8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:46:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMBt-0001Ts-QL
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbWLXFqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbWLXFqb
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:46:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53757 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbWLXFqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:46:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMBp-0008Pw-6x; Sun, 24 Dec 2006 00:46:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6F61E20FB65; Sun, 24 Dec 2006 00:46:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35342>

Junio pointed out to me that read() won't return EPIPE like write()
does, so there is no reason for us to exit successfully if we get
an EPIPE error while in read_or_die.

Instead we should just die if we get any error from read() while
in read_or_die as there is no reasonable recovery.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 write_or_die.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index a56d992..8cf6486 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -9,11 +9,8 @@ void read_or_die(int fd, void *buf, size_t count)
 		loaded = xread(fd, p, count);
 		if (loaded == 0)
 			die("unexpected end of file");
-		else if (loaded < 0) {
-			if (errno == EPIPE)
-				exit(0);
+		else if (loaded < 0)
 			die("read error (%s)", strerror(errno));
-		}
 		count -= loaded;
 		p += loaded;
 	}
-- 
1.4.4.3.g2e63
