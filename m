From: Junio C Hamano <gitster@pobox.com>
Subject: Re: absurdly slow git-diff
Date: Fri, 07 Nov 2008 21:30:52 -0800
Message-ID: <7v7i7eeqcz.fsf@gitster.siamese.dyndns.org>
References: <20081107200126.GA20284@toroid.org>
 <alpine.LFD.2.00.0811071335010.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071503120.8736@alien.or.mcafeemobile.com>
 <alpine.DEB.1.10.0811071517280.8736@alien.or.mcafeemobile.com>
 <alpine.LFD.2.00.0811071540340.3468@nehalem.linux-foundation.org>
 <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Abhijit Menon-Sen <ams@toroid.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 06:32:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KygQz-0003fQ-EY
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbYKHFbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 00:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbYKHFbS
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 00:31:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYKHFbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 00:31:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 50F877A245;
	Sat,  8 Nov 2008 00:31:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 965717A244; Sat,
  8 Nov 2008 00:30:59 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.0811071547080.8736@alien.or.mcafeemobile.com>
 (Davide Libenzi's message of "Fri, 7 Nov 2008 15:48:34 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75070A64-AD56-11DD-90CB-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100381>

Davide Libenzi <davidel@xmailserver.org> writes:

> Yeah, similar. Mine is below. There's one less branch in the for loops.

Thanks, will apply like this, but I am not sure if you meant windowN or
just window...

-- >8 --
From: Davide Libenzi <davidel@xmailserver.org>
Date: Fri, 7 Nov 2008 21:24:33 -0800
Subject: [PATCH] xdiff: give up scanning similar lines early

In a corner case of large files whose lines do not match uniquely, the
loop to eliminate a line that matches multiple locations adjacent to a run
of lines that do not uniquely match wasted too much cycles.  Fix this by
giving up early after scanning 100 lines in both direction.
---
 xdiff/xprepare.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e87ab57..6a70cdf 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -23,10 +23,9 @@
 #include "xinclude.h"
 
 
-
 #define XDL_KPDIS_RUN 4
 #define XDL_MAX_EQLIMIT 1024
-
+#define XDL_SIMSCAN_WINDOWN 100
 
 
 typedef struct s_xdlclass {
@@ -313,6 +312,18 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
 	long r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
+	 * Limits the window the is examined during the similar-lines
+	 * scan. The loops below stops when dis[i - r] == 1 (line that
+	 * has no match), but there are corner cases where the loop
+	 * proceed all the way to the extremities by causing huge
+	 * performance penalties in case of big files.
+	 */
+	if (i - s > XDL_SIMSCAN_WINDOWN)
+		s = i - XDL_SIMSCAN_WINDOWN;
+	if (e - i > XDL_SIMSCAN_WINDOWN)
+		e = i + XDL_SIMSCAN_WINDOWN;
+
+	/*
 	 * Scans the lines before 'i' to find a run of lines that either
 	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
 	 * Note that we always call this function with dis[i] > 1, so the
-- 
1.6.0.3.674.gdf99f
