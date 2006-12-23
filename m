From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 13/17] Ensure core.packedGitWindowSize cannot be less than 2 pages.
Date: Sat, 23 Dec 2006 02:34:38 -0500
Message-ID: <20061223073438.GN9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1P4-0001ux-Ey
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbWLWHem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbWLWHem
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38813 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbWLWHel (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OZ-0003D3-Kb; Sat, 23 Dec 2006 02:34:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 53C7820FB65; Sat, 23 Dec 2006 02:34:38 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35294>

We cannot allow a window to be smaller than 2 system pages.
This limitation is necessary to support the feature of use_pack()
where we always supply at least 20 bytes after the offset to help
the object header and delta base parsing routines.

If packedGitWindowSize were allowed to be as small as 1 system page
then we would be completely unable to access an object header which
spanned over a page as we would never be able to arrange a mapping
such that the header was contiguous in virtual memory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 config.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index a8ea063..edc42f4 100644
--- a/config.c
+++ b/config.c
@@ -302,8 +302,8 @@ int git_default_config(const char *var, const char *value)
 		int pgsz = getpagesize();
 		packed_git_window_size = git_config_int(var, value);
 		packed_git_window_size /= pgsz;
-		if (!packed_git_window_size)
-			packed_git_window_size = 1;
+		if (packed_git_window_size < 2)
+			packed_git_window_size = 2;
 		packed_git_window_size *= pgsz;
 		return 0;
 	}
-- 
1.4.4.3.g87d8
