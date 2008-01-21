From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 11:24:13 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
 <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org>
 <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2Gg-0007jp-MR
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYAUTYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYAUTYe
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:24:34 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34507 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751724AbYAUTYd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:24:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJODGG019625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 11:24:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJODCv015756;
	Mon, 21 Jan 2008 11:24:13 -0800
In-Reply-To: <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71314>



On Mon, 21 Jan 2008, Linus Torvalds wrote:
> 
> Still looking.

Damn.

The comment that I also  moved says it all.

I'd forgotten about that really ugly special case. It's no longer ugly, 
but missing that part of the ce_mode handling cleanup certainly explains 
the test-suite failing.

		Linus

---
 read-cache.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f5f9c3d..58a9b95 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -124,6 +124,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
 
+	if (ce->ce_flags & CE_REMOVE)
+		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
+
 	switch (ce->ce_mode & S_IFMT) {
 	case S_IFREG:
 		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
@@ -145,8 +149,6 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 		else if (ce_compare_gitlink(ce))
 			changed |= DATA_CHANGED;
 		return changed;
-	case 0: /* Special case: unmerged file in index */
-		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
 	default:
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
