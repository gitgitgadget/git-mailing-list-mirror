From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] interpret_nth_last_branch(): plug small memleak
Date: Mon, 19 Jan 2009 22:21:09 -0800
Message-ID: <7vvdsamrai.fsf_-_@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 <7vprijra52.fsf@gitster.siamese.dyndns.org>
 <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 07:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPA0b-0000pO-W7
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 07:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbZATGVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZATGVT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:21:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZATGVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:21:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 93511914E0;
	Tue, 20 Jan 2009 01:21:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3ECE4914DF; Tue,
 20 Jan 2009 01:21:11 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 19 Jan 2009 13:33:34 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BDEAAF6-E6BA-11DD-8551-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106440>

The error return path leaked both cb.buf[] strbuf array itself, and the
strings contained in its elements.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f54b6cb..4c0370b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -754,7 +754,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 {
 	long nth;
-	int i;
+	int i, retval;
 	struct grab_nth_branch_switch_cbdata cb;
 	const char *brace;
 	char *num_end;
@@ -774,17 +774,21 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	for (i = 0; i < nth; i++)
 		strbuf_init(&cb.buf[i], 20);
 	cb.cnt = 0;
+	retval = 0;
 	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
 	if (cb.cnt < nth)
-		return 0;
+		goto release_return;
 	i = cb.cnt % nth;
 	strbuf_reset(buf);
 	strbuf_add(buf, cb.buf[i].buf, cb.buf[i].len);
+	retval = brace-name+1;
+
+release_return:
 	for (i = 0; i < nth; i++)
 		strbuf_release(&cb.buf[i]);
 	free(cb.buf);
 
-	return brace-name+1;
+	return retval;
 }
 
 /*
-- 
1.6.1.267.g11c6e
