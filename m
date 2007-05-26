From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Micro-optimize prepare_alt_odb
Date: Sat, 26 May 2007 01:24:40 -0400
Message-ID: <20070526052440.GB11957@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 07:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hroln-0000iX-66
	for gcvg-git@gmane.org; Sat, 26 May 2007 07:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXEZFYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 01:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXEZFYp
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 01:24:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40406 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXEZFYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 01:24:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hrold-00060M-8e; Sat, 26 May 2007 01:24:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A034520FBAE; Sat, 26 May 2007 01:24:40 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48450>

Calling getenv() is not that expensive, but its also not free,
and its certainly not cheaper than testing to see if alt_odb_tail
is not null.

Because we are calling prepare_alt_odb() from within find_sha1_file
every time we cannot find an object file locally we want to skip out
of prepare_alt_odb() as early as possible once we have initialized
our alternate list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6a5ba63..a3637d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -376,11 +376,12 @@ void prepare_alt_odb(void)
 {
 	const char *alt;
 
+	if (alt_odb_tail)
+		return;
+
 	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
 	if (!alt) alt = "";
 
-	if (alt_odb_tail)
-		return;
 	alt_odb_tail = &alt_odb_list;
 	link_alt_odb_entries(alt, alt + strlen(alt), ':', NULL, 0);
 
-- 
1.5.2.789.g8ee1
