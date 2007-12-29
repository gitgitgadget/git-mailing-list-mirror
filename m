From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach revision walker about reflog ranges
Date: Sun, 30 Dec 2007 00:02:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712300000170.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Dec 30 00:02:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8khX-0000ay-C9
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 00:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbXL2XCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 18:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXL2XCO
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 18:02:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752289AbXL2XCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 18:02:14 -0500
Received: (qmail invoked by alias); 29 Dec 2007 23:02:11 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 30 Dec 2007 00:02:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cqx5orgzcc1eBlCiPCWF4RIVUo/8qOQohXAXsf9
	Dc7eSKuJyVb7YG
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69336>


Now you can ask for a revision range

	master@{2.weeks.ago..1.day.ago}

or even something like

	HEAD@{20..yesterday}

It does this by allocating an strbuf to construct the second ref string
(in the above examples "master@{1.day.ago}" and "HEAD@{yesterday}",
respectively), which is never free()d.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Another nail in the coffin of libification, but for the common 
	one-shot command, it is the easiest way to support reflog ranges.

 revision.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 6e85aaa..3e7a834 100644
--- a/revision.c
+++ b/revision.c
@@ -794,10 +794,24 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		const char *this = arg;
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ UNINTERESTING;
+		const char *at;
 
 		*dotdot = 0;
 		next += symmetric;
 
+		at = strstr(arg, "@{");
+		if (at && !strchr(at + 2, '}')) {
+			struct strbuf buf;
+			strcpy(dotdot, "}");
+			strbuf_init(&buf, 0);
+			strbuf_insert(&buf, 0, arg, at + 2 - arg);
+			if (!strcmp(next, "}"))
+				strbuf_addch(&buf, '0');
+			strbuf_addstr(&buf, next);
+			/* we will not free() this buffer */
+			next = buf.buf;
+		}
+
 		if (!*next)
 			next = "HEAD";
 		if (dotdot == arg)
-- 
1.5.4.rc2.5.g44b6d-dirty
