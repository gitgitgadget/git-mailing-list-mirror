From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2 jk/war-on-sprintf] read_branches_file: plug a FILE* leak
Date: Fri, 23 Oct 2015 08:02:51 +0200
Message-ID: <2c89c60e470def8f85941933c9fafe4db314628a.1445579874.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, git-for-windows@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 08:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpVRz-00051A-U4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 08:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbbJWGDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 02:03:09 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:31879 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbJWGDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 02:03:08 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nhw2x4HPKz5tlP;
	Fri, 23 Oct 2015 08:03:05 +0200 (CEST)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id DC438531A;
	Fri, 23 Oct 2015 08:03:04 +0200 (CEST)
X-Mailer: git-send-email 2.3.2.245.gb5bf9d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280083>

The earlier rewrite f28e3ab2 (read_branches_file: simplify string handling)
of read_branches_file() lost an fclose() call. Put it back.

As on Windows files that are open cannot be removed, the leak manifests in
a failure of 'git remote rename origin origin' when the remote's URL is
specified in .git/branches/origin, because by the time that the command
attempts to remove this file, it is still open.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/remote.c b/remote.c
index 1101f82..fb16153 100644
--- a/remote.c
+++ b/remote.c
@@ -282,6 +282,7 @@ static void read_branches_file(struct remote *remote)
 		return;
 
 	strbuf_getline(&buf, f, '\n');
+	fclose(f);
 	strbuf_trim(&buf);
 	if (!buf.len) {
 		strbuf_release(&buf);
-- 
2.3.2.245.gb5bf9d3
