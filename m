From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/2] xdi_diff: trim common trailing lines
Date: Thu, 13 Dec 2007 14:31:49 -0800
Message-ID: <7vmysez0oa.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<7v7ijorwnc.fsf@gitster.siamese.dyndns.org>
	<7vabof5mze.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712122219160.20487@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 23:33:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2wbx-0006g3-B4
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 23:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759090AbXLMWcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762476AbXLMWcE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 17:32:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758726AbXLMWcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 17:32:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 44206852D;
	Thu, 13 Dec 2007 17:31:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4454E851E;
	Thu, 13 Dec 2007 17:31:52 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68197>

This implements earlier Linus's optimization to trim common lines at the
end before passing them down to low level xdiff interface for all of our
xdiff users.

We could later enhance this to also trim common leading lines, but that
would need tweaking of the output function to add the number of lines
trimmed at the beginning to line numbers that appear in the hunk
headers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff-interface.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 69a022c..f2cd488 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -103,9 +103,41 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	return 0;
 }
 
+/*
+ * Trim down common substring at the end of the buffers,
+ * but leave at least ctx lines at the end.
+ */
+static void trim_common_tail(mmfile_t *a, mmfile_t *b, int ctx)
+{
+	const int blk = 1024;
+	long trimmed = 0, recovered = 0;
+	int i;
+	char *ap = a->ptr + a->size;
+	char *bp = b->ptr + b->size;
+	long smaller = (a->size < b->size) ? a->size : b->size;
+
+	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
+		trimmed += blk;
+		ap -= blk;
+		bp -= blk;
+	}
+
+	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
+		while (recovered < trimmed && ap[recovered] != '\n')
+			recovered++;
+	}
+	a->size -= (trimmed - recovered);
+	b->size -= (trimmed - recovered);
+}
+
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
-	return xdl_diff(mf1, mf2, xpp, xecfg, xecb);
+	mmfile_t a = *mf1;
+	mmfile_t b = *mf2;
+
+	trim_common_tail(&a, &b, xecfg->ctxlen);
+
+	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
 
 int read_mmfile(mmfile_t *ptr, const char *filename)
-- 
1.5.4.rc0.1.g37d0
