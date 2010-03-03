From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] submodule summary: do not fail before the first commit
Date: Wed,  3 Mar 2010 14:19:10 -0800
Message-ID: <1267654750-30911-2-git-send-email-gitster@pobox.com>
References: <1267654750-30911-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 23:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmwuY-0001mv-BN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 23:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911Ab0CCWTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 17:19:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903Ab0CCWTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 17:19:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67A9A9E145
	for <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qkn9
	0Q9AyX+dSLmIodC88QwSx1c=; b=LA3v14NcglRd0tRVjQ5E8cqV5m4hHdvbqKzB
	ZIkaSOzGmupO5yZ9nVdtljxeESzWqB5LLXfw2F4R0CyPuhdZB8Gsfed8YeM/hMvw
	FBmNageEgVBKe2d9ueZGbmMkf2rjl6/0rkeTEKpvqLB9oypHlBerPpWtZefFnSiS
	Bou226Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NTw4yY
	cIVQF1iKIKyccaoI0epa59i6n/p6jMOlOLAh1Sx6MWzgU/TLuNVhYzvjdqAGwodL
	w93fiERmtJbhBmCKW1A+ucnLDHTxn9UProRz4yOaAIcnw1C2RYs6bPPTLghABbXF
	ADpdRmgdYm3ouYMhUelQ8fDOZdmcI1JCq+38Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 621B59E143
	for <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB0AD9E142 for
 <git@vger.kernel.org>; Wed,  3 Mar 2010 17:19:13 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.290.g2d87e
In-Reply-To: <1267654750-30911-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CCD10C68-2712-11DF-B214-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141486>

When "git status" collects changes for the index (usually relative to
HEAD), it compares the index with an empty tree when the repository does
not have an initial commit yet.  "git submodule summary" is about asking
what submodule changes would be recorded if a commit is made right now,
and should do the same comparison to report all the added submodules,
instead of punting and being silent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 383dc45..eab2549 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -559,7 +559,8 @@ cmd_summary() {
 		test $# = 0 || shift
 	elif test -z "$1" -o "$1" = "HEAD"
 	then
-		return
+		# before the first commit: compare with an empty tree
+		head=$(git hash-object -w -t tree --stdin </dev/null)
 	else
 		head="HEAD"
 	fi
-- 
1.7.0.1.290.g2d87e
