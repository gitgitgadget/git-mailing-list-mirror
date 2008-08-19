From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Tue, 19 Aug 2008 16:44:33 -0700
Message-ID: <20080819234433.GJ24212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVatZ-00016A-Tz
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 01:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYHSXoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYHSXoe
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 19:44:34 -0400
Received: from george.spearce.org ([209.20.77.23]:34025 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbYHSXoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 19:44:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A8FF938375; Tue, 19 Aug 2008 23:44:33 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92938>

As we support seconds-since-epoch in $GIT_COMMITTER_TIME we should
also support it in a reflog @{...} style notation.  We can easily
tell this apart from @{nth} style notation by looking to see if
the value is unreasonably large for an @{nth} style notation.

The value 1112911993 was chosen for the limit as it is the commit
timestamp for e83c516331 "Initial revision of "git" ...". Any
reflogs in existance should contain timestamps dated later than
the date Linus first stored Git into itself, as reflogs came about
quite a bit after that.

Additionally a reflog with 1,112,911,993 record entries is also
simply not valid.  Such a reflog would require at least 87 TB to
store just the old and new SHA-1 values.  So our randomly chosen
upper limit for @{nth} notation is "big enough" that users will
not run into it by accident.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4fb77f8..e25f56a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -349,7 +349,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 			else
 				nth = -1;
 		}
-		if (0 <= nth)
+		if (1112911993 <= nth) {
+			at_time = nth;
+			nth = -1;
+		} else if (0 <= nth)
 			at_time = 0;
 		else {
 			char *tmp = xstrndup(str + at + 2, reflog_len);
-- 
1.6.0.96.g2fad1.dirty

-- 
Shawn.
