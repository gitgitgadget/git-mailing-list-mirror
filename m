From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: [PATCH] git-rebase-interactive: avoid breaking when GREP_OPTIONS="-H"
Date: Mon,  7 Sep 2009 05:56:00 -0700
Message-ID: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 15:05:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkduX-00013G-1p
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZIGNFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 09:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZIGNFX
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:05:23 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:58553 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZIGNFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 09:05:23 -0400
Received: by sajino.sajinet.com.pe (Postfix, from userid 65534)
	id 724F5A5821D; Mon,  7 Sep 2009 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (dsl081-071-036.sfo1.dsl.speakeasy.net [64.81.71.36])
	by sajino.sajinet.com.pe (Postfix) with ESMTP id 1E54BA580C7
	for <git@vger.kernel.org>; Mon,  7 Sep 2009 12:56:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127928>

if GREP_OPTIONS is set and includes -H, using `grep -c` will fail
to generate a numeric count and result in the following error :

  /usr/libexec/git-core/git-rebase--interactive: line 110: (standard
  input):1+(standard input):0: missing `)' (error token is
  "input):1+(standard input):0")

instead of grep counting use `wc -l` to return the line count.

Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
---
 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..c12d980 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -106,8 +106,8 @@ mark_action_done () {
 	sed -e 1q < "$TODO" >> "$DONE"
 	sed -e 1d < "$TODO" >> "$TODO".new
 	mv -f "$TODO".new "$TODO"
-	count=$(grep -c '^[^#]' < "$DONE")
-	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
+	count=$(grep '^[^#]' < "$DONE" | wc -l)
+	total=$(($count+$(grep '^[^#]' < "$TODO" | wc -l)))
 	if test "$last_count" != "$count"
 	then
 		last_count=$count
-- 
1.6.3.3
