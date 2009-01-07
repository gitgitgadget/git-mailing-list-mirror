From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] diff --no-index -q: fix endless loop
Date: Wed,  7 Jan 2009 12:15:30 +0100
Message-ID: <1231326930-7132-1-git-send-email-trast@student.ethz.ch>
References: <7veizfbnuw.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 12:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKWP2-0004hN-6x
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 12:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbZAGLPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 06:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZAGLPY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 06:15:24 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:25607 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbZAGLPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 06:15:23 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 12:15:22 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 12:15:22 +0100
X-Mailer: git-send-email 1.6.1.259.g236c
In-Reply-To: <7veizfbnuw.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 07 Jan 2009 11:15:22.0225 (UTC) FILETIME=[3B429610:01C970B9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104786>

We forgot to move to the next argument when parsing -q, getting stuck
in an endless loop.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Junio C Hamano wrote:
> I'll queue the "--" fix, "-q" fix and this pager fix.  Thanks.

Seems the after-midnight rule indeed has some value.  I pointed out
the argv[i] bug, which I see you have squashed into the -- fix, but
failed to notice that the -q parsing is also missing an i++.

I'm still not convinced of the option's value, but this patch at least
fixes the bug.


 diff-no-index.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 12ff1f1..60ed174 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -207,8 +207,10 @@ void diff_no_index(struct rev_info *revs,
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
-		else if (!strcmp(argv[i], "-q"))
+		else if (!strcmp(argv[i], "-q")) {
 			options |= DIFF_SILENT_ON_REMOVED;
+			i++;
+		}
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-- 
tg: (3bbe36c..) t/diff-q-endless (depends on: next)
