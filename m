From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] change throughput display units with fast links
Date: Tue, 13 Oct 2009 23:02:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910132256280.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 05:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxuBq-0001vA-8c
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 05:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761289AbZJNDCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 23:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbZJNDCq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 23:02:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24291 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbZJNDCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 23:02:45 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRH00CDVHRG4360@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 13 Oct 2009 23:02:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130237>

Switch to MiB/s when the connection is fast enough (i.e. on a LAN).

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
diff --git a/progress.c b/progress.c
index 132ed95..3971f49 100644
--- a/progress.c
+++ b/progress.c
@@ -131,7 +131,13 @@ static void throughput_string(struct throughput *tp, off_t total,
 	} else {
 		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
 	}
-	if (rate)
+
+	if (rate > 1 << 10) {
+		int x = rate + 5;  /* for rounding */
+		snprintf(tp->display + sizeof(tp->display) - l, l,
+			 " | %u.%2.2u MiB/s",
+			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
+	} else if (rate)
 		snprintf(tp->display + sizeof(tp->display) - l, l,
 			 " | %u KiB/s", rate);
 }
