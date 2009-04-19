From: James Cloos <cloos@jhcloos.com>
Subject: [PATCH 1/1] Improve progress display in kB range.
Date: Sun, 19 Apr 2009 00:32:42 -0400
Message-ID: <d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
References: <cover.1240115957.git.cloos@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 06:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvP7j-0006h1-I0
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 06:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZDSE5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 00:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbZDSE5o
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 00:57:44 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:2793 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZDSE5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 00:57:42 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 2E97F40084; Sun, 19 Apr 2009 04:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240116383;
	bh=CLCXGiIYEeXjmOhxE7+A9NHaBksnpW8MsaoXOctHGJo=;
	h=From:To:Subject:In-Reply-To:Date:References:Message-Id:
	 MIME-Version:Content-Type;
	b=nFade+fqQtj9PW6pmdI8Zn+XDPvhQ1USmnFTHA4nKsIOde//JUXjxPhCfX6stlI0Z
	 cfHPSR0Z4ouz1u7tTdD7mdfYoZ0W14eVWq1B+kqMOCX4Ozvp8x0jA1V9mhYYf+nPgE
	 pOKrWrCq4Y+JPlAk/YMxDR5QunhId2MxRyKtqjug=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 3B7FC6124C; Sun, 19 Apr 2009 04:45:52 +0000 (UTC)
In-Reply-To: <cover.1240115957.git.cloos@jhcloos.com>
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090419:git@vger.kernel.org::6rqazW/MwNJzB/ct:000000000000000000000000000000000000000007+p3y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116885>

When progress.c:throughput_string() is called, the variable total
invariably has its twelve least significant bits set.  Ie, it is
always the case that:

       total & 0xFFF == 0xFFF

As such, there is no point in displaying centi KiB.

Signed-off-by: James Cloos <cloos@jhcloos.com>
---
 progress.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index 55a8687..e51b834 100644
--- a/progress.c
+++ b/progress.c
@@ -125,9 +125,8 @@ static void throughput_string(struct throughput *tp, off_t total,
 			      (int)(total >> 20),
 			      ((int)(total & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (total > 1 << 10) {
-		l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
-			      (int)(total >> 10),
-			      ((int)(total & ((1 << 10) - 1)) * 100) >> 10);
+		l -= snprintf(tp->display, l, ", %u KiB",
+			      (int)(total >> 10));
 	} else {
 		l -= snprintf(tp->display, l, ", %u bytes", (int)total);
 	}
-- 
1.6.3.rc1.1.g7e8e.dirty
