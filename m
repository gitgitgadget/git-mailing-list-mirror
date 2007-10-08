From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT
Date: Mon, 8 Oct 2007 13:46:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710081342530.4964@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710081337490.4964@woody.linux-foundation.org
 >
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IezVK-0005z0-JZ
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 22:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXJHUq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXJHUq5
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 16:46:57 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52849 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643AbXJHUq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 16:46:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98Kkq4Q002216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 13:46:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98KkqKh018767;
	Mon, 8 Oct 2007 13:46:52 -0700
In-Reply-To: <alpine.LFD.0.999.0710081337490.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.738 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60337>


This fixes an unnecessary empty line that we add to the log message when 
we generate diffs, but don't actually end up printing any due to having 
DIFF_FORMAT_NO_OUTPUT set.

This can happen with pickaxe or with rename following. The reason is that 
we normally add an empty line between the commit and the diff, but we do 
that even for the case where we've then suppressed the actual printing of 
the diff.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 log-tree.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2319154..62edd34 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -304,7 +304,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 		 * output for readability.
 		 */
 		show_log(opt, opt->diffopt.msg_sep);
-		if (opt->verbose_header &&
+		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
