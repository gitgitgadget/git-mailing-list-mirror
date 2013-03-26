From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/2] fast-import: Fix an gcc -Wuninitialized warning
Date: Tue, 26 Mar 2013 19:09:44 +0000
Message-ID: <5151F278.2040109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZRz-000570-46
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab3CZTV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:21:59 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:45336 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754105Ab3CZTV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:21:58 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 6C8B4384082;
	Tue, 26 Mar 2013 19:21:57 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id C849D38407C;
	Tue, 26 Mar 2013 19:21:56 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 26 Mar 2013 19:21:56 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219187>


Commit cbfd5e1c ("drop some obsolete "x = x" compiler warning hacks",
21-03-2013) removed a gcc hack that suppressed an "might be used
uninitialized" warning issued by older versions of gcc.

However, commit 3aa99df8 ('fast-import: clarify "inline" logic in
file_change_m', 21-03-2013) addresses an (almost) identical issue
(with very similar code), but includes additional code in it's
resolution. The solution used by this commit, unlike that used by
commit cbfd5e1c, also suppresses the -Wuninitialized warning on
older versions of gcc.

In order to suppress the warning (against the 'oe' symbol) in the
note_change_n() function, we adopt the same solution used by commit
3aa99df8.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 fast-import.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fast-import.c b/fast-import.c
index a0c2c2f..5f539d7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2465,6 +2465,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 		hashcpy(sha1, oe->idx.sha1);
 	} else if (!prefixcmp(p, "inline ")) {
 		inline_data = 1;
+		oe = NULL; /* not used with inline_data, but makes gcc happy */
 		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
-- 
1.8.2
