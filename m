From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Test: catch if trash cannot be removed
Date: Tue, 18 Mar 2008 21:58:01 -0700
Message-ID: <7vd4pr5mzq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:44:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4C7-0002JK-N6
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbYCSTkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYCSTkF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:40:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbYCSTkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:40:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B69C81A8C;
	Wed, 19 Mar 2008 00:58:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 066E91A8B; Wed, 19 Mar 2008 00:58:04 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77518>

When your test creates an unwritable directory that test framework cannot
clean out by "rm -fr trash", later tests cannot start in a fresh state
they expect to.  Detect this and error out early.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 268b26c..870b255 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -396,7 +396,12 @@ fi
 
 # Test repository
 test=trash
-rm -fr "$test"
+rm -fr "$test" || {
+	trap - exit
+	echo >&5 "FATAL: Cannot prepare test area"
+	exit 1
+}
+
 test_create_repo $test
 cd "$test"
 
-- 
1.5.5.rc0.122.g8e28f
