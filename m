From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Improve argument parsing in cat-file
Date: Sat, 21 Apr 2007 21:14:43 -0400
Message-ID: <20070422011443.GB2910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQfa-0000QE-K2
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbXDVBPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbXDVBPE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:15:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36098 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbXDVBOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:14:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfQew-0002Lt-Df; Sat, 21 Apr 2007 21:14:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7A5220FBAE; Sat, 21 Apr 2007 21:14:43 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45202>

Small refactoring of the command line parsing so we can
more easily add new long options to the mix.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-cat-file.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f132d58..b2437fe 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -82,25 +82,26 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	enum object_type type;
 	void *buf;
 	unsigned long size;
-	int opt;
-	const char *exp_type, *obj_name;
+	int opt = 0, i;
+	const char *exp_type = NULL, *obj_name = NULL;
 
 	git_config(git_default_config);
-	if (argc != 3)
+	for (i = 1; i < argc; i++) {
+		const char *a = argv[i];
+		if (!opt && a[0] == '-' && a[1])
+			opt = a[1];
+		else if (!opt && !exp_type)
+			exp_type = a;
+		else if (!obj_name)
+			obj_name = a;
+		else
+			break;
+	}
+	if (!obj_name)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	exp_type = argv[1];
-	obj_name = argv[2];
-
 	if (get_sha1(obj_name, sha1))
 		die("Not a valid object name %s", obj_name);
 
-	opt = 0;
-	if ( exp_type[0] == '-' ) {
-		opt = exp_type[1];
-		if ( !opt || exp_type[2] )
-			opt = -1; /* Not a single character option */
-	}
-
 	buf = NULL;
 	switch (opt) {
 	case 't':
-- 
1.5.1.1.135.gf948
