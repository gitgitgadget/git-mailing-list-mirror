From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-archive: insert --format before double dash if
 necessary.
Date: Thu, 10 Dec 2009 23:20:05 +0100
Message-ID: <20091210222005.GP4114@genesis.frugalware.org>
References: <20091210212636.GA27722@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIrMt-0003rh-MF
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761952AbZLJWUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761926AbZLJWUA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:20:00 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48852 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761848AbZLJWUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:20:00 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C24EE58084;
	Thu, 10 Dec 2009 23:20:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A2AF042F0A;
	Thu, 10 Dec 2009 23:20:05 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C3AFF1240014; Thu, 10 Dec 2009 23:20:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091210212636.GA27722@Knoppix>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135043>

Reported-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

What about this fix?

 builtin-archive.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..ffbc9b0 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -104,14 +104,35 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	}
 
 	if (format) {
+		int i, found = 0;
+		const char *ptr = NULL;
+
 		sprintf(fmt_opt, "--format=%s", format);
 		/*
 		 * This is safe because either --format and/or --output must
 		 * have been given on the original command line if we get to
 		 * this point, and parse_options() must have eaten at least
 		 * one argument, i.e. we have enough room to append to argv[].
+		 *
+		 * First check if we have to insert the argument before
+		 * two dashes.
 		 */
-		argv[argc++] = fmt_opt;
+		for (i = 0; i < argc; i++) {
+			if (found) {
+				const char *tmp = argv[i];
+				argv[i] = ptr;
+				ptr = tmp;
+			} else if (!strcmp(argv[i], "--")) {
+				found = 1;
+				ptr = argv[i];
+				argv[i] = fmt_opt;
+				argc++;
+			}
+		}
+
+		/* No double dash? Then just append it to the end of the list. */
+		if (!found)
+			argv[argc++] = fmt_opt;
 		argv[argc] = NULL;
 	}
 
-- 
1.6.5.2
