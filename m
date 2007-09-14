From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Fix "git diff" setup code
Date: Fri, 14 Sep 2007 10:17:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWEoi-0003QX-DX
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbXINRS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbXINRS3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:18:29 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40956 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366AbXINRS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 13:18:28 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHHWct014562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 10:17:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHHVCO015739;
	Fri, 14 Sep 2007 10:17:32 -0700
In-Reply-To: <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58165>


For some inexplicable reason, "git diff" would call "diff_setup_done()" 
iff we hadn't given an explicit output format.

That makes no sense, since much of what diff_setup_done() does is exactly 
about checking the output format!

This just moves the call to "diff_setup_done()" out of the conditional, 
and to where we've actually done all of the diffopt changes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-diff.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index f77352b..cb4743b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -252,13 +252,12 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		argc = 0;
 	else
 		argc = setup_revisions(argc, argv, &rev, NULL);
-	if (!rev.diffopt.output_format) {
+	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (diff_setup_done(&rev.diffopt) < 0)
-			die("diff_setup_done failed");
-	}
 	rev.diffopt.allow_external = 1;
 	rev.diffopt.recursive = 1;
+	if (diff_setup_done(&rev.diffopt) < 0)
+		die("diff_setup_done failed");
 
 	/* If the user asked for our exit code then don't start a
 	 * pager or we would end up reporting its exit code instead.
