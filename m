From: Shawn Pearce <spearce@spearce.org>
Subject: [RFC 6/5] Fix ref log parsing so it works properly.
Date: Wed, 17 May 2006 18:34:48 -0400
Message-ID: <20060517223448.GE30313@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 00:35:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgUba-0000Ax-1G
	for gcvg-git@gmane.org; Thu, 18 May 2006 00:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWEQWew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 18:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWEQWew
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 18:34:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:64483 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750782AbWEQWev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 18:34:51 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FgUbI-0007xY-9A; Wed, 17 May 2006 18:34:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 74B6C212667; Wed, 17 May 2006 18:34:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20248>

The log parser was only ever matching the last log record due to
calling strtoul on "> 1136091609" rather than " 1136091609".  Also
once a match for '@' has been found after the name of the ref there
is no point in looking for another '@' within the remaining text.

---
 Uh yea, I found a couple of bugs.  :-)
 This applies on top of the other 5 patches (hence the 6/5).

 refs.c      |    2 +-
 sha1_name.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

fbc7bf049255370f1611a5772c39d35422a81e24
diff --git a/refs.c b/refs.c
index 4c99e37..ae9825d 100644
--- a/refs.c
+++ b/refs.c
@@ -459,7 +459,7 @@ int read_ref_at(const char *ref, unsigne
 			c++;
 		if (c == logend || *c == '\n')
 			die("Log %s is corrupt.", logfile);
-		date = strtoul(c, NULL, 10);
+		date = strtoul(c + 1, NULL, 10);
 		if (date <= at_time) {
 			if (get_sha1_hex(rec + 41, sha1))
 				die("Log %s is corrupt.", logfile);
diff --git a/sha1_name.c b/sha1_name.c
index 3ac3ab4..4376cb3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -267,6 +267,7 @@ static int get_sha1_basic(const char *st
 			at_time = approxidate(date_spec);
 			free(date_spec);
 			len = at_mark;
+			break;
 		}
 	}
 
-- 
1.3.2.g7278
