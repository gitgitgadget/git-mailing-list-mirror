From: Shawn Pearce <spearce@spearce.org>
Subject: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 09:42:33 -0400
Message-ID: <20060829134233.GA21335@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 29 15:43:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI3rm-0001NK-2R
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 15:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWH2Nmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 09:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWH2Nmh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 09:42:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:434 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964964AbWH2Nmg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 09:42:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GI3rJ-0000mB-LP
	for git@vger.kernel.org; Tue, 29 Aug 2006 09:42:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14D5F20FB7F; Tue, 29 Aug 2006 09:42:33 -0400 (EDT)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26205>

Sorry but this really is a pretty stupid question on my part:

In builtin-pack-objects.c write_one(), why is the base object written
behind the first delta that depends on it (if it hasn't been written
already) rather than BEFORE the first delta that depends on it?

If the base always had to appear before any delta that uses it then
unpack-objects wouldn't need to cache a delta in memory waiting
for the base to get unpacked.

>From a data locality perspective putting the base object before
or after the delta shouldn't matter, as either way the delta
is useless without the base.  So placing the base immediately
before the delta should perform just as well as placing it after.
Either way the OS should have the base in cache by the time the
delta is being accessed.

In other words, why not apply this patch and make it a requirement
of the pack file format?


diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 46f524d..5dd97b9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -341,11 +341,11 @@ static unsigned long write_one(struct sh
 		 * if it is written already.
 		 */
 		return offset;
-	e->offset = offset;
-	offset += write_object(f, e);
 	/* if we are deltified, write out its base object. */
 	if (e->delta)
 		offset = write_one(f, e->delta, offset);
+	e->offset = offset;
+	offset += write_object(f, e);
 	return offset;
 }
 
